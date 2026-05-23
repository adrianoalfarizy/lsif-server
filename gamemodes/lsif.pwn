#include <open.mp>

#define COLOR_WHITE     0xFFFFFFFF
#define COLOR_GREEN     0x00FF00FF
#define COLOR_RED       0xFF0000FF
#define COLOR_YELLOW    0xFFFF00FF
#define COLOR_CYAN      0x00FFFFFF
#define COLOR_ORANGE    0xFF9900FF

#define SPAWN_X         1958.3783
#define SPAWN_Y         1343.1572
#define SPAWN_Z         15.3746
#define SPAWN_A         269.1425

#define MAX_PAY_AMOUNT  50000

new PlayerMoney[MAX_PLAYERS];
new PlayerXP[MAX_PLAYERS];
new PlayerLevel[MAX_PLAYERS];
new PlayerAdmin[MAX_PLAYERS];
new PlayerVehicle[MAX_PLAYERS];

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

main()
{
    print("========================================");
    print(" LSIF - Los Santos Indonesia Freeroam");
    print(" Development Gamemode Loaded");
    print("========================================");
}

public OnGameModeInit()
{
    SetGameModeText("LSIF Dev v0.2 Economy");

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
        PlayerMoney[i] = 500;
        PlayerXP[i] = 0;
        PlayerLevel[i] = 1;
        PlayerAdmin[i] = 0;
        PlayerVehicle[i] = INVALID_VEHICLE_ID;
    }

    print("[LSIF] Gamemode v0.2 Economy berhasil dijalankan.");
    return 1;
}

public OnGameModeExit()
{
    print("[LSIF] Gamemode dimatikan.");
    return 1;
}

public OnPlayerConnect(playerid)
{
    PlayerMoney[playerid] = 500;
    PlayerXP[playerid] = 0;
    PlayerLevel[playerid] = 1;

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerMoney[playerid]);

    // Untuk development awal, semua player dibuat owner sementara.
    // Nanti kalau database sudah ada, ini akan diganti dari data akun.
    PlayerAdmin[playerid] = 5;

    PlayerVehicle[playerid] = INVALID_VEHICLE_ID;

    SendClientMessage(playerid, COLOR_GREEN, "Selamat datang di LSIF - Los Santos Indonesia Freeroam.");
    SendClientMessage(playerid, COLOR_WHITE, "Server development awal berhasil dijalankan.");
    SendClientMessage(playerid, COLOR_YELLOW, "Gunakan /help untuk melihat command.");

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if (PlayerVehicle[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(PlayerVehicle[playerid]);
        PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
    }

    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
    SetPlayerFacingAngle(playerid, SPAWN_A);

    SetPlayerCameraPos(playerid, 1962.0000, 1343.0000, 17.0000);
    SetPlayerCameraLookAt(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);

    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

    SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
    SetPlayerFacingAngle(playerid, SPAWN_A);

    ResetPlayerWeapons(playerid);

    SendClientMessage(playerid, COLOR_CYAN, "Kamu berhasil spawn di Los Santos.");
    SendClientMessage(playerid, COLOR_WHITE, "Coba command: /help, /stats, /veh 411, /kill.");

    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
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

    SendClientMessage(playerid, COLOR_RED, "Command tidak ditemukan. Gunakan /help.");
    return 1;
}