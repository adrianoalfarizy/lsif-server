#include <open.mp>
#include <a_mysql>

#define COLOR_WHITE     0xFFFFFFFF
#define COLOR_GREEN     0x00FF00FF
#define COLOR_RED       0xFF0000FF
#define COLOR_YELLOW    0xFFFF00FF
#define COLOR_CYAN      0x00FFFFFF
#define COLOR_ORANGE    0xFF9900FF

#define MYSQL_HOST      "localhost"
#define MYSQL_USER      "lsif_user"
#define MYSQL_PASSWORD  "LSIF_DB_PASS_Dev2026!"
#define MYSQL_DATABASE  "lsif_db"

#define DIALOG_REGISTER 1000
#define DIALOG_LOGIN    1001

#define AUTOSAVE_INTERVAL 300000 // 5 menit dalam milidetik

#define SPAWN_X         1958.3783
#define SPAWN_Y         1343.1572
#define SPAWN_Z         15.3746
#define SPAWN_A         269.1425

#define DEFAULT_SKIN 0

#define MAX_PAY_AMOUNT  50000

#define JOB_NONE        0
#define JOB_COURIER     1

#define WORK_NONE       0
#define WORK_COURIER    1

#define MAX_COURIER_POINTS 5

#define COURIER_COOLDOWN_SECONDS 30

#define VEHICLE_BURRITO 482
#define VEHICLE_BOXVILLE 498
#define VEHICLE_MULE 414
#define VEHICLE_PONY 413
#define VEHICLE_RUMPO 440

#define VEHICLE_OWNER_NONE 0

new MySQL:g_SQL;
new g_AutosaveTimer;

new PlayerDBID[MAX_PLAYERS];
new PlayerLoggedIn[MAX_PLAYERS];

new Float:PlayerLastX[MAX_PLAYERS];
new Float:PlayerLastY[MAX_PLAYERS];
new Float:PlayerLastZ[MAX_PLAYERS];
new Float:PlayerLastA[MAX_PLAYERS];

new PlayerMoney[MAX_PLAYERS];
new PlayerXP[MAX_PLAYERS];
new PlayerLevel[MAX_PLAYERS];
new PlayerAdmin[MAX_PLAYERS];
new PlayerVehicle[MAX_PLAYERS];

new OwnedVehicleDBID[MAX_PLAYERS];
new OwnedVehicleModel[MAX_PLAYERS];
new OwnedVehicleID[MAX_PLAYERS];
new OwnedVehicleLocked[MAX_PLAYERS];

new Float:OwnedVehicleX[MAX_PLAYERS];
new Float:OwnedVehicleY[MAX_PLAYERS];
new Float:OwnedVehicleZ[MAX_PLAYERS];
new Float:OwnedVehicleA[MAX_PLAYERS];

//job
new PlayerJob[MAX_PLAYERS];
new PlayerWorking[MAX_PLAYERS];
new PlayerWorkType[MAX_PLAYERS];
new PlayerWorkPoint[MAX_PLAYERS];
new PlayerLastWorkTick[MAX_PLAYERS];

new Float:CourierPointX[MAX_COURIER_POINTS] =
{
    2102.8870,
    1836.2458,
    1365.8962,
    2229.3215,
    2495.5024
};

new Float:CourierPointY[MAX_COURIER_POINTS] =
{
    -1806.4775,
        -1682.0194,
        -1279.8245,
        -1159.7343,
        -1687.8154
    };

new Float:CourierPointZ[MAX_COURIER_POINTS] =
{
    13.5547,
    13.3750,
    13.5469,
    25.7331,
    13.5152
};

new CourierReward[MAX_COURIER_POINTS] =
{
    250,
    300,
    350,
    450,
    400
};

new CourierXP[MAX_COURIER_POINTS] =
{
    20,
    25,
    30,
    35,
    30
};

forward OnAccountCheck(playerid);
forward OnAccountRegister(playerid);
forward OnAccountLogin(playerid);
forward AutoSavePlayers();
forward OnPlayerDataSaved(playerid, notify);
forward OnOwnedVehicleCheck(playerid);
forward OnOwnedVehicleBought(playerid, modelid, price);
forward OnOwnedVehicleSaved(playerid, notify);
forward OnOwnedVehicleSold(playerid, sellPrice);

stock SaveAllPlayers()
{
    new savedCount = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i])
        {
            SavePlayerData(i);
            savedCount++;
        }
    }

    new msg[128];
    format(msg, sizeof(msg), "[AUTOSAVE] %d player data disimpan.", savedCount);
    print(msg);

    return savedCount;
}

stock GetPlayerAccountName(playerid, output[], size)
{
    GetPlayerName(playerid, output, size);
    return 1;
}

stock ResetPlayerAccountData(playerid)
{
    PlayerDBID[playerid] = 0;
    PlayerLoggedIn[playerid] = 0;

    PlayerMoney[playerid] = 500;
    PlayerXP[playerid] = 0;
    PlayerLevel[playerid] = 1;
    PlayerAdmin[playerid] = 0;
    PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
    ResetOwnedVehicleData(playerid);

    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = 0;

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;

    ResetPlayerMoney(playerid);
    return 1;
}

stock ShowRegisterDialog(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_REGISTER,
        DIALOG_STYLE_PASSWORD,
        "LSIF Register",
        "Akun belum terdaftar.\nMasukkan password baru minimal 4 karakter:",
        "Register",
        "Keluar"
    );
    return 1;
}

stock ShowLoginDialog(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_LOGIN,
        DIALOG_STYLE_PASSWORD,
        "LSIF Login",
        "Akun ditemukan.\nMasukkan password akun kamu:",
        "Login",
        "Keluar"
    );
    return 1;
}

