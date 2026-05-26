#include <open.mp>
#include <a_mysql>
#pragma dynamic 131072

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
#define JOB_TAXI        2
#define JOB_TRUCKER     3

#define WORK_NONE       0
#define WORK_COURIER    1
#define WORK_TAXI       2
#define WORK_TRUCKER    3

#define MAX_COURIER_POINTS 5
#define MAX_TAXI_ROUTES 5

#define TAXI_STAGE_NONE     0
#define TAXI_STAGE_PICKUP   1
#define TAXI_STAGE_DROPOFF  2

#define TAXI_COOLDOWN_SECONDS 30

#define TAXI_BASE_FARE          250
#define TAXI_FARE_PER_UNIT      2
#define TAXI_MIN_REWARD         400
#define TAXI_MAX_REWARD         2500

#define TAXI_BASE_XP            20
#define TAXI_XP_PER_100_UNITS   5
#define TAXI_MIN_XP             25
#define TAXI_MAX_XP             120

#define VEHICLE_TAXI    420
#define VEHICLE_CABBIE  438

#define COURIER_COOLDOWN_SECONDS 30

#define MAX_TRUCKER_ROUTES 5

#define TRUCKER_STAGE_NONE      0
#define TRUCKER_STAGE_PICKUP    1
#define TRUCKER_STAGE_DROPOFF   2

#define TRUCKER_COOLDOWN_SECONDS 45

#define TRUCKER_BASE_FARE          800
#define TRUCKER_FARE_PER_UNIT      3
#define TRUCKER_MIN_REWARD         1200
#define TRUCKER_MAX_REWARD         6000

#define TRUCKER_BASE_XP            45
#define TRUCKER_XP_PER_100_UNITS   8
#define TRUCKER_MIN_XP             60
#define TRUCKER_MAX_XP             250

#define VEHICLE_LINERUNNER 403
#define VEHICLE_TANKER     514
#define VEHICLE_ROADTRAIN  515
#define VEHICLE_DFT30      578
#define VEHICLE_FLATBED    455
#define VEHICLE_YANKEE     456

#define VEHICLE_BURRITO 482
#define VEHICLE_BOXVILLE 498
#define VEHICLE_MULE 414
#define VEHICLE_PONY 413
#define VEHICLE_RUMPO 440

#define VEHICLE_OWNER_NONE 0

#define ADMIN_NONE      0
#define ADMIN_HELPER    1
#define ADMIN_MOD       2
#define ADMIN_ADMIN     3
#define ADMIN_SENIOR    4
#define ADMIN_OWNER     5

#define RACE_NONE       0
#define RACE_LS_INTRO   1

#define MAX_LS_RACE_POINTS 6

#define RACE_LS_REWARD  1200
#define RACE_LS_XP      75

#define RACE_COOLDOWN_SECONDS 120

#define ANTICHEAT_INTERVAL 10000 // 10 detik
#define MONEY_MISMATCH_TOLERANCE 0

#define MAX_BANK_TRANSACTION 10000000

#define MAX_BANK_POINTS 5
#define BANK_ACCESS_RADIUS 7.0

#define MAX_HOUSES 5
#define HOUSE_ACCESS_RADIUS 5.0
#define HOUSE_SELL_PERCENT 70

#define HOUSE_INTERIOR_ID 3
#define HOUSE_VW_OFFSET 10000

#define HOUSE_INT_X 2496.0498
#define HOUSE_INT_Y -1695.2382
#define HOUSE_INT_Z 1014.7422
#define HOUSE_INT_A 180.0000

new MySQL:g_SQL;
new g_AutosaveTimer;

new g_AntiCheatTimer;

new g_ServerStartTick;

new PlayerMoneyMismatchCount[MAX_PLAYERS];
new PlayerLastACWarningTick[MAX_PLAYERS];

new PlayerDBID[MAX_PLAYERS];
new PlayerLoggedIn[MAX_PLAYERS];

new Float:PlayerLastX[MAX_PLAYERS];
new Float:PlayerLastY[MAX_PLAYERS];
new Float:PlayerLastZ[MAX_PLAYERS];
new Float:PlayerLastA[MAX_PLAYERS];

new PlayerMoney[MAX_PLAYERS];
new PlayerBankMoney[MAX_PLAYERS];
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
new Text3D:OwnedVehicleLabel[MAX_PLAYERS];

//job
new PlayerJob[MAX_PLAYERS];
new PlayerWorking[MAX_PLAYERS];
new PlayerWorkType[MAX_PLAYERS];
new PlayerWorkPoint[MAX_PLAYERS];
new PlayerLastWorkTick[MAX_PLAYERS];
new PlayerTaxiStage[MAX_PLAYERS];
new PlayerTaxiRoute[MAX_PLAYERS];

new PlayerTruckerStage[MAX_PLAYERS];
new PlayerTruckerRoute[MAX_PLAYERS];

new Float:TruckerPickupX[MAX_TRUCKER_ROUTES] =
{
    2460.3918,
    2202.9321,
    2786.4487,
    1041.2736,
    1651.7496
};

new Float:TruckerPickupY[MAX_TRUCKER_ROUTES] =
{
    -2114.8193,
        -2663.3110,
        -2417.9055,
        -299.5216,
        -1839.6616
    };

new Float:TruckerPickupZ[MAX_TRUCKER_ROUTES] =
{
    13.5469,
    13.5469,
    13.6328,
    73.9922,
    13.5469
};

new Float:TruckerDropoffX[MAX_TRUCKER_ROUTES] =
{
    1012.0282,
    -77.9614,
    1715.9419,
    2435.4377,
    2852.1299
};

new Float:TruckerDropoffY[MAX_TRUCKER_ROUTES] =
{
    -1350.7133,
        -1136.9480,
        -1951.1108,
        -2088.8242,
        -1523.7355
    };

new Float:TruckerDropoffZ[MAX_TRUCKER_ROUTES] =
{
    13.3438,
    1.0781,
    13.5669,
    13.5469,
    11.0938
};

new Float:TaxiPickupX[MAX_TAXI_ROUTES] =
{
    1481.1278,
    1832.3447,
    2114.5803,
    1175.8121,
    2234.9126
};

new Float:TaxiPickupY[MAX_TAXI_ROUTES] =
{
    -1771.2051,
        -1842.8834,
        -1788.4382,
        -1323.5415,
        -1159.2144
    };

new Float:TaxiPickupZ[MAX_TAXI_ROUTES] =
{
    18.7958,
    13.5781,
    13.5547,
    15.3984,
    25.8906
};

new Float:TaxiDropoffX[MAX_TAXI_ROUTES] =
{
    2072.5527,
    1361.9814,
    2488.3027,
    1552.7406,
    1022.8163
};

new Float:TaxiDropoffY[MAX_TAXI_ROUTES] =
{
    -1831.2913,
        -1285.3228,
        -1666.9521,
        -1675.6229,
        -1123.4095
    };

new Float:TaxiDropoffZ[MAX_TAXI_ROUTES] =
{
    13.5469,
    13.5469,
    13.3438,
    16.1953,
    23.8281
};

// new TaxiReward[MAX_TAXI_ROUTES] =
// {
//     500,
//     700,
//     650,
//     800,
//     900
// };

// new TaxiXP[MAX_TAXI_ROUTES] =
// {
//     35,
//     45,
//     40,
//     50,
//     55
// };

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

new PlayerRace[MAX_PLAYERS];
new PlayerRaceCheckpoint[MAX_PLAYERS];
new PlayerRaceStartTick[MAX_PLAYERS];
new PlayerRaceVehicle[MAX_PLAYERS];
new PlayerLastRaceTick[MAX_PLAYERS];

new Float:RaceLSX[MAX_LS_RACE_POINTS] =
{
    1528.3741,
    1690.6326,
    1812.7244,
    1965.9974,
    2105.4453,
    2265.5576
};

new Float:RaceLSY[MAX_LS_RACE_POINTS] =
{
    -1678.0245,
        -1610.3588,
        -1504.9277,
        -1433.2037,
        -1344.9448,
        -1210.4338
    };

new Float:RaceLSZ[MAX_LS_RACE_POINTS] =
{
    13.3828,
    13.5469,
    6.0600,
    13.5469,
    23.9844,
    24.0000
};

new PlayerLastJobTopQuery[MAX_PLAYERS][32];

new PlayerFindingBank[MAX_PLAYERS];

new Float:BankPointX[MAX_BANK_POINTS] =
{
    1462.1489, // Pershing Square
    1367.2457, // Market
    1833.8134, // Idlewood
    2421.5427, // East LS
    1154.7312  // Santa Maria Beach
};

new Float:BankPointY[MAX_BANK_POINTS] =
{
    -1012.3848,
        -1279.8615,
        -1842.4136,
        -1224.3597,
        -1769.6847
    };

new Float:BankPointZ[MAX_BANK_POINTS] =
{
    26.8438,
    13.5469,
    13.5781,
    25.3828,
    16.5938
};

new BankPointName[MAX_BANK_POINTS][32] =
{
    "Pershing Square Bank",
    "Market ATM",
    "Idlewood ATM",
    "East LS Bank",
    "Santa Maria ATM"
};

new PlayerHouseDBID[MAX_PLAYERS];
new PlayerHouseIndex[MAX_PLAYERS];
new PlayerHouseLocked[MAX_PLAYERS];
new PlayerSpawnHouse[MAX_PLAYERS];
new PlayerInsideHouse[MAX_PLAYERS];
new PlayerFindingHouse[MAX_PLAYERS];
new PlayerFindingHouseIndex[MAX_PLAYERS];

new Float:HouseX[MAX_HOUSES] =
{
    2243.9121,
    2362.7712,
    1412.1656,
    1095.4482,
    827.9244
};

new Float:HouseY[MAX_HOUSES] =
{
    -1638.2314,
        -1643.1138,
        -920.2480,
        -647.5122,
        -858.1049
    };

new Float:HouseZ[MAX_HOUSES] =
{
    15.9074,
    13.5234,
    35.0781,
    113.6484,
    70.3308
};

new HousePrice[MAX_HOUSES] =
{
    50000,
    75000,
    120000,
    180000,
    250000
};

new HouseName[MAX_HOUSES][64] =
{
    "Ganton Starter House",
    "Idlewood Family House",
    "Market Hill House",
    "Mulholland View House",
    "Richman Small Villa"
};

stock Float:GetDistanceBetweenPoints3D(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    new Float:dx = x1 - x2;
    new Float:dy = y1 - y2;
    new Float:dz = z1 - z2;

    return floatsqroot((dx * dx) + (dy * dy) + (dz * dz));
}

stock ClampInt(value, minValue, maxValue)
{
    if (value < minValue)
    {
        return minValue;
    }

    if (value > maxValue)
    {
        return maxValue;
    }

    return value;
}

stock Float:GetTaxiRouteDistance(route)
{
    if (route < 0 || route >= MAX_TAXI_ROUTES)
    {
        return 0.0;
    }

    return GetDistanceBetweenPoints3D(
               TaxiPickupX[route],
               TaxiPickupY[route],
               TaxiPickupZ[route],
               TaxiDropoffX[route],
               TaxiDropoffY[route],
               TaxiDropoffZ[route]
           );
}

stock GetTaxiDynamicReward(route)
{
    new Float:distance = GetTaxiRouteDistance(route);

    new reward = TAXI_BASE_FARE + floatround(distance * TAXI_FARE_PER_UNIT);

    return ClampInt(reward, TAXI_MIN_REWARD, TAXI_MAX_REWARD);
}

stock GetTaxiDynamicXP(route)
{
    new Float:distance = GetTaxiRouteDistance(route);

    new xp = TAXI_BASE_XP + floatround((distance / 100.0) * TAXI_XP_PER_100_UNITS);

    return ClampInt(xp, TAXI_MIN_XP, TAXI_MAX_XP);
}

stock IsTruckerVehicleModel(modelid)
{
    if (modelid == VEHICLE_LINERUNNER) return 1;
    if (modelid == VEHICLE_TANKER) return 1;
    if (modelid == VEHICLE_ROADTRAIN) return 1;
    if (modelid == VEHICLE_DFT30) return 1;
    if (modelid == VEHICLE_FLATBED) return 1;
    if (modelid == VEHICLE_YANKEE) return 1;

    return 0;
}

stock IsPlayerInTruckerVehicle(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return 0;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new modelid = GetVehicleModel(vehicleid);

    return IsTruckerVehicleModel(modelid);
}

stock GetTruckerCooldownLeft(playerid)
{
    new lastTick = PlayerLastWorkTick[playerid];

    if (lastTick == 0)
    {
        return 0;
    }

    new currentTick = GetTickCount();
    new elapsed = (currentTick - lastTick) / 1000;

    if (elapsed >= TRUCKER_COOLDOWN_SECONDS)
    {
        return 0;
    }

    return TRUCKER_COOLDOWN_SECONDS - elapsed;
}

stock ResetTruckerWorkData(playerid)
{
    PlayerTruckerStage[playerid] = TRUCKER_STAGE_NONE;
    PlayerTruckerRoute[playerid] = -1;
    return 1;
}

stock Float:GetTruckerRouteDistance(route)
{
    if (route < 0 || route >= MAX_TRUCKER_ROUTES)
    {
        return 0.0;
    }

    return GetDistanceBetweenPoints3D(
               TruckerPickupX[route],
               TruckerPickupY[route],
               TruckerPickupZ[route],
               TruckerDropoffX[route],
               TruckerDropoffY[route],
               TruckerDropoffZ[route]
           );
}

stock GetTruckerDynamicReward(route)
{
    new Float:distance = GetTruckerRouteDistance(route);

    new reward = TRUCKER_BASE_FARE + floatround(distance * TRUCKER_FARE_PER_UNIT);

    return ClampInt(reward, TRUCKER_MIN_REWARD, TRUCKER_MAX_REWARD);
}

stock GetTruckerDynamicXP(route)
{
    new Float:distance = GetTruckerRouteDistance(route);

    new xp = TRUCKER_BASE_XP + floatround((distance / 100.0) * TRUCKER_XP_PER_100_UNITS);

    return ClampInt(xp, TRUCKER_MIN_XP, TRUCKER_MAX_XP);
}