stock CheckPlayerAccount(playerid)
{
    new username[MAX_PLAYER_NAME];
    new query[256];

    GetPlayerAccountName(playerid, username, sizeof(username));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT id FROM players WHERE username = '%e' LIMIT 1",
        username
    );

    mysql_tquery(g_SQL, query, "OnAccountCheck", "i", playerid);
    return 1;
}

stock SavePlayerData(playerid, notify = 0)
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        if (notify)
        {
            SendClientMessage(playerid, COLOR_RED, "Data gagal disimpan. Kamu belum login.");
        }
        return 0;
    }

    new Float:x, Float:y, Float:z, Float:a;
    new query[512];

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE players SET money=%d, xp=%d, level=%d, admin_level=%d, current_job=%d, pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f WHERE id=%d LIMIT 1",
        PlayerMoney[playerid],
        PlayerXP[playerid],
        PlayerLevel[playerid],
        PlayerAdmin[playerid],
        PlayerJob[playerid],
        x,
        y,
        z,
        a,
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerDataSaved", "ii", playerid, notify);
    return 1;
}

stock ApplyLoadedPlayerData(playerid)
{
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerMoney[playerid]);
    SetPlayerScore(playerid, PlayerLevel[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Login berhasil. Data akun berhasil dimuat.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /stats untuk melihat data akun kamu.");

    SpawnLoggedPlayer(playerid);
    return 1;
}

stock SpawnLoggedPlayer(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    SetSpawnInfo(
        playerid,
        NO_TEAM,
        DEFAULT_SKIN,
        PlayerLastX[playerid],
        PlayerLastY[playerid],
        PlayerLastZ[playerid],
        PlayerLastA[playerid],
        WEAPON:WEAPON_FIST, 0,
        WEAPON:WEAPON_FIST, 0,
        WEAPON:WEAPON_FIST, 0
    );

    TogglePlayerSpectating(playerid, false);
    SpawnPlayer(playerid);

    return 1;
}

stock IsNumericString(const str[])
{
    if (str[0] == EOS)
    {
        return 0;
    }

    for (new i = 0; str[i] != EOS; i++)
    {
        if (str[i] < '0' || str[i] > '9')
        {
            return 0;
        }
    }

    return 1;
}

stock GetTwoParams(const input[], param1[], param1Size, param2[], param2Size)
{
    new i = 0;
    new p = 0;

    while (input[i] == ' ')
    {
        i++;
    }

    while (input[i] != EOS && input[i] != ' ' && p < param1Size - 1)
    {
        param1[p] = input[i];
        p++;
        i++;
    }
    param1[p] = EOS;

    while (input[i] == ' ')
    {
        i++;
    }

    p = 0;

    while (input[i] != EOS && input[i] != ' ' && p < param2Size - 1)
    {
        param2[p] = input[i];
        p++;
        i++;
    }
    param2[p] = EOS;

    if (param1[0] == EOS || param2[0] == EOS)
    {
        return 0;
    }

    return 1;
}

stock GetOneParam(const input[], param1[], param1Size)
{
    new i = 0;
    new p = 0;

    while (input[i] == ' ')
    {
        i++;
    }

    while (input[i] != EOS && input[i] != ' ' && p < param1Size - 1)
    {
        param1[p] = input[i];
        p++;
        i++;
    }

    param1[p] = EOS;

    if (param1[0] == EOS)
    {
        return 0;
    }

    return 1;
}

stock GivePlayerCash(playerid, amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    PlayerMoney[playerid] += amount;
    GivePlayerMoney(playerid, amount);

    return 1;
}

stock TakePlayerCash(playerid, amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    if (PlayerMoney[playerid] < amount)
    {
        return 0;
    }

    PlayerMoney[playerid] -= amount;
    GivePlayerMoney(playerid, -amount);

    return 1;
}

stock GetRequiredXP(level)
{
    return level * level * 500;
}

stock CheckPlayerLevelUp(playerid)
{
    new requiredXP = GetRequiredXP(PlayerLevel[playerid] + 1);

    if (PlayerXP[playerid] >= requiredXP)
    {
        PlayerLevel[playerid]++;

        new msg[144];
        format(msg, sizeof(msg), "LEVEL UP! Sekarang kamu level %d.", PlayerLevel[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }

    return 1;
}

stock GivePlayerXPEx(playerid, amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    PlayerXP[playerid] += amount;

    new msg[144];
    format(msg, sizeof(msg), "Kamu mendapatkan %d XP.", amount);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    CheckPlayerLevelUp(playerid);

    return 1;
}

//Jobs
stock GetJobName(jobid, output[], size)
{
    if (jobid == JOB_COURIER)
    {
        format(output, size, "Courier");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock IsCourierVehicleModel(modelid)
{
    if (modelid == VEHICLE_BURRITO) return 1;
    if (modelid == VEHICLE_BOXVILLE) return 1;
    if (modelid == VEHICLE_MULE) return 1;
    if (modelid == VEHICLE_PONY) return 1;
    if (modelid == VEHICLE_RUMPO) return 1;

    return 0;
}

stock IsPlayerInCourierVehicle(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new modelid = GetVehicleModel(vehicleid);

    return IsCourierVehicleModel(modelid);
}

stock GetCourierCooldownLeft(playerid)
{
    new lastTick = PlayerLastWorkTick[playerid];

    if (lastTick == 0)
    {
        return 0;
    }

    new currentTick = GetTickCount();
    new elapsed = (currentTick - lastTick) / 1000;

    if (elapsed >= COURIER_COOLDOWN_SECONDS)
    {
        return 0;
    }

    return COURIER_COOLDOWN_SECONDS - elapsed;
}

stock StartCourierWork(playerid)
{
    if (PlayerJob[playerid] != JOB_COURIER)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum bekerja sebagai courier. Gunakan /joinjob courier.");
        return 0;
    }

    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang menjalankan pekerjaan. Gunakan /cancelwork untuk membatalkan.");
        return 0;
    }

    new cooldownLeft = GetCourierCooldownLeft(playerid);

    if (cooldownLeft > 0)
    {
        new cooldownMsg[144];
        format(cooldownMsg, sizeof(cooldownMsg), "Tunggu %d detik sebelum mengambil delivery berikutnya.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, cooldownMsg);
        return 0;
    }

    if (!IsPlayerInCourierVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di kendaraan delivery untuk mulai kerja courier.");
        SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Burrito, Boxville, Mule, Pony, atau Rumpo.");
        SendClientMessage(playerid, COLOR_WHITE, "Untuk test cepat gunakan: /veh 482");
        return 0;
    }

    new point = random(MAX_COURIER_POINTS);

    PlayerWorking[playerid] = 1;
    PlayerWorkType[playerid] = WORK_COURIER;
    PlayerWorkPoint[playerid] = point;

    SetPlayerCheckpoint(
        playerid,
        CourierPointX[point],
        CourierPointY[point],
        CourierPointZ[point],
        4.0
    );

    new msg[144];
    format(
        msg,
        sizeof(msg),
        "Courier: antarkan paket ke checkpoint. Reward: $%d dan %d XP.",
        CourierReward[point],
        CourierXP[point]
    );
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Tetap gunakan kendaraan delivery sampai tujuan.");

    return 1;
}

stock CompleteCourierWork(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_COURIER)
    {
        return 0;
    }

    new point = PlayerWorkPoint[playerid];
    new reward = CourierReward[point];
    new xp = CourierXP[point];

    GivePlayerCash(playerid, reward);
    GivePlayerXPEx(playerid, xp);

    DisablePlayerCheckpoint(playerid);

    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = GetTickCount();

    new msg[144];
    format(msg, sizeof(msg), "Paket berhasil diantar. Kamu mendapat $%d dan %d XP.", reward, xp);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work lagi untuk mengambil delivery berikutnya.");

    return 1;
}

stock CancelPlayerWork(playerid)
{
    if (!PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang bekerja.");
        return 0;
    }

    DisablePlayerCheckpoint(playerid);

    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;

    SendClientMessage(playerid, COLOR_YELLOW, "Pekerjaan aktif dibatalkan.");
    return 1;
}

stock ResetOwnedVehicleData(playerid)
{
    OwnedVehicleDBID[playerid] = 0;
    OwnedVehicleModel[playerid] = 0;
    OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    OwnedVehicleLocked[playerid] = 0;

    OwnedVehicleX[playerid] = SPAWN_X + 3.0;
    OwnedVehicleY[playerid] = SPAWN_Y;
    OwnedVehicleZ[playerid] = SPAWN_Z;
    OwnedVehicleA[playerid] = SPAWN_A;

    return 1;
}

stock GetVehicleBasePrice(modelid)
{
    switch (modelid)
    {
        case 400: return 12000; // Landstalker
        case 401: return 8000;  // Bravura
        case 402: return 25000; // Buffalo
        case 411: return 75000; // Infernus
        case 413: return 12000; // Pony
        case 414: return 18000; // Mule
        case 415: return 60000; // Cheetah
        case 440: return 14000; // Rumpo
        case 451: return 65000; // Turismo
        case 461: return 15000; // PCJ-600
        case 462: return 5000;  // Faggio
        case 482: return 15000; // Burrito
        case 498: return 16000; // Boxville
    }

    if (modelid >= 400 && modelid <= 611)
    {
        return 10000;
    }

    return 0;
}

stock LoadOwnedVehicle(playerid)
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT id, model_id, pos_x, pos_y, pos_z, pos_a, locked FROM player_vehicles WHERE owner_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnOwnedVehicleCheck", "i", playerid);
    return 1;
}

stock SpawnOwnedVehicle(playerid)
{
    if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleModel[playerid] < 400 || OwnedVehicleModel[playerid] > 611)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya kendaraan pribadi.");
        return 0;
    }

    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(OwnedVehicleID[playerid]);
        OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    OwnedVehicleID[playerid] = CreateVehicle(
                                   OwnedVehicleModel[playerid],
                                   OwnedVehicleX[playerid],
                                   OwnedVehicleY[playerid],
                                   OwnedVehicleZ[playerid],
                                   OwnedVehicleA[playerid],
                                   1,
                                   1,
                                   -1
                               );

    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal spawn kendaraan pribadi.");
        return 0;
    }

    if (OwnedVehicleLocked[playerid])
    {
        SetVehicleParamsEx(OwnedVehicleID[playerid], 0, 0, 0, 1, 0, 0, 0);
    }
    else
    {
        SetVehicleParamsEx(OwnedVehicleID[playerid], 0, 0, 0, 0, 0, 0, 0);
    }

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan pribadi model %d berhasil di-spawn.", OwnedVehicleModel[playerid]);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    return 1;
}