forward OnAccountCheck(playerid);
forward OnAccountRegister(playerid);
forward OnAccountLogin(playerid);
forward AutoSavePlayers();
forward OnPlayerDataSaved(playerid, notify);
forward OnOwnedVehicleCheck(playerid);
forward OnOwnedVehicleBought(playerid, modelid, price);
forward OnOwnedVehicleSaved(playerid, notify);
forward OnOwnedVehicleSold(playerid, sellPrice);
forward DelayedKick(playerid);
forward OnPlayerBanCheck(playerid);
forward OnPlayerBanned(playerid, targetid);
forward OnPlayerUnbanned(playerid);
forward OnPlayerBanInfo(playerid);
forward OnReportCreated(playerid, targetid);
forward OnReportsList(playerid);
forward OnReportClosed(playerid, reportid);
forward OnRaceRecordSaved(playerid, timeMs);
forward OnRaceTop(playerid);
forward OnJobStatsLoaded(playerid);
forward OnJobTopLoaded(playerid);
forward OnJobProgressSaved(playerid);
forward AntiCheatCheck();
forward OnDatabasePing(playerid);
forward OnPlayerHouseLoaded(playerid);
forward OnPlayerHouseBought(playerid, houseIndex, price);
forward OnPlayerHouseSold(playerid, sellPrice);

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

stock SyncPlayerMoneyHUD(playerid)
{
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerMoney[playerid]);
    return 1;
}

stock ReportSuspiciousActivity(playerid, const reason[])
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }

    new nowTick = GetTickCount();

    // Batasi log anti-cheat per player maksimal 1x per 30 detik.
    if (PlayerLastACWarningTick[playerid] != 0 && nowTick - PlayerLastACWarningTick[playerid] < 30000)
    {
        return 1;
    }

    PlayerLastACWarningTick[playerid] = nowTick;

    new name[MAX_PLAYER_NAME];
    new msg[144];

    GetPlayerName(playerid, name, sizeof(name));

    format(msg, sizeof(msg), "[AC] %s[%d]: %s", name, playerid, reason);
    print(msg);

    SendMessageToAdmins(COLOR_ORANGE, msg);

    LogAdminAction(INVALID_PLAYER_ID, playerid, "ANTICHEAT", reason);

    return 1;
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
    PlayerBankMoney[playerid] = 0;
    PlayerXP[playerid] = 0;
    PlayerLevel[playerid] = 1;
    PlayerAdmin[playerid] = 0;
    PlayerVehicle[playerid] = INVALID_VEHICLE_ID;
    ResetOwnedVehicleData(playerid);
    ResetPlayerRaceData(playerid);
    PlayerFindingBank[playerid] = 0;
    ResetPlayerHouseData(playerid);

    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = 0;
    ResetTaxiWorkData(playerid);
    ResetTruckerWorkData(playerid);

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;

    PlayerMoneyMismatchCount[playerid] = 0;
    PlayerLastACWarningTick[playerid] = 0;

    SyncPlayerMoneyHUD(playerid);
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

    if (PlayerInsideHouse[playerid] && PlayerHouseIndex[playerid] != -1)
    {
        new houseIndex = PlayerHouseIndex[playerid];

        x = HouseX[houseIndex];
        y = HouseY[houseIndex];
        z = HouseZ[houseIndex];
        a = 0.0;
    }
    else
    {
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
    }

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE players SET money=%d, bank_money=%d, xp=%d, level=%d, admin_level=%d, current_job=%d, spawn_house=%d, pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f WHERE id=%d LIMIT 1",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid],
        PlayerXP[playerid],
        PlayerLevel[playerid],
        PlayerAdmin[playerid],
        PlayerJob[playerid],
        PlayerSpawnHouse[playerid],
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
    SyncPlayerMoneyHUD(playerid);
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

stock GetThreeParams(const input[], param1[], param1Size, param2[], param2Size, param3[], param3Size)
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

    while (input[i] == ' ')
    {
        i++;
    }

    p = 0;

    while (input[i] != EOS && p < param3Size - 1)
    {
        param3[p] = input[i];
        p++;
        i++;
    }
    param3[p] = EOS;

    if (param1[0] == EOS || param2[0] == EOS || param3[0] == EOS)
    {
        return 0;
    }

    return 1;
}

stock GetFirstParamAndRest(const input[], param1[], param1Size, rest[], restSize)
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

    while (input[i] != EOS && p < restSize - 1)
    {
        rest[p] = input[i];
        p++;
        i++;
    }
    rest[p] = EOS;

    if (param1[0] == EOS || rest[0] == EOS)
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
    SyncPlayerMoneyHUD(playerid);

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
    SyncPlayerMoneyHUD(playerid);

    return 1;
}

stock GivePlayerBankMoney(playerid, amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    PlayerBankMoney[playerid] += amount;
    return 1;
}

stock TakePlayerBankMoney(playerid, amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    if (PlayerBankMoney[playerid] < amount)
    {
        return 0;
    }

    PlayerBankMoney[playerid] -= amount;
    return 1;
}

stock IsValidBankAmount(amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    if (amount > MAX_BANK_TRANSACTION)
    {
        return 0;
    }

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

    if (jobid == JOB_TAXI)
    {
        format(output, size, "Taxi Driver");
        return 1;
    }

    if (jobid == JOB_TRUCKER)
    {
        format(output, size, "Trucker");
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
    AddJobProgress(playerid, "courier", reward, xp);

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

stock StartTaxiWork(playerid)
{
    if (PlayerJob[playerid] != JOB_TAXI)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum bekerja sebagai taxi driver. Gunakan /joinjob taxi.");
        return 0;
    }

    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang menjalankan pekerjaan. Gunakan /cancelwork untuk membatalkan.");
        return 0;
    }

    new cooldownLeft = GetTaxiCooldownLeft(playerid);

    if (cooldownLeft > 0)
    {
        new cooldownMsg[144];
        format(cooldownMsg, sizeof(cooldownMsg), "Tunggu %d detik sebelum mengambil order taxi berikutnya.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, cooldownMsg);
        return 0;
    }

    if (!IsPlayerInTaxiVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus menjadi driver kendaraan Taxi/Cabbie untuk mulai kerja taxi.");
        SendClientMessage(playerid, COLOR_WHITE, "Untuk test cepat gunakan: /veh 420 atau /veh 438.");
        return 0;
    }

    new route = random(MAX_TAXI_ROUTES);

    PlayerWorking[playerid] = 1;
    PlayerWorkType[playerid] = WORK_TAXI;
    PlayerWorkPoint[playerid] = route;

    PlayerTaxiStage[playerid] = TAXI_STAGE_PICKUP;
    PlayerTaxiRoute[playerid] = route;

    SetPlayerCheckpoint(
        playerid,
        TaxiPickupX[route],
        TaxiPickupY[route],
        TaxiPickupZ[route],
        4.0
    );

    new msg[144];
    new reward = GetTaxiDynamicReward(route);
    new xp = GetTaxiDynamicXP(route);
    new Float:distance = GetTaxiRouteDistance(route);

    format(
        msg,
        sizeof(msg),
        "Taxi: jemput penumpang. Estimasi jarak: %.1f unit.",
        distance
    );
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(
        msg,
        sizeof(msg),
        "Estimasi reward: $%d dan %d XP.",
        reward,
        xp
    );
    SendClientMessage(playerid, COLOR_CYAN, msg);

    SendClientMessage(playerid, COLOR_WHITE, "Tetap gunakan kendaraan taxi sampai order selesai.");

    return 1;
}

stock HandleTaxiCheckpoint(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_TAXI)
    {
        return 0;
    }

    new route = PlayerTaxiRoute[playerid];

    if (route < 0 || route >= MAX_TAXI_ROUTES)
    {
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Taxi order error. Pekerjaan dibatalkan.");
        return 1;
    }

    if (!IsPlayerInTaxiVehicle(playerid))
    {
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Taxi order dibatalkan karena kamu tidak berada sebagai driver Taxi/Cabbie.");
        return 1;
    }

    if (PlayerTaxiStage[playerid] == TAXI_STAGE_PICKUP)
    {
        PlayerTaxiStage[playerid] = TAXI_STAGE_DROPOFF;

        SetPlayerCheckpoint(
            playerid,
            TaxiDropoffX[route],
            TaxiDropoffY[route],
            TaxiDropoffZ[route],
            4.0
        );

        SendClientMessage(playerid, COLOR_GREEN, "Penumpang naik. Antar ke checkpoint tujuan.");
        return 1;
    }

    if (PlayerTaxiStage[playerid] == TAXI_STAGE_DROPOFF)
    {
        CompleteTaxiWork(playerid);
        return 1;
    }

    return 1;
}

stock CompleteTaxiWork(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_TAXI)
    {
        return 0;
    }

    new route = PlayerTaxiRoute[playerid];

    if (route < 0 || route >= MAX_TAXI_ROUTES)
    {
        route = 0;
    }

    new reward = GetTaxiDynamicReward(route);
    new xp = GetTaxiDynamicXP(route);
    new Float:distance = GetTaxiRouteDistance(route);

    GivePlayerCash(playerid, reward);
    GivePlayerXPEx(playerid, xp);
    AddJobProgress(playerid, "taxi", reward, xp);

    DisablePlayerCheckpoint(playerid);

    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = GetTickCount();

    ResetTaxiWorkData(playerid);

    new msg[144];
    format(
        msg,
        sizeof(msg),
        "Taxi order selesai. Jarak trip: %.1f unit.",
        distance
    );
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(
        msg,
        sizeof(msg),
        "Kamu mendapat $%d dan %d XP.",
        reward,
        xp
    );
    SendClientMessage(playerid, COLOR_CYAN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work lagi setelah cooldown untuk mengambil order taxi berikutnya.");

    SavePlayerData(playerid);

    return 1;
}

stock StartTruckerWork(playerid)
{
    if (PlayerJob[playerid] != JOB_TRUCKER)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum bekerja sebagai trucker. Gunakan /joinjob trucker.");
        return 0;
    }

    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang menjalankan pekerjaan. Gunakan /cancelwork untuk membatalkan.");
        return 0;
    }

    new cooldownLeft = GetTruckerCooldownLeft(playerid);

    if (cooldownLeft > 0)
    {
        new cooldownMsg[144];
        format(cooldownMsg, sizeof(cooldownMsg), "Tunggu %d detik sebelum mengambil muatan berikutnya.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, cooldownMsg);
        return 0;
    }

    if (!IsPlayerInTruckerVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus menjadi driver kendaraan truck untuk mulai kerja trucker.");
        SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Linerunner, Tanker, Roadtrain, DFT-30, Flatbed, Yankee.");
        SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 515 atau /veh 403.");
        return 0;
    }

    new route = random(MAX_TRUCKER_ROUTES);

    PlayerWorking[playerid] = 1;
    PlayerWorkType[playerid] = WORK_TRUCKER;
    PlayerWorkPoint[playerid] = route;

    PlayerTruckerStage[playerid] = TRUCKER_STAGE_PICKUP;
    PlayerTruckerRoute[playerid] = route;

    SetPlayerCheckpoint(
        playerid,
        TruckerPickupX[route],
        TruckerPickupY[route],
        TruckerPickupZ[route],
        6.0
    );

    new msg[144];
    new reward = GetTruckerDynamicReward(route);
    new xp = GetTruckerDynamicXP(route);
    new Float:distance = GetTruckerRouteDistance(route);

    format(msg, sizeof(msg), "Trucker: ambil cargo di checkpoint. Estimasi jarak: %.1f unit.", distance);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Estimasi reward: $%d dan %d XP.", reward, xp);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    SendClientMessage(playerid, COLOR_WHITE, "Tetap gunakan truck sampai delivery selesai.");
    return 1;
}

stock HandleTruckerCheckpoint(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_TRUCKER)
    {
        return 0;
    }

    new route = PlayerTruckerRoute[playerid];

    if (route < 0 || route >= MAX_TRUCKER_ROUTES)
    {
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Trucker route error. Pekerjaan dibatalkan.");
        return 1;
    }

    if (!IsPlayerInTruckerVehicle(playerid))
    {
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Trucker job dibatalkan karena kamu tidak berada sebagai driver truck.");
        return 1;
    }

    if (PlayerTruckerStage[playerid] == TRUCKER_STAGE_PICKUP)
    {
        PlayerTruckerStage[playerid] = TRUCKER_STAGE_DROPOFF;

        SetPlayerCheckpoint(
            playerid,
            TruckerDropoffX[route],
            TruckerDropoffY[route],
            TruckerDropoffZ[route],
            7.0
        );

        SendClientMessage(playerid, COLOR_GREEN, "Cargo berhasil dimuat. Antar ke checkpoint tujuan.");
        return 1;
    }

    if (PlayerTruckerStage[playerid] == TRUCKER_STAGE_DROPOFF)
    {
        CompleteTruckerWork(playerid);
        return 1;
    }

    return 1;
}

stock CompleteTruckerWork(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_TRUCKER)
    {
        return 0;
    }

    new route = PlayerTruckerRoute[playerid];

    if (route < 0 || route >= MAX_TRUCKER_ROUTES)
    {
        route = 0;
    }

    new reward = GetTruckerDynamicReward(route);
    new xp = GetTruckerDynamicXP(route);
    new Float:distance = GetTruckerRouteDistance(route);
    new msg[144];

    GivePlayerCash(playerid, reward);
    GivePlayerXPEx(playerid, xp);
    AddJobProgress(playerid, "trucker", reward, xp);

    DisablePlayerCheckpoint(playerid);

    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = GetTickCount();

    ResetTruckerWorkData(playerid);

    format(msg, sizeof(msg), "Cargo berhasil dikirim. Jarak trip: %.1f unit.", distance);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Kamu mendapat $%d dan %d XP.", reward, xp);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work lagi setelah cooldown untuk mengambil muatan berikutnya.");

    SavePlayerData(playerid);
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

    ResetTaxiWorkData(playerid);
    ResetTruckerWorkData(playerid);

    SendClientMessage(playerid, COLOR_YELLOW, "Pekerjaan aktif dibatalkan.");
    return 1;
}

stock ResetOwnedVehicleData(playerid)
{
    OwnedVehicleDBID[playerid] = 0;
    OwnedVehicleModel[playerid] = 0;
    OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    OwnedVehicleLocked[playerid] = 0;
    OwnedVehicleLabel[playerid] = Text3D:INVALID_3DTEXT_ID;

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
        DestroyOwnedVehicleLabel(playerid);
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

    ApplyOwnedVehicleParams(playerid);
    CreateOwnedVehicleLabel(playerid);

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

stock ApplyOwnedVehicleParams(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    SetVehicleParamsEx(
        OwnedVehicleID[playerid],
        1, // engine ON
        0, // lights OFF
        0, // alarm OFF
        OwnedVehicleLocked[playerid] ? 1 : 0, // doors
        0, // bonnet CLOSED
        0, // boot CLOSED
        0  // objective OFF
    );

    return 1;
}

stock GetOwnedVehicleOwner(vehicleid)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && OwnedVehicleID[i] == vehicleid)
        {
            return i;
        }
    }

    return INVALID_PLAYER_ID;
}

stock IsOwnedVehicle(vehicleid)
{
    return GetOwnedVehicleOwner(vehicleid) != INVALID_PLAYER_ID;
}

stock CreateOwnedVehicleLabel(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    if (OwnedVehicleLabel[playerid] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(OwnedVehicleLabel[playerid]);
        OwnedVehicleLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
    }

    new ownerName[MAX_PLAYER_NAME];
    new labelText[144];

    GetPlayerName(playerid, ownerName, sizeof(ownerName));

    format(
        labelText,
        sizeof(labelText),
        "LSIF Vehicle\nOwner: %s\nModel: %d",
        ownerName,
        OwnedVehicleModel[playerid]
    );

    OwnedVehicleLabel[playerid] = Create3DTextLabel(
                                      labelText,
                                      COLOR_CYAN,
                                      0.0,
                                      0.0,
                                      0.0,
                                      20.0,
                                      0,
                                      true
                                  );

    Attach3DTextLabelToVehicle(
        OwnedVehicleLabel[playerid],
        OwnedVehicleID[playerid],
        0.0,
        0.0,
        1.2
    );

    return 1;
}

stock DestroyOwnedVehicleLabel(playerid)
{
    if (OwnedVehicleLabel[playerid] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(OwnedVehicleLabel[playerid]);
        OwnedVehicleLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
    }

    return 1;
}

stock IsAdminLevel(playerid, level)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    if (PlayerAdmin[playerid] < level)
    {
        return 0;
    }

    return 1;
}

stock GetAdminRankName(level, output[], size)
{
    switch (level)
    {
        case ADMIN_HELPER: format(output, size, "Helper");
        case ADMIN_MOD: format(output, size, "Moderator");
        case ADMIN_ADMIN: format(output, size, "Admin");
        case ADMIN_SENIOR: format(output, size, "Senior Admin");
        case ADMIN_OWNER: format(output, size, "Owner");
        default:
            format(output, size, "Player");
    }

    return 1;
}

stock LogAdminAction(playerid, targetid, const action[], const detail[])
{
    new adminName[MAX_PLAYER_NAME];
    new targetName[MAX_PLAYER_NAME];
    new adminDbId = 0;
    new targetDbId = 0;
    new query[512];

    if (playerid != INVALID_PLAYER_ID && IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, adminName, sizeof(adminName));
        adminDbId = PlayerDBID[playerid];
    }
    else
    {
        format(adminName, sizeof(adminName), "SYSTEM");
        adminDbId = 0;
    }

    if (targetid != INVALID_PLAYER_ID && IsPlayerConnected(targetid))
    {
        GetPlayerName(targetid, targetName, sizeof(targetName));
        targetDbId = PlayerDBID[targetid];
    }
    else
    {
        format(targetName, sizeof(targetName), "-");
        targetDbId = 0;
    }

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO admin_logs (admin_id, admin_name, target_id, target_name, action, detail) VALUES (%d, '%e', %d, '%e', '%e', '%e')",
        adminDbId,
        adminName,
        targetDbId,
        targetName,
        action,
        detail
    );

    mysql_tquery(g_SQL, query);
    return 1;
}

stock CheckPlayerBan(playerid)
{
    new username[MAX_PLAYER_NAME];
    new ip[45];
    new query[512];

    GetPlayerName(playerid, username, sizeof(username));
    GetPlayerIp(playerid, ip, sizeof(ip));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT id, reason, admin_name, duration_minutes, expires_at FROM bans WHERE active=1 AND (player_name='%e' OR ip_address='%e') AND (expires_at IS NULL OR expires_at > NOW()) ORDER BY id DESC LIMIT 1",
        username,
        ip
    );

    mysql_tquery(g_SQL, query, "OnPlayerBanCheck", "i", playerid);
    return 1;
}

stock SendMessageToAdmins(color, const message[])
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] >= ADMIN_HELPER)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}

stock FormatRaceTime(timeMs, output[], size)
{
    new seconds = timeMs / 1000;
    new milliseconds = timeMs % 1000;
    new minutes = seconds / 60;

    seconds = seconds % 60;

    format(output, size, "%02d:%02d.%03d", minutes, seconds, milliseconds);
    return 1;
}

stock ResetPlayerRaceData(playerid)
{
    PlayerRace[playerid] = RACE_NONE;
    PlayerRaceCheckpoint[playerid] = 0;
    PlayerRaceStartTick[playerid] = 0;
    PlayerRaceVehicle[playerid] = INVALID_VEHICLE_ID;
    return 1;
}

stock GetRaceName(raceid, output[], size)
{
    if (raceid == RACE_LS_INTRO)
    {
        format(output, size, "Los Santos Intro");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock ShowRaceCheckpoint(playerid)
{
    if (PlayerRace[playerid] != RACE_LS_INTRO)
    {
        return 0;
    }

    new cp = PlayerRaceCheckpoint[playerid];

    if (cp < 0 || cp >= MAX_LS_RACE_POINTS)
    {
        return 0;
    }

    SetPlayerCheckpoint(
        playerid,
        RaceLSX[cp],
        RaceLSY[cp],
        RaceLSZ[cp],
        6.0
    );

    new msg[144];

    if (cp == MAX_LS_RACE_POINTS - 1)
    {
        format(msg, sizeof(msg), "Race: checkpoint finish! CP %d/%d", cp + 1, MAX_LS_RACE_POINTS);
    }
    else
    {
        format(msg, sizeof(msg), "Race: menuju checkpoint %d/%d.", cp + 1, MAX_LS_RACE_POINTS);
    }

    SendClientMessage(playerid, COLOR_CYAN, msg);
    return 1;
}

stock StartLSIntroRace(playerid)
{
    if (PlayerRace[playerid] != RACE_NONE)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang mengikuti race. Gunakan /leaverace untuk keluar.");
        return 0;
    }

    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang bekerja. Batalkan dulu dengan /cancelwork.");
        return 0;
    }

    new cooldownLeft = GetRaceCooldownLeft(playerid);

    if (cooldownLeft > 0)
    {
        new cooldownMsg[144];
        format(cooldownMsg, sizeof(cooldownMsg), "Tunggu %d detik sebelum ikut race lagi.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, cooldownMsg);
        return 0;
    }

    if (!IsPlayerInAnyVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di kendaraan untuk ikut race.");
        SendClientMessage(playerid, COLOR_WHITE, "Untuk test cepat: /veh 411 lalu /joinrace ls.");
        return 0;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus menjadi driver, bukan passenger.");
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);

    SetVehiclePos(vehicleid, RaceLSX[0], RaceLSY[0], RaceLSZ[0]);
    SetVehicleZAngle(vehicleid, 90.0);
    PutPlayerInVehicle(playerid, vehicleid, 0);

    PlayerRace[playerid] = RACE_LS_INTRO;
    PlayerRaceCheckpoint[playerid] = 1;
    PlayerRaceStartTick[playerid] = GetTickCount();
    PlayerRaceVehicle[playerid] = vehicleid;

    SendClientMessage(playerid, COLOR_GREEN, "Race Los Santos Intro dimulai!");
    SendClientMessage(playerid, COLOR_WHITE, "Ikuti checkpoint sampai finish. Jangan keluar kendaraan.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /leaverace untuk keluar dari race.");

    ShowRaceCheckpoint(playerid);
    return 1;
}

stock CancelPlayerRace(playerid)
{
    if (PlayerRace[playerid] == RACE_NONE)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang mengikuti race.");
        return 0;
    }

    DisablePlayerCheckpoint(playerid);
    ResetPlayerRaceData(playerid);

    SendClientMessage(playerid, COLOR_YELLOW, "Kamu keluar dari race.");
    return 1;
}

stock SaveRaceRecord(playerid, const raceCode[], timeMs)
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO race_records (player_id, race_code, best_time_ms, total_finishes) VALUES (%d, '%e', %d, 1) ON DUPLICATE KEY UPDATE best_time_ms=IF(%d < best_time_ms, %d, best_time_ms), total_finishes=total_finishes+1, updated_at=NOW()",
        PlayerDBID[playerid],
        raceCode,
        timeMs,
        timeMs,
        timeMs
    );

    mysql_tquery(g_SQL, query, "OnRaceRecordSaved", "ii", playerid, timeMs);
    return 1;
}

stock CompletePlayerRace(playerid)
{
    if (PlayerRace[playerid] != RACE_LS_INTRO)
    {
        return 0;
    }

    new timeMs = GetTickCount() - PlayerRaceStartTick[playerid];
    new timeText[32];
    new msg[144];

    FormatRaceTime(timeMs, timeText, sizeof(timeText));

    DisablePlayerCheckpoint(playerid);

    GivePlayerCash(playerid, RACE_LS_REWARD);
    GivePlayerXPEx(playerid, RACE_LS_XP);

    format(msg, sizeof(msg), "Race selesai! Waktu kamu: %s. Reward: $%d dan %d XP.", timeText, RACE_LS_REWARD, RACE_LS_XP);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SaveRaceRecord(playerid, "ls_intro", timeMs);

    PlayerLastRaceTick[playerid] = GetTickCount();

    ResetPlayerRaceData(playerid);
    SavePlayerData(playerid);

    return 1;
}

stock HandleRaceCheckpoint(playerid)
{
    if (PlayerRace[playerid] == RACE_NONE)
    {
        return 0;
    }

    if (!IsPlayerValidRaceDriver(playerid))
    {
        CancelPlayerRace(playerid);
        SendClientMessage(playerid, COLOR_RED, "Race dibatalkan karena kamu tidak berada di kendaraan race sebagai driver.");
        return 1;
    }

    if (PlayerRace[playerid] == RACE_LS_INTRO)
    {
        if (PlayerRaceCheckpoint[playerid] >= MAX_LS_RACE_POINTS - 1)
        {
            CompletePlayerRace(playerid);
            return 1;
        }

        PlayerRaceCheckpoint[playerid]++;
        ShowRaceCheckpoint(playerid);
        return 1;
    }

    return 0;
}

stock GetRaceCooldownLeft(playerid)
{
    new lastTick = PlayerLastRaceTick[playerid];

    if (lastTick == 0)
    {
        return 0;
    }

    new currentTick = GetTickCount();
    new elapsed = (currentTick - lastTick) / 1000;

    if (elapsed >= RACE_COOLDOWN_SECONDS)
    {
        return 0;
    }

    return RACE_COOLDOWN_SECONDS - elapsed;
}

stock IsPlayerValidRaceDriver(playerid)
{
    if (PlayerRace[playerid] == RACE_NONE)
    {
        return 0;
    }

    if (PlayerRaceVehicle[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    if (!IsPlayerInAnyVehicle(playerid))
    {
        return 0;
    }

    if (GetPlayerVehicleID(playerid) != PlayerRaceVehicle[playerid])
    {
        return 0;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        return 0;
    }

    return 1;
}

stock IsTaxiVehicleModel(modelid)
{
    if (modelid == VEHICLE_TAXI) return 1;
    if (modelid == VEHICLE_CABBIE) return 1;

    return 0;
}

stock IsPlayerInTaxiVehicle(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return 0;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new modelid = GetVehicleModel(vehicleid);

    return IsTaxiVehicleModel(modelid);
}

stock GetTaxiCooldownLeft(playerid)
{
    new lastTick = PlayerLastWorkTick[playerid];

    if (lastTick == 0)
    {
        return 0;
    }

    new currentTick = GetTickCount();
    new elapsed = (currentTick - lastTick) / 1000;

    if (elapsed >= TAXI_COOLDOWN_SECONDS)
    {
        return 0;
    }

    return TAXI_COOLDOWN_SECONDS - elapsed;
}

stock ResetTaxiWorkData(playerid)
{
    PlayerTaxiStage[playerid] = TAXI_STAGE_NONE;
    PlayerTaxiRoute[playerid] = -1;
    return 1;
}

stock GetJobCode(jobid, output[], size)
{
    if (jobid == JOB_COURIER)
    {
        format(output, size, "courier");
        return 1;
    }

    if (jobid == JOB_TAXI)
    {
        format(output, size, "taxi");
        return 1;
    }

    if (jobid == JOB_TRUCKER)
    {
        format(output, size, "trucker");
        return 1;
    }

    format(output, size, "none");
    return 1;
}

stock IsValidJobCode(const jobCode[])
{
    if (!strcmp(jobCode, "courier", true)) return 1;
    if (!strcmp(jobCode, "taxi", true)) return 1;
    if (!strcmp(jobCode, "trucker", true)) return 1;

    return 0;
}

stock AddJobProgress(playerid, const jobCode[], earned, xp)
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        return 0;
    }

    if (!IsValidJobCode(jobCode))
    {
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO job_stats (player_id, job_code, total_completed, total_earned, total_xp) VALUES (%d, '%e', 1, %d, %d) ON DUPLICATE KEY UPDATE total_completed=total_completed+1, total_earned=total_earned+%d, total_xp=total_xp+%d, updated_at=NOW()",
        PlayerDBID[playerid],
        jobCode,
        earned,
        xp,
        earned,
        xp
    );

    mysql_tquery(g_SQL, query, "OnJobProgressSaved", "i", playerid);
    return 1;
}

stock FormatUptime(uptimeMs, output[], size)
{
    new totalSeconds = uptimeMs / 1000;
    new days = totalSeconds / 86400;
    new hours = (totalSeconds % 86400) / 3600;
    new minutes = (totalSeconds % 3600) / 60;
    new seconds = totalSeconds % 60;

    format(output, size, "%d hari, %02d jam, %02d menit, %02d detik", days, hours, minutes, seconds);
    return 1;
}

stock CountOnlinePlayers()
{
    new count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            count++;
        }
    }

    return count;
}

stock CountLoggedPlayers()
{
    new count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i])
        {
            count++;
        }
    }

    return count;
}