stock SaveOwnedVehicle(playerid, notify = 0)
{
    if (!PlayerLoggedIn[playerid] || OwnedVehicleDBID[playerid] <= 0)
    {
        if (notify)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya kendaraan pribadi.");
        }
        return 0;
    }

    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        if (notify)
        {
            SendClientMessage(playerid, COLOR_RED, "Kendaraan pribadi belum di-spawn.");
        }
        return 0;
    }

    new Float:x, Float:y, Float:z, Float:a;
    new query[512];

    GetVehiclePos(OwnedVehicleID[playerid], x, y, z);
    GetVehicleZAngle(OwnedVehicleID[playerid], a);

    OwnedVehicleX[playerid] = x;
    OwnedVehicleY[playerid] = y;
    OwnedVehicleZ[playerid] = z;
    OwnedVehicleA[playerid] = a;

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_vehicles SET pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f, locked=%d WHERE id=%d LIMIT 1",
        x,
        y,
        z,
        a,
        OwnedVehicleLocked[playerid],
        OwnedVehicleDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnOwnedVehicleSaved", "ii", playerid, notify);
    return 1;
}

stock IsPlayerNearOwnedVehicle(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    new Float:px, Float:py, Float:pz;
    new Float:vx, Float:vy, Float:vz;

    GetPlayerPos(playerid, px, py, pz);
    GetVehiclePos(OwnedVehicleID[playerid], vx, vy, vz);

    if (GetPlayerDistanceFromPoint(playerid, vx, vy, vz) <= 8.0)
    {
        return 1;
    }

    return 0;
}

main()
{
    print("========================================");
    print(" LSIF - Los Santos Indonesia Freeroam");
    print(" Development Gamemode Loaded");
    print("========================================");
}

public AutoSavePlayers()
{
    SaveAllPlayers();
    return 1;
}

public OnGameModeInit()
{
    SetGameModeText("LSIF Dev v0.5A Vehicle");

    g_SQL = mysql_connect(
                MYSQL_HOST,
                MYSQL_USER,
                MYSQL_PASSWORD,
                MYSQL_DATABASE
            );

    if (mysql_errno(g_SQL) != 0)
    {
        print("[MYSQL] Gagal connect ke database.");
    }
    else
    {
        print("[MYSQL] Berhasil connect ke database lsif_db.");
    }
    AddPlayerClass(
        0,
        SPAWN_X,
        SPAWN_Y,
        SPAWN_Z,
        SPAWN_A,
        WEAPON:WEAPON_FIST, 0,
        WEAPON:WEAPON_FIST, 0,
        WEAPON:WEAPON_FIST, 0
    );

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerDBID[i] = 0;
        PlayerLoggedIn[i] = 0;

        PlayerMoney[i] = 500;
        PlayerXP[i] = 0;
        PlayerLevel[i] = 1;
        PlayerAdmin[i] = 0;
        PlayerVehicle[i] = INVALID_VEHICLE_ID;
        ResetOwnedVehicleData(i);

        PlayerJob[i] = JOB_NONE;
        PlayerWorking[i] = 0;
        PlayerWorkType[i] = WORK_NONE;
        PlayerWorkPoint[i] = -1;
        PlayerLastWorkTick[i] = 0;

        PlayerLastX[i] = SPAWN_X;
        PlayerLastY[i] = SPAWN_Y;
        PlayerLastZ[i] = SPAWN_Z;
        PlayerLastA[i] = SPAWN_A;
    }
    g_AutosaveTimer = SetTimer("AutoSavePlayers", AUTOSAVE_INTERVAL, true);

    print("[LSIF] Autosave timer aktif setiap 5 menit.");
    print("[LSIF] Gamemode v0.5A Vehicle Ownership berhasil dijalankan.");
    return 1;
}

public OnGameModeExit()
{
    print("[LSIF] Menyimpan semua data player sebelum gamemode exit...");
    SaveAllPlayers();

    if (g_AutosaveTimer)
    {
        KillTimer(g_AutosaveTimer);
        g_AutosaveTimer = 0;
    }

    mysql_close(g_SQL);

    print("[MYSQL] Koneksi database ditutup.");
    print("[LSIF] Gamemode dimatikan.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    ResetPlayerAccountData(playerid);

    // Sembunyikan class selection/pilih skin sebelum login.
    TogglePlayerSpectating(playerid, true);

    SendClientMessage(playerid, COLOR_GREEN, "Selamat datang di LSIF - Los Santos Indonesia Freeroam.");
    SendClientMessage(playerid, COLOR_WHITE, "Mengecek akun kamu di database...");

    CheckPlayerAccount(playerid);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);
    SaveOwnedVehicle(playerid);

    if (PlayerVehicle[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(PlayerVehicle[playerid]);
        PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
    }

    DisablePlayerCheckpoint(playerid);

    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;

    PlayerLoggedIn[playerid] = 0;
    PlayerDBID[playerid] = 0;

    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(OwnedVehicleID[playerid]);
        OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus login/register terlebih dahulu.");
        return 0;
    }

    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if (!PlayerLoggedIn[playerid])
    {
        TogglePlayerSpectating(playerid, true);
        return 0;
    }

    SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
    SetPlayerFacingAngle(playerid, SPAWN_A);

    SetPlayerCameraPos(playerid, 1962.0000, 1343.0000, 17.0000);
    SetPlayerCameraLookAt(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);

    return 1;
}