stock GetWorkName(workType, output[], size)
{
    if (workType == WORK_COURIER)
    {
        format(output, size, "Courier");
        return 1;
    }

    if (workType == WORK_TAXI)
    {
        format(output, size, "Taxi");
        return 1;
    }

    if (workType == WORK_TRUCKER)
    {
        format(output, size, "Trucker");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock GetRaceDebugName(raceid, output[], size)
{
    if (raceid == RACE_LS_INTRO)
    {
        format(output, size, "LS Intro");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock GetNearestBankPoint(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(
                playerid,
                BankPointX[i],
                BankPointY[i],
                BankPointZ[i]
                                               );

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock IsPlayerNearBankPoint(playerid)
{
    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        if (GetPlayerDistanceFromPoint(playerid, BankPointX[i], BankPointY[i], BankPointZ[i]) <= BANK_ACCESS_RADIUS)
        {
            return 1;
        }
    }

    return 0;
}

stock GetNearestBankDistance(playerid)
{
    new nearest = GetNearestBankPoint(playerid);

    if (nearest == -1)
    {
        return 999999;
    }

    return floatround(GetPlayerDistanceFromPoint(
                          playerid,
                          BankPointX[nearest],
                          BankPointY[nearest],
                          BankPointZ[nearest]
                      ));
}

stock ResetPlayerHouseData(playerid)
{
    PlayerHouseDBID[playerid] = 0;
    PlayerHouseIndex[playerid] = -1;
    PlayerHouseLocked[playerid] = 1;
    PlayerSpawnHouse[playerid] = 0;
    PlayerInsideHouse[playerid] = 0;
    PlayerFindingHouse[playerid] = 0;
    PlayerFindingHouseIndex[playerid] = -1;
    return 1;
}

stock IsValidHouseIndex(houseIndex)
{
    if (houseIndex < 0 || houseIndex >= MAX_HOUSES)
    {
        return 0;
    }

    return 1;
}

stock IsPlayerNearHouse(playerid, houseIndex)
{
    if (!IsValidHouseIndex(houseIndex))
    {
        return 0;
    }

    if (GetPlayerDistanceFromPoint(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]) <= HOUSE_ACCESS_RADIUS)
    {
        return 1;
    }

    return 0;
}

stock LoadPlayerHouse(playerid)
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
        "SELECT id, house_index, locked FROM player_houses WHERE owner_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerHouseLoaded", "i", playerid);
    return 1;
}

stock GetNearestHouse(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(playerid, HouseX[i], HouseY[i], HouseZ[i]);

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock GetPlayerHouseVirtualWorld(playerid)
{
    if (PlayerDBID[playerid] <= 0)
    {
        return HOUSE_VW_OFFSET + playerid;
    }

    return HOUSE_VW_OFFSET + PlayerDBID[playerid];
}

stock EnterPlayerHouse(playerid)
{
    if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
        return 0;
    }

    if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak bisa masuk rumah saat job/race aktif.");
        return 0;
    }

    new houseIndex = PlayerHouseIndex[playerid];

    if (!IsPlayerNearHouse(playerid, houseIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumahmu untuk masuk.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /gohome atau /findhouse [id].");
        return 0;
    }

    PlayerInsideHouse[playerid] = 1;

    SetPlayerInterior(playerid, HOUSE_INTERIOR_ID);
    SetPlayerVirtualWorld(playerid, GetPlayerHouseVirtualWorld(playerid));
    SetPlayerPos(playerid, HOUSE_INT_X, HOUSE_INT_Y, HOUSE_INT_Z);
    SetPlayerFacingAngle(playerid, HOUSE_INT_A);

    SendClientMessage(playerid, COLOR_GREEN, "Kamu masuk ke dalam rumah.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /exithouse untuk keluar.");

    return 1;
}

stock ExitPlayerHouse(playerid)
{
    if (!PlayerInsideHouse[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang berada di dalam rumah.");
        return 0;
    }

    if (PlayerHouseIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Data rumah tidak valid.");
        return 0;
    }

    new houseIndex = PlayerHouseIndex[playerid];

    PlayerInsideHouse[playerid] = 0;

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]);
    SetPlayerFacingAngle(playerid, 0.0);

    SendClientMessage(playerid, COLOR_GREEN, "Kamu keluar dari rumah.");
    return 1;
}

stock SavePlayerHouseLock(playerid)
{
    if (PlayerHouseDBID[playerid] <= 0)
    {
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_houses SET locked=%d WHERE id=%d AND owner_id=%d LIMIT 1",
        PlayerHouseLocked[playerid],
        PlayerHouseDBID[playerid],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);
    return 1;
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
    g_ServerStartTick = GetTickCount();
    SetGameModeText("LSIF Dev v0.12B House Interior");

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
        PlayerBankMoney[i] = 0;
        PlayerXP[i] = 0;
        PlayerLevel[i] = 1;
        PlayerAdmin[i] = 0;
        PlayerVehicle[i] = INVALID_VEHICLE_ID;
        ResetOwnedVehicleData(i);
        ResetPlayerRaceData(i);
        PlayerLastRaceTick[i] = 0;
        ResetTaxiWorkData(i);
        ResetTruckerWorkData(i);
        ResetPlayerHouseData(i);

        PlayerJob[i] = JOB_NONE;
        PlayerWorking[i] = 0;
        PlayerWorkType[i] = WORK_NONE;
        PlayerWorkPoint[i] = -1;
        PlayerLastWorkTick[i] = 0;

        PlayerLastX[i] = SPAWN_X;
        PlayerLastY[i] = SPAWN_Y;
        PlayerLastZ[i] = SPAWN_Z;
        PlayerLastA[i] = SPAWN_A;

        PlayerMoneyMismatchCount[i] = 0;
        PlayerLastACWarningTick[i] = 0;
    }
    g_AutosaveTimer = SetTimer("AutoSavePlayers", AUTOSAVE_INTERVAL, true);
    g_AntiCheatTimer = SetTimer("AntiCheatCheck", ANTICHEAT_INTERVAL, true);

    print("[LSIF] Autosave timer aktif setiap 5 menit.");
    print("[LSIF] Anti-cheat timer aktif setiap 10 detik.");
    print("[LSIF] Gamemode v0.12B House Interior berhasil dijalankan.");
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

    if (g_AntiCheatTimer)
    {
        KillTimer(g_AntiCheatTimer);
        g_AntiCheatTimer = 0;
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
    SendClientMessage(playerid, COLOR_WHITE, "Mengecek status akun kamu di database...");

    CheckPlayerBan(playerid);
    // SendClientMessage(playerid, COLOR_WHITE, "Mengecek akun kamu di database...");

    // CheckPlayerAccount(playerid);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);
    SaveOwnedVehicle(playerid);
    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyOwnedVehicleLabel(playerid);
        DestroyVehicle(OwnedVehicleID[playerid]);
        OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    DisablePlayerCheckpoint(playerid);

    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;

    PlayerLoggedIn[playerid] = 0;
    PlayerDBID[playerid] = 0;
    PlayerFindingBank[playerid] = 0;

    ResetTaxiWorkData(playerid);
    ResetTruckerWorkData(playerid);
    if (PlayerInsideHouse[playerid])
    {
        PlayerInsideHouse[playerid] = 0;
    }
    ResetPlayerHouseData(playerid);

    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(OwnedVehicleID[playerid]);
        OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    if (PlayerRace[playerid] != RACE_NONE)
    {
        DisablePlayerCheckpoint(playerid);
        ResetPlayerRaceData(playerid);
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

    if (PlayerSpawnHouse[playerid] && PlayerHouseIndex[playerid] != -1)
    {
        new houseIndex = PlayerHouseIndex[playerid];

        SetPlayerPos(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]);
        SetPlayerFacingAngle(playerid, 0.0);
    }
    else
    {
        SetPlayerPos(playerid, PlayerLastX[playerid], PlayerLastY[playerid], PlayerLastZ[playerid]);
        SetPlayerFacingAngle(playerid, PlayerLastA[playerid]);
    }

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
        new query[768];

        GetPlayerAccountName(playerid, username, sizeof(username));
        GetPlayerIp(playerid, ip, sizeof(ip));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO players (username, password_hash, money, bank_money, xp, level, admin_level, current_job, pos_x, pos_y, pos_z, pos_a, last_ip, last_login) VALUES ('%e', SHA2('%e', 256), 500, 0, 0, 1, 0, 0, %f, %f, %f, %f, '%e', NOW())",
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
            "SELECT id, money, bank_money, xp, level, admin_level, skin, current_job, spawn_house, pos_x, pos_y, pos_z, pos_a FROM players WHERE username='%e' AND password_hash=SHA2('%e', 256) LIMIT 1",
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
    PlayerBankMoney[playerid] = 0;
    PlayerXP[playerid] = 0;
    PlayerLevel[playerid] = 1;
    PlayerAdmin[playerid] = 0;
    PlayerJob[playerid] = JOB_NONE;
    PlayerSpawnHouse[playerid] = 0;
    PlayerSpawnHouse[playerid] = 0;
    ResetPlayerHouseData(playerid);

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;
    ResetOwnedVehicleData(playerid);

    SyncPlayerMoneyHUD(playerid);
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
    cache_get_value_name_int(0, "bank_money", PlayerBankMoney[playerid]);
    cache_get_value_name_int(0, "xp", PlayerXP[playerid]);
    cache_get_value_name_int(0, "level", PlayerLevel[playerid]);
    cache_get_value_name_int(0, "admin_level", PlayerAdmin[playerid]);
    // cache_get_value_name_int(0, "skin", PlayerLevel[playerid]);
    cache_get_value_name_int(0, "current_job", PlayerJob[playerid]);
    cache_get_value_name_int(0, "spawn_house", PlayerSpawnHouse[playerid]);

    cache_get_value_name_float(0, "pos_x", PlayerLastX[playerid]);
    cache_get_value_name_float(0, "pos_y", PlayerLastY[playerid]);
    cache_get_value_name_float(0, "pos_z", PlayerLastZ[playerid]);
    cache_get_value_name_float(0, "pos_a", PlayerLastA[playerid]);

    PlayerLoggedIn[playerid] = 1;

    ApplyLoadedPlayerData(playerid);
    LoadOwnedVehicle(playerid);
    LoadPlayerHouse(playerid);

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
    if (PlayerRace[playerid] != RACE_NONE)
    {
        HandleRaceCheckpoint(playerid);
        return 1;
    }

    if (PlayerFindingBank[playerid])
    {
        if (IsPlayerNearBankPoint(playerid))
        {
            DisablePlayerCheckpoint(playerid);
            PlayerFindingBank[playerid] = 0;

            SendClientMessage(playerid, COLOR_GREEN, "Kamu sudah sampai di bank/ATM.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /balance, /deposit [amount/all], atau /withdraw [amount/all].");
            return 1;
        }
    }

    if (PlayerFindingHouse[playerid])
    {
        new houseIndex = PlayerFindingHouseIndex[playerid];

        if (IsValidHouseIndex(houseIndex) && IsPlayerNearHouse(playerid, houseIndex))
        {
            DisablePlayerCheckpoint(playerid);
            PlayerFindingHouse[playerid] = 0;

            SendClientMessage(playerid, COLOR_GREEN, "Kamu sudah sampai di lokasi rumah.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /buyhouse [id] jika ingin membeli rumah ini.");
            return 1;
        }
    }

    if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_TRUCKER)
    {
        HandleTruckerCheckpoint(playerid);
        return 1;
    }

    if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_TAXI)
    {
        HandleTaxiCheckpoint(playerid);
        return 1;
    }

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
        DestroyOwnedVehicleLabel(playerid);
        DestroyVehicle(OwnedVehicleID[playerid]);
    }

    ResetOwnedVehicleData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan berhasil dijual. Kamu menerima $%d.", sellPrice);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SavePlayerData(playerid);

    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new ownerid = GetOwnedVehicleOwner(vehicleid);

    if (ownerid == INVALID_PLAYER_ID)
    {
        return 1;
    }

    if (ownerid == playerid)
    {
        return 1;
    }

    if (OwnedVehicleLocked[ownerid])
    {
        ClearAnimations(playerid);
        SendClientMessage(playerid, COLOR_RED, "Kendaraan ini terkunci dan bukan milikmu.");
        return 0;
    }

    SendClientMessage(playerid, COLOR_YELLOW, "Kamu masuk kendaraan pribadi milik player lain.");
    return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        new ownerid = GetOwnedVehicleOwner(vehicleid);

        if (ownerid != INVALID_PLAYER_ID && ownerid != playerid && OwnedVehicleLocked[ownerid])
        {
            RemovePlayerFromVehicle(playerid);
            SendClientMessage(playerid, COLOR_RED, "Kendaraan ini terkunci.");
            return 1;
        }
    }

    if (PlayerRace[playerid] != RACE_NONE)
    {
        if ((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && newstate == PLAYER_STATE_ONFOOT)
        {
            CancelPlayerRace(playerid);
            SendClientMessage(playerid, COLOR_RED, "Race dibatalkan karena kamu keluar dari kendaraan.");
            return 1;
        }
    }

    return 1;
}

public DelayedKick(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        Kick(playerid);
    }

    return 1;
}

public OnPlayerBanCheck(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows > 0)
    {
        new reason[128];
        new adminName[24];
        new expiresAt[32];
        new durationMinutes;
        new msg[144];

        cache_get_value_name(0, "reason", reason, sizeof(reason));
        cache_get_value_name(0, "admin_name", adminName, sizeof(adminName));
        cache_get_value_name_int(0, "duration_minutes", durationMinutes);
        cache_get_value_name(0, "expires_at", expiresAt, sizeof(expiresAt));

        SendClientMessage(playerid, COLOR_RED, "Akun/IP kamu sedang dibanned dari server LSIF.");

        format(msg, sizeof(msg), "Admin: %s", adminName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Reason: %s", reason);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (durationMinutes == 0)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Durasi: Permanent");
        }
        else
        {
            format(msg, sizeof(msg), "Durasi: %d menit | Expired: %s", durationMinutes, expiresAt);
            SendClientMessage(playerid, COLOR_YELLOW, msg);
        }

        SetTimerEx("DelayedKick", 1000, false, "i", playerid);
        return 1;
    }

    CheckPlayerAccount(playerid);
    return 1;
}

public OnPlayerBanned(playerid, targetid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new insertId = cache_insert_id();

    if (insertId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Ban gagal. Database insert gagal.");
        return 1;
    }

    SendClientMessage(playerid, COLOR_GREEN, "Ban berhasil disimpan ke database.");

    if (IsPlayerConnected(targetid))
    {
        SendClientMessage(targetid, COLOR_RED, "Kamu telah dibanned dari server LSIF.");
        SetTimerEx("DelayedKick", 1000, false, "i", targetid);
    }

    return 1;
}

public OnPlayerUnbanned(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();
    new msg[144];

    format(msg, sizeof(msg), "Unban selesai. Affected rows: %d", affectedRows);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    if (affectedRows == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Tidak ada ban aktif untuk username tersebut.");
    }

    return 1;
}

public OnPlayerBanInfo(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Tidak ada data ban untuk username tersebut.");
        return 1;
    }

    new playerName[24];
    new ip[45];
    new adminName[24];
    new reason[128];
    new expiresAt[32];
    new createdAt[32];
    new durationMinutes;
    new active;
    new banId;
    new msg[144];

    cache_get_value_name_int(0, "id", banId);
    cache_get_value_name(0, "player_name", playerName, sizeof(playerName));
    cache_get_value_name(0, "ip_address", ip, sizeof(ip));
    cache_get_value_name(0, "admin_name", adminName, sizeof(adminName));
    cache_get_value_name(0, "reason", reason, sizeof(reason));
    cache_get_value_name_int(0, "duration_minutes", durationMinutes);
    cache_get_value_name(0, "expires_at", expiresAt, sizeof(expiresAt));
    cache_get_value_name_int(0, "active", active);
    cache_get_value_name(0, "created_at", createdAt, sizeof(createdAt));

    SendClientMessage(playerid, COLOR_YELLOW, "========== BAN INFO ==========");

    format(msg, sizeof(msg), "Ban ID: %d | Username: %s", banId, playerName);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "IP: %s | Active: %d", ip, active);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Admin: %s", adminName);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Reason: %s", reason);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    if (durationMinutes == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Duration: Permanent");
    }
    else
    {
        format(msg, sizeof(msg), "Duration: %d minutes | Expires: %s", durationMinutes, expiresAt);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    format(msg, sizeof(msg), "Created: %s", createdAt);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    return 1;
}

public OnReportCreated(playerid, targetid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new reportId = cache_insert_id();

    if (reportId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Report gagal dibuat. Database insert gagal.");
        return 1;
    }

    SendClientMessage(playerid, COLOR_GREEN, "Report berhasil dikirim ke admin online.");

    new reporterName[MAX_PLAYER_NAME];
    new targetName[MAX_PLAYER_NAME];
    new msg[144];

    GetPlayerName(playerid, reporterName, sizeof(reporterName));

    if (IsPlayerConnected(targetid))
    {
        GetPlayerName(targetid, targetName, sizeof(targetName));
    }
    else
    {
        format(targetName, sizeof(targetName), "Unknown");
    }

    format(msg, sizeof(msg), "[REPORT #%d] %s melaporkan %s. Gunakan /reports.", reportId, reporterName, targetName);
    SendMessageToAdmins(COLOR_ORANGE, msg);

    return 1;
}

public OnReportsList(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== OPEN REPORTS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Tidak ada report terbuka.");
        return 1;
    }

    new reportId;
    new reporterName[24];
    new targetName[24];
    new reason[128];
    new createdAt[32];
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", reportId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "target_name", targetName, sizeof(targetName));
        cache_get_value_name(i, "reason", reason, sizeof(reason));
        cache_get_value_name(i, "created_at", createdAt, sizeof(createdAt));

        format(msg, sizeof(msg), "#%d | %s -> %s | %s", reportId, reporterName, targetName, reason);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Created: %s | Close: /closereport %d handled", createdAt, reportId);
        SendClientMessage(playerid, COLOR_CYAN, msg);
    }

    return 1;
}

public OnReportClosed(playerid, reportid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();
    new msg[144];

    if (affectedRows > 0)
    {
        format(msg, sizeof(msg), "Report #%d berhasil ditutup.", reportid);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }
    else
    {
        format(msg, sizeof(msg), "Report #%d tidak ditemukan atau sudah tertutup.", reportid);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
    }

    return 1;
}

public OnRaceRecordSaved(playerid, timeMs)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new timeText[32];
    new msg[144];

    FormatRaceTime(timeMs, timeText, sizeof(timeText));

    format(msg, sizeof(msg), "Race record tersimpan. Waktu: %s. Cek /racetop.", timeText);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    return 1;
}

public OnRaceTop(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== RACE TOP: LS INTRO ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada record race.");
        return 1;
    }

    new username[24];
    new bestTime;
    new finishes;
    new timeText[32];
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "username", username, sizeof(username));
        cache_get_value_name_int(i, "best_time_ms", bestTime);
        cache_get_value_name_int(i, "total_finishes", finishes);

        FormatRaceTime(bestTime, timeText, sizeof(timeText));

        format(msg, sizeof(msg), "%d. %s - %s | Finish: %d", i + 1, username, timeText, finishes);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnJobProgressSaved(playerid)
{
    return 1;
}

public OnJobStatsLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== JOB STATS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada statistik job.");
        SendClientMessage(playerid, COLOR_CYAN, "Selesaikan courier/taxi/trucker job untuk mulai mengisi statistik.");
        return 1;
    }

    new jobCode[32];
    new completed;
    new earned;
    new xp;
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "job_code", jobCode, sizeof(jobCode));
        cache_get_value_name_int(i, "total_completed", completed);
        cache_get_value_name_int(i, "total_earned", earned);
        cache_get_value_name_int(i, "total_xp", xp);

        format(
            msg,
            sizeof(msg),
            "%s | Completed: %d | Earned: $%d | XP: %d",
            jobCode,
            completed,
            earned,
            xp
        );
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnJobTopLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    format(msg, sizeof(msg), "========== JOB TOP: %s ==========", PlayerLastJobTopQuery[playerid]);
    SendClientMessage(playerid, COLOR_YELLOW, msg);

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada data leaderboard untuk job ini.");
        return 1;
    }

    new username[24];
    new completed;
    new earned;
    new xp;

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "username", username, sizeof(username));
        cache_get_value_name_int(i, "total_completed", completed);
        cache_get_value_name_int(i, "total_earned", earned);
        cache_get_value_name_int(i, "total_xp", xp);

        format(
            msg,
            sizeof(msg),
            "%d. %s | Completed: %d | Earned: $%d | XP: %d",
            i + 1,
            username,
            completed,
            earned,
            xp
        );

        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public AntiCheatCheck()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i))
        {
            continue;
        }

        if (!PlayerLoggedIn[i])
        {
            continue;
        }

        new hudMoney = GetPlayerMoney(i);

        if (hudMoney != PlayerMoney[i])
        {
            PlayerMoneyMismatchCount[i]++;

            new reason[144];
            format(
                reason,
                sizeof(reason),
                "Money mismatch detected. HUD=$%d Server=$%d Count=%d",
                hudMoney,
                PlayerMoney[i],
                PlayerMoneyMismatchCount[i]
            );

            ReportSuspiciousActivity(i, reason);

            SyncPlayerMoneyHUD(i);

            if (PlayerMoneyMismatchCount[i] >= 3)
            {
                SendClientMessage(i, COLOR_RED, "Anti-cheat: money mismatch terdeteksi. Uang kamu disinkronkan ulang.");
                PlayerMoneyMismatchCount[i] = 0;
            }
        }

        if (PlayerRace[i] != RACE_NONE)
        {
            if (!IsPlayerValidRaceDriver(i))
            {
                CancelPlayerRace(i);
                ReportSuspiciousActivity(i, "Race cancelled by anti-cheat: invalid vehicle/driver state.");
            }
        }

        if (PlayerWorking[i] && PlayerWorkType[i] == WORK_TAXI)
        {
            if (!IsPlayerInTaxiVehicle(i))
            {
                CancelPlayerWork(i);
                ReportSuspiciousActivity(i, "Taxi job cancelled by anti-cheat: invalid taxi vehicle.");
            }
        }

        if (PlayerWorking[i] && PlayerWorkType[i] == WORK_TRUCKER)
        {
            if (!IsPlayerInTruckerVehicle(i))
            {
                CancelPlayerWork(i);
                ReportSuspiciousActivity(i, "Trucker job cancelled by anti-cheat: invalid truck vehicle.");
            }
        }

        if (PlayerWorking[i] && PlayerWorkType[i] == WORK_COURIER)
        {
            if (!IsPlayerInCourierVehicle(i))
            {
                CancelPlayerWork(i);
                ReportSuspiciousActivity(i, "Courier job cancelled by anti-cheat: invalid courier vehicle.");
            }
        }
    }

    return 1;
}

public OnDatabasePing(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows > 0)
    {
        SendClientMessage(playerid, COLOR_GREEN, "Database OK. Query SELECT 1 berhasil.");
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "Database ping gagal atau tidak mengembalikan row.");
    }

    return 1;
}

public OnPlayerHouseLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        PlayerHouseDBID[playerid] = 0;
        PlayerHouseIndex[playerid] = -1;
        return 1;
    }

    cache_get_value_name_int(0, "id", PlayerHouseDBID[playerid]);
    cache_get_value_name_int(0, "house_index", PlayerHouseIndex[playerid]);
    cache_get_value_name_int(0, "locked", PlayerHouseLocked[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Data rumah berhasil dimuat. Gunakan /myhouse.");
    return 1;
}

public OnPlayerHouseBought(playerid, houseIndex, price)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new insertId = cache_insert_id();

    if (insertId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal membeli rumah. Database insert gagal.");
        return 1;
    }

    TakePlayerCash(playerid, price);

    PlayerHouseDBID[playerid] = insertId;
    PlayerHouseIndex[playerid] = houseIndex;
    PlayerHouseLocked[playerid] = 1;

    new msg[144];

    format(msg, sizeof(msg), "Kamu berhasil membeli rumah: %s seharga $%d.", HouseName[houseIndex], price);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /myhouse untuk info rumah.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /setspawn house jika ingin spawn di rumah.");

    SavePlayerData(playerid);
    return 1;
}