public OnPlayerSpawn(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum login.");
        return 1;
    }
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

    SetPlayerPos(playerid, PlayerLastX[playerid], PlayerLastY[playerid], PlayerLastZ[playerid]);
    SetPlayerFacingAngle(playerid, PlayerLastA[playerid]);

    ResetPlayerWeapons(playerid);

    SendClientMessage(playerid, COLOR_CYAN, "Kamu berhasil spawn di Los Santos.");
    SendClientMessage(playerid, COLOR_WHITE, "Coba command: /help, /stats, /veh 411, /kill.");

    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == DIALOG_REGISTER)
    {
        if (!response)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu keluar dari proses register.");
            Kick(playerid);
            return 1;
        }

        if (strlen(inputtext) < 4)
        {
            SendClientMessage(playerid, COLOR_RED, "Password minimal 4 karakter.");
            ShowRegisterDialog(playerid);
            return 1;
        }

        new username[MAX_PLAYER_NAME];
        new ip[45];
        new query[512];

        GetPlayerAccountName(playerid, username, sizeof(username));
        GetPlayerIp(playerid, ip, sizeof(ip));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO players (username, password_hash, money, xp, level, admin_level, current_job, pos_x, pos_y, pos_z, pos_a, last_ip, last_login) VALUES ('%e', SHA2('%e', 256), 500, 0, 1, 0, 0, %f, %f, %f, %f, '%e', NOW())",
            username,
            inputtext,
            SPAWN_X,
            SPAWN_Y,
            SPAWN_Z,
            SPAWN_A,
            ip
        );

        mysql_tquery(g_SQL, query, "OnAccountRegister", "i", playerid);
        return 1;
    }

    if (dialogid == DIALOG_LOGIN)
    {
        if (!response)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu keluar dari proses login.");
            Kick(playerid);
            return 1;
        }

        if (strlen(inputtext) < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "Password tidak boleh kosong.");
            ShowLoginDialog(playerid);
            return 1;
        }

        new username[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerAccountName(playerid, username, sizeof(username));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT id, money, xp, level, admin_level, skin, current_job, pos_x, pos_y, pos_z, pos_a FROM players WHERE username='%e' AND password_hash=SHA2('%e', 256) LIMIT 1",
            username,
            inputtext
        );

        mysql_tquery(g_SQL, query, "OnAccountLogin", "i", playerid);
        return 1;
    }

    return 0;
}

public OnAccountCheck(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows > 0)
    {
        ShowLoginDialog(playerid);
    }
    else
    {
        ShowRegisterDialog(playerid);
    }

    return 1;
}

public OnAccountRegister(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    PlayerDBID[playerid] = cache_insert_id();
    PlayerLoggedIn[playerid] = 1;

    PlayerMoney[playerid] = 500;
    PlayerXP[playerid] = 0;
    PlayerLevel[playerid] = 1;
    PlayerAdmin[playerid] = 0;
    PlayerJob[playerid] = JOB_NONE;

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;
    ResetOwnedVehicleData(playerid);

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerMoney[playerid]);
    SetPlayerScore(playerid, PlayerLevel[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Register berhasil. Akun kamu sudah dibuat.");
    SendClientMessage(playerid, COLOR_WHITE, "Selamat datang di LSIF.");

    SpawnLoggedPlayer(playerid);
    return 1;
}

public OnAccountLogin(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Password salah.");
        ShowLoginDialog(playerid);
        return 1;
    }

    cache_get_value_name_int(0, "id", PlayerDBID[playerid]);
    cache_get_value_name_int(0, "money", PlayerMoney[playerid]);
    cache_get_value_name_int(0, "xp", PlayerXP[playerid]);
    cache_get_value_name_int(0, "level", PlayerLevel[playerid]);
    cache_get_value_name_int(0, "admin_level", PlayerAdmin[playerid]);
    // cache_get_value_name_int(0, "skin", PlayerLevel[playerid]);
    cache_get_value_name_int(0, "current_job", PlayerJob[playerid]);

    cache_get_value_name_float(0, "pos_x", PlayerLastX[playerid]);
    cache_get_value_name_float(0, "pos_y", PlayerLastY[playerid]);
    cache_get_value_name_float(0, "pos_z", PlayerLastZ[playerid]);
    cache_get_value_name_float(0, "pos_a", PlayerLastA[playerid]);

    PlayerLoggedIn[playerid] = 1;

    ApplyLoadedPlayerData(playerid);
    LoadOwnedVehicle(playerid);

    new ip[45];
    new query[256];

    GetPlayerIp(playerid, ip, sizeof(ip));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE players SET last_ip='%e', last_login=NOW() WHERE id=%d LIMIT 1",
        ip,
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);

    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_COURIER)
    {
        CompleteCourierWork(playerid);
        return 1;
    }

    return 1;
}

public OnPlayerDataSaved(playerid, notify)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (notify)
    {
        new affectedRows = cache_affected_rows();
        new msg[144];

        format(msg, sizeof(msg), "Data akun berhasil disimpan. Affected rows: %d", affectedRows);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }

    return 1;
}

public OnOwnedVehicleCheck(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        ResetOwnedVehicleData(playerid);
        return 1;
    }

    cache_get_value_name_int(0, "id", OwnedVehicleDBID[playerid]);
    cache_get_value_name_int(0, "model_id", OwnedVehicleModel[playerid]);
    cache_get_value_name_float(0, "pos_x", OwnedVehicleX[playerid]);
    cache_get_value_name_float(0, "pos_y", OwnedVehicleY[playerid]);
    cache_get_value_name_float(0, "pos_z", OwnedVehicleZ[playerid]);
    cache_get_value_name_float(0, "pos_a", OwnedVehicleA[playerid]);
    cache_get_value_name_int(0, "locked", OwnedVehicleLocked[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Data kendaraan pribadi berhasil dimuat. Gunakan /myveh untuk spawn.");
    return 1;
}

public OnOwnedVehicleBought(playerid, modelid, price)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new insertId = cache_insert_id();

    if (insertId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal membeli kendaraan. Database insert gagal.");
        return 1;
    }

    TakePlayerCash(playerid, price);

    OwnedVehicleDBID[playerid] = insertId;
    OwnedVehicleModel[playerid] = modelid;
    OwnedVehicleLocked[playerid] = 0;

    new Float:x, Float:y, Float:z, Float:a;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    OwnedVehicleX[playerid] = x + 3.0;
    OwnedVehicleY[playerid] = y;
    OwnedVehicleZ[playerid] = z;
    OwnedVehicleA[playerid] = a;

    new msg[144];
    format(msg, sizeof(msg), "Kamu berhasil membeli kendaraan model %d seharga $%d.", modelid, price);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /myveh untuk spawn kendaraan pribadi.");

    SavePlayerData(playerid);

    return 1;
}