public OnPlayerHouseSold(playerid, sellPrice)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    GivePlayerCash(playerid, sellPrice);

    PlayerHouseDBID[playerid] = 0;
    PlayerHouseIndex[playerid] = -1;
    PlayerHouseLocked[playerid] = 1;
    PlayerInsideHouse[playerid] = 0;
    PlayerSpawnHouse[playerid] = 0;

    new msg[144];

    format(msg, sizeof(msg), "Rumah berhasil dijual. Kamu menerima $%d.", sellPrice);
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
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob taxi - Ambil job taxi");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob trucker - Ambil job trucker");
        SendClientMessage(playerid, COLOR_WHITE, "/jobinfo - Melihat informasi job aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/jobstats - Melihat statistik job kamu");
        SendClientMessage(playerid, COLOR_WHITE, "/jobtop [job] - Leaderboard job");
        SendClientMessage(playerid, COLOR_WHITE, "/taxifare - Melihat formula reward taxi");
        SendClientMessage(playerid, COLOR_WHITE, "/truckerfare - Melihat formula reward trucker");
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
        SendClientMessage(playerid, COLOR_WHITE, "/vehinfo - Melihat informasi kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/admins - Melihat admin online");
        if (PlayerAdmin[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_ORANGE, "Admin: gunakan /ahelp untuk command admin.");
        }
        SendClientMessage(playerid, COLOR_WHITE, "/report [id] [reason] - Laporkan player ke admin");
        SendClientMessage(playerid, COLOR_WHITE, "/races - Melihat daftar race");
        SendClientMessage(playerid, COLOR_WHITE, "/joinrace ls - Ikut race Los Santos Intro");
        SendClientMessage(playerid, COLOR_WHITE, "/raceinfo - Melihat status race aktif/cooldown");
        SendClientMessage(playerid, COLOR_WHITE, "/leaverace - Keluar dari race aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/racetop - Leaderboard race");
        SendClientMessage(playerid, COLOR_WHITE, "/serverinfo - Melihat info server");
        SendClientMessage(playerid, COLOR_WHITE, "/balance atau /bank - Melihat saldo cash dan bank");
        SendClientMessage(playerid, COLOR_WHITE, "/banks - Melihat daftar bank/ATM");
        SendClientMessage(playerid, COLOR_WHITE, "/findbank - Cari bank/ATM terdekat");
        SendClientMessage(playerid, COLOR_WHITE, "/cancelbank - Hapus checkpoint bank");
        SendClientMessage(playerid, COLOR_WHITE, "/deposit [amount/all] - Simpan cash ke bank");
        SendClientMessage(playerid, COLOR_WHITE, "/withdraw [amount/all] - Ambil uang dari bank");
        SendClientMessage(playerid, COLOR_WHITE, "/houses - Melihat daftar rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/findhouse [id] - Cari lokasi rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/cancelhouse - Hapus checkpoint rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/buyhouse [id] - Beli rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/myhouse - Info rumah pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/enterhouse - Masuk ke rumah pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/exithouse - Keluar dari rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/lockhouse - Kunci/buka rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/houseinfo - Debug/info rumah pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/gohome - Teleport ke rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/setspawn [house/default] - Atur spawn");
        SendClientMessage(playerid, COLOR_WHITE, "/sellhouse - Jual rumah");


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

        format(msg, sizeof(msg), "Bank: $%d", PlayerBankMoney[playerid]);
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
        SendClientMessage(playerid, COLOR_WHITE, "taxi - Antar penumpang dari pickup ke tujuan.");
        SendClientMessage(playerid, COLOR_WHITE, "trucker - Ambil cargo dan kirim ke lokasi industri.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan: /joinjob courier, /joinjob taxi, atau /joinjob trucker");
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

    if (!strcmp(cmdtext, "/joinjob taxi", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan atau batalkan pekerjaan aktif dulu.");
            return 1;
        }

        PlayerJob[playerid] = JOB_TAXI;

        SendClientMessage(playerid, COLOR_GREEN, "Kamu sekarang bekerja sebagai Taxi Driver.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work saat berada di Taxi/Cabbie.");
        SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 420 atau /veh 438.");

        SavePlayerData(playerid);

        return 1;
    }

    if (!strcmp(cmdtext, "/joinjob trucker", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan atau batalkan pekerjaan aktif dulu.");
            return 1;
        }

        PlayerJob[playerid] = JOB_TRUCKER;

        SendClientMessage(playerid, COLOR_GREEN, "Kamu sekarang bekerja sebagai Trucker.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /work saat berada di kendaraan truck.");
        SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 515 atau /veh 403.");

        SavePlayerData(playerid);
        return 1;
    }

    if (strfind(cmdtext, "/joinjob", true) == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /joinjob courier, /joinjob taxi, atau /joinjob trucker");
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

        if (PlayerJob[playerid] == JOB_TAXI)
        {
            StartTaxiWork(playerid);
            return 1;
        }

        if (PlayerJob[playerid] == JOB_TRUCKER)
        {
            StartTruckerWork(playerid);
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
            SendClientMessage(playerid, COLOR_WHITE, "Reward taxi dihitung berdasarkan jarak pickup ke dropoff.");

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

        if (PlayerJob[playerid] == JOB_TAXI)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tugas: jemput penumpang dan antar ke checkpoint tujuan.");
            SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Taxi atau Cabbie.");
            SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 420 atau /veh 438 lalu /work.");

            new cooldownLeft = GetTaxiCooldownLeft(playerid);

            if (cooldownLeft > 0)
            {
                format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
                SendClientMessage(playerid, COLOR_YELLOW, msg);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap bekerja.");
            }

            if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_TAXI)
            {
                new route = PlayerTaxiRoute[playerid];

                if (route >= 0 && route < MAX_TAXI_ROUTES)
                {
                    new reward = GetTaxiDynamicReward(route);
                    new xp = GetTaxiDynamicXP(route);
                    new Float:distance = GetTaxiRouteDistance(route);

                    format(msg, sizeof(msg), "Trip distance: %.1f unit | Reward: $%d | XP: %d", distance, reward, xp);
                    SendClientMessage(playerid, COLOR_CYAN, msg);
                }
                if (PlayerTaxiStage[playerid] == TAXI_STAGE_PICKUP)
                {
                    SendClientMessage(playerid, COLOR_CYAN, "Status: menuju lokasi pickup.");
                }
                else if (PlayerTaxiStage[playerid] == TAXI_STAGE_DROPOFF)
                {
                    SendClientMessage(playerid, COLOR_CYAN, "Status: mengantar penumpang ke tujuan.");
                }
            }

            return 1;
        }

        if (PlayerJob[playerid] == JOB_TRUCKER)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tugas: ambil cargo dan kirim ke checkpoint tujuan.");
            SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Linerunner, Tanker, Roadtrain, DFT-30, Flatbed, Yankee.");
            SendClientMessage(playerid, COLOR_WHITE, "Test cepat: /veh 515 atau /veh 403 lalu /work.");
            SendClientMessage(playerid, COLOR_WHITE, "Reward trucker dihitung berdasarkan jarak pickup ke dropoff.");

            new cooldownLeft = GetTruckerCooldownLeft(playerid);

            if (cooldownLeft > 0)
            {
                format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
                SendClientMessage(playerid, COLOR_YELLOW, msg);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap bekerja.");
            }

            if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_TRUCKER)
            {
                new route = PlayerTruckerRoute[playerid];

                if (PlayerTruckerStage[playerid] == TRUCKER_STAGE_PICKUP)
                {
                    SendClientMessage(playerid, COLOR_CYAN, "Status: menuju lokasi pickup cargo.");
                }
                else if (PlayerTruckerStage[playerid] == TRUCKER_STAGE_DROPOFF)
                {
                    SendClientMessage(playerid, COLOR_CYAN, "Status: mengantar cargo ke tujuan.");
                }

                if (route >= 0 && route < MAX_TRUCKER_ROUTES)
                {
                    new reward = GetTruckerDynamicReward(route);
                    new xp = GetTruckerDynamicXP(route);
                    new Float:distance = GetTruckerRouteDistance(route);

                    format(msg, sizeof(msg), "Trip distance: %.1f unit | Reward: $%d | XP: %d", distance, reward, xp);
                    SendClientMessage(playerid, COLOR_CYAN, msg);
                }
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

        format(msg, sizeof(msg), "Cash: $%d | Bank: $%d", PlayerMoney[playerid], PlayerBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "XP: %d | Level: %d", PlayerXP[playerid], PlayerLevel[playerid]);
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

        if (PlayerHouseDBID[playerid] > 0 && PlayerHouseIndex[playerid] != -1)
        {
            format(
                msg,
                sizeof(msg),
                "House: %s | SpawnHouse: %d | Locked: %d | Inside: %d",
                HouseName[PlayerHouseIndex[playerid]],
                PlayerSpawnHouse[playerid],
                PlayerHouseLocked[playerid],
                PlayerInsideHouse[playerid]
            );
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "House: None");
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
            ApplyOwnedVehicleParams(playerid);
            SendClientMessage(playerid, COLOR_GREEN, "Kendaraan dibuka.");
        }
        else
        {
            OwnedVehicleLocked[playerid] = 1;
            ApplyOwnedVehicleParams(playerid);
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

    if (!strcmp(cmdtext, "/vehinfo", true))
    {
        if (OwnedVehicleDBID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya kendaraan pribadi.");
            return 1;
        }

        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== VEHICLE INFO ==========");

        format(msg, sizeof(msg), "DB ID: %d", OwnedVehicleDBID[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Model ID: %d", OwnedVehicleModel[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Spawned Vehicle ID: %d", OwnedVehicleID[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Locked: %s", OwnedVehicleLocked[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Position: %.2f, %.2f, %.2f", OwnedVehicleX[playerid], OwnedVehicleY[playerid], OwnedVehicleZ[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/admins", true))
    {
        new found = 0;
        new msg[144];
        new rankName[32];
        new name[MAX_PLAYER_NAME];

        SendClientMessage(playerid, COLOR_YELLOW, "========== ONLINE ADMINS ==========");

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] > 0)
            {
                GetPlayerName(i, name, sizeof(name));
                GetAdminRankName(PlayerAdmin[i], rankName, sizeof(rankName));

                format(msg, sizeof(msg), "%s [%d] - %s", name, i, rankName);
                SendClientMessage(playerid, COLOR_WHITE, msg);

                found++;
            }
        }

        if (!found)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tidak ada admin online.");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/ahelp", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "========== ADMIN HELP ==========");
        SendClientMessage(playerid, COLOR_WHITE, "/admins - Lihat admin online");
        SendClientMessage(playerid, COLOR_WHITE, "/kick [id] [reason] - Kick player");
        SendClientMessage(playerid, COLOR_WHITE, "/goto [id] - Teleport ke player");
        SendClientMessage(playerid, COLOR_WHITE, "/gethere [id] - Tarik player");
        SendClientMessage(playerid, COLOR_WHITE, "/setmoney [id] [amount] - Set uang player");
        SendClientMessage(playerid, COLOR_WHITE, "/setlevel [id] [level] - Set level player");
        SendClientMessage(playerid, COLOR_WHITE, "/makeadmin [id] [level] - Set admin level, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/ban [id] [menit] [reason] - Ban player");
        SendClientMessage(playerid, COLOR_WHITE, "/unban [username] - Unban username");
        SendClientMessage(playerid, COLOR_WHITE, "/baninfo [username] - Cek info ban");
        SendClientMessage(playerid, COLOR_WHITE, "/reports - Lihat 5 report terbuka terakhir");
        SendClientMessage(playerid, COLOR_WHITE, "/closereport [id] [note] - Tutup report");
        SendClientMessage(playerid, COLOR_WHITE, "/acinfo - Melihat informasi basic anti-cheat");
        SendClientMessage(playerid, COLOR_WHITE, "/serverinfo - Info server dan uptime");
        SendClientMessage(playerid, COLOR_WHITE, "/dbping - Test koneksi database");
        SendClientMessage(playerid, COLOR_WHITE, "/saveall - Simpan semua player, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/playerinfo [id] - Debug data player");
        SendClientMessage(playerid, COLOR_WHITE, "/vehdebug - Debug kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/jobdebug - Debug job/race aktif");
        return 1;
    }

    if (strfind(cmdtext, "/kick ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Moderator untuk menggunakan command ini.");
            return 1;
        }

        new targetStr[16];
        new reason[64];

        if (!GetTwoParams(cmdtext[6], targetStr, sizeof(targetStr), reason, sizeof(reason)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kick [playerid] [reason]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /kick 1 rules");
            return 1;
        }

        if (!IsNumericString(targetStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online.");
            return 1;
        }

        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa kick diri sendiri.");
            return 1;
        }

        if (PlayerAdmin[targetid] >= PlayerAdmin[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa kick admin dengan level sama/lebih tinggi.");
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new targetName[MAX_PLAYER_NAME];
        new msg[144];

        GetPlayerName(playerid, adminName, sizeof(adminName));
        GetPlayerName(targetid, targetName, sizeof(targetName));

        format(msg, sizeof(msg), "Admin %s menendang %s. Reason: %s", adminName, targetName, reason);
        SendClientMessageToAll(COLOR_ORANGE, msg);

        LogAdminAction(playerid, targetid, "KICK", reason);

        SetTimerEx("DelayedKick", 500, false, "i", targetid);
        return 1;
    }

    if (strfind(cmdtext, "/setmoney ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_ADMIN))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Admin untuk menggunakan command ini.");
            return 1;
        }

        new targetStr[16];
        new amountStr[16];

        if (!GetTwoParams(cmdtext[10], targetStr, sizeof(targetStr), amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setmoney [playerid] [amount]");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(amountStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan amount harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new amount = strval(amountStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (amount < 0 || amount > 100000000)
        {
            SendClientMessage(playerid, COLOR_RED, "Amount tidak valid.");
            return 1;
        }

        PlayerMoney[targetid] = amount;
        SyncPlayerMoneyHUD(targetid);

        SavePlayerData(targetid);

        new msg[144];
        format(msg, sizeof(msg), "Uang player ID %d diset menjadi $%d.", targetid, amount);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Admin mengubah uang kamu menjadi $%d.", amount);
        SendClientMessage(targetid, COLOR_YELLOW, msg);

        format(msg, sizeof(msg), "setmoney amount=%d", amount);
        LogAdminAction(playerid, targetid, "SETMONEY", msg);

        return 1;
    }

    if (strfind(cmdtext, "/setlevel ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_ADMIN))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Admin untuk menggunakan command ini.");
            return 1;
        }

        new targetStr[16];
        new levelStr[16];

        if (!GetTwoParams(cmdtext[10], targetStr, sizeof(targetStr), levelStr, sizeof(levelStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setlevel [playerid] [level]");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(levelStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan level harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new level = strval(levelStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (level < 1 || level > 1000)
        {
            SendClientMessage(playerid, COLOR_RED, "Level tidak valid.");
            return 1;
        }

        PlayerLevel[targetid] = level;
        SetPlayerScore(targetid, PlayerLevel[targetid]);
        SavePlayerData(targetid);

        new msg[144];
        format(msg, sizeof(msg), "Level player ID %d diset menjadi %d.", targetid, level);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Admin mengubah level kamu menjadi %d.", level);
        SendClientMessage(targetid, COLOR_YELLOW, msg);

        format(msg, sizeof(msg), "setlevel level=%d", level);
        LogAdminAction(playerid, targetid, "SETLEVEL", msg);

        return 1;
    }

    if (strfind(cmdtext, "/makeadmin ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menggunakan command ini.");
            return 1;
        }

        new targetStr[16];
        new levelStr[16];

        if (!GetTwoParams(cmdtext[11], targetStr, sizeof(targetStr), levelStr, sizeof(levelStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /makeadmin [playerid] [level 0-5]");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(levelStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan level harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new level = strval(levelStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (level < 0 || level > ADMIN_OWNER)
        {
            SendClientMessage(playerid, COLOR_RED, "Level admin harus 0 sampai 5.");
            return 1;
        }

        PlayerAdmin[targetid] = level;
        SavePlayerData(targetid);

        new rankName[32];
        new msg[144];

        GetAdminRankName(level, rankName, sizeof(rankName));

        format(msg, sizeof(msg), "Admin level player ID %d diubah menjadi %d (%s).", targetid, level, rankName);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Admin level kamu diubah menjadi %d (%s).", level, rankName);
        SendClientMessage(targetid, COLOR_YELLOW, msg);

        format(msg, sizeof(msg), "makeadmin level=%d", level);
        LogAdminAction(playerid, targetid, "MAKEADMIN", msg);

        return 1;
    }

    if (strfind(cmdtext, "/ban ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_SENIOR))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Senior Admin untuk menggunakan command ini.");
            return 1;
        }

        new targetStr[16];
        new minutesStr[16];
        new reason[128];

        if (!GetThreeParams(cmdtext[5], targetStr, sizeof(targetStr), minutesStr, sizeof(minutesStr), reason, sizeof(reason)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /ban [playerid] [menit] [reason]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh sementara: /ban 1 60 cheating");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh permanen: /ban 1 0 severe_cheating");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(minutesStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan menit harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new minutes = strval(minutesStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa ban diri sendiri.");
            return 1;
        }

        if (PlayerAdmin[targetid] >= PlayerAdmin[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa ban admin dengan level sama/lebih tinggi.");
            return 1;
        }

        if (minutes < 0 || minutes > 525600)
        {
            SendClientMessage(playerid, COLOR_RED, "Durasi tidak valid. Gunakan 0 untuk permanent, atau maksimal 525600 menit.");
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new targetName[MAX_PLAYER_NAME];
        new targetIp[45];
        new query[768];

        GetPlayerName(playerid, adminName, sizeof(adminName));
        GetPlayerName(targetid, targetName, sizeof(targetName));
        GetPlayerIp(targetid, targetIp, sizeof(targetIp));

        if (minutes == 0)
        {
            mysql_format(
                g_SQL,
                query,
                sizeof(query),
                "INSERT INTO bans (player_id, player_name, ip_address, admin_id, admin_name, reason, duration_minutes, expires_at, active) VALUES (%d, '%e', '%e', %d, '%e', '%e', 0, NULL, 1)",
                PlayerDBID[targetid],
                targetName,
                targetIp,
                PlayerDBID[playerid],
                adminName,
                reason
            );
        }
        else
        {
            mysql_format(
                g_SQL,
                query,
                sizeof(query),
                "INSERT INTO bans (player_id, player_name, ip_address, admin_id, admin_name, reason, duration_minutes, expires_at, active) VALUES (%d, '%e', '%e', %d, '%e', '%e', %d, DATE_ADD(NOW(), INTERVAL %d MINUTE), 1)",
                PlayerDBID[targetid],
                targetName,
                targetIp,
                PlayerDBID[playerid],
                adminName,
                reason,
                minutes,
                minutes
            );
        }

        mysql_tquery(g_SQL, query, "OnPlayerBanned", "ii", playerid, targetid);

        new detail[160];
        format(detail, sizeof(detail), "ban minutes=%d reason=%s", minutes, reason);
        LogAdminAction(playerid, targetid, "BAN", detail);

        return 1;
    }

    if (strfind(cmdtext, "/unban ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_SENIOR))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Senior Admin untuk menggunakan command ini.");
            return 1;
        }

        new targetName[24];

        if (!GetOneParam(cmdtext[7], targetName, sizeof(targetName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /unban [username]");
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerName(playerid, adminName, sizeof(adminName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE bans SET active=0, unbanned_by_id=%d, unbanned_by_name='%e', unbanned_at=NOW(), unban_reason='manual_unban' WHERE player_name='%e' AND active=1",
            PlayerDBID[playerid],
            adminName,
            targetName
        );

        mysql_tquery(g_SQL, query, "OnPlayerUnbanned", "i", playerid);

        new detail[128];
        format(detail, sizeof(detail), "unban username=%s", targetName);
        LogAdminAction(playerid, INVALID_PLAYER_ID, "UNBAN", detail);

        return 1;
    }

    if (strfind(cmdtext, "/baninfo ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new targetName[24];

        if (!GetOneParam(cmdtext[9], targetName, sizeof(targetName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /baninfo [username]");
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT id, player_name, ip_address, admin_name, reason, duration_minutes, expires_at, active, created_at FROM bans WHERE player_name='%e' ORDER BY id DESC LIMIT 1",
            targetName
        );

        mysql_tquery(g_SQL, query, "OnPlayerBanInfo", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/report ", true) == 0)
    {
        new targetStr[16];
        new reason[255];

        if (!GetFirstParamAndRest(cmdtext[8], targetStr, sizeof(targetStr), reason, sizeof(reason)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /report [playerid] [reason]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /report 1 cheating teleport");
            return 1;
        }

        if (!IsNumericString(targetStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa report diri sendiri.");
            return 1;
        }

        new reporterName[MAX_PLAYER_NAME];
        new targetName[MAX_PLAYER_NAME];
        new query[768];

        GetPlayerName(playerid, reporterName, sizeof(reporterName));
        GetPlayerName(targetid, targetName, sizeof(targetName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO reports (reporter_id, reporter_name, target_id, target_name, reason, status) VALUES (%d, '%e', %d, '%e', '%e', 'open')",
            PlayerDBID[playerid],
            reporterName,
            PlayerDBID[targetid],
            targetName,
            reason
        );

        mysql_tquery(g_SQL, query, "OnReportCreated", "ii", playerid, targetid);
        return 1;
    }

    if (!strcmp(cmdtext, "/reports", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT id, reporter_name, target_name, reason, created_at FROM reports WHERE status='open' ORDER BY id DESC LIMIT 5"
        );

        mysql_tquery(g_SQL, query, "OnReportsList", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/closereport ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new reportStr[16];
        new note[255];

        if (!GetFirstParamAndRest(cmdtext[13], reportStr, sizeof(reportStr), note, sizeof(note)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /closereport [report_id] [note]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /closereport 3 handled");
            return 1;
        }

        if (!IsNumericString(reportStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Report ID harus angka.");
            return 1;
        }

        new reportid = strval(reportStr);
        new adminName[MAX_PLAYER_NAME];
        new query[768];

        GetPlayerName(playerid, adminName, sizeof(adminName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE reports SET status='closed', handled_by_id=%d, handled_by_name='%e', close_note='%e', closed_at=NOW() WHERE id=%d AND status='open' LIMIT 1",
            PlayerDBID[playerid],
            adminName,
            note,
            reportid
        );

        mysql_tquery(g_SQL, query, "OnReportClosed", "ii", playerid, reportid);

        new detail[160];
        format(detail, sizeof(detail), "closereport id=%d note=%s", reportid, note);
        LogAdminAction(playerid, INVALID_PLAYER_ID, "CLOSE_REPORT", detail);

        return 1;
    }

    if (!strcmp(cmdtext, "/races", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== RACES ==========");
        SendClientMessage(playerid, COLOR_WHITE, "ls - Los Santos Intro Time Trial");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan: /joinrace ls");
        SendClientMessage(playerid, COLOR_WHITE, "Leaderboard: /racetop");
        return 1;
    }

    if (strfind(cmdtext, "/joinrace ", true) == 0)
    {
        new raceCode[32];

        if (!GetOneParam(cmdtext[10], raceCode, sizeof(raceCode)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /joinrace [race_code]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /joinrace ls");
            return 1;
        }

        if (!strcmp(raceCode, "ls", true))
        {
            StartLSIntroRace(playerid);
            return 1;
        }

        SendClientMessage(playerid, COLOR_RED, "Race tidak ditemukan. Gunakan /races.");
        return 1;
    }

    if (!strcmp(cmdtext, "/leaverace", true))
    {
        CancelPlayerRace(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/racetop", true))
    {
        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT p.username, r.best_time_ms, r.total_finishes FROM race_records r JOIN players p ON p.id = r.player_id WHERE r.race_code='ls_intro' ORDER BY r.best_time_ms ASC LIMIT 5"
        );

        mysql_tquery(g_SQL, query, "OnRaceTop", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/raceinfo", true))
    {
        new msg[144];
        new raceName[32];

        SendClientMessage(playerid, COLOR_YELLOW, "========== RACE INFO ==========");

        GetRaceName(PlayerRace[playerid], raceName, sizeof(raceName));

        format(msg, sizeof(msg), "Race aktif: %s", raceName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (PlayerRace[playerid] != RACE_NONE)
        {
            format(msg, sizeof(msg), "Checkpoint: %d/%d", PlayerRaceCheckpoint[playerid] + 1, MAX_LS_RACE_POINTS);
            SendClientMessage(playerid, COLOR_WHITE, msg);

            new timeMs = GetTickCount() - PlayerRaceStartTick[playerid];
            new timeText[32];

            FormatRaceTime(timeMs, timeText, sizeof(timeText));

            format(msg, sizeof(msg), "Waktu berjalan: %s", timeText);
            SendClientMessage(playerid, COLOR_WHITE, msg);

            format(msg, sizeof(msg), "Race Vehicle ID: %d", PlayerRaceVehicle[playerid]);
            SendClientMessage(playerid, COLOR_WHITE, msg);

            return 1;
        }

        new cooldownLeft = GetRaceCooldownLeft(playerid);

        if (cooldownLeft > 0)
        {
            format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
            SendClientMessage(playerid, COLOR_YELLOW, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap ikut race.");
        }

        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /races untuk melihat race tersedia.");
        return 1;
    }

    if (!strcmp(cmdtext, "/taxifare", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== TAXI FARE INFO ==========");

        new msg[144];

        format(msg, sizeof(msg), "Base fare: $%d", TAXI_BASE_FARE);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Fare per unit: $%d", TAXI_FARE_PER_UNIT);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Reward range: $%d - $%d", TAXI_MIN_REWARD, TAXI_MAX_REWARD);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "XP range: %d - %d", TAXI_MIN_XP, TAXI_MAX_XP);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Semakin jauh trip taxi, semakin besar reward.");
        return 1;
    }

    if (!strcmp(cmdtext, "/truckerfare", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== TRUCKER FARE INFO ==========");

        new msg[144];

        format(msg, sizeof(msg), "Base fare: $%d", TRUCKER_BASE_FARE);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Fare per unit: $%d", TRUCKER_FARE_PER_UNIT);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Reward range: $%d - $%d", TRUCKER_MIN_REWARD, TRUCKER_MAX_REWARD);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "XP range: %d - %d", TRUCKER_MIN_XP, TRUCKER_MAX_XP);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Semakin jauh pengiriman cargo, semakin besar reward.");
        return 1;
    }

    if (!strcmp(cmdtext, "/jobstats", true))
    {
        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT job_code, total_completed, total_earned, total_xp FROM job_stats WHERE player_id=%d ORDER BY total_earned DESC",
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnJobStatsLoaded", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/jobtop ", true) == 0)
    {
        new jobCode[32];

        if (!GetOneParam(cmdtext[8], jobCode, sizeof(jobCode)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /jobtop [courier/taxi/trucker]");
            return 1;
        }

        if (!IsValidJobCode(jobCode))
        {
            SendClientMessage(playerid, COLOR_RED, "Job tidak valid. Pilih: courier, taxi, atau trucker.");
            return 1;
        }

        format(PlayerLastJobTopQuery[playerid], 32, "%s", jobCode);

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT p.username, js.total_completed, js.total_earned, js.total_xp FROM job_stats js JOIN players p ON p.id = js.player_id WHERE js.job_code='%e' ORDER BY js.total_earned DESC LIMIT 5",
            jobCode
        );

        mysql_tquery(g_SQL, query, "OnJobTopLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/jobtop", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /jobtop [courier/taxi/trucker]");
        SendClientMessage(playerid, COLOR_WHITE, "Contoh: /jobtop courier");
        return 1;
    }

    if (!strcmp(cmdtext, "/acinfo", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== ANTICHEAT INFO ==========");

        format(msg, sizeof(msg), "Interval: %d ms", ANTICHEAT_INTERVAL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_WHITE, "Checks: money HUD sync, race vehicle state, job vehicle state.");
        SendClientMessage(playerid, COLOR_WHITE, "Logs: suspicious activity masuk admin_logs sebagai SYSTEM.");

        return 1;
    }

    if (!strcmp(cmdtext, "/serverinfo", true))
    {
        new uptimeText[64];
        new msg[144];

        FormatUptime(GetTickCount() - g_ServerStartTick, uptimeText, sizeof(uptimeText));

        SendClientMessage(playerid, COLOR_YELLOW, "========== SERVER INFO ==========");

        format(msg, sizeof(msg), "Gamemode: LSIF Dev v0.10B Stability");
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Uptime: %s", uptimeText);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Players online: %d | Logged in: %d", CountOnlinePlayers(), CountLoggedPlayers());
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Autosave interval: %d ms", AUTOSAVE_INTERVAL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Anti-cheat interval: %d ms", ANTICHEAT_INTERVAL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/dbping", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT 1 AS db_ok", "OnDatabasePing", "i", playerid);
        SendClientMessage(playerid, COLOR_YELLOW, "Mengirim database ping...");
        return 1;
    }

    if (!strcmp(cmdtext, "/saveall", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menggunakan command ini.");
            return 1;
        }

        new savedCount = SaveAllPlayers();

        new msg[144];
        format(msg, sizeof(msg), "SaveAll selesai. %d player data dikirim untuk disimpan.", savedCount);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        LogAdminAction(playerid, INVALID_PLAYER_ID, "SAVEALL", "Manual save all players");
        return 1;
    }

    if (strfind(cmdtext, "/playerinfo ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[12], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /playerinfo [playerid]");
            return 1;
        }

        if (!IsNumericString(targetStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online.");
            return 1;
        }

        new targetName[MAX_PLAYER_NAME];
        new jobName[32];
        new rankName[32];
        new msg[144];

        GetPlayerName(targetid, targetName, sizeof(targetName));
        GetJobName(PlayerJob[targetid], jobName, sizeof(jobName));
        GetAdminRankName(PlayerAdmin[targetid], rankName, sizeof(rankName));

        SendClientMessage(playerid, COLOR_YELLOW, "========== PLAYER INFO ==========");

        format(msg, sizeof(msg), "Name: %s | ID: %d | DBID: %d", targetName, targetid, PlayerDBID[targetid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "LoggedIn: %s | Admin: %d (%s)", PlayerLoggedIn[targetid] ? ("Yes") : ("No"), PlayerAdmin[targetid], rankName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(
            msg,
            sizeof(msg),
            "Cash: $%d | Bank: $%d | HUD: $%d",
            PlayerMoney[targetid],
            PlayerBankMoney[targetid],
            GetPlayerMoney(targetid)
        );
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "XP: %d | Level: %d", PlayerXP[targetid], PlayerLevel[targetid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Job: %s | Working: %s | WorkType: %d", jobName, PlayerWorking[targetid] ? ("Yes") : ("No"), PlayerWorkType[targetid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Race: %d | Vehicle: %d | OwnedVehDBID: %d", PlayerRace[targetid], PlayerRaceVehicle[targetid], OwnedVehicleDBID[targetid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "AC mismatch count: %d", PlayerMoneyMismatchCount[targetid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (PlayerHouseDBID[playerid] > 0 && PlayerHouseIndex[playerid] != -1)
        {
            format(msg, sizeof(msg), "House: %s | SpawnHouse: %d", HouseName[PlayerHouseIndex[playerid]], PlayerSpawnHouse[playerid]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "House: None");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/playerinfo", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /playerinfo [playerid]");
        return 1;
    }

    if (!strcmp(cmdtext, "/vehdebug", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== VEHICLE DEBUG ==========");

        format(msg, sizeof(msg), "Owned DBID: %d | Model: %d | Spawned ID: %d", OwnedVehicleDBID[playerid], OwnedVehicleModel[playerid], OwnedVehicleID[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Locked: %d | Label: %d", OwnedVehicleLocked[playerid], _:OwnedVehicleLabel[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Pos: %.2f, %.2f, %.2f | A: %.2f", OwnedVehicleX[playerid], OwnedVehicleY[playerid], OwnedVehicleZ[playerid], OwnedVehicleA[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            new Float:x, Float:y, Float:z, Float:health;

            GetVehiclePos(OwnedVehicleID[playerid], x, y, z);
            GetVehicleHealth(OwnedVehicleID[playerid], health);

            format(msg, sizeof(msg), "Current vehicle pos: %.2f, %.2f, %.2f | Health: %.1f", x, y, z, health);
            SendClientMessage(playerid, COLOR_CYAN, msg);
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/jobdebug", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new jobName[32];
        new workName[32];
        new raceName[32];
        new msg[144];

        GetJobName(PlayerJob[playerid], jobName, sizeof(jobName));
        GetWorkName(PlayerWorkType[playerid], workName, sizeof(workName));
        GetRaceDebugName(PlayerRace[playerid], raceName, sizeof(raceName));

        SendClientMessage(playerid, COLOR_YELLOW, "========== JOB/RACE DEBUG ==========");

        format(msg, sizeof(msg), "Job: %s (%d)", jobName, PlayerJob[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Working: %s | WorkType: %s (%d) | WorkPoint: %d", PlayerWorking[playerid] ? ("Yes") : ("No"), workName, PlayerWorkType[playerid], PlayerWorkPoint[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Taxi stage: %d | Taxi route: %d", PlayerTaxiStage[playerid], PlayerTaxiRoute[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Trucker stage: %d | Trucker route: %d", PlayerTruckerStage[playerid], PlayerTruckerRoute[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Race: %s (%d) | CP: %d | RaceVeh: %d", raceName, PlayerRace[playerid], PlayerRaceCheckpoint[playerid], PlayerRaceVehicle[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/balance", true) || !strcmp(cmdtext, "/bank", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== BANK ACCOUNT ==========");

        format(msg, sizeof(msg), "Cash: $%d", PlayerMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Bank: $%d", PlayerBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);


        format(msg, sizeof(msg), "Total: $%d", PlayerMoney[playerid] + PlayerBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        if (IsPlayerNearBankPoint(playerid))
        {
            SendClientMessage(playerid, COLOR_GREEN, "Status: kamu berada dekat bank/ATM.");
        }
        else
        {
            new distance = GetNearestBankDistance(playerid);
            format(msg, sizeof(msg), "Status: tidak dekat bank/ATM. Terdekat sekitar %d unit.", distance);
            SendClientMessage(playerid, COLOR_YELLOW, msg);
        }

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /deposit [amount/all] atau /withdraw [amount/all].");
        return 1;
    }

    if (strfind(cmdtext, "/deposit ", true) == 0)
    {
        new amountStr[32];

        if (!GetOneParam(cmdtext[9], amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /deposit [amount/all]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /deposit 5000");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /deposit all");
            return 1;
        }

        new amount;

        if (!strcmp(amountStr, "all", true))
        {
            amount = PlayerMoney[playerid];
        }
        else
        {
            if (!IsNumericString(amountStr))
            {
                SendClientMessage(playerid, COLOR_RED, "Amount harus angka atau all.");
                return 1;
            }

            amount = strval(amountStr);
        }

        if (!IsPlayerNearBankPoint(playerid))
        {
            new distance = GetNearestBankDistance(playerid);
            new msg[144];

            format(msg, sizeof(msg), "Kamu harus berada dekat bank/ATM untuk deposit. Bank terdekat sekitar %d unit.", distance);
            SendClientMessage(playerid, COLOR_RED, msg);
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /findbank untuk mencari bank/ATM terdekat.");
            return 1;
        }

        if (!IsValidBankAmount(amount))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah deposit tidak valid.");
            return 1;
        }

        if (PlayerMoney[playerid] < amount)
        {
            SendClientMessage(playerid, COLOR_RED, "Cash kamu tidak cukup.");
            return 1;
        }

        TakePlayerCash(playerid, amount);
        GivePlayerBankMoney(playerid, amount);

        SavePlayerData(playerid);

        new msg[144];
        format(msg, sizeof(msg), "Deposit berhasil: $%d masuk ke bank.", amount);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Cash: $%d | Bank: $%d", PlayerMoney[playerid], PlayerBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/deposit", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /deposit [amount/all]");
        return 1;
    }

    if (strfind(cmdtext, "/withdraw ", true) == 0)
    {
        new amountStr[32];

        if (!GetOneParam(cmdtext[10], amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /withdraw [amount/all]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /withdraw 5000");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /withdraw all");
            return 1;
        }

        new amount;

        if (!strcmp(amountStr, "all", true))
        {
            amount = PlayerBankMoney[playerid];
        }
        else
        {
            if (!IsNumericString(amountStr))
            {
                SendClientMessage(playerid, COLOR_RED, "Amount harus angka atau all.");
                return 1;
            }

            amount = strval(amountStr);
        }

        if (!IsPlayerNearBankPoint(playerid))
        {
            new distance = GetNearestBankDistance(playerid);
            new msg[144];

            format(msg, sizeof(msg), "Kamu harus berada dekat bank/ATM untuk withdraw. Bank terdekat sekitar %d unit.", distance);
            SendClientMessage(playerid, COLOR_RED, msg);
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /findbank untuk mencari bank/ATM terdekat.");
            return 1;
        }

        if (!IsValidBankAmount(amount))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah withdraw tidak valid.");
            return 1;
        }

        if (PlayerBankMoney[playerid] < amount)
        {
            SendClientMessage(playerid, COLOR_RED, "Saldo bank kamu tidak cukup.");
            return 1;
        }

        TakePlayerBankMoney(playerid, amount);
        GivePlayerCash(playerid, amount);

        SavePlayerData(playerid);

        new msg[144];
        format(msg, sizeof(msg), "Withdraw berhasil: $%d keluar dari bank.", amount);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "Cash: $%d | Bank: $%d", PlayerMoney[playerid], PlayerBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/withdraw", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /withdraw [amount/all]");
        return 1;
    }

    if (!strcmp(cmdtext, "/banks", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== BANK / ATM LOCATIONS ==========");

        for (new i = 0; i < MAX_BANK_POINTS; i++)
        {
            format(msg, sizeof(msg), "%d. %s", i + 1, BankPointName[i]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /findbank untuk diarahkan ke bank/ATM terdekat.");
        return 1;
    }

    if (!strcmp(cmdtext, "/findbank", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sedang bekerja. Selesaikan atau /cancelwork dulu.");
            return 1;
        }

        if (PlayerRace[playerid] != RACE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sedang race. Selesaikan atau /leaverace dulu.");
            return 1;
        }

        new nearest = GetNearestBankPoint(playerid);

        if (nearest == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Bank/ATM tidak ditemukan.");
            return 1;
        }

        SetPlayerCheckpoint(
            playerid,
            BankPointX[nearest],
            BankPointY[nearest],
            BankPointZ[nearest],
            BANK_ACCESS_RADIUS
        );

        PlayerFindingBank[playerid] = 1;

        new msg[144];
        format(msg, sizeof(msg), "Checkpoint diarahkan ke: %s.", BankPointName[nearest]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /cancelbank untuk menghapus checkpoint bank.");

        return 1;
    }

    if (!strcmp(cmdtext, "/cancelbank", true))
    {
        if (!PlayerFindingBank[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang mencari bank/ATM.");
            return 1;
        }

        DisablePlayerCheckpoint(playerid);
        PlayerFindingBank[playerid] = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "Checkpoint bank/ATM dihapus.");
        return 1;
    }

    if (!strcmp(cmdtext, "/houses", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== AVAILABLE HOUSES ==========");

        for (new i = 0; i < MAX_HOUSES; i++)
        {
            format(msg, sizeof(msg), "%d. %s | Price: $%d", i + 1, HouseName[i], HousePrice[i]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /findhouse [id] untuk mencari rumah.");
        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /buyhouse [id] saat dekat rumah.");
        return 1;
    }

    if (strfind(cmdtext, "/findhouse ", true) == 0)
    {
        new houseStr[16];

        if (!GetOneParam(cmdtext[11], houseStr, sizeof(houseStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /findhouse [house_id]");
            return 1;
        }

        if (!IsNumericString(houseStr))
        {
            SendClientMessage(playerid, COLOR_RED, "House ID harus angka.");
            return 1;
        }

        new houseIndex = strval(houseStr) - 1;

        if (!IsValidHouseIndex(houseIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "House ID tidak valid.");
            return 1;
        }

        if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan job/race aktif dulu.");
            return 1;
        }

        SetPlayerCheckpoint(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex], HOUSE_ACCESS_RADIUS);

        PlayerFindingHouse[playerid] = 1;
        PlayerFindingHouseIndex[playerid] = houseIndex;

        new msg[144];
        format(msg, sizeof(msg), "Checkpoint diarahkan ke rumah: %s.", HouseName[houseIndex]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /cancelhouse untuk menghapus checkpoint.");

        return 1;
    }

    if (!strcmp(cmdtext, "/findhouse", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /findhouse [house_id]");
        return 1;
    }

    if (!strcmp(cmdtext, "/cancelhouse", true))
    {
        if (!PlayerFindingHouse[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang mencari rumah.");
            return 1;
        }

        DisablePlayerCheckpoint(playerid);
        PlayerFindingHouse[playerid] = 0;
        PlayerFindingHouseIndex[playerid] = -1;

        SendClientMessage(playerid, COLOR_YELLOW, "Checkpoint rumah dihapus.");
        return 1;
    }
    if (strfind(cmdtext, "/buyhouse ", true) == 0)
    {
        new houseStr[16];

        if (!GetOneParam(cmdtext[10], houseStr, sizeof(houseStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /buyhouse [house_id]");
            return 1;
        }

        if (!IsNumericString(houseStr))
        {
            SendClientMessage(playerid, COLOR_RED, "House ID harus angka.");
            return 1;
        }

        if (PlayerHouseDBID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah punya rumah. Gunakan /sellhouse dulu.");
            return 1;
        }

        new houseIndex = strval(houseStr) - 1;

        if (!IsValidHouseIndex(houseIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "House ID tidak valid.");
            return 1;
        }

        if (!IsPlayerNearHouse(playerid, houseIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumah tersebut untuk membelinya.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /findhouse [id].");
            return 1;
        }

        new price = HousePrice[houseIndex];

        if (PlayerMoney[playerid] < price)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Harga rumah ini $%d.", price);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO player_houses (owner_id, house_index, house_name, price, locked, pos_x, pos_y, pos_z) VALUES (%d, %d, '%e', %d, 1, %f, %f, %f)",
            PlayerDBID[playerid],
            houseIndex,
            HouseName[houseIndex],
            price,
            HouseX[houseIndex],
            HouseY[houseIndex],
            HouseZ[houseIndex]
        );

        mysql_tquery(g_SQL, query, "OnPlayerHouseBought", "iii", playerid, houseIndex, price);
        return 1;
    }

    if (!strcmp(cmdtext, "/myhouse", true))
    {
        if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        new houseIndex = PlayerHouseIndex[playerid];
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== MY HOUSE ==========");

        format(msg, sizeof(msg), "House: %s", HouseName[houseIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "DBID: %d | Price: $%d", PlayerHouseDBID[playerid], HousePrice[houseIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Spawn at house: %s", PlayerSpawnHouse[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Locked: %s | Inside: %s", PlayerHouseLocked[playerid] ? ("Yes") : ("No"), PlayerInsideHouse[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Location: %.2f, %.2f, %.2f", HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Command: /enterhouse, /exithouse, /lockhouse, /gohome, /setspawn house, /sellhouse.");
        return 1;
    }

    if (!strcmp(cmdtext, "/gohome", true))
    {
        if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak bisa /gohome saat job/race aktif.");
            return 1;
        }

        new houseIndex = PlayerHouseIndex[playerid];

        PlayerInsideHouse[playerid] = 0;

        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPos(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]);
        SetPlayerFacingAngle(playerid, 0.0);

        SendClientMessage(playerid, COLOR_GREEN, "Kamu teleport ke rumah.");
        return 1;
    }

    if (strfind(cmdtext, "/setspawn ", true) == 0)
    {
        new spawnStr[32];

        if (!GetOneParam(cmdtext[10], spawnStr, sizeof(spawnStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setspawn [house/default]");
            return 1;
        }

        if (!strcmp(spawnStr, "house", true))
        {
            if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
            {
                SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
                return 1;
            }

            PlayerSpawnHouse[playerid] = 1;
            SavePlayerData(playerid);

            SendClientMessage(playerid, COLOR_GREEN, "Spawn kamu diatur ke rumah.");
            return 1;
        }

        if (!strcmp(spawnStr, "default", true))
        {
            PlayerSpawnHouse[playerid] = 0;
            SavePlayerData(playerid);

            SendClientMessage(playerid, COLOR_GREEN, "Spawn kamu dikembalikan ke posisi terakhir/default.");
            return 1;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setspawn [house/default]");
        return 1;
    }

    if (!strcmp(cmdtext, "/sellhouse", true))
    {
        if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        if (PlayerInsideHouse[playerid])
        {
            ExitPlayerHouse(playerid);
        }

        new houseIndex = PlayerHouseIndex[playerid];
        new sellPrice = (HousePrice[houseIndex] * HOUSE_SELL_PERCENT) / 100;
        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM player_houses WHERE id=%d AND owner_id=%d LIMIT 1",
            PlayerHouseDBID[playerid],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnPlayerHouseSold", "ii", playerid, sellPrice);
        return 1;
    }

    if (!strcmp(cmdtext, "/enterhouse", true))
    {
        EnterPlayerHouse(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/exithouse", true))
    {
        ExitPlayerHouse(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/lockhouse", true))
    {
        if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        if (!PlayerInsideHouse[playerid] && !IsPlayerNearHouse(playerid, PlayerHouseIndex[playerid]))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di rumah atau dekat rumah untuk mengunci/membuka rumah.");
            return 1;
        }

        if (PlayerHouseLocked[playerid])
        {
            PlayerHouseLocked[playerid] = 0;
            SendClientMessage(playerid, COLOR_GREEN, "Rumah dibuka.");
        }
        else
        {
            PlayerHouseLocked[playerid] = 1;
            SendClientMessage(playerid, COLOR_YELLOW, "Rumah dikunci.");
        }

        SavePlayerHouseLock(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/houseinfo", true))
    {
        if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        new houseIndex = PlayerHouseIndex[playerid];
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== HOUSE INFO ==========");

        format(msg, sizeof(msg), "House: %s", HouseName[houseIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "DBID: %d | Index: %d", PlayerHouseDBID[playerid], houseIndex + 1);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Locked: %s", PlayerHouseLocked[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Inside House: %s", PlayerInsideHouse[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Virtual World: %d", GetPlayerHouseVirtualWorld(playerid));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Command: /enterhouse, /exithouse, /lockhouse, /gohome, /sellhouse.");
        return 1;
    }

    SendClientMessage(playerid, COLOR_RED, "Command tidak ditemukan. Gunakan /help.");
    return 1;
}