public OnOwnedVehicleSaved(playerid, notify)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (notify)
    {
        new affectedRows = cache_affected_rows();
        new msg[144];

        format(msg, sizeof(msg), "Kendaraan berhasil disimpan. Affected rows: %d", affectedRows);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }

    return 1;
}

public OnOwnedVehicleSold(playerid, sellPrice)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    GivePlayerCash(playerid, sellPrice);

    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(OwnedVehicleID[playerid]);
    }

    ResetOwnedVehicleData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan berhasil dijual. Kamu menerima $%d.", sellPrice);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SavePlayerData(playerid);

    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (!PlayerLoggedIn[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus login/register terlebih dahulu.");
        return 1;
    }
    if (!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF HELP ==========");
        SendClientMessage(playerid, COLOR_WHITE, "/help - Menampilkan bantuan");
        SendClientMessage(playerid, COLOR_WHITE, "/stats - Melihat statistik player");
        SendClientMessage(playerid, COLOR_WHITE, "/money - Melihat uang kamu");
        SendClientMessage(playerid, COLOR_WHITE, "/givemoney - Dev test tambah uang");
        SendClientMessage(playerid, COLOR_WHITE, "/givemexp - Dev test tambah XP");
        SendClientMessage(playerid, COLOR_WHITE, "/pay [id] [amount] - Kirim uang ke player lain");
        SendClientMessage(playerid, COLOR_WHITE, "/spawn - Kembali ke spawn utama");
        SendClientMessage(playerid, COLOR_WHITE, "/kill - Respawn test");
        SendClientMessage(playerid, COLOR_WHITE, "/veh [modelid] - Spawn kendaraan, contoh: /veh 411");
        SendClientMessage(playerid, COLOR_WHITE, "/fixveh - Perbaiki kendaraan");
        SendClientMessage(playerid, COLOR_WHITE, "/dv - Hapus kendaraan pribadi sementara");
        SendClientMessage(playerid, COLOR_ORANGE, "Admin dev: /goto [id], /gethere [id]");
        SendClientMessage(playerid, COLOR_WHITE, "/jobs - Melihat daftar job");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob courier - Ambil job courier");
        SendClientMessage(playerid, COLOR_WHITE, "/jobinfo - Melihat informasi job aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/leavejob - Keluar dari job");
        SendClientMessage(playerid, COLOR_WHITE, "/work - Mulai pekerjaan aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/cancelwork - Batalkan pekerjaan aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/account - Melihat informasi akun");
        SendClientMessage(playerid, COLOR_WHITE, "/savedata - Simpan data akun manual");
        SendClientMessage(playerid, COLOR_WHITE, "/buyveh [modelid] - Beli kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/myveh - Spawn kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/park - Simpan posisi kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/lock - Kunci/buka kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/sellveh - Jual kendaraan pribadi");

        return 1;
    }

    if (!strcmp(cmdtext, "/stats", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== PLAYER STATS ==========");

        format(msg, sizeof(msg), "ID: %d", playerid);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Money: $%d", PlayerMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "XP: %d", PlayerXP[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Level: %d", PlayerLevel[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Admin Level: %d", PlayerAdmin[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        new jobName[32];
        GetJobName(PlayerJob[playerid], jobName, sizeof(jobName));

        format(msg, sizeof(msg), "Job: %s", jobName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Working: %s", PlayerWorking[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (OwnedVehicleDBID[playerid] > 0)
        {
            format(msg, sizeof(msg), "Owned Vehicle: DBID %d | Model %d | Locked %d", OwnedVehicleDBID[playerid], OwnedVehicleModel[playerid], OwnedVehicleLocked[playerid]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Owned Vehicle: None");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/spawn", true))
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
        SetPlayerFacingAngle(playerid, SPAWN_A);
        SendClientMessage(playerid, COLOR_GREEN, "Kamu dikembalikan ke spawn utama.");
        return 1;
    }

    if (!strcmp(cmdtext, "/kill", true))
    {
        SetPlayerHealth(playerid, 0.0);
        SendClientMessage(playerid, COLOR_RED, "Kamu menggunakan /kill.");
        return 1;
    }

    if (!strcmp(cmdtext, "/fixveh", true))
    {
        if (!IsPlayerInAnyVehicle(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di dalam kendaraan.");
            return 1;
        }

        new vehicleid = GetPlayerVehicleID(playerid);
        RepairVehicle(vehicleid);
        SetVehicleHealth(vehicleid, 1000.0);
        SendClientMessage(playerid, COLOR_GREEN, "Kendaraan berhasil diperbaiki.");
        return 1;
    }

    if (!strcmp(cmdtext, "/dv", true))
    {
        if (PlayerVehicle[playerid] == INVALID_VEHICLE_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak punya kendaraan sementara.");
            return 1;
        }

        DestroyVehicle(PlayerVehicle[playerid]);
        PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
        SendClientMessage(playerid, COLOR_GREEN, "Kendaraan sementara berhasil dihapus.");
        return 1;
    }

    if (strfind(cmdtext, "/veh ", true) == 0)
    {
        new modelid = strval(cmdtext[5]);

        if (modelid < 400 || modelid > 611)
        {
            SendClientMessage(playerid, COLOR_RED, "Model kendaraan tidak valid. Gunakan model ID 400 sampai 611.");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /veh 411");
            return 1;
        }

        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        if (PlayerVehicle[playerid] != INVALID_VEHICLE_ID)
        {
            DestroyVehicle(PlayerVehicle[playerid]);
            PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
        }

        PlayerVehicle[playerid] = CreateVehicle(modelid, x + 3.0, y, z, a, 1, 1, -1);
        PutPlayerInVehicle(playerid, PlayerVehicle[playerid], 0);

        new msg[144];
        format(msg, sizeof(msg), "Kendaraan model ID %d berhasil dibuat.", modelid);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        return 1;
    }

    if (strfind(cmdtext, "/goto ", true) == 0)
    {
        if (PlayerAdmin[playerid] < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new targetid = strval(cmdtext[6]);

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Target player tidak online.");
            return 1;
        }

        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);

        SetPlayerInterior(playerid, GetPlayerInterior(targetid));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
        SetPlayerPos(playerid, x + 1.0, y, z);

        SendClientMessage(playerid, COLOR_GREEN, "Kamu teleport ke target.");
        return 1;
    }

    if (strfind(cmdtext, "/gethere ", true) == 0)
    {
        if (PlayerAdmin[playerid] < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new targetid = strval(cmdtext[9]);

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Target player tidak online.");
            return 1;
        }

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        SetPlayerInterior(targetid, GetPlayerInterior(playerid));
        SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
        SetPlayerPos(targetid, x + 1.0, y, z);

        SendClientMessage(playerid, COLOR_GREEN, "Target berhasil ditarik ke posisimu.");
        SendClientMessage(targetid, COLOR_ORANGE, "Kamu ditarik oleh admin.");

        return 1;
    }

    if (!strcmp(cmdtext, "/money", true))
    {
        new msg[144];
        format(msg, sizeof(msg), "Uang kamu saat ini: $%d", PlayerMoney[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }

    if (!strcmp(cmdtext, "/givemoney", true))
    {
        if (PlayerAdmin[playerid] < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        GivePlayerCash(playerid, 1000);
        GivePlayerXPEx(playerid, 50);

        SendClientMessage(playerid, COLOR_GREEN, "Dev test: kamu mendapat $1000 dan 50 XP.");
        return 1;
    }

    if (!strcmp(cmdtext, "/givemexp", true))
    {
        if (PlayerAdmin[playerid] < 1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        GivePlayerXPEx(playerid, 250);
        return 1;
    }

    if (strfind(cmdtext, "/pay ", true) == 0)
    {
        new targetStr[16];
        new amountStr[16];

        if (!GetTwoParams(cmdtext[5], targetStr, sizeof(targetStr), amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /pay [playerid] [amount]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /pay 1 500");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(amountStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan jumlah uang harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new amount = strval(amountStr);

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Target player tidak online.");
            return 1;
        }

        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa membayar diri sendiri.");
            return 1;
        }

        if (amount <= 0 || amount > MAX_PAY_AMOUNT)
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah uang tidak valid atau melebihi batas.");
            return 1;
        }

        if (!TakePlayerCash(playerid, amount))
        {
            SendClientMessage(playerid, COLOR_RED, "Uang kamu tidak cukup.");
            return 1;
        }

        GivePlayerCash(targetid, amount);

        new msg[144];

        format(msg, sizeof(msg), "Kamu mengirim $%d ke player ID %d.", amount, targetid);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Kamu menerima $%d dari player ID %d.", amount, playerid);
        SendClientMessage(targetid, COLOR_GREEN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/jobs", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== JOBS ==========");
        SendClientMessage(playerid, COLOR_WHITE, "courier - Antar paket ke beberapa lokasi di Los Santos.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan: /joinjob courier");
        return 1;
    }

    if (!strcmp(cmdtext, "/joinjob courier", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan atau batalkan pekerjaan aktif dulu.");
            return 1;
        }

        PlayerJob[playerid] = JOB_COURIER;

        SendClientMessage(playerid, COLOR_GREEN, "Kamu sekarang bekerja sebagai Courier.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work untuk mulai mengantar paket.");
        SendClientMessage(playerid, COLOR_WHITE, "Rekomendasi kendaraan: /veh 482");

        return 1;
    }

    if (strfind(cmdtext, "/joinjob", true) == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /joinjob courier");
        return 1;
    }

    if (!strcmp(cmdtext, "/leavejob", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Batalkan pekerjaan aktif dulu dengan /cancelwork.");
            return 1;
        }

        if (PlayerJob[playerid] == JOB_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum memiliki job.");
            return 1;
        }

        PlayerJob[playerid] = JOB_NONE;
        SendClientMessage(playerid, COLOR_YELLOW, "Kamu keluar dari job saat ini.");
        return 1;
    }

    if (!strcmp(cmdtext, "/work", true))
    {
        if (PlayerJob[playerid] == JOB_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya job. Gunakan /jobs.");
            return 1;
        }

        if (PlayerJob[playerid] == JOB_COURIER)
        {
            StartCourierWork(playerid);
            return 1;
        }

        SendClientMessage(playerid, COLOR_RED, "Job kamu belum memiliki sistem work.");
        return 1;
    }

    if (!strcmp(cmdtext, "/cancelwork", true))
    {
        CancelPlayerWork(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/jobinfo", true))
    {
        new jobName[32];
        new msg[144];

        GetJobName(PlayerJob[playerid], jobName, sizeof(jobName));

        SendClientMessage(playerid, COLOR_YELLOW, "========== JOB INFO ==========");

        format(msg, sizeof(msg), "Job saat ini: %s", jobName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (PlayerJob[playerid] == JOB_COURIER)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tugas: antarkan paket ke checkpoint tujuan.");
            SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Burrito, Boxville, Mule, Pony, Rumpo.");
            SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 482 lalu /work.");

            new cooldownLeft = GetCourierCooldownLeft(playerid);

            if (cooldownLeft > 0)
            {
                format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
                SendClientMessage(playerid, COLOR_YELLOW, msg);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap bekerja.");
            }

            return 1;
        }

        SendClientMessage(playerid, COLOR_WHITE, "Kamu belum memiliki job. Gunakan /jobs.");
        return 1;
    }

    if (!strcmp(cmdtext, "/savedata", true))
    {
        if (!PlayerLoggedIn[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus login terlebih dahulu.");
            return 1;
        }

        SavePlayerData(playerid, 1);
        return 1;
    }

    if (!strcmp(cmdtext, "/account", true))
    {
        if (!PlayerLoggedIn[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus login terlebih dahulu.");
            return 1;
        }

        new name[MAX_PLAYER_NAME];
        new msg[144];

        GetPlayerName(playerid, name, sizeof(name));

        SendClientMessage(playerid, COLOR_YELLOW, "========== ACCOUNT INFO ==========");

        format(msg, sizeof(msg), "Username: %s", name);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Database ID: %d", PlayerDBID[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Logged In: %s", PlayerLoggedIn[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Admin Level: %d", PlayerAdmin[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Money: $%d | XP: %d | Level: %d", PlayerMoney[playerid], PlayerXP[playerid], PlayerLevel[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (OwnedVehicleDBID[playerid] > 0)
        {
            format(msg, sizeof(msg), "Owned Vehicle: DBID %d | Model %d | Locked %d", OwnedVehicleDBID[playerid], OwnedVehicleModel[playerid], OwnedVehicleLocked[playerid]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Owned Vehicle: None");
        }

        return 1;
    }

    if (strfind(cmdtext, "/buyveh ", true) == 0)
    {
        new modelStr[16];

        if (!GetOneParam(cmdtext[8], modelStr, sizeof(modelStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /buyveh [modelid]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /buyveh 411");
            return 1;
        }

        if (!IsNumericString(modelStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Model ID harus angka.");
            return 1;
        }

        new modelid = strval(modelStr);

        if (modelid < 400 || modelid > 611)
        {
            SendClientMessage(playerid, COLOR_RED, "Model kendaraan tidak valid. Gunakan ID 400 sampai 611.");
            return 1;
        }

        if (OwnedVehicleDBID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah punya kendaraan pribadi. Gunakan /sellveh dulu.");
            return 1;
        }

        new price = GetVehicleBasePrice(modelid);

        if (price <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kendaraan ini belum bisa dibeli.");
            return 1;
        }

        if (PlayerMoney[playerid] < price)
        {
            new msg[144];
            format(msg, sizeof(msg), "Uang tidak cukup. Harga kendaraan ini $%d.", price);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        new Float:x, Float:y, Float:z, Float:a;
        new query[512];

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO player_vehicles (owner_id, model_id, color1, color2, pos_x, pos_y, pos_z, pos_a, locked) VALUES (%d, %d, 1, 1, %f, %f, %f, %f, 0)",
            PlayerDBID[playerid],
            modelid,
            x + 3.0,
            y,
            z,
            a
        );

        mysql_tquery(g_SQL, query, "OnOwnedVehicleBought", "iii", playerid, modelid, price);
        return 1;
    }

    if (!strcmp(cmdtext, "/myveh", true))
    {
        SpawnOwnedVehicle(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/park", true))
    {
        if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "Kendaraan pribadi belum di-spawn.");
            return 1;
        }

        if (!IsPlayerInAnyVehicle(playerid) || GetPlayerVehicleID(playerid) != OwnedVehicleID[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di kendaraan pribadi untuk park.");
            return 1;
        }

        SaveOwnedVehicle(playerid, 1);
        return 1;
    }

    if (!strcmp(cmdtext, "/lock", true))
    {
        if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "Kendaraan pribadi belum di-spawn.");
            return 1;
        }

        if (!IsPlayerNearOwnedVehicle(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus dekat dengan kendaraan pribadi.");
            return 1;
        }

        if (OwnedVehicleLocked[playerid])
        {
            OwnedVehicleLocked[playerid] = 0;
            SetVehicleParamsEx(OwnedVehicleID[playerid], 0, 0, 0, 0, 0, 0, 0);
            SendClientMessage(playerid, COLOR_GREEN, "Kendaraan dibuka.");
        }
        else
        {
            OwnedVehicleLocked[playerid] = 1;
            SetVehicleParamsEx(OwnedVehicleID[playerid], 0, 0, 0, 1, 0, 0, 0);
            SendClientMessage(playerid, COLOR_YELLOW, "Kendaraan dikunci.");
        }

        SaveOwnedVehicle(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/sellveh", true))
    {
        if (OwnedVehicleDBID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya kendaraan pribadi.");
            return 1;
        }

        new basePrice = GetVehicleBasePrice(OwnedVehicleModel[playerid]);
        new sellPrice = basePrice / 2;
        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM player_vehicles WHERE id=%d AND owner_id=%d LIMIT 1",
            OwnedVehicleDBID[playerid],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnOwnedVehicleSold", "ii", playerid, sellPrice);
        return 1;
    }

    SendClientMessage(playerid, COLOR_RED, "Command tidak ditemukan. Gunakan /help.");
    return 1;
}