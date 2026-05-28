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
#define DIALOG_BETA_RULES 1002
#define DIALOG_BETA_MOTD 1003
#define DIALOG_FEEDBACK_LIST 1004
#define DIALOG_ATM_MENU 1005
#define DIALOG_ATM_DEPOSIT 1006
#define DIALOG_ATM_WITHDRAW 1007
#define DIALOG_ATM_BALANCE 1008
#define DIALOG_DEALER_MENU 1010
#define DIALOG_DEALER_CONFIRM 1011
#define DIALOG_HOUSE_MENU 1012
#define DIALOG_HOUSE_INFO 1013
#define DIALOG_HOUSE_BUY_CONFIRM 1014
#define DIALOG_HOUSE_SELL_CONFIRM 1015
#define DIALOG_BUSINESS_MENU 1016
#define DIALOG_BUSINESS_INFO 1017
#define DIALOG_BUSINESS_BUY_CONFIRM 1018
#define DIALOG_BUSINESS_UPGRADE_CONFIRM 1019
#define DIALOG_BUSINESS_SELL_CONFIRM 1020
#define DIALOG_DEALER_MAIN 1021
#define DIALOG_GARAGE_MENU 1022
#define DIALOG_GARAGE_SPAWN 1023
#define DIALOG_GARAGE_RENAME_SLOT 1024
#define DIALOG_GARAGE_RENAME_INPUT 1025
#define DIALOG_GARAGE_SELL_SLOT 1026
#define DIALOG_GARAGE_SELL_CONFIRM 1027
#define DIALOG_GARAGE_REPAIR_CONFIRM 1028
#define DIALOG_GARAGE_REFUEL_CONFIRM 1029
#define DIALOG_GARAGE_STATUS 1030
#define DIALOG_ORG_MENU 1031
#define DIALOG_ORG_INFO 1032
#define DIALOG_ORG_MEMBERS 1033
#define DIALOG_ORG_BANK 1034
#define DIALOG_ORG_DEPOSIT 1035
#define DIALOG_ORG_WITHDRAW 1036
#define DIALOG_ORG_INVITE 1037
#define DIALOG_ORG_SETRANK 1038
#define DIALOG_ORG_KICK 1039
#define DIALOG_ORG_KICK_CONFIRM 1040
#define DIALOG_ORG_LEAVE_CONFIRM 1041
#define DIALOG_ORG_DISBAND_CONFIRM 1042
#define DIALOG_ORG_CREATE_INPUT 1043
#define DIALOG_ORG_LIST 1044

#define DIALOG_ADMIN_MENU 1045
#define DIALOG_BETA_MENU 1046
#define DIALOG_ADMIN_PLAYERS 1047
#define DIALOG_ADMIN_ADMINS 1048
#define DIALOG_ADMIN_RECENT_BUGS 1049
#define DIALOG_ADMIN_RECENT_REPORTS 1050
#define DIALOG_ADMIN_RECENT_FEEDBACK 1051
#define DIALOG_ADMIN_RECENT_LOGS 1052
#define DIALOG_BETA_STATUS_DIALOG 1053
#define DIALOG_BETA_WHITELIST_LIST 1054
#define DIALOG_BETA_WLADD_INPUT 1055
#define DIALOG_BETA_WLREMOVE_INPUT 1056
#define DIALOG_BETA_WLCHECK_INPUT 1057
#define DIALOG_BETA_WLCHECK_RESULT 1058

#define STARTER_CASH 15000
#define STARTER_BANK 5000
#define STARTER_XP 250


#define AUTOSAVE_INTERVAL 300000 // 5 menit dalam milidetik

#define CLOSED_BETA_ENABLED 1
#define CLOSED_BETA_ALLOW_EMPTY 1 // 1 = kalau whitelist kosong, server tetap bisa dimasuki untuk bootstrap admin

#define BETA_MOTD_TITLE "LSIF Closed Beta"
#define BETA_MOTD_TEXT "Selamat datang di LSIF Closed Beta. Fitur masih dalam tahap testing. Laporkan bug dengan /report."


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

#define JOB_VEHICLE_GRACE_SECONDS 30

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

#define HOUSE_PICKUP_MODEL 1318
#define HOUSE_PICKUP_TYPE 1
#define HOUSE_PICKUP_COOLDOWN_MS 3000
#define HOUSE_EXIT_PICKUP_Y_OFFSET -2.0

#define ORG_CREATE_PRICE 100000
#define MAX_ORG_BANK_TRANSACTION 10000000

#define ORG_RANK_NONE   0
#define ORG_RANK_MEMBER 1
#define ORG_RANK_ADMIN  3
#define ORG_RANK_OWNER  5

#define MAX_BUSINESSES 5
#define BUSINESS_ACCESS_RADIUS 5.0
#define BUSINESS_SELL_PERCENT 70
#define BUSINESS_MAX_COLLECT 500000

#define BUSINESS_MAX_LEVEL 5
#define BUSINESS_UPGRADE_BASE_COST 50000
#define BUSINESS_UPGRADE_COST_MULTIPLIER 2

#define MAX_DEALERSHIPS 3
#define DEALERSHIP_ACCESS_RADIUS 8.0

#define MAX_SHOP_VEHICLES 12

#define WORLD_MARKER_PICKUP_MODEL 1239
#define WORLD_MARKER_PICKUP_TYPE 1
#define WORLD_LABEL_DRAW_DISTANCE 22.0

#define MAPICON_BASE_ATM 10
#define MAPICON_BASE_HOUSE 20
#define MAPICON_BASE_BUSINESS 30
#define MAPICON_BASE_DEALER 40
#define MAPICON_BASE_RACE 50

#define MAPICON_TYPE_ATM 52
#define MAPICON_TYPE_HOUSE 31
#define MAPICON_TYPE_BUSINESS 52
#define MAPICON_TYPE_DEALER 55
#define MAPICON_TYPE_RACE 53
#if !defined MAPICON_LOCAL
#define MAPICON_LOCAL 0
#endif

#define MAX_GARAGE_SLOTS 3

#define VEHICLE_MAX_FUEL 100
#define VEHICLE_REPAIR_COST 1500
#define VEHICLE_REFUEL_COST_PER_POINT 20

#define FUEL_TIMER_INTERVAL 60000 // 60 detik
#define FUEL_CONSUME_AMOUNT 1

new MySQL:g_SQL;
new g_AutosaveTimer;

new g_AntiCheatTimer;
new g_FuelTimer;

new g_ServerStartTick;

new PlayerMoneyMismatchCount[MAX_PLAYERS];
new PlayerLastACWarningTick[MAX_PLAYERS];
new PlayerLastWhitelistQuery[MAX_PLAYERS][24];
new PlayerStarterPackClaimed[MAX_PLAYERS];

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
new OwnedVehicleSlot[MAX_PLAYERS];

new Float:OwnedVehicleX[MAX_PLAYERS];
new Float:OwnedVehicleY[MAX_PLAYERS];
new Float:OwnedVehicleZ[MAX_PLAYERS];
new Float:OwnedVehicleA[MAX_PLAYERS];
new Text3D:OwnedVehicleLabel[MAX_PLAYERS];
new OwnedVehicleName[MAX_PLAYERS][32];
new Float:OwnedVehicleHealth[MAX_PLAYERS];
new OwnedVehicleFuel[MAX_PLAYERS];

new PlayerGarageDBID[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new PlayerGarageModel[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new PlayerGarageLocked[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new PlayerGarageName[MAX_PLAYERS][MAX_GARAGE_SLOTS][32];
new Float:PlayerGarageHealth[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new PlayerGarageFuel[MAX_PLAYERS][MAX_GARAGE_SLOTS];

new Float:PlayerGarageX[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new Float:PlayerGarageY[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new Float:PlayerGarageZ[MAX_PLAYERS][MAX_GARAGE_SLOTS];
new Float:PlayerGarageA[MAX_PLAYERS][MAX_GARAGE_SLOTS];

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
new PlayerWorkExitTick[MAX_PLAYERS];

new Float:BankPointX[MAX_BANK_POINTS] =
{
    1833.8134, // Idlewood 24/7 / Supermarket
    1352.4896, // Commerce / Market 24/7
    1000.5822, // Vinewood shop area
    2421.5427, // East LS store area
    1154.7312  // Santa Maria beach shop area
};

new Float:BankPointY[MAX_BANK_POINTS] =
{
    -1842.4136,
        -1758.2188,
        -919.9146,
        -1224.3597,
        -1769.6847
    };

new Float:BankPointZ[MAX_BANK_POINTS] =
{
    13.5781,
    13.5078,
    42.3281,
    25.3828,
    16.5938
};

new BankPointName[MAX_BANK_POINTS][32] =
{
    "Idlewood 24/7 ATM",
    "Commerce 24/7 ATM",
    "Vinewood Store ATM",
    "East LS Market ATM",
    "Santa Maria Shop ATM"
};

new PlayerHouseDBID[MAX_PLAYERS];
new PlayerHouseIndex[MAX_PLAYERS];
new PlayerHouseLocked[MAX_PLAYERS];
new PlayerSpawnHouse[MAX_PLAYERS];
new PlayerInsideHouse[MAX_PLAYERS];
new PlayerInsideHouseOwner[MAX_PLAYERS];
new PlayerHouseInvite[MAX_PLAYERS];
new PlayerFindingHouse[MAX_PLAYERS];
new PlayerFindingHouseIndex[MAX_PLAYERS];
new HouseExteriorPickup[MAX_HOUSES];
new PlayerHouseExitPickup[MAX_PLAYERS];
new PlayerLastHousePickupTick[MAX_PLAYERS];

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

new PlayerOrgID[MAX_PLAYERS];
new PlayerOrgRank[MAX_PLAYERS];
new PlayerOrgInvite[MAX_PLAYERS];
new PlayerOrgName[MAX_PLAYERS][64];
new PlayerPendingOrgName[MAX_PLAYERS][64];
new PlayerOrgBankMoney[MAX_PLAYERS];
new PlayerSelectedOrgTarget[MAX_PLAYERS];

new PlayerBusinessDBID[MAX_PLAYERS];
new PlayerBusinessIndex[MAX_PLAYERS];
new PlayerBusinessLevel[MAX_PLAYERS];
new PlayerBusinessTotalCollected[MAX_PLAYERS];
new PlayerFindingBusiness[MAX_PLAYERS];
new PlayerFindingBusinessIndex[MAX_PLAYERS];

new Float:BusinessX[MAX_BUSINESSES] =
{
    1833.1124,
    2105.4583,
    1368.9248,
    2420.3311,
    1000.5822
};

new Float:BusinessY[MAX_BUSINESSES] =
{
    -1842.9921,
        -1806.4227,
        -1279.6914,
        -1508.2178,
        -919.9146
    };

new Float:BusinessZ[MAX_BUSINESSES] =
{
    13.5781,
    13.5547,
    13.5469,
    24.0000,
    42.3281
};

new BusinessPrice[MAX_BUSINESSES] =
{
    80000,
    120000,
    175000,
    250000,
    350000
};

new BusinessIncomePerMinute[MAX_BUSINESSES] =
{
    120,
    180,
    250,
    350,
    500
};

new BusinessName[MAX_BUSINESSES][64] =
{
    "Idlewood Mini Market",
    "Willowfield Workshop",
    "Market Food Store",
    "East LS Gas Station",
    "Vinewood Electronics"
};

new PlayerFindingDealer[MAX_PLAYERS];
new PlayerDialogDealerVehicle[MAX_PLAYERS];
new PlayerDialogHouseIndex[MAX_PLAYERS];
new PlayerDialogBusinessIndex[MAX_PLAYERS];
new PlayerDialogGarageSlot[MAX_PLAYERS];

new BankPointPickup[MAX_BANK_POINTS];
new Text3D:BankPointLabel[MAX_BANK_POINTS];

new DealershipPickup[MAX_DEALERSHIPS];
new Text3D:DealershipLabel[MAX_DEALERSHIPS];

new BusinessPickup[MAX_BUSINESSES];
new Text3D:BusinessLabel[MAX_BUSINESSES];

new Text3D:HouseExteriorLabel[MAX_HOUSES];
new RaceStartPickup;
new Text3D:RaceStartLabel;

new Float:DealershipX[MAX_DEALERSHIPS] =
{
    2131.9177,
    562.6155,
    -1954.2469
};

new Float:DealershipY[MAX_DEALERSHIPS] =
{
    -1150.1232,
        -1291.7563,
        300.2021
    };

new Float:DealershipZ[MAX_DEALERSHIPS] =
{
    24.2266,
    17.2482,
    35.4688
};

new DealershipName[MAX_DEALERSHIPS][64] =
{
    "LS Grotti Dealership",
    "Market Budget Cars",
    "San Fierro Import Dealer"
};

new ShopVehicleModel[MAX_SHOP_VEHICLES] =
{
    401, // Bravura
    400, // Landstalker
    462, // Faggio
    461, // PCJ-600
    482, // Burrito
    413, // Pony
    402, // Buffalo
    415, // Cheetah
    411, // Infernus
    451, // Turismo
    420, // Taxi
    515  // Roadtrain
};

new ShopVehiclePrice[MAX_SHOP_VEHICLES] =
{
    8000,
    12000,
    5000,
    15000,
    15000,
    12000,
    25000,
    60000,
    75000,
    65000,
    18000,
    90000
};

new ShopVehicleName[MAX_SHOP_VEHICLES][32] =
{
    "Bravura",
    "Landstalker",
    "Faggio",
    "PCJ-600",
    "Burrito",
    "Pony",
    "Buffalo",
    "Cheetah",
    "Infernus",
    "Turismo",
    "Taxi",
    "Roadtrain"
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
forward FuelSystemTick();
forward OnDatabasePing(playerid);
forward OnPlayerHouseLoaded(playerid);
forward OnPlayerHouseBought(playerid, houseIndex, price);
forward OnPlayerHouseSold(playerid, sellPrice);
forward OnPlayerOrgLoaded(playerid);
forward OnOrgCreated(playerid);
forward OnOrgInviteAccepted(playerid);
forward OnOrgMembersLoaded(playerid);
forward OnOrgListLoaded(playerid);
forward OnOrgRankUpdated(playerid, targetid, newRank);
forward OnOrgMemberKicked(playerid, targetid);
forward OnOrgDisbanded(playerid, orgid);
forward OnOrgInfoLoaded(playerid);
forward OnOrgMembersDialogLoaded(playerid);
forward OnOrgListDialogLoaded(playerid);
forward OnPlayerBusinessLoaded(playerid);
forward OnPlayerBusinessBought(playerid, businessIndex, price);
forward OnBusinessCollectLoaded(playerid);
forward OnPlayerBusinessSold(playerid, sellPrice);
forward OnBusinessUpgraded(playerid, newLevel, cost);
forward OnBusinessTopLoaded(playerid);
forward OnGarageLoaded(playerid);
forward OnGarageVehicleBought(playerid, slotIndex, modelid, price);
forward OnGarageVehicleSold(playerid, slotIndex, sellPrice);
forward OnBetaWhitelistCheck(playerid);
forward OnWhitelistAdded(playerid);
forward OnWhitelistRemoved(playerid);
forward OnWhitelistListLoaded(playerid);
forward OnFeedbackCreated(playerid);
forward OnFeedbackListLoaded(playerid);
forward OnFeedbackClosed(playerid, feedbackid);
forward OnWhitelistCheckLoaded(playerid);
forward ShowPostLoginRules(playerid);
forward OnRecentBugsLoaded(playerid);
forward OnRecentFeedbackLoaded(playerid);
forward OnRecentReportsLoaded(playerid);
forward OnRecentLogsLoaded(playerid);
forward OnWhitelistDialogLoaded(playerid);
forward OnWhitelistCheckDialogLoaded(playerid);
forward OnRecentBugsDialogLoaded(playerid);
forward OnRecentFeedbackDialogLoaded(playerid);
forward OnRecentReportsDialogLoaded(playerid);
forward OnRecentLogsDialogLoaded(playerid);


stock ShowBetaMOTD(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_BETA_MOTD,
        DIALOG_STYLE_MSGBOX,
        BETA_MOTD_TITLE,
        BETA_MOTD_TEXT,
        "OK",
        ""
    );
    return 1;
}

stock ShowServerRules(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_BETA_RULES,
        DIALOG_STYLE_MSGBOX,
        "LSIF Server Rules",
        "1. Dilarang cheat, exploit, atau abuse bug.\n2. Dilarang DM sembarangan saat testing.\n3. Laporkan bug lewat /report.\n4. Jangan spam command/chat.\n5. Hormati admin dan tester lain.\n\nDengan bermain di closed beta, kamu setuju mengikuti aturan ini.",
        "Saya Mengerti",
        ""
    );
    return 1;
}

stock SendBetaGuide(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF CLOSED BETA GUIDE ==========");
    SendClientMessage(playerid, COLOR_WHITE, "Mulai: /jobs, /races, /dealerships, /houses, /businesses.");
    SendClientMessage(playerid, COLOR_WHITE, "Uang: kerja courier/taxi/trucker, race, business income.");
    SendClientMessage(playerid, COLOR_WHITE, "Kendaraan: /finddealer -> /vehicleshop -> /buyvehicle [id].");
    SendClientMessage(playerid, COLOR_WHITE, "Bank: /findbank -> /deposit atau /withdraw.");
    SendClientMessage(playerid, COLOR_WHITE, "Starter: /starterpack untuk modal awal closed beta.");
    SendClientMessage(playerid, COLOR_WHITE, "Bug/saran: /bugreport [text] atau /suggest [text].");
    SendClientMessage(playerid, COLOR_WHITE, "Report player: /report [id] [reason]. Admin online: /admins.");
    SendClientMessage(playerid, COLOR_CYAN, "Baca aturan kapan saja dengan /serverrules dan info beta dengan /motd.");
    return 1;
}

stock SendBetaLoginMessages(playerid, isNewAccount)
{
    if (isNewAccount)
    {
        SendClientMessage(playerid, COLOR_GREEN, "Akun baru terdaftar untuk LSIF Closed Beta.");
        SendBetaGuide(playerid);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREEN, "Selamat datang kembali di LSIF Closed Beta.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /betahelp untuk starter guide dan /serverrules untuk aturan server.");
    }

    SendClientMessage(playerid, COLOR_ORANGE, BETA_MOTD_TEXT);
    SendClientMessage(playerid, COLOR_WHITE, "Rules akan muncul setelah spawn. Gunakan /serverrules jika dialog tidak muncul.");
    SetTimerEx("ShowPostLoginRules", 1500, false, "i", playerid);
    return 1;
}

public ShowPostLoginRules(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (!PlayerLoggedIn[playerid])
    {
        return 1;
    }

    ShowServerRules(playerid);
    return 1;
}

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
    ResetPlayerGarageData(playerid);
    ResetPlayerRaceData(playerid);
    PlayerFindingBank[playerid] = 0;
    ResetPlayerHouseData(playerid);
    ResetPlayerOrgData(playerid);
    ResetPlayerBusinessData(playerid);
    ResetPlayerDealerData(playerid);


    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkExitTick[playerid] = 0;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = 0;
    PlayerWorkExitTick[playerid] = 0;
    ResetTaxiWorkData(playerid);
    ResetTruckerWorkData(playerid);

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;

    PlayerMoneyMismatchCount[playerid] = 0;
    PlayerLastACWarningTick[playerid] = 0;
    format(PlayerLastWhitelistQuery[playerid], 24, "-");
    PlayerStarterPackClaimed[playerid] = 0;

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

stock CheckBetaWhitelist(playerid)
{
    if (!CLOSED_BETA_ENABLED)
    {
        CheckPlayerAccount(playerid);
        return 1;
    }

    new username[MAX_PLAYER_NAME];
    new query[512];

    GetPlayerAccountName(playerid, username, sizeof(username));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT (SELECT COUNT(*) FROM beta_whitelist WHERE active=1) AS total_active, (SELECT COUNT(*) FROM beta_whitelist WHERE active=1 AND username='%e') AS allowed",
        username
    );

    mysql_tquery(g_SQL, query, "OnBetaWhitelistCheck", "i", playerid);
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
        "UPDATE players SET money=%d, bank_money=%d, xp=%d, level=%d, admin_level=%d, current_job=%d, spawn_house=%d, starter_pack_claimed=%d, pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f WHERE id=%d LIMIT 1",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid],
        PlayerXP[playerid],
        PlayerLevel[playerid],
        PlayerAdmin[playerid],
        PlayerJob[playerid],
        PlayerSpawnHouse[playerid],
        PlayerStarterPackClaimed[playerid],
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
    PlayerWorkExitTick[playerid] = 0;
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
    PlayerWorkExitTick[playerid] = 0;
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
    PlayerWorkExitTick[playerid] = 0;
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

stock IsCurrentWorkVehicleValid(playerid)
{
    if (!PlayerWorking[playerid])
    {
        return 1;
    }

    if (PlayerWorkType[playerid] == WORK_TAXI)
    {
        return IsPlayerInTaxiVehicle(playerid);
    }

    if (PlayerWorkType[playerid] == WORK_TRUCKER)
    {
        return IsPlayerInTruckerVehicle(playerid);
    }

    if (PlayerWorkType[playerid] == WORK_COURIER)
    {
        return IsPlayerInCourierVehicle(playerid);
    }

    return 1;
}

stock GetWorkVehicleGraceLeft(playerid)
{
    if (PlayerWorkExitTick[playerid] == 0)
    {
        return 0;
    }

    new elapsed = (GetTickCount() - PlayerWorkExitTick[playerid]) / 1000;

    if (elapsed >= JOB_VEHICLE_GRACE_SECONDS)
    {
        return 0;
    }

    return JOB_VEHICLE_GRACE_SECONDS - elapsed;
}

stock StartWorkVehicleGrace(playerid)
{
    if (!PlayerWorking[playerid])
    {
        return 0;
    }

    if (PlayerWorkExitTick[playerid] == 0)
    {
        PlayerWorkExitTick[playerid] = GetTickCount();

        new msg[144];
        format(msg, sizeof(msg), "Kamu keluar dari kendaraan job. Kembali dalam %d detik atau job dibatalkan.", JOB_VEHICLE_GRACE_SECONDS);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
    }

    return 1;
}

stock ClearWorkVehicleGrace(playerid)
{
    if (PlayerWorkExitTick[playerid] != 0)
    {
        PlayerWorkExitTick[playerid] = 0;
        SendClientMessage(playerid, COLOR_GREEN, "Kamu kembali ke kendaraan job. Countdown cancel dibatalkan.");
    }

    return 1;
}

stock CheckWorkVehicleGrace(playerid)
{
    if (!PlayerWorking[playerid])
    {
        PlayerWorkExitTick[playerid] = 0;
        return 1;
    }

    if (IsCurrentWorkVehicleValid(playerid))
    {
        ClearWorkVehicleGrace(playerid);
        return 1;
    }

    if (PlayerWorkExitTick[playerid] == 0)
    {
        StartWorkVehicleGrace(playerid);
        return 1;
    }

    new elapsed = (GetTickCount() - PlayerWorkExitTick[playerid]) / 1000;

    if (elapsed >= JOB_VEHICLE_GRACE_SECONDS)
    {
        PlayerWorkExitTick[playerid] = 0;
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Job otomatis dibatalkan karena kamu terlalu lama keluar dari kendaraan job.");
        return 1;
    }

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
    OwnedVehicleSlot[playerid] = -1;
    OwnedVehicleLabel[playerid] = Text3D:INVALID_3DTEXT_ID;

    format(OwnedVehicleName[playerid], 32, "Vehicle");
    OwnedVehicleHealth[playerid] = 1000.0;
    OwnedVehicleFuel[playerid] = VEHICLE_MAX_FUEL;

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

    SetVehicleHealth(OwnedVehicleID[playerid], OwnedVehicleHealth[playerid]);

    ApplyOwnedVehicleParams(playerid);
    CreateOwnedVehicleLabel(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan slot %d [%s] model %d berhasil di-spawn.", OwnedVehicleSlot[playerid] + 1, OwnedVehicleName[playerid], OwnedVehicleModel[playerid]);
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

    new Float:health;
    GetVehicleHealth(OwnedVehicleID[playerid], health);

    OwnedVehicleHealth[playerid] = health;

    OwnedVehicleX[playerid] = x;
    OwnedVehicleY[playerid] = y;
    OwnedVehicleZ[playerid] = z;
    OwnedVehicleA[playerid] = a;

    if (IsValidGarageSlot(OwnedVehicleSlot[playerid]))
    {
        new slotIndex = OwnedVehicleSlot[playerid];

        PlayerGarageX[playerid][slotIndex] = x;
        PlayerGarageY[playerid][slotIndex] = y;
        PlayerGarageZ[playerid][slotIndex] = z;
        PlayerGarageA[playerid][slotIndex] = a;
        PlayerGarageLocked[playerid][slotIndex] = OwnedVehicleLocked[playerid];
        PlayerGarageHealth[playerid][slotIndex] = health;
        PlayerGarageFuel[playerid][slotIndex] = OwnedVehicleFuel[playerid];
        format(PlayerGarageName[playerid][slotIndex], 32, "%s", OwnedVehicleName[playerid]);
    }

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_vehicles SET vehicle_name='%e', pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f, health=%f, fuel=%d, locked=%d WHERE id=%d AND owner_id=%d LIMIT 1",
        OwnedVehicleName[playerid],
        OwnedVehicleX[playerid],
        OwnedVehicleY[playerid],
        OwnedVehicleZ[playerid],
        OwnedVehicleA[playerid],
        OwnedVehicleHealth[playerid],
        OwnedVehicleFuel[playerid],
        OwnedVehicleLocked[playerid],
        OwnedVehicleDBID[playerid],
        PlayerDBID[playerid]
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

    new engineState = 1;

    if (OwnedVehicleFuel[playerid] <= 0)
    {
        engineState = 0;
    }

    SetVehicleParamsEx(
        OwnedVehicleID[playerid],
        engineState, // engine ON only if fuel available
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
        "LSIF Vehicle\n%s\nOwner: %s\nModel: %d",
        OwnedVehicleName[playerid],
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
    PlayerInsideHouseOwner[playerid] = INVALID_PLAYER_ID;
    PlayerHouseInvite[playerid] = INVALID_PLAYER_ID;
    PlayerHouseExitPickup[playerid] = -1;
    PlayerLastHousePickupTick[playerid] = 0;
    PlayerFindingHouse[playerid] = 0;
    PlayerFindingHouseIndex[playerid] = -1;
    return 1;
}

stock DestroyPlayerHouseExitPickup(playerid)
{
    if (PlayerHouseExitPickup[playerid] != -1)
    {
        DestroyPickup(PlayerHouseExitPickup[playerid]);
        PlayerHouseExitPickup[playerid] = -1;
    }

    return 1;
}

stock IsPlayerInHousePickupCooldown(playerid)
{
    new nowTick = GetTickCount();

    if (PlayerLastHousePickupTick[playerid] != 0 && nowTick - PlayerLastHousePickupTick[playerid] < HOUSE_PICKUP_COOLDOWN_MS)
    {
        return 1;
    }

    return 0;
}

stock SetPlayerHousePickupCooldown(playerid)
{
    PlayerLastHousePickupTick[playerid] = GetTickCount();
    return 1;
}

stock CreatePlayerHouseExitPickup(playerid, ownerid)
{
    DestroyPlayerHouseExitPickup(playerid);

    PlayerHouseExitPickup[playerid] = CreatePickup(
                                          HOUSE_PICKUP_MODEL,
                                          HOUSE_PICKUP_TYPE,
                                          HOUSE_INT_X,
                                          HOUSE_INT_Y + HOUSE_EXIT_PICKUP_Y_OFFSET,
                                          HOUSE_INT_Z,
                                          GetPlayerHouseVirtualWorld(ownerid)
                                      );

    return 1;
}

stock CreateHouseExteriorPickups()
{
    for (new i = 0; i < MAX_HOUSES; i++)
    {
        HouseExteriorPickup[i] = CreatePickup(
                                     HOUSE_PICKUP_MODEL,
                                     HOUSE_PICKUP_TYPE,
                                     HouseX[i],
                                     HouseY[i],
                                     HouseZ[i],
                                     0
                                 );
    }

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
    return EnterHouseAsVisitor(playerid, playerid);
}

stock ExitPlayerHouse(playerid)
{
    if (!PlayerInsideHouse[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang berada di dalam rumah.");
        return 0;
    }

    KickPlayerFromHouse(playerid);

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

stock IsPlayerHouseOwner(playerid)
{
    if (PlayerHouseDBID[playerid] > 0 && PlayerHouseIndex[playerid] != -1)
    {
        return 1;
    }

    return 0;
}

stock CanVisitHouse(playerid, ownerid)
{
    if (!IsPlayerConnected(ownerid) || !PlayerLoggedIn[ownerid])
    {
        return 0;
    }

    if (!IsPlayerHouseOwner(ownerid))
    {
        return 0;
    }

    if (ownerid == playerid)
    {
        return 1;
    }

    if (!PlayerHouseLocked[ownerid])
    {
        return 1;
    }

    if (PlayerHouseInvite[playerid] == ownerid)
    {
        return 1;
    }

    return 0;
}

stock EnterHouseAsVisitor(playerid, ownerid)
{
    if (!CanVisitHouse(playerid, ownerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak punya akses ke rumah ini.");
        return 0;
    }

    if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak bisa masuk rumah saat job/race aktif.");
        return 0;
    }

    new houseIndex = PlayerHouseIndex[ownerid];

    if (!IsPlayerNearHouse(playerid, houseIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumah owner untuk masuk.");
        return 0;
    }

    PlayerInsideHouse[playerid] = 1;
    PlayerInsideHouseOwner[playerid] = ownerid;
    SetPlayerHousePickupCooldown(playerid);

    SetPlayerInterior(playerid, HOUSE_INTERIOR_ID);
    SetPlayerVirtualWorld(playerid, GetPlayerHouseVirtualWorld(ownerid));
    SetPlayerPos(playerid, HOUSE_INT_X, HOUSE_INT_Y, HOUSE_INT_Z);
    SetPlayerFacingAngle(playerid, HOUSE_INT_A);
    CreatePlayerHouseExitPickup(playerid, ownerid);

    if (playerid != ownerid && PlayerHouseInvite[playerid] == ownerid)
    {
        PlayerHouseInvite[playerid] = INVALID_PLAYER_ID;
        SendClientMessage(playerid, COLOR_YELLOW, "House invite digunakan dan sekarang sudah expired.");
    }

    if (playerid == ownerid)
    {
        SendClientMessage(playerid, COLOR_GREEN, "Kamu masuk ke dalam rumah.");
    }
    else
    {
        new ownerName[MAX_PLAYER_NAME];
        new msg[144];

        GetPlayerName(ownerid, ownerName, sizeof(ownerName));

        format(msg, sizeof(msg), "Kamu masuk ke rumah milik %s.", ownerName);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }

    SendClientMessage(playerid, COLOR_WHITE, "Sentuh panah keluar di dalam rumah, atau gunakan /exithouse sebagai fallback.");

    return 1;
}

stock KickPlayerFromHouse(playerid)
{
    if (!PlayerInsideHouse[playerid])
    {
        return 0;
    }

    new ownerid = PlayerInsideHouseOwner[playerid];

    if (ownerid == INVALID_PLAYER_ID || !IsPlayerConnected(ownerid) || PlayerHouseIndex[ownerid] == -1)
    {
        SetPlayerHousePickupCooldown(playerid);
        DestroyPlayerHouseExitPickup(playerid);
        PlayerInsideHouse[playerid] = 0;
        PlayerInsideHouseOwner[playerid] = INVALID_PLAYER_ID;

        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPos(playerid, SPAWN_X, SPAWN_Y, SPAWN_Z);
        SetPlayerFacingAngle(playerid, SPAWN_A);
        return 1;
    }

    new houseIndex = PlayerHouseIndex[ownerid];

    SetPlayerHousePickupCooldown(playerid);
    DestroyPlayerHouseExitPickup(playerid);
    PlayerInsideHouse[playerid] = 0;
    PlayerInsideHouseOwner[playerid] = INVALID_PLAYER_ID;

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, HouseX[houseIndex], HouseY[houseIndex], HouseZ[houseIndex]);
    SetPlayerFacingAngle(playerid, 0.0);

    return 1;
}

stock ResetPlayerOrgData(playerid)
{
    PlayerOrgID[playerid] = 0;
    PlayerOrgRank[playerid] = ORG_RANK_NONE;
    PlayerOrgInvite[playerid] = INVALID_PLAYER_ID;
    PlayerOrgBankMoney[playerid] = 0;
    PlayerSelectedOrgTarget[playerid] = INVALID_PLAYER_ID;
    format(PlayerOrgName[playerid], 64, "None");
    format(PlayerPendingOrgName[playerid], 64, "None");
    return 1;
}

stock GetOrgRankName(rank, output[], size)
{
    if (rank >= ORG_RANK_OWNER)
    {
        format(output, size, "Owner");
        return 1;
    }

    if (rank >= ORG_RANK_ADMIN)
    {
        format(output, size, "Admin");
        return 1;
    }

    if (rank >= ORG_RANK_MEMBER)
    {
        format(output, size, "Member");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock LoadPlayerOrganization(playerid)
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
        "SELECT om.org_id, om.rank_level, o.name, o.bank_money FROM organization_members om JOIN organizations o ON o.id = om.org_id WHERE om.player_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerOrgLoaded", "i", playerid);
    return 1;
}

stock SendMessageToOrg(orgid, color, const message[])
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerOrgID[i] == orgid)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}

stock IsValidOrgRank(rank)
{
    if (rank == ORG_RANK_MEMBER) return 1;
    if (rank == ORG_RANK_ADMIN) return 1;
    if (rank == ORG_RANK_OWNER) return 1;

    return 0;
}

stock IsOrgOwner(playerid)
{
    if (PlayerOrgID[playerid] > 0 && PlayerOrgRank[playerid] >= ORG_RANK_OWNER)
    {
        return 1;
    }

    return 0;
}

stock IsOrgAdmin(playerid)
{
    if (PlayerOrgID[playerid] > 0 && PlayerOrgRank[playerid] >= ORG_RANK_ADMIN)
    {
        return 1;
    }

    return 0;
}

stock IsValidOrgBankAmount(amount)
{
    if (amount <= 0)
    {
        return 0;
    }

    if (amount > MAX_ORG_BANK_TRANSACTION)
    {
        return 0;
    }

    return 1;
}

stock SyncOrgBankMoney(orgid, newBankMoney)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerOrgID[i] == orgid)
        {
            PlayerOrgBankMoney[i] = newBankMoney;
        }
    }

    return 1;
}

stock SaveOrgBankMoney(orgid, bankMoney)
{
    if (orgid <= 0)
    {
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE organizations SET bank_money=%d WHERE id=%d LIMIT 1",
        bankMoney,
        orgid
    );

    mysql_tquery(g_SQL, query);
    return 1;
}

stock ShowOrgMenuDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        ShowPlayerDialog(
            playerid,
            DIALOG_ORG_MENU,
            DIALOG_STYLE_LIST,
            "Organization Menu",
            "Create Organization\nView Organizations",
            "Pilih",
            "Tutup"
        );
        return 1;
    }

    ShowPlayerDialog(
        playerid,
        DIALOG_ORG_MENU,
        DIALOG_STYLE_LIST,
        "Organization Menu",
        "Organization Info\nMembers\nOrg Bank\nDeposit Org Bank\nWithdraw Org Bank\nInvite Member\nSet Member Rank\nKick Member\nLeave Organization\nDisband Organization",
        "Pilih",
        "Tutup"
    );
    return 1;
}

stock ShowOrgInfoDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    new rankName[32];
    new dialogText[512];

    GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

    format(
        dialogText,
        sizeof(dialogText),
        "Organization: %s\nOrg ID: %d\nYour Rank: %s (%d)\nOrg Bank: $%d\n\nGunakan menu ini untuk mengelola organisasi tanpa banyak command.",
        PlayerOrgName[playerid],
        PlayerOrgID[playerid],
        rankName,
        PlayerOrgRank[playerid],
        PlayerOrgBankMoney[playerid]
    );

    ShowPlayerDialog(playerid, DIALOG_ORG_INFO, DIALOG_STYLE_MSGBOX, "Organization Info", dialogText, "Back", "Tutup");
    return 1;
}

stock ShowOrgBankDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    new rankName[32];
    new dialogText[512];

    GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

    format(
        dialogText,
        sizeof(dialogText),
        "Organization: %s\nYour Rank: %s (%d)\nOrg Bank: $%d\nYour Cash: $%d\n\nMember bisa deposit. Admin/Owner bisa withdraw.",
        PlayerOrgName[playerid],
        rankName,
        PlayerOrgRank[playerid],
        PlayerOrgBankMoney[playerid],
        PlayerMoney[playerid]
    );

    ShowPlayerDialog(playerid, DIALOG_ORG_BANK, DIALOG_STYLE_MSGBOX, "Organization Bank", dialogText, "Back", "Tutup");
    return 1;
}

stock ShowOrgDepositDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    new dialogText[256];
    format(dialogText, sizeof(dialogText), "Cash kamu: $%d\nOrg bank: $%d\n\nMasukkan jumlah deposit, atau ketik all.", PlayerMoney[playerid], PlayerOrgBankMoney[playerid]);
    ShowPlayerDialog(playerid, DIALOG_ORG_DEPOSIT, DIALOG_STYLE_INPUT, "Deposit Org Bank", dialogText, "Deposit", "Back");
    return 1;
}

stock ShowOrgWithdrawDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    if (PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk withdraw.");
        return 0;
    }

    new dialogText[256];
    format(dialogText, sizeof(dialogText), "Org bank: $%d\nCash kamu: $%d\n\nMasukkan jumlah withdraw.", PlayerOrgBankMoney[playerid], PlayerMoney[playerid]);
    ShowPlayerDialog(playerid, DIALOG_ORG_WITHDRAW, DIALOG_STYLE_INPUT, "Withdraw Org Bank", dialogText, "Withdraw", "Back");
    return 1;
}

stock ShowOrgInviteDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0 || PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk invite.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_ORG_INVITE, DIALOG_STYLE_INPUT, "Invite Organization Member", "Masukkan player ID yang ingin diundang ke organisasi.", "Invite", "Back");
    return 1;
}

stock ShowOrgSetRankDialog(playerid)
{
    if (!IsOrgOwner(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner organisasi yang bisa mengubah rank.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_ORG_SETRANK, DIALOG_STYLE_INPUT, "Set Organization Rank", "Format: playerid rank\n\nRank valid:\n1 = Member\n3 = Admin\n\nContoh: 2 3", "Set", "Back");
    return 1;
}

stock ShowOrgKickDialog(playerid)
{
    if (!IsOrgAdmin(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk kick member.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_ORG_KICK, DIALOG_STYLE_INPUT, "Kick Organization Member", "Masukkan player ID yang ingin dikeluarkan dari organisasi.", "Kick", "Back");
    return 1;
}

stock ShowOrgMembersDialog(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT player_name, rank_level FROM organization_members WHERE org_id=%d ORDER BY rank_level DESC, player_name ASC LIMIT 20",
        PlayerOrgID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnOrgMembersDialogLoaded", "i", playerid);
    return 1;
}

stock ShowOrgListDialog(playerid)
{
    mysql_tquery(
        g_SQL,
        "SELECT id, name, owner_name, bank_money FROM organizations ORDER BY id ASC LIMIT 10",
        "OnOrgListDialogLoaded",
        "i",
        playerid
    );
    return 1;
}

stock ShowOrgCreateInputDialog(playerid)
{
    if (PlayerOrgID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam organisasi.");
        return 0;
    }

    new dialogText[256];
    format(dialogText, sizeof(dialogText), "Biaya membuat organisasi: $%d\nCash kamu: $%d\n\nMasukkan nama organisasi baru.", ORG_CREATE_PRICE, PlayerMoney[playerid]);
    ShowPlayerDialog(playerid, DIALOG_ORG_CREATE_INPUT, DIALOG_STYLE_INPUT, "Create Organization", dialogText, "Create", "Back");
    return 1;
}

stock OrgDepositMoney(playerid, const amountStr[])
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
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
            return 0;
        }

        amount = strval(amountStr);
    }

    if (!IsValidOrgBankAmount(amount))
    {
        SendClientMessage(playerid, COLOR_RED, "Jumlah deposit organisasi tidak valid.");
        return 0;
    }

    if (PlayerMoney[playerid] < amount)
    {
        SendClientMessage(playerid, COLOR_RED, "Cash kamu tidak cukup.");
        return 0;
    }

    TakePlayerCash(playerid, amount);

    new newBank = PlayerOrgBankMoney[playerid] + amount;

    SyncOrgBankMoney(PlayerOrgID[playerid], newBank);
    SaveOrgBankMoney(PlayerOrgID[playerid], newBank);
    SavePlayerData(playerid);

    new playerName[MAX_PLAYER_NAME];
    new msg[160];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    format(msg, sizeof(msg), "[ORG BANK] %s deposit $%d. Org bank sekarang: $%d.", playerName, amount, newBank);
    SendMessageToOrg(PlayerOrgID[playerid], COLOR_CYAN, msg);
    return 1;
}

stock OrgWithdrawMoney(playerid, const amountStr[])
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    if (PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk withdraw.");
        return 0;
    }

    if (!IsNumericString(amountStr))
    {
        SendClientMessage(playerid, COLOR_RED, "Amount harus angka.");
        return 0;
    }

    new amount = strval(amountStr);

    if (!IsValidOrgBankAmount(amount))
    {
        SendClientMessage(playerid, COLOR_RED, "Jumlah withdraw organisasi tidak valid.");
        return 0;
    }

    if (PlayerOrgBankMoney[playerid] < amount)
    {
        SendClientMessage(playerid, COLOR_RED, "Saldo bank organisasi tidak cukup.");
        return 0;
    }

    new newBank = PlayerOrgBankMoney[playerid] - amount;

    SyncOrgBankMoney(PlayerOrgID[playerid], newBank);
    SaveOrgBankMoney(PlayerOrgID[playerid], newBank);

    GivePlayerCash(playerid, amount);
    SavePlayerData(playerid);

    new playerName[MAX_PLAYER_NAME];
    new msg[160];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    format(msg, sizeof(msg), "[ORG BANK] %s withdraw $%d. Org bank sekarang: $%d.", playerName, amount, newBank);
    SendMessageToOrg(PlayerOrgID[playerid], COLOR_ORANGE, msg);
    return 1;
}

stock OrgInvitePlayer(playerid, targetid)
{
    if (PlayerOrgID[playerid] <= 0 || PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal admin organisasi untuk invite.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
        return 0;
    }

    if (PlayerOrgID[targetid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Target sudah tergabung dalam organisasi.");
        return 0;
    }

    PlayerOrgInvite[targetid] = playerid;

    new msg[144];
    new inviterName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, inviterName, sizeof(inviterName));

    format(msg, sizeof(msg), "Kamu mengundang player ID %d ke organisasi %s.", targetid, PlayerOrgName[playerid]);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "%s mengundang kamu ke organisasi %s. Gunakan /acceptorg.", inviterName, PlayerOrgName[playerid]);
    SendClientMessage(targetid, COLOR_GREEN, msg);
    return 1;
}

stock OrgSetMemberRank(playerid, targetid, newRank)
{
    if (!IsOrgOwner(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner organisasi yang bisa mengubah rank.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
        return 0;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa mengubah rank diri sendiri.");
        return 0;
    }

    if (PlayerOrgID[targetid] != PlayerOrgID[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target bukan anggota organisasi kamu.");
        return 0;
    }

    if (!IsValidOrgRank(newRank) || newRank == ORG_RANK_OWNER)
    {
        SendClientMessage(playerid, COLOR_RED, "Rank tidak valid untuk dialog ini. Gunakan 1 atau 3.");
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE organization_members SET rank_level=%d WHERE player_id=%d AND org_id=%d LIMIT 1",
        newRank,
        PlayerDBID[targetid],
        PlayerOrgID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnOrgRankUpdated", "iii", playerid, targetid, newRank);
    return 1;
}

stock OrgKickMember(playerid, targetid)
{
    if (!IsOrgAdmin(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk kick member.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
        return 0;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, COLOR_RED, "Gunakan Leave Organization untuk keluar sendiri.");
        return 0;
    }

    if (PlayerOrgID[targetid] != PlayerOrgID[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target bukan anggota organisasi kamu.");
        return 0;
    }

    if (PlayerOrgRank[targetid] >= ORG_RANK_OWNER)
    {
        SendClientMessage(playerid, COLOR_RED, "Owner tidak bisa dikick.");
        return 0;
    }

    if (PlayerOrgRank[targetid] >= PlayerOrgRank[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa kick anggota dengan rank sama/lebih tinggi.");
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM organization_members WHERE player_id=%d AND org_id=%d LIMIT 1",
        PlayerDBID[targetid],
        PlayerOrgID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnOrgMemberKicked", "ii", playerid, targetid);
    return 1;
}

stock OrgLeave(playerid)
{
    if (PlayerOrgID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
        return 0;
    }

    if (PlayerOrgRank[playerid] >= ORG_RANK_OWNER)
    {
        SendClientMessage(playerid, COLOR_RED, "Owner tidak bisa leave. Gunakan Disband Organization.");
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM organization_members WHERE player_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);
    ResetPlayerOrgData(playerid);
    SendClientMessage(playerid, COLOR_YELLOW, "Kamu keluar dari organisasi.");
    return 1;
}

stock OrgDisband(playerid)
{
    if (!IsOrgOwner(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner organisasi yang bisa membubarkan organisasi.");
        return 0;
    }

    new orgid = PlayerOrgID[playerid];
    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM organization_members WHERE org_id=%d",
        orgid
    );
    mysql_tquery(g_SQL, query);

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM organizations WHERE id=%d LIMIT 1",
        orgid
    );
    mysql_tquery(g_SQL, query, "OnOrgDisbanded", "ii", playerid, orgid);
    return 1;
}

stock ResetPlayerBusinessData(playerid)
{
    PlayerBusinessDBID[playerid] = 0;
    PlayerBusinessIndex[playerid] = -1;
    PlayerBusinessLevel[playerid] = 0;
    PlayerBusinessTotalCollected[playerid] = 0;
    PlayerFindingBusiness[playerid] = 0;
    PlayerFindingBusinessIndex[playerid] = -1;
    return 1;
}

stock IsValidBusinessIndex(businessIndex)
{
    if (businessIndex < 0 || businessIndex >= MAX_BUSINESSES)
    {
        return 0;
    }

    return 1;
}

stock IsPlayerNearBusiness(playerid, businessIndex)
{
    if (!IsValidBusinessIndex(businessIndex))
    {
        return 0;
    }

    if (GetPlayerDistanceFromPoint(playerid, BusinessX[businessIndex], BusinessY[businessIndex], BusinessZ[businessIndex]) <= BUSINESS_ACCESS_RADIUS)
    {
        return 1;
    }

    return 0;
}

stock LoadPlayerBusiness(playerid)
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
        "SELECT id, business_index, business_level, total_collected FROM player_businesses WHERE owner_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerBusinessLoaded", "i", playerid);
    return 1;
}

stock GetBusinessIncomePerMinute(businessIndex, level)
{
    if (!IsValidBusinessIndex(businessIndex))
    {
        return 0;
    }

    if (level < 1)
    {
        level = 1;
    }

    return BusinessIncomePerMinute[businessIndex] * level;
}

stock GetBusinessUpgradeCost(level)
{
    if (level < 1)
    {
        level = 1;
    }

    new cost = BUSINESS_UPGRADE_BASE_COST;

    for (new i = 1; i < level; i++)
    {
        cost *= BUSINESS_UPGRADE_COST_MULTIPLIER;
    }

    return cost;
}

stock IsBusinessOwner(playerid)
{
    if (PlayerBusinessDBID[playerid] > 0 && PlayerBusinessIndex[playerid] != -1)
    {
        return 1;
    }

    return 0;
}

stock ResetPlayerDealerData(playerid)
{
    PlayerFindingDealer[playerid] = 0;
    PlayerDialogDealerVehicle[playerid] = -1;
    PlayerDialogHouseIndex[playerid] = -1;
    PlayerDialogBusinessIndex[playerid] = -1;
    PlayerDialogGarageSlot[playerid] = -1;
    return 1;
}

stock GetNearestDealership(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(
                playerid,
                DealershipX[i],
                DealershipY[i],
                DealershipZ[i]
                                               );

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock IsPlayerNearDealership(playerid)
{
    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        if (GetPlayerDistanceFromPoint(playerid, DealershipX[i], DealershipY[i], DealershipZ[i]) <= DEALERSHIP_ACCESS_RADIUS)
        {
            return 1;
        }
    }

    return 0;
}

stock GetNearestDealershipDistance(playerid)
{
    new nearest = GetNearestDealership(playerid);

    if (nearest == -1)
    {
        return 999999;
    }

    return floatround(GetPlayerDistanceFromPoint(
                          playerid,
                          DealershipX[nearest],
                          DealershipY[nearest],
                          DealershipZ[nearest]
                      ));
}

stock IsValidShopVehicleIndex(index)
{
    if (index < 0 || index >= MAX_SHOP_VEHICLES)
    {
        return 0;
    }

    return 1;
}

stock ResetPlayerGarageData(playerid)
{
    for (new i = 0; i < MAX_GARAGE_SLOTS; i++)
    {
        PlayerGarageDBID[playerid][i] = 0;
        PlayerGarageModel[playerid][i] = 0;
        PlayerGarageLocked[playerid][i] = 0;

        format(PlayerGarageName[playerid][i], 32, "Vehicle");
        PlayerGarageHealth[playerid][i] = 1000.0;
        PlayerGarageFuel[playerid][i] = VEHICLE_MAX_FUEL;

        PlayerGarageX[playerid][i] = SPAWN_X + 3.0;
        PlayerGarageY[playerid][i] = SPAWN_Y;
        PlayerGarageZ[playerid][i] = SPAWN_Z;
        PlayerGarageA[playerid][i] = SPAWN_A;
    }

    return 1;
}

stock GetFreeGarageSlot(playerid)
{
    for (new i = 0; i < MAX_GARAGE_SLOTS; i++)
    {
        if (PlayerGarageDBID[playerid][i] <= 0)
        {
            return i;
        }
    }

    return -1;
}

stock CountPlayerGarageVehicles(playerid)
{
    new count = 0;

    for (new i = 0; i < MAX_GARAGE_SLOTS; i++)
    {
        if (PlayerGarageDBID[playerid][i] > 0)
        {
            count++;
        }
    }

    return count;
}

stock IsValidGarageSlot(slotIndex)
{
    if (slotIndex < 0 || slotIndex >= MAX_GARAGE_SLOTS)
    {
        return 0;
    }

    return 1;
}

stock SetActiveVehicleFromGarage(playerid, slotIndex)
{
    if (!IsValidGarageSlot(slotIndex))
    {
        return 0;
    }

    if (PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        return 0;
    }

    OwnedVehicleSlot[playerid] = slotIndex;
    OwnedVehicleDBID[playerid] = PlayerGarageDBID[playerid][slotIndex];
    OwnedVehicleModel[playerid] = PlayerGarageModel[playerid][slotIndex];
    OwnedVehicleLocked[playerid] = PlayerGarageLocked[playerid][slotIndex];

    format(OwnedVehicleName[playerid], 32, "%s", PlayerGarageName[playerid][slotIndex]);
    OwnedVehicleHealth[playerid] = PlayerGarageHealth[playerid][slotIndex];
    OwnedVehicleFuel[playerid] = PlayerGarageFuel[playerid][slotIndex];

    OwnedVehicleX[playerid] = PlayerGarageX[playerid][slotIndex];
    OwnedVehicleY[playerid] = PlayerGarageY[playerid][slotIndex];
    OwnedVehicleZ[playerid] = PlayerGarageZ[playerid][slotIndex];
    OwnedVehicleA[playerid] = PlayerGarageA[playerid][slotIndex];

    return 1;
}

stock LoadPlayerGarage(playerid)
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
        "SELECT id, slot, model_id, vehicle_name, pos_x, pos_y, pos_z, pos_a, health, fuel, locked FROM player_vehicles WHERE owner_id=%d ORDER BY slot ASC",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnGarageLoaded", "i", playerid);
    return 1;
}

stock SaveActiveVehicleMeta(playerid)
{
    if (OwnedVehicleDBID[playerid] <= 0)
    {
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_vehicles SET vehicle_name='%e', health=%f, fuel=%d, locked=%d WHERE id=%d AND owner_id=%d LIMIT 1",
        OwnedVehicleName[playerid],
        OwnedVehicleHealth[playerid],
        OwnedVehicleFuel[playerid],
        OwnedVehicleLocked[playerid],
        OwnedVehicleDBID[playerid],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);
    return 1;
}

stock IsPlayerDrivingActiveOwnedVehicle(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }

    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    if (OwnedVehicleSlot[playerid] == -1)
    {
        return 0;
    }

    if (!IsPlayerInAnyVehicle(playerid))
    {
        return 0;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        return 0;
    }

    if (GetPlayerVehicleID(playerid) != OwnedVehicleID[playerid])
    {
        return 0;
    }

    return 1;
}

stock SyncActiveVehicleFuelToGarage(playerid)
{
    if (!IsValidGarageSlot(OwnedVehicleSlot[playerid]))
    {
        return 0;
    }

    PlayerGarageFuel[playerid][OwnedVehicleSlot[playerid]] = OwnedVehicleFuel[playerid];
    return 1;
}

stock SaveActiveVehicleFuel(playerid)
{
    if (OwnedVehicleDBID[playerid] <= 0)
    {
        return 0;
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_vehicles SET fuel=%d WHERE id=%d AND owner_id=%d LIMIT 1",
        OwnedVehicleFuel[playerid],
        OwnedVehicleDBID[playerid],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);
    return 1;
}

stock StopVehicleEngineDueFuel(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID)
    {
        return 0;
    }

    new engine;
    new lights;
    new alarm;
    new doors;
    new bonnet;
    new boot;
    new objective;

    GetVehicleParamsEx(OwnedVehicleID[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(OwnedVehicleID[playerid], 0, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleVelocity(OwnedVehicleID[playerid], 0.0, 0.0, 0.0);

    SendClientMessage(playerid, COLOR_RED, "Fuel kendaraan habis. Mesin dimatikan.");
    SendClientMessage(playerid, COLOR_WHITE, "Pergi ke dealership dan gunakan /refuelveh.");

    return 1;
}

public FuelSystemTick()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerDrivingActiveOwnedVehicle(i))
        {
            continue;
        }

        if (OwnedVehicleFuel[i] <= 0)
        {
            OwnedVehicleFuel[i] = 0;
            SyncActiveVehicleFuelToGarage(i);
            StopVehicleEngineDueFuel(i);
            continue;
        }

        OwnedVehicleFuel[i] -= FUEL_CONSUME_AMOUNT;

        if (OwnedVehicleFuel[i] < 0)
        {
            OwnedVehicleFuel[i] = 0;
        }

        SyncActiveVehicleFuelToGarage(i);
        SaveActiveVehicleFuel(i);

        if (OwnedVehicleFuel[i] == 20 || OwnedVehicleFuel[i] == 10 || OwnedVehicleFuel[i] == 5)
        {
            new msg[144];
            format(msg, sizeof(msg), "Fuel kendaraan rendah: %d/%d.", OwnedVehicleFuel[i], VEHICLE_MAX_FUEL);
            SendClientMessage(i, COLOR_YELLOW, msg);
        }

        if (OwnedVehicleFuel[i] <= 0)
        {
            StopVehicleEngineDueFuel(i);
        }
    }

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


stock SendStarterPackInfo(playerid)
{
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== STARTER PACK ==========");
    format(msg, sizeof(msg), "Cash: $%d | Bank: $%d | XP: %d", STARTER_CASH, STARTER_BANK, STARTER_XP);
    SendClientMessage(playerid, COLOR_WHITE, msg);
    SendClientMessage(playerid, COLOR_CYAN, "Gunakan /starterpack satu kali untuk klaim.");
    return 1;
}

stock ShowWhereAmI(playerid)
{
    new Float:x, Float:y, Float:z;
    new msg[144];

    GetPlayerPos(playerid, x, y, z);

    SendClientMessage(playerid, COLOR_YELLOW, "========== WHERE AM I ==========");

    format(msg, sizeof(msg), "Pos: %.2f, %.2f, %.2f", x, y, z);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Interior: %d | VirtualWorld: %d", GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Nearest bank: %d unit | Nearest dealer: %d unit", GetNearestBankDistance(playerid), GetNearestDealershipDistance(playerid));
    SendClientMessage(playerid, COLOR_WHITE, msg);

    if (PlayerInsideHouse[playerid])
    {
        format(msg, sizeof(msg), "Inside house owner: %d", PlayerInsideHouseOwner[playerid]);
        SendClientMessage(playerid, COLOR_CYAN, msg);
    }

    return 1;
}

stock CreateFeedbackReport(playerid, const feedbackType[], const message[])
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        return 0;
    }

    new playerName[MAX_PLAYER_NAME];
    new query[768];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO feedback_reports (reporter_id, reporter_name, type, message, status) VALUES (%d, '%e', '%e', '%e', 'open')",
        PlayerDBID[playerid],
        playerName,
        feedbackType,
        message
    );

    mysql_tquery(g_SQL, query, "OnFeedbackCreated", "i", playerid);
    return 1;
}

public OnFeedbackCreated(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new feedbackId = cache_insert_id();
    new msg[144];

    if (feedbackId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Feedback gagal dikirim ke database.");
        return 1;
    }

    format(msg, sizeof(msg), "Feedback berhasil dikirim. ID: #%d. Terima kasih sudah membantu closed beta.", feedbackId);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "[FEEDBACK #%d] Feedback baru masuk. Admin gunakan /feedbacks.", feedbackId);
    SendMessageToAdmins(COLOR_ORANGE, msg);

    return 1;
}

public OnFeedbackListLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== OPEN FEEDBACK ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Tidak ada feedback terbuka.");
        return 1;
    }

    new feedbackId;
    new reporterName[24];
    new feedbackType[16];
    new message[96];
    new createdAt[32];
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", feedbackId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "type", feedbackType, sizeof(feedbackType));
        cache_get_value_name(i, "message", message, sizeof(message));
        cache_get_value_name(i, "created_at", createdAt, sizeof(createdAt));

        format(msg, sizeof(msg), "#%d [%s] %s: %s", feedbackId, feedbackType, reporterName, message);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Created: %s | Close: /closefeedback %d done", createdAt, feedbackId);
        SendClientMessage(playerid, COLOR_CYAN, msg);
    }

    return 1;
}

public OnFeedbackClosed(playerid, feedbackid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();
    new msg[144];

    if (affectedRows > 0)
    {
        format(msg, sizeof(msg), "Feedback #%d berhasil ditutup.", feedbackid);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }
    else
    {
        format(msg, sizeof(msg), "Feedback #%d tidak ditemukan atau sudah tertutup.", feedbackid);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
    }

    return 1;
}



public OnRecentBugsLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== RECENT BUGS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada bug report terbuka.");
        return 1;
    }

    new feedbackId;
    new reporterName[24];
    new message[96];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", feedbackId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "message", message, sizeof(message));

        format(msg, sizeof(msg), "#%d | %s | %s", feedbackId, reporterName, message);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnRecentFeedbackLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== RECENT FEEDBACK ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada feedback terbuka.");
        return 1;
    }

    new feedbackId;
    new reporterName[24];
    new feedbackType[16];
    new message[88];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", feedbackId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "type", feedbackType, sizeof(feedbackType));
        cache_get_value_name(i, "message", message, sizeof(message));

        format(msg, sizeof(msg), "#%d | %s | %s | %s", feedbackId, feedbackType, reporterName, message);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnRecentReportsLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== RECENT PLAYER REPORTS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada report player terbuka.");
        return 1;
    }

    new reportId;
    new reporterName[24];
    new targetName[24];
    new reason[80];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", reportId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "target_name", targetName, sizeof(targetName));
        cache_get_value_name(i, "reason", reason, sizeof(reason));

        format(msg, sizeof(msg), "#%d | %s -> %s | %s", reportId, reporterName, targetName, reason);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnRecentLogsLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== RECENT ADMIN LOGS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada admin log.");
        return 1;
    }

    new logId;
    new adminName[24];
    new targetName[24];
    new action[32];
    new detail[64];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", logId);
        cache_get_value_name(i, "admin_name", adminName, sizeof(adminName));
        cache_get_value_name(i, "target_name", targetName, sizeof(targetName));
        cache_get_value_name(i, "action", action, sizeof(action));
        cache_get_value_name(i, "detail", detail, sizeof(detail));

        format(msg, sizeof(msg), "#%d | %s | %s -> %s | %s", logId, action, adminName, targetName, detail);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}


public OnWhitelistDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[2048];
    new line[160];
    new username[24];
    new addedBy[24];
    new createdAt[32];

    if (rows == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_BETA_WHITELIST_LIST, DIALOG_STYLE_MSGBOX, "Active Whitelist", "Whitelist aktif kosong.", "Back", "Close");
        return 1;
    }

    format(dialogText, sizeof(dialogText), "Username\tAdded By\tCreated\n");

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "username", username, sizeof(username));
        cache_get_value_name(i, "added_by", addedBy, sizeof(addedBy));
        cache_get_value_name(i, "created_at", createdAt, sizeof(createdAt));
        format(line, sizeof(line), "%s\t%s\t%s\n", username, addedBy, createdAt);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_BETA_WHITELIST_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Active Whitelist", dialogText, "Back", "Close");
    return 1;
}

public OnWhitelistCheckDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[512];

    if (rows == 0)
    {
        format(dialogText, sizeof(dialogText), "%s tidak ditemukan di whitelist.", PlayerLastWhitelistQuery[playerid]);
        ShowPlayerDialog(playerid, DIALOG_BETA_WLCHECK_RESULT, DIALOG_STYLE_MSGBOX, "Whitelist Check", dialogText, "Back", "Close");
        return 1;
    }

    new username[24];
    new addedBy[24];
    new createdAt[32];
    new active;

    cache_get_value_name(0, "username", username, sizeof(username));
    cache_get_value_name_int(0, "active", active);
    cache_get_value_name(0, "added_by", addedBy, sizeof(addedBy));
    cache_get_value_name(0, "created_at", createdAt, sizeof(createdAt));

    format(
        dialogText,
        sizeof(dialogText),
        "Username: %s\nActive: %d\nAdded By: %s\nCreated: %s",
        username,
        active,
        addedBy,
        createdAt
    );

    ShowPlayerDialog(playerid, DIALOG_BETA_WLCHECK_RESULT, DIALOG_STYLE_MSGBOX, "Whitelist Check", dialogText, "Back", "Close");
    return 1;
}

public OnRecentBugsDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[2048];
    new line[192];
    new feedbackId;
    new reporterName[24];
    new message[96];

    if (rows == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_BUGS, DIALOG_STYLE_MSGBOX, "Recent Bugs", "Belum ada bug report terbuka.", "Back", "Close");
        return 1;
    }

    format(dialogText, sizeof(dialogText), "ID\tReporter\tMessage\n");

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", feedbackId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "message", message, sizeof(message));
        format(line, sizeof(line), "%d\t%s\t%s\n", feedbackId, reporterName, message);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_BUGS, DIALOG_STYLE_TABLIST_HEADERS, "Recent Bugs", dialogText, "Back", "Close");
    return 1;
}

public OnRecentFeedbackDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[2048];
    new line[192];
    new feedbackId;
    new reporterName[24];
    new feedbackType[16];
    new message[88];

    if (rows == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_FEEDBACK, DIALOG_STYLE_MSGBOX, "Recent Feedback", "Belum ada feedback terbuka.", "Back", "Close");
        return 1;
    }

    format(dialogText, sizeof(dialogText), "ID\tType\tReporter\tMessage\n");

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", feedbackId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "type", feedbackType, sizeof(feedbackType));
        cache_get_value_name(i, "message", message, sizeof(message));
        format(line, sizeof(line), "%d\t%s\t%s\t%s\n", feedbackId, feedbackType, reporterName, message);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_FEEDBACK, DIALOG_STYLE_TABLIST_HEADERS, "Recent Feedback", dialogText, "Back", "Close");
    return 1;
}

public OnRecentReportsDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[2048];
    new line[192];
    new reportId;
    new reporterName[24];
    new targetName[24];
    new reason[80];

    if (rows == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_REPORTS, DIALOG_STYLE_MSGBOX, "Recent Player Reports", "Belum ada report player terbuka.", "Back", "Close");
        return 1;
    }

    format(dialogText, sizeof(dialogText), "ID\tReporter\tTarget\tReason\n");

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", reportId);
        cache_get_value_name(i, "reporter_name", reporterName, sizeof(reporterName));
        cache_get_value_name(i, "target_name", targetName, sizeof(targetName));
        cache_get_value_name(i, "reason", reason, sizeof(reason));
        format(line, sizeof(line), "%d\t%s\t%s\t%s\n", reportId, reporterName, targetName, reason);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_REPORTS, DIALOG_STYLE_TABLIST_HEADERS, "Recent Player Reports", dialogText, "Back", "Close");
    return 1;
}

public OnRecentLogsDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[2048];
    new line[192];
    new logId;
    new adminName[24];
    new targetName[24];
    new action[32];
    new detail[64];

    if (rows == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_LOGS, DIALOG_STYLE_MSGBOX, "Recent Admin Logs", "Belum ada admin log.", "Back", "Close");
        return 1;
    }

    format(dialogText, sizeof(dialogText), "ID\tAction\tAdmin\tTarget\tDetail\n");

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", logId);
        cache_get_value_name(i, "admin_name", adminName, sizeof(adminName));
        cache_get_value_name(i, "target_name", targetName, sizeof(targetName));
        cache_get_value_name(i, "action", action, sizeof(action));
        cache_get_value_name(i, "detail", detail, sizeof(detail));
        format(line, sizeof(line), "%d\t%s\t%s\t%s\t%s\n", logId, action, adminName, targetName, detail);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_RECENT_LOGS, DIALOG_STYLE_TABLIST_HEADERS, "Recent Admin Logs", dialogText, "Back", "Close");
    return 1;
}

public OnGameModeInit()
{
    g_ServerStartTick = GetTickCount();
    DisableInteriorEnterExits();
    ManualVehicleEngineAndLights();
    SetGameModeText("LSIF Dev v0.17H Map Markers");

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

    CreateHouseExteriorPickups();
    CreateWorldInteractionMarkers();

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
        ResetPlayerGarageData(i);
        ResetPlayerRaceData(i);
        PlayerLastRaceTick[i] = 0;
        ResetTaxiWorkData(i);
        ResetTruckerWorkData(i);
        ResetPlayerHouseData(i);
        ResetPlayerOrgData(i);
        ResetPlayerBusinessData(i);
        ResetPlayerDealerData(i);

        PlayerJob[i] = JOB_NONE;
        PlayerWorking[i] = 0;
        PlayerWorkType[i] = WORK_NONE;
        PlayerWorkPoint[i] = -1;
        PlayerLastWorkTick[i] = 0;
        PlayerWorkExitTick[i] = 0;
        PlayerHouseExitPickup[i] = -1;

        PlayerLastX[i] = SPAWN_X;
        PlayerLastY[i] = SPAWN_Y;
        PlayerLastZ[i] = SPAWN_Z;
        PlayerLastA[i] = SPAWN_A;

        PlayerMoneyMismatchCount[i] = 0;
        PlayerLastACWarningTick[i] = 0;
        format(PlayerLastWhitelistQuery[i], 24, "-");
    }
    g_AutosaveTimer = SetTimer("AutoSavePlayers", AUTOSAVE_INTERVAL, true);
    g_AntiCheatTimer = SetTimer("AntiCheatCheck", ANTICHEAT_INTERVAL, true);
    g_FuelTimer = SetTimer("FuelSystemTick", FUEL_TIMER_INTERVAL, true);

    print("[LSIF] Autosave timer aktif setiap 5 menit.");
    print("[LSIF] Anti-cheat timer aktif setiap 10 detik.");
    print("[LSIF] Fuel system timer aktif setiap 60 detik.");
    print("[LSIF] Closed beta whitelist system aktif.");
    print("[LSIF] Manual vehicle engine mode aktif.");
    print("[LSIF] Default GTA interior enter/exit markers disabled.");
    print("[LSIF] Custom house arrow pickups aktif.");
    print("[LSIF] Map icons, 3D labels, and ALT world markers aktif.");
    print("[LSIF] Gamemode v0.17H Map Legend & World Markers berhasil dijalankan.");
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

    if (g_FuelTimer)
    {
        KillTimer(g_FuelTimer);
        g_FuelTimer = 0;
    }

    DestroyWorldInteractionMarkers();

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        if (HouseExteriorPickup[i] != -1)
        {
            DestroyPickup(HouseExteriorPickup[i]);
            HouseExteriorPickup[i] = -1;
        }
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

    SendClientMessage(playerid, COLOR_GREEN, "Selamat datang di LSIF Closed Beta.");
    SendClientMessage(playerid, COLOR_WHITE, "Mengecek whitelist, ban, dan status akun kamu...");
    SendClientMessage(playerid, COLOR_CYAN, "Setelah login gunakan /betaguide, /version, dan /serverrules.");

    CheckPlayerBan(playerid);
    // SendClientMessage(playerid, COLOR_WHITE, "Mengecek akun kamu di database...");

    // CheckPlayerAccount(playerid);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);
    SaveOwnedVehicle(playerid);
    RemoveLSIFMapIcons(playerid);
    DestroyPlayerHouseExitPickup(playerid);
    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyOwnedVehicleLabel(playerid);
        DestroyVehicle(OwnedVehicleID[playerid]);
        OwnedVehicleID[playerid] = INVALID_VEHICLE_ID;
    }

    ResetPlayerGarageData(playerid);
    DisablePlayerCheckpoint(playerid);

    PlayerJob[playerid] = JOB_NONE;
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerWorkExitTick[playerid] = 0;

    PlayerLoggedIn[playerid] = 0;
    PlayerDBID[playerid] = 0;
    PlayerFindingBank[playerid] = 0;
    ResetPlayerOrgData(playerid);

    ResetTaxiWorkData(playerid);
    ResetTruckerWorkData(playerid);
    if (PlayerInsideHouse[playerid])
    {
        PlayerInsideHouse[playerid] = 0;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i))
        {
            continue;
        }

        if (PlayerHouseInvite[i] == playerid)
        {
            PlayerHouseInvite[i] = INVALID_PLAYER_ID;
        }

        if (PlayerInsideHouse[i] && PlayerInsideHouseOwner[i] == playerid)
        {
            KickPlayerFromHouse(i);
            SendClientMessage(i, COLOR_YELLOW, "Owner rumah keluar dari server. Kamu dikeluarkan dari rumah.");
        }
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

    ResetPlayerBusinessData(playerid);
    ResetPlayerDealerData(playerid);


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
    ApplyLSIFMapIcons(playerid);

    SendClientMessage(playerid, COLOR_CYAN, "Kamu berhasil spawn di Los Santos.");
    SendClientMessage(playerid, COLOR_WHITE, "Closed Beta: gunakan /betaguide untuk alur awal dan /bugreport jika menemukan bug.");
    SendClientMessage(playerid, COLOR_WHITE, "Command cepat: /help, /starterpack, /jobs, /maplegend. Cari marker [ALT] untuk interaksi dunia.");

    return 1;
}


stock ShowAdminDashboardMenu(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    ShowPlayerDialog(
        playerid,
        DIALOG_ADMIN_MENU,
        DIALOG_STYLE_LIST,
        "LSIF Admin Dashboard",
        "Beta Status\nPlayer List\nOnline Admins\nRecent Bugs\nRecent Player Reports\nRecent Feedback\nRecent Admin Logs\nBeta/Whitelist Menu",
        "Select",
        "Close"
    );
    return 1;
}

stock ShowBetaDashboardMenu(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    ShowPlayerDialog(
        playerid,
        DIALOG_BETA_MENU,
        DIALOG_STYLE_LIST,
        "LSIF Beta Dashboard",
        "Beta Status\nWhitelist Active List\nAdd Whitelist\nRemove Whitelist\nCheck Whitelist\nRecent Bugs\nRecent Feedback\nRecent Player Reports",
        "Select",
        "Back"
    );
    return 1;
}

stock ShowBetaStatusDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    new uptimeText[64];
    new dialogText[768];
    new adminCount = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] > 0)
        {
            adminCount++;
        }
    }

    FormatUptime(GetTickCount() - g_ServerStartTick, uptimeText, sizeof(uptimeText));

    format(
        dialogText,
        sizeof(dialogText),
        "Gamemode: LSIF Dev v0.17H Map Markers\n\nUptime: %s\nPlayers Online: %d\nLogged Players: %d\nAdmins Online: %d\n\nClosed Beta: ACTIVE\nWhitelist: ENABLED after first active whitelist user\n\nMenu terkait:\n/adminmenu\n/betamenu",
        uptimeText,
        CountOnlinePlayers(),
        CountLoggedPlayers(),
        adminCount
    );

    ShowPlayerDialog(playerid, DIALOG_BETA_STATUS_DIALOG, DIALOG_STYLE_MSGBOX, "Closed Beta Status", dialogText, "Back", "Close");
    return 1;
}

stock ShowPlayerListDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    new dialogText[2048];
    new line[160];
    new name[MAX_PLAYER_NAME];
    new found = 0;

    format(dialogText, sizeof(dialogText), "ID\tName\tLogin\tAdmin\tDBID\n");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GetPlayerName(i, name, sizeof(name));
            format(line, sizeof(line), "%d\t%s\t%d\t%d\t%d\n", i, name, PlayerLoggedIn[i], PlayerAdmin[i], PlayerDBID[i]);
            strcat(dialogText, line, sizeof(dialogText));
            found++;
        }
    }

    if (!found)
    {
        format(dialogText, sizeof(dialogText), "Tidak ada player online.");
        ShowPlayerDialog(playerid, DIALOG_ADMIN_PLAYERS, DIALOG_STYLE_MSGBOX, "Online Players", dialogText, "Back", "Close");
        return 1;
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_PLAYERS, DIALOG_STYLE_TABLIST_HEADERS, "Online Players", dialogText, "Back", "Close");
    return 1;
}

stock ShowOnlineAdminsDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    new dialogText[1536];
    new line[144];
    new name[MAX_PLAYER_NAME];
    new rankName[32];
    new found = 0;

    format(dialogText, sizeof(dialogText), "ID\tName\tLevel\tRank\n");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] > 0)
        {
            GetPlayerName(i, name, sizeof(name));
            GetAdminRankName(PlayerAdmin[i], rankName, sizeof(rankName));
            format(line, sizeof(line), "%d\t%s\t%d\t%s\n", i, name, PlayerAdmin[i], rankName);
            strcat(dialogText, line, sizeof(dialogText));
            found++;
        }
    }

    if (!found)
    {
        format(dialogText, sizeof(dialogText), "Tidak ada admin online.");
        ShowPlayerDialog(playerid, DIALOG_ADMIN_ADMINS, DIALOG_STYLE_MSGBOX, "Online Admins", dialogText, "Back", "Close");
        return 1;
    }

    ShowPlayerDialog(playerid, DIALOG_ADMIN_ADMINS, DIALOG_STYLE_TABLIST_HEADERS, "Online Admins", dialogText, "Back", "Close");
    return 1;
}

stock ShowWhitelistAddInput(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_OWNER))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menambah whitelist beta.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_BETA_WLADD_INPUT, DIALOG_STYLE_INPUT, "Add Beta Whitelist", "Masukkan username player yang ingin ditambahkan ke whitelist.", "Add", "Back");
    return 1;
}

stock ShowWhitelistRemoveInput(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_OWNER))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menonaktifkan whitelist beta.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_BETA_WLREMOVE_INPUT, DIALOG_STYLE_INPUT, "Remove Beta Whitelist", "Masukkan username whitelist yang ingin dinonaktifkan.", "Remove", "Back");
    return 1;
}

stock ShowWhitelistCheckInput(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    ShowPlayerDialog(playerid, DIALOG_BETA_WLCHECK_INPUT, DIALOG_STYLE_INPUT, "Check Beta Whitelist", "Masukkan username yang ingin dicek.", "Check", "Back");
    return 1;
}

stock OpenRecentBugsDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    mysql_tquery(g_SQL, "SELECT id, reporter_name, message FROM feedback_reports WHERE type='bug' AND status='open' ORDER BY id DESC LIMIT 10", "OnRecentBugsDialogLoaded", "i", playerid);
    return 1;
}

stock OpenRecentFeedbackDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    mysql_tquery(g_SQL, "SELECT id, reporter_name, type, message FROM feedback_reports WHERE status='open' ORDER BY id DESC LIMIT 10", "OnRecentFeedbackDialogLoaded", "i", playerid);
    return 1;
}

stock OpenRecentReportsDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    mysql_tquery(g_SQL, "SELECT id, reporter_name, target_name, reason FROM reports WHERE status='open' ORDER BY id DESC LIMIT 10", "OnRecentReportsDialogLoaded", "i", playerid);
    return 1;
}

stock OpenRecentLogsDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    mysql_tquery(g_SQL, "SELECT id, admin_name, target_name, action, detail FROM admin_logs ORDER BY id DESC LIMIT 10", "OnRecentLogsDialogLoaded", "i", playerid);
    return 1;
}

stock OpenWhitelistListDialog(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_HELPER))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
        return 0;
    }

    mysql_tquery(g_SQL, "SELECT username, added_by, created_at FROM beta_whitelist WHERE active=1 ORDER BY id DESC LIMIT 20", "OnWhitelistDialogLoaded", "i", playerid);
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == DIALOG_BETA_RULES || dialogid == DIALOG_BETA_MOTD || dialogid == DIALOG_FEEDBACK_LIST)
    {
        return 1;
    }


    if (dialogid == DIALOG_ADMIN_MENU)
    {
        if (!response)
        {
            return 1;
        }

        if (listitem == 0)
        {
            ShowBetaStatusDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowPlayerListDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowOnlineAdminsDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            OpenRecentBugsDialog(playerid);
            return 1;
        }

        if (listitem == 4)
        {
            OpenRecentReportsDialog(playerid);
            return 1;
        }

        if (listitem == 5)
        {
            OpenRecentFeedbackDialog(playerid);
            return 1;
        }

        if (listitem == 6)
        {
            OpenRecentLogsDialog(playerid);
            return 1;
        }

        if (listitem == 7)
        {
            ShowBetaDashboardMenu(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_BETA_MENU)
    {
        if (!response)
        {
            ShowAdminDashboardMenu(playerid);
            return 1;
        }

        if (listitem == 0)
        {
            ShowBetaStatusDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            OpenWhitelistListDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowWhitelistAddInput(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ShowWhitelistRemoveInput(playerid);
            return 1;
        }

        if (listitem == 4)
        {
            ShowWhitelistCheckInput(playerid);
            return 1;
        }

        if (listitem == 5)
        {
            OpenRecentBugsDialog(playerid);
            return 1;
        }

        if (listitem == 6)
        {
            OpenRecentFeedbackDialog(playerid);
            return 1;
        }

        if (listitem == 7)
        {
            OpenRecentReportsDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_ADMIN_PLAYERS || dialogid == DIALOG_ADMIN_ADMINS || dialogid == DIALOG_ADMIN_RECENT_BUGS || dialogid == DIALOG_ADMIN_RECENT_REPORTS || dialogid == DIALOG_ADMIN_RECENT_FEEDBACK || dialogid == DIALOG_ADMIN_RECENT_LOGS || dialogid == DIALOG_BETA_STATUS_DIALOG || dialogid == DIALOG_BETA_WHITELIST_LIST || dialogid == DIALOG_BETA_WLCHECK_RESULT)
    {
        if (response)
        {
            ShowAdminDashboardMenu(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_BETA_WLADD_INPUT)
    {
        if (!response)
        {
            ShowBetaDashboardMenu(playerid);
            return 1;
        }

        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menambah whitelist beta.");
            return 1;
        }

        if (strlen(inputtext) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Username minimal 3 karakter.");
            ShowWhitelistAddInput(playerid);
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerName(playerid, adminName, sizeof(adminName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO beta_whitelist (username, added_by, note, active) VALUES ('%e', '%e', 'dialog_add', 1) ON DUPLICATE KEY UPDATE added_by='%e', note='dialog_add', active=1, updated_at=NOW()",
            inputtext,
            adminName,
            adminName
        );

        mysql_tquery(g_SQL, query, "OnWhitelistAdded", "i", playerid);
        return 1;
    }

    if (dialogid == DIALOG_BETA_WLREMOVE_INPUT)
    {
        if (!response)
        {
            ShowBetaDashboardMenu(playerid);
            return 1;
        }

        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menonaktifkan whitelist beta.");
            return 1;
        }

        if (strlen(inputtext) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Username minimal 3 karakter.");
            ShowWhitelistRemoveInput(playerid);
            return 1;
        }

        new query[256];

        format(PlayerLastWhitelistQuery[playerid], 24, "%s", inputtext);
        mysql_format(g_SQL, query, sizeof(query), "UPDATE beta_whitelist SET active=0, updated_at=NOW() WHERE username='%e' LIMIT 1", inputtext);
        mysql_tquery(g_SQL, query, "OnWhitelistRemoved", "i", playerid);
        return 1;
    }

    if (dialogid == DIALOG_BETA_WLCHECK_INPUT)
    {
        if (!response)
        {
            ShowBetaDashboardMenu(playerid);
            return 1;
        }

        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        if (strlen(inputtext) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Username minimal 3 karakter.");
            ShowWhitelistCheckInput(playerid);
            return 1;
        }

        new query[256];

        format(PlayerLastWhitelistQuery[playerid], 24, "%s", inputtext);
        mysql_format(g_SQL, query, sizeof(query), "SELECT username, active, added_by, created_at FROM beta_whitelist WHERE username='%e' LIMIT 1", inputtext);
        mysql_tquery(g_SQL, query, "OnWhitelistCheckDialogLoaded", "i", playerid);
        return 1;
    }

    if (dialogid == DIALOG_ORG_MENU)
    {
        if (!response)
        {
            return 1;
        }

        if (PlayerOrgID[playerid] <= 0)
        {
            if (listitem == 0)
            {
                ShowOrgCreateInputDialog(playerid);
                return 1;
            }

            if (listitem == 1)
            {
                ShowOrgListDialog(playerid);
                return 1;
            }

            return 1;
        }

        if (listitem == 0)
        {
            ShowOrgInfoDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowOrgMembersDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowOrgBankDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ShowOrgDepositDialog(playerid);
            return 1;
        }

        if (listitem == 4)
        {
            ShowOrgWithdrawDialog(playerid);
            return 1;
        }

        if (listitem == 5)
        {
            ShowOrgInviteDialog(playerid);
            return 1;
        }

        if (listitem == 6)
        {
            ShowOrgSetRankDialog(playerid);
            return 1;
        }

        if (listitem == 7)
        {
            ShowOrgKickDialog(playerid);
            return 1;
        }

        if (listitem == 8)
        {
            ShowPlayerDialog(playerid, DIALOG_ORG_LEAVE_CONFIRM, DIALOG_STYLE_MSGBOX, "Leave Organization", "Yakin ingin keluar dari organisasi?", "Leave", "Back");
            return 1;
        }

        if (listitem == 9)
        {
            if (!IsOrgOwner(playerid))
            {
                SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa membubarkan organisasi.");
                return 1;
            }

            ShowPlayerDialog(playerid, DIALOG_ORG_DISBAND_CONFIRM, DIALOG_STYLE_MSGBOX, "Disband Organization", "PERINGATAN: organisasi akan dihapus permanen. Semua member akan keluar. Lanjutkan?", "Disband", "Back");
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_ORG_INFO || dialogid == DIALOG_ORG_BANK || dialogid == DIALOG_ORG_MEMBERS || dialogid == DIALOG_ORG_LIST)
    {
        if (response)
        {
            ShowOrgMenuDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_ORG_CREATE_INPUT)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        if (PlayerOrgID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam organisasi.");
            return 1;
        }

        if (strlen(inputtext) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Nama organisasi minimal 3 karakter.");
            ShowOrgCreateInputDialog(playerid);
            return 1;
        }

        if (PlayerMoney[playerid] < ORG_CREATE_PRICE)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Biaya membuat organisasi: $%d.", ORG_CREATE_PRICE);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        new playerName[MAX_PLAYER_NAME];
        new query[768];

        GetPlayerName(playerid, playerName, sizeof(playerName));
        format(PlayerPendingOrgName[playerid], 64, "%s", inputtext);

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO organizations (name, owner_id, owner_name, bank_money) VALUES ('%e', %d, '%e', 0)",
            inputtext,
            PlayerDBID[playerid],
            playerName
        );

        mysql_tquery(g_SQL, query, "OnOrgCreated", "i", playerid);
        return 1;
    }

    if (dialogid == DIALOG_ORG_DEPOSIT)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        OrgDepositMoney(playerid, inputtext);
        return 1;
    }

    if (dialogid == DIALOG_ORG_WITHDRAW)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        OrgWithdrawMoney(playerid, inputtext);
        return 1;
    }

    if (dialogid == DIALOG_ORG_INVITE)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        if (!IsNumericString(inputtext))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            ShowOrgInviteDialog(playerid);
            return 1;
        }

        OrgInvitePlayer(playerid, strval(inputtext));
        return 1;
    }

    if (dialogid == DIALOG_ORG_SETRANK)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        new targetStr[16];
        new rankStr[16];

        if (!GetTwoParams(inputtext, targetStr, sizeof(targetStr), rankStr, sizeof(rankStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Format: playerid rank. Contoh: 2 3");
            ShowOrgSetRankDialog(playerid);
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(rankStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan rank harus angka.");
            ShowOrgSetRankDialog(playerid);
            return 1;
        }

        OrgSetMemberRank(playerid, strval(targetStr), strval(rankStr));
        return 1;
    }

    if (dialogid == DIALOG_ORG_KICK)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        if (!IsNumericString(inputtext))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            ShowOrgKickDialog(playerid);
            return 1;
        }

        new targetid = strval(inputtext);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (PlayerOrgID[targetid] != PlayerOrgID[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target bukan anggota organisasi kamu.");
            return 1;
        }

        PlayerSelectedOrgTarget[playerid] = targetid;

        new targetName[MAX_PLAYER_NAME];
        new dialogText[256];
        GetPlayerName(targetid, targetName, sizeof(targetName));

        format(dialogText, sizeof(dialogText), "Yakin ingin mengeluarkan %s [%d] dari organisasi?", targetName, targetid);
        ShowPlayerDialog(playerid, DIALOG_ORG_KICK_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Kick Member", dialogText, "Kick", "Back");
        return 1;
    }

    if (dialogid == DIALOG_ORG_KICK_CONFIRM)
    {
        if (!response)
        {
            PlayerSelectedOrgTarget[playerid] = INVALID_PLAYER_ID;
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        new targetid = PlayerSelectedOrgTarget[playerid];
        PlayerSelectedOrgTarget[playerid] = INVALID_PLAYER_ID;
        OrgKickMember(playerid, targetid);
        return 1;
    }

    if (dialogid == DIALOG_ORG_LEAVE_CONFIRM)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        OrgLeave(playerid);
        return 1;
    }

    if (dialogid == DIALOG_ORG_DISBAND_CONFIRM)
    {
        if (!response)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        OrgDisband(playerid);
        return 1;
    }

    if (dialogid == DIALOG_ATM_MENU)
    {
        if (!response)
        {
            return 1;
        }

        if (!IsPlayerNearBankPoint(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat ATM/bank.");
            return 1;
        }

        if (listitem == 0)
        {
            ShowATMBalanceDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowATMDepositDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowATMWithdrawDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_ATM_BALANCE)
    {
        if (response)
        {
            ShowATMDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_ATM_DEPOSIT)
    {
        if (!response)
        {
            ShowATMDialog(playerid);
            return 1;
        }

        ProcessATMDeposit(playerid, inputtext);
        return 1;
    }

    if (dialogid == DIALOG_ATM_WITHDRAW)
    {
        if (!response)
        {
            ShowATMDialog(playerid);
            return 1;
        }

        ProcessATMWithdraw(playerid, inputtext);
        return 1;
    }



    if (dialogid == DIALOG_DEALER_MAIN)
    {
        if (!response)
        {
            return 1;
        }

        if (!IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat dealership.");
            return 1;
        }

        if (listitem == 0)
        {
            ShowDealershipDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowGarageRepairConfirmDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ShowGarageRefuelConfirmDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_GARAGE_MENU)
    {
        if (!response)
        {
            ShowDealershipMainDialog(playerid);
            return 1;
        }

        if (listitem == 0)
        {
            ShowGarageStatusDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowGarageSpawnDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowGarageRenameSlotDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ShowGarageRepairConfirmDialog(playerid);
            return 1;
        }

        if (listitem == 4)
        {
            ShowGarageRefuelConfirmDialog(playerid);
            return 1;
        }

        if (listitem == 5)
        {
            ShowGarageSellSlotDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_GARAGE_STATUS)
    {
        if (response)
        {
            ShowGarageMenuDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_SPAWN)
    {
        if (!response)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        ProcessDialogGarageSpawn(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_RENAME_SLOT)
    {
        if (!response)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        if (!IsValidGarageSlot(listitem) || PlayerGarageDBID[playerid][listitem] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
            ShowGarageRenameSlotDialog(playerid);
            return 1;
        }

        ShowGarageRenameInputDialog(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_RENAME_INPUT)
    {
        if (!response)
        {
            ShowGarageRenameSlotDialog(playerid);
            return 1;
        }

        ProcessDialogGarageRename(playerid, PlayerDialogGarageSlot[playerid], inputtext);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_SELL_SLOT)
    {
        if (!response)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        if (!IsValidGarageSlot(listitem) || PlayerGarageDBID[playerid][listitem] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
            ShowGarageSellSlotDialog(playerid);
            return 1;
        }

        ShowGarageSellConfirmDialog(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_SELL_CONFIRM)
    {
        if (!response)
        {
            ShowGarageSellSlotDialog(playerid);
            return 1;
        }

        ProcessDialogGarageSell(playerid, PlayerDialogGarageSlot[playerid]);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_REPAIR_CONFIRM)
    {
        if (!response)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        ProcessDialogVehicleRepair(playerid);
        return 1;
    }

    if (dialogid == DIALOG_GARAGE_REFUEL_CONFIRM)
    {
        if (!response)
        {
            ShowGarageMenuDialog(playerid);
            return 1;
        }

        ProcessDialogVehicleRefuel(playerid);
        return 1;
    }

    if (dialogid == DIALOG_DEALER_MENU)
    {
        if (!response)
        {
            return 1;
        }

        if (!IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat dealership.");
            return 1;
        }

        if (!IsValidShopVehicleIndex(listitem))
        {
            SendClientMessage(playerid, COLOR_RED, "Pilihan kendaraan tidak valid.");
            return 1;
        }

        ShowDealershipConfirmDialog(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_DEALER_CONFIRM)
    {
        new shopIndex = PlayerDialogDealerVehicle[playerid];

        if (!response)
        {
            ShowDealershipDialog(playerid);
            return 1;
        }

        ProcessDialogVehiclePurchase(playerid, shopIndex);
        return 1;
    }

    if (dialogid == DIALOG_HOUSE_MENU)
    {
        if (!response)
        {
            return 1;
        }

        new houseIndex = PlayerDialogHouseIndex[playerid];

        if (!IsValidHouseIndex(houseIndex) || !IsPlayerNearHouse(playerid, houseIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat rumah.");
            return 1;
        }

        if (listitem == 0)
        {
            ShowHouseInfoDialog(playerid, houseIndex);
            return 1;
        }

        if (listitem == 1)
        {
            ShowHouseBuyConfirmDialog(playerid, houseIndex);
            return 1;
        }

        if (listitem == 2)
        {
            if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
            {
                SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
                return 1;
            }
            ShowHouseInfoDialog(playerid, PlayerHouseIndex[playerid]);
            return 1;
        }

        if (listitem == 3)
        {
            if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
            {
                SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
                return 1;
            }

            if (!PlayerInsideHouse[playerid] && !IsPlayerNearHouse(playerid, PlayerHouseIndex[playerid]))
            {
                SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumahmu untuk lock/unlock.");
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

        if (listitem == 4)
        {
            ShowHouseSellConfirmDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_HOUSE_INFO)
    {
        if (response)
        {
            new houseIndex = PlayerDialogHouseIndex[playerid];
            if (IsValidHouseIndex(houseIndex) && IsPlayerNearHouse(playerid, houseIndex))
            {
                ShowHouseInteractionDialog(playerid, houseIndex);
            }
        }
        return 1;
    }

    if (dialogid == DIALOG_HOUSE_BUY_CONFIRM)
    {
        new houseIndex = PlayerDialogHouseIndex[playerid];

        if (!response)
        {
            if (IsValidHouseIndex(houseIndex) && IsPlayerNearHouse(playerid, houseIndex))
            {
                ShowHouseInteractionDialog(playerid, houseIndex);
            }
            return 1;
        }

        ProcessDialogHouseBuy(playerid, houseIndex);
        return 1;
    }

    if (dialogid == DIALOG_HOUSE_SELL_CONFIRM)
    {
        if (!response)
        {
            new houseIndex = PlayerDialogHouseIndex[playerid];
            if (IsValidHouseIndex(houseIndex) && IsPlayerNearHouse(playerid, houseIndex))
            {
                ShowHouseInteractionDialog(playerid, houseIndex);
            }
            return 1;
        }

        ProcessDialogHouseSell(playerid);
        return 1;
    }

    if (dialogid == DIALOG_BUSINESS_MENU)
    {
        if (!response)
        {
            return 1;
        }

        new businessIndex = PlayerDialogBusinessIndex[playerid];

        if (!IsValidBusinessIndex(businessIndex) || !IsPlayerNearBusiness(playerid, businessIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat business.");
            return 1;
        }

        if (listitem == 0)
        {
            ShowBusinessInfoDialog(playerid, businessIndex);
            return 1;
        }

        if (listitem == 1)
        {
            ShowBusinessBuyConfirmDialog(playerid, businessIndex);
            return 1;
        }

        if (listitem == 2)
        {
            ShowMyBusinessDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ProcessDialogBusinessCollect(playerid);
            return 1;
        }

        if (listitem == 4)
        {
            ShowBusinessUpgradeConfirmDialog(playerid);
            return 1;
        }

        if (listitem == 5)
        {
            ShowBusinessSellConfirmDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_BUSINESS_INFO)
    {
        if (response)
        {
            new businessIndex = PlayerDialogBusinessIndex[playerid];
            if (IsValidBusinessIndex(businessIndex) && IsPlayerNearBusiness(playerid, businessIndex))
            {
                ShowBusinessInteractionDialog(playerid, businessIndex);
            }
        }
        return 1;
    }

    if (dialogid == DIALOG_BUSINESS_BUY_CONFIRM)
    {
        new businessIndex = PlayerDialogBusinessIndex[playerid];

        if (!response)
        {
            if (IsValidBusinessIndex(businessIndex) && IsPlayerNearBusiness(playerid, businessIndex))
            {
                ShowBusinessInteractionDialog(playerid, businessIndex);
            }
            return 1;
        }

        ProcessDialogBusinessBuy(playerid, businessIndex);
        return 1;
    }

    if (dialogid == DIALOG_BUSINESS_UPGRADE_CONFIRM)
    {
        if (!response)
        {
            new businessIndex = PlayerDialogBusinessIndex[playerid];
            if (IsValidBusinessIndex(businessIndex) && IsPlayerNearBusiness(playerid, businessIndex))
            {
                ShowBusinessInteractionDialog(playerid, businessIndex);
            }
            return 1;
        }

        ProcessDialogBusinessUpgrade(playerid);
        return 1;
    }

    if (dialogid == DIALOG_BUSINESS_SELL_CONFIRM)
    {
        if (!response)
        {
            new businessIndex = PlayerDialogBusinessIndex[playerid];
            if (IsValidBusinessIndex(businessIndex) && IsPlayerNearBusiness(playerid, businessIndex))
            {
                ShowBusinessInteractionDialog(playerid, businessIndex);
            }
            return 1;
        }

        ProcessDialogBusinessSell(playerid);
        return 1;
    }

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
            "INSERT INTO players (username, password_hash, money, bank_money, xp, level, admin_level, current_job, starter_pack_claimed, pos_x, pos_y, pos_z, pos_a, last_ip, last_login) VALUES ('%e', SHA2('%e', 256), 500, 0, 0, 1, 0, 0, 0, %f, %f, %f, %f, '%e', NOW())",
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
            "SELECT id, money, bank_money, xp, level, admin_level, skin, current_job, spawn_house, starter_pack_claimed, pos_x, pos_y, pos_z, pos_a FROM players WHERE username='%e' AND password_hash=SHA2('%e', 256) LIMIT 1",
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
    PlayerStarterPackClaimed[playerid] = 0;
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
    SendBetaLoginMessages(playerid, 1);
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
    cache_get_value_name_int(0, "starter_pack_claimed", PlayerStarterPackClaimed[playerid]);

    cache_get_value_name_float(0, "pos_x", PlayerLastX[playerid]);
    cache_get_value_name_float(0, "pos_y", PlayerLastY[playerid]);
    cache_get_value_name_float(0, "pos_z", PlayerLastZ[playerid]);
    cache_get_value_name_float(0, "pos_a", PlayerLastA[playerid]);

    PlayerLoggedIn[playerid] = 1;

    ApplyLoadedPlayerData(playerid);
    LoadPlayerGarage(playerid);
    LoadPlayerHouse(playerid);
    LoadPlayerOrganization(playerid);
    LoadPlayerBusiness(playerid);

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

    SendBetaLoginMessages(playerid, 0);

    return 1;
}


stock GetNearestBusiness(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(playerid, BusinessX[i], BusinessY[i], BusinessZ[i]);

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock HandleVehicleMissionKey(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Kamu sudah sedang menjalankan pekerjaan. Gunakan /cancelwork jika ingin membatalkan.");
        return 1;
    }

    if (!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Tombol 2 digunakan untuk mulai vehicle mission saat kamu menjadi driver kendaraan job.");
        SendClientMessage(playerid, COLOR_WHITE, "Contoh: Taxi/Cabbie, delivery van, atau truck.");
        return 1;
    }

    if (IsPlayerInTaxiVehicle(playerid))
    {
        if (PlayerJob[playerid] != JOB_TAXI)
        {
            PlayerJob[playerid] = JOB_TAXI;
            SavePlayerData(playerid);
            SendClientMessage(playerid, COLOR_CYAN, "Vehicle mission: kamu otomatis aktif sebagai Taxi Driver.");
        }

        StartTaxiWork(playerid);
        return 1;
    }

    if (IsPlayerInCourierVehicle(playerid))
    {
        if (PlayerJob[playerid] != JOB_COURIER)
        {
            PlayerJob[playerid] = JOB_COURIER;
            SavePlayerData(playerid);
            SendClientMessage(playerid, COLOR_CYAN, "Vehicle mission: kamu otomatis aktif sebagai Courier.");
        }

        StartCourierWork(playerid);
        return 1;
    }

    if (IsPlayerInTruckerVehicle(playerid))
    {
        if (PlayerJob[playerid] != JOB_TRUCKER)
        {
            PlayerJob[playerid] = JOB_TRUCKER;
            SavePlayerData(playerid);
            SendClientMessage(playerid, COLOR_CYAN, "Vehicle mission: kamu otomatis aktif sebagai Trucker.");
        }

        StartTruckerWork(playerid);
        return 1;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new modelid = GetVehicleModel(vehicleid);
    new msg[144];

    format(msg, sizeof(msg), "Model kendaraan %d belum punya vehicle mission. Tombol 2 khusus start job/mission kendaraan.", modelid);
    SendClientMessage(playerid, COLOR_YELLOW, msg);
    return 1;
}


stock InitWorldMarkerArrays()
{
    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        BankPointPickup[i] = -1;
        BankPointLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        DealershipPickup[i] = -1;
        DealershipLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        BusinessPickup[i] = -1;
        BusinessLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        HouseExteriorLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    RaceStartPickup = -1;
    RaceStartLabel = Text3D:INVALID_3DTEXT_ID;
    return 1;
}

stock CreateWorldInteractionMarkers()
{
    InitWorldMarkerArrays();

    new labelText[144];

    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        BankPointPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, BankPointX[i], BankPointY[i], BankPointZ[i], 0);

        format(labelText, sizeof(labelText), "[ALT] ATM\n%s\nBalance / Deposit / Withdraw", BankPointName[i]);
        BankPointLabel[i] = Create3DTextLabel(labelText, COLOR_CYAN, BankPointX[i], BankPointY[i], BankPointZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        DealershipPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, DealershipX[i], DealershipY[i], DealershipZ[i], 0);

        format(labelText, sizeof(labelText), "[ALT] Dealership\n%s\nVehicle Shop / Garage Service", DealershipName[i]);
        DealershipLabel[i] = Create3DTextLabel(labelText, COLOR_GREEN, DealershipX[i], DealershipY[i], DealershipZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        BusinessPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, BusinessX[i], BusinessY[i], BusinessZ[i], 0);

        format(labelText, sizeof(labelText), "[ALT] Business\n%s\nBuy / Manage / Collect", BusinessName[i]);
        BusinessLabel[i] = Create3DTextLabel(labelText, COLOR_YELLOW, BusinessX[i], BusinessY[i], BusinessZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        format(labelText, sizeof(labelText), "[ALT] House Menu\n%s\nPanah = Enter/Exit", HouseName[i]);
        HouseExteriorLabel[i] = Create3DTextLabel(labelText, COLOR_WHITE, HouseX[i], HouseY[i], HouseZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    RaceStartPickup = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, RaceLSX[0], RaceLSY[0], RaceLSZ[0], 0);
    RaceStartLabel = Create3DTextLabel("[RACE] LS Intro\nGunakan /joinrace ls\nTombol 2 hanya untuk vehicle mission/job", COLOR_ORANGE, RaceLSX[0], RaceLSY[0], RaceLSZ[0] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);

    print("[LSIF] World interaction markers and 3D labels created.");
    return 1;
}

stock DestroyWorldInteractionMarkers()
{
    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        if (BankPointPickup[i] != -1)
        {
            DestroyPickup(BankPointPickup[i]);
            BankPointPickup[i] = -1;
        }

        if (BankPointLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(BankPointLabel[i]);
            BankPointLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        if (DealershipPickup[i] != -1)
        {
            DestroyPickup(DealershipPickup[i]);
            DealershipPickup[i] = -1;
        }

        if (DealershipLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(DealershipLabel[i]);
            DealershipLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        if (BusinessPickup[i] != -1)
        {
            DestroyPickup(BusinessPickup[i]);
            BusinessPickup[i] = -1;
        }

        if (BusinessLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(BusinessLabel[i]);
            BusinessLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        if (HouseExteriorLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(HouseExteriorLabel[i]);
            HouseExteriorLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    if (RaceStartPickup != -1)
    {
        DestroyPickup(RaceStartPickup);
        RaceStartPickup = -1;
    }

    if (RaceStartLabel != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(RaceStartLabel);
        RaceStartLabel = Text3D:INVALID_3DTEXT_ID;
    }

    return 1;
}

stock ApplyLSIFMapIcons(playerid)
{
    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_ATM + i, BankPointX[i], BankPointY[i], BankPointZ[i], MAPICON_TYPE_ATM, COLOR_CYAN, MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_HOUSE + i, HouseX[i], HouseY[i], HouseZ[i], MAPICON_TYPE_HOUSE, COLOR_WHITE, MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_BUSINESS + i, BusinessX[i], BusinessY[i], BusinessZ[i], MAPICON_TYPE_BUSINESS, COLOR_YELLOW, MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_DEALER + i, DealershipX[i], DealershipY[i], DealershipZ[i], MAPICON_TYPE_DEALER, COLOR_GREEN, MAPICON_LOCAL);
    }

    SetPlayerMapIcon(playerid, MAPICON_BASE_RACE, RaceLSX[0], RaceLSY[0], RaceLSZ[0], MAPICON_TYPE_RACE, COLOR_ORANGE, MAPICON_LOCAL);
    return 1;
}

stock RemoveLSIFMapIcons(playerid)
{
    for (new i = 0; i < MAX_BANK_POINTS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_ATM + i);
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_HOUSE + i);
    }

    for (new i = 0; i < MAX_BUSINESSES; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_BUSINESS + i);
    }

    for (new i = 0; i < MAX_DEALERSHIPS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_DEALER + i);
    }

    RemovePlayerMapIcon(playerid, MAPICON_BASE_RACE);
    return 1;
}

stock ShowMapLegendDialog(playerid)
{
    new dialogText[768];

    format(
        dialogText,
        sizeof(dialogText),
        "Radar/Map Icon LSIF:\n\nATM/Bank - transaksi bank, pakai ALT di marker ATM.\nHouse - rumah/interior; ALT untuk menu, panah untuk masuk/keluar.\nBusiness - beli/manage/collect business dengan ALT.\nDealership - vehicle shop dan garage service dengan ALT.\nRace - lokasi race/time trial.\n\nDi dunia, cari 3D label seperti [ALT] ATM atau [ALT] Dealership. Berdiri dekat marker lalu tekan ALT.\nTombol 2 hanya untuk start vehicle mission/job."
    );

    ShowPlayerDialog(playerid, DIALOG_BETA_MOTD, DIALOG_STYLE_MSGBOX, "LSIF Map Legend", dialogText, "OK", "Tutup");
    return 1;
}

stock ShowInteractionNoPoint(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "Tidak ada interaksi dekatmu.");
    SendClientMessage(playerid, COLOR_WHITE, "ALT dipakai di marker [ALT]: ATM, dealership, house, dan business.");
    SendClientMessage(playerid, COLOR_WHITE, "Tombol 2 khusus untuk start job/vehicle mission.");
    return 1;
}


stock ShowATMDialog(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank untuk memakai menu ATM.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /findbank untuk mencari ATM terdekat.");
        return 0;
    }

    new dialogText[256];

    format(
        dialogText,
        sizeof(dialogText),
        "Balance - Lihat saldo\nDeposit - Simpan cash ke bank\nWithdraw - Ambil uang dari bank\nCancel"
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_ATM_MENU,
        DIALOG_STYLE_LIST,
        "LSIF ATM",
        dialogText,
        "Pilih",
        "Tutup"
    );

    return 1;
}

stock ShowATMBalanceDialog(playerid)
{
    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank.");
        return 0;
    }

    new dialogText[256];

    format(
        dialogText,
        sizeof(dialogText),
        "Cash: $%d\nBank: $%d\nTotal: $%d\n\nGunakan menu Deposit atau Withdraw untuk transaksi.",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid],
        PlayerMoney[playerid] + PlayerBankMoney[playerid]
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_ATM_BALANCE,
        DIALOG_STYLE_MSGBOX,
        "ATM Balance",
        dialogText,
        "Kembali",
        "Tutup"
    );

    return 1;
}

stock ShowATMDepositDialog(playerid)
{
    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank.");
        return 0;
    }

    new dialogText[256];

    format(
        dialogText,
        sizeof(dialogText),
        "Cash kamu: $%d\nBank kamu: $%d\n\nMasukkan jumlah deposit.\nKetik all untuk menyimpan semua cash.",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid]
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_ATM_DEPOSIT,
        DIALOG_STYLE_INPUT,
        "ATM Deposit",
        dialogText,
        "Deposit",
        "Kembali"
    );

    return 1;
}

stock ShowATMWithdrawDialog(playerid)
{
    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank.");
        return 0;
    }

    new dialogText[256];

    format(
        dialogText,
        sizeof(dialogText),
        "Cash kamu: $%d\nBank kamu: $%d\n\nMasukkan jumlah withdraw.\nKetik all untuk mengambil semua saldo bank.",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid]
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_ATM_WITHDRAW,
        DIALOG_STYLE_INPUT,
        "ATM Withdraw",
        dialogText,
        "Withdraw",
        "Kembali"
    );

    return 1;
}

stock ProcessATMDeposit(playerid, const amountText[])
{
    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank untuk deposit.");
        return 0;
    }

    new amount;

    if (!strcmp(amountText, "all", true))
    {
        amount = PlayerMoney[playerid];
    }
    else
    {
        if (!IsNumericString(amountText))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah harus angka atau all.");
            ShowATMDepositDialog(playerid);
            return 0;
        }

        amount = strval(amountText);
    }

    if (!IsValidBankAmount(amount))
    {
        SendClientMessage(playerid, COLOR_RED, "Jumlah deposit tidak valid.");
        ShowATMDepositDialog(playerid);
        return 0;
    }

    if (PlayerMoney[playerid] < amount)
    {
        SendClientMessage(playerid, COLOR_RED, "Cash kamu tidak cukup.");
        ShowATMDepositDialog(playerid);
        return 0;
    }

    TakePlayerCash(playerid, amount);
    GivePlayerBankMoney(playerid, amount);
    SavePlayerData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Deposit berhasil: $%d masuk ke bank.", amount);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    ShowATMBalanceDialog(playerid);
    return 1;
}

stock ProcessATMWithdraw(playerid, const amountText[])
{
    if (!IsPlayerNearBankPoint(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat ATM/bank untuk withdraw.");
        return 0;
    }

    new amount;

    if (!strcmp(amountText, "all", true))
    {
        amount = PlayerBankMoney[playerid];
    }
    else
    {
        if (!IsNumericString(amountText))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah harus angka atau all.");
            ShowATMWithdrawDialog(playerid);
            return 0;
        }

        amount = strval(amountText);
    }

    if (!IsValidBankAmount(amount))
    {
        SendClientMessage(playerid, COLOR_RED, "Jumlah withdraw tidak valid.");
        ShowATMWithdrawDialog(playerid);
        return 0;
    }

    if (PlayerBankMoney[playerid] < amount)
    {
        SendClientMessage(playerid, COLOR_RED, "Saldo bank kamu tidak cukup.");
        ShowATMWithdrawDialog(playerid);
        return 0;
    }

    TakePlayerBankMoney(playerid, amount);
    GivePlayerCash(playerid, amount);
    SavePlayerData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Withdraw berhasil: $%d keluar dari bank.", amount);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    ShowATMBalanceDialog(playerid);
    return 1;
}


stock ShowDealershipMainDialog(playerid)
{
    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer untuk mencari dealership terdekat.");
        return 0;
    }

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "Vehicle Shop\nGarage Service\nRepair Active Vehicle\nRefuel Active Vehicle\nCancel"
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_DEALER_MAIN,
        DIALOG_STYLE_LIST,
        "Dealership Interaction",
        dialogText,
        "Pilih",
        "Tutup"
    );
    return 1;
}

stock ShowGarageMenuDialog(playerid)
{
    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Garage service hanya tersedia dekat dealership.");
        return 0;
    }

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "View Garage Status\nSpawn Vehicle\nRename Vehicle\nRepair Active Vehicle\nRefuel Active Vehicle\nSell Vehicle\nCancel"
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_MENU,
        DIALOG_STYLE_LIST,
        "Garage Service",
        dialogText,
        "Pilih",
        "Back"
    );
    return 1;
}

stock BuildGarageSlotList(playerid, output[], size)
{
    output[0] = EOS;

    for (new i = 0; i < MAX_GARAGE_SLOTS; i++)
    {
        new row[144];

        if (PlayerGarageDBID[playerid][i] > 0)
        {
            format(
                row,
                sizeof(row),
                "Slot %d: %s | Model %d | Fuel %d | HP %.0f\n",
                i + 1,
                PlayerGarageName[playerid][i],
                PlayerGarageModel[playerid][i],
                PlayerGarageFuel[playerid][i],
                PlayerGarageHealth[playerid][i]
            );
        }
        else
        {
            format(row, sizeof(row), "Slot %d: Empty\n", i + 1);
        }

        strcat(output, row, size);
    }

    return 1;
}

stock ShowGarageStatusDialog(playerid)
{
    new dialogText[1024];
    new header[128];

    format(
        header,
        sizeof(header),
        "Garage: %d/%d vehicles\nActive Slot: %d\n\n",
        CountPlayerGarageVehicles(playerid),
        MAX_GARAGE_SLOTS,
        OwnedVehicleSlot[playerid] == -1 ? 0 : OwnedVehicleSlot[playerid] + 1
    );

    format(dialogText, sizeof(dialogText), "%s", header);

    new slots[768];
    BuildGarageSlotList(playerid, slots, sizeof(slots));
    strcat(dialogText, slots, sizeof(dialogText));

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_STATUS,
        DIALOG_STYLE_MSGBOX,
        "Garage Status",
        dialogText,
        "Back",
        "Tutup"
    );
    return 1;
}

stock ShowGarageSpawnDialog(playerid)
{
    new dialogText[1024];
    BuildGarageSlotList(playerid, dialogText, sizeof(dialogText));

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_SPAWN,
        DIALOG_STYLE_LIST,
        "Spawn Vehicle",
        dialogText,
        "Spawn",
        "Back"
    );
    return 1;
}

stock ShowGarageRenameSlotDialog(playerid)
{
    new dialogText[1024];
    BuildGarageSlotList(playerid, dialogText, sizeof(dialogText));

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_RENAME_SLOT,
        DIALOG_STYLE_LIST,
        "Rename Vehicle",
        dialogText,
        "Pilih",
        "Back"
    );
    return 1;
}

stock ShowGarageRenameInputDialog(playerid, slotIndex)
{
    if (!IsValidGarageSlot(slotIndex) || PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
        return 0;
    }

    PlayerDialogGarageSlot[playerid] = slotIndex;

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "Slot %d: %s\n\nMasukkan nama baru kendaraan.\nMinimal 3 karakter, maksimal 31 karakter.",
        slotIndex + 1,
        PlayerGarageName[playerid][slotIndex]
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_RENAME_INPUT,
        DIALOG_STYLE_INPUT,
        "Rename Vehicle",
        dialogText,
        "Save",
        "Back"
    );
    return 1;
}

stock ShowGarageSellSlotDialog(playerid)
{
    new dialogText[1024];
    BuildGarageSlotList(playerid, dialogText, sizeof(dialogText));

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_SELL_SLOT,
        DIALOG_STYLE_LIST,
        "Sell Vehicle",
        dialogText,
        "Pilih",
        "Back"
    );
    return 1;
}

stock ShowGarageSellConfirmDialog(playerid, slotIndex)
{
    if (!IsValidGarageSlot(slotIndex) || PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
        return 0;
    }

    PlayerDialogGarageSlot[playerid] = slotIndex;

    new modelid = PlayerGarageModel[playerid][slotIndex];
    new basePrice = GetVehicleBasePrice(modelid);
    new sellPrice = basePrice / 2;
    new dialogText[384];

    format(
        dialogText,
        sizeof(dialogText),
        "Slot %d: %s\nModel: %d\nSell price: $%d\n\nJual kendaraan ini?",
        slotIndex + 1,
        PlayerGarageName[playerid][slotIndex],
        modelid,
        sellPrice
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_SELL_CONFIRM,
        DIALOG_STYLE_MSGBOX,
        "Confirm Sell Vehicle",
        dialogText,
        "Sell",
        "Back"
    );
    return 1;
}

stock ShowGarageRepairConfirmDialog(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID || OwnedVehicleSlot[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif yang sedang spawn.");
        return 0;
    }

    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk repair kendaraan.");
        return 0;
    }

    new Float:health = OwnedVehicleHealth[playerid];
    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        GetVehicleHealth(OwnedVehicleID[playerid], health);
    }

    new dialogText[384];
    format(
        dialogText,
        sizeof(dialogText),
        "Vehicle: %s\nSlot: %d\nHealth: %.1f/1000\nRepair Cost: $%d\n\nRepair kendaraan aktif?",
        OwnedVehicleName[playerid],
        OwnedVehicleSlot[playerid] + 1,
        health,
        VEHICLE_REPAIR_COST
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_REPAIR_CONFIRM,
        DIALOG_STYLE_MSGBOX,
        "Repair Vehicle",
        dialogText,
        "Repair",
        "Back"
    );
    return 1;
}

stock ShowGarageRefuelConfirmDialog(playerid)
{
    if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif.");
        return 0;
    }

    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk refuel kendaraan.");
        return 0;
    }

    new needFuel = VEHICLE_MAX_FUEL - OwnedVehicleFuel[playerid];
    if (needFuel < 0)
    {
        needFuel = 0;
    }

    new cost = needFuel * VEHICLE_REFUEL_COST_PER_POINT;
    new dialogText[384];

    format(
        dialogText,
        sizeof(dialogText),
        "Vehicle: %s\nSlot: %d\nFuel: %d/%d\nNeed Fuel: %d\nCost: $%d\n\nRefuel kendaraan aktif sampai penuh?",
        OwnedVehicleName[playerid],
        OwnedVehicleSlot[playerid] + 1,
        OwnedVehicleFuel[playerid],
        VEHICLE_MAX_FUEL,
        needFuel,
        cost
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_GARAGE_REFUEL_CONFIRM,
        DIALOG_STYLE_MSGBOX,
        "Refuel Vehicle",
        dialogText,
        "Refuel",
        "Back"
    );
    return 1;
}

stock ProcessDialogGarageSpawn(playerid, slotIndex)
{
    if (!IsValidGarageSlot(slotIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Slot tidak valid.");
        return 0;
    }

    if (PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong.");
        ShowGarageSpawnDialog(playerid);
        return 0;
    }

    SetActiveVehicleFromGarage(playerid, slotIndex);
    SpawnOwnedVehicle(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan slot %d sekarang aktif.", slotIndex + 1);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    return 1;
}

stock ProcessDialogGarageRename(playerid, slotIndex, const newName[])
{
    if (!IsValidGarageSlot(slotIndex) || PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
        return 0;
    }

    if (strlen(newName) < 3)
    {
        SendClientMessage(playerid, COLOR_RED, "Nama kendaraan minimal 3 karakter.");
        ShowGarageRenameInputDialog(playerid, slotIndex);
        return 0;
    }

    format(PlayerGarageName[playerid][slotIndex], 32, "%s", newName);

    if (OwnedVehicleSlot[playerid] == slotIndex)
    {
        format(OwnedVehicleName[playerid], 32, "%s", newName);

        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            CreateOwnedVehicleLabel(playerid);
        }
    }

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_vehicles SET vehicle_name='%e' WHERE id=%d AND owner_id=%d LIMIT 1",
        newName,
        PlayerGarageDBID[playerid][slotIndex],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan slot %d berhasil diberi nama: %s.", slotIndex + 1, newName);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    ShowGarageMenuDialog(playerid);
    return 1;
}

stock ProcessDialogGarageSell(playerid, slotIndex)
{
    if (!IsValidGarageSlot(slotIndex) || PlayerGarageDBID[playerid][slotIndex] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong/tidak valid.");
        return 0;
    }

    new modelid = PlayerGarageModel[playerid][slotIndex];
    new basePrice = GetVehicleBasePrice(modelid);
    new sellPrice = basePrice / 2;
    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM player_vehicles WHERE id=%d AND owner_id=%d LIMIT 1",
        PlayerGarageDBID[playerid][slotIndex],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnGarageVehicleSold", "iii", playerid, slotIndex, sellPrice);
    return 1;
}

stock ProcessDialogVehicleRepair(playerid)
{
    if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID || OwnedVehicleSlot[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif yang sedang spawn.");
        return 0;
    }

    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk repair kendaraan.");
        return 0;
    }

    if (PlayerMoney[playerid] < VEHICLE_REPAIR_COST)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Biaya repair: $%d.", VEHICLE_REPAIR_COST);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
    }

    TakePlayerCash(playerid, VEHICLE_REPAIR_COST);

    SetVehicleHealth(OwnedVehicleID[playerid], 1000.0);
    OwnedVehicleHealth[playerid] = 1000.0;

    if (IsValidGarageSlot(OwnedVehicleSlot[playerid]))
    {
        PlayerGarageHealth[playerid][OwnedVehicleSlot[playerid]] = 1000.0;
    }

    SaveActiveVehicleMeta(playerid);
    SavePlayerData(playerid);

    SendClientMessage(playerid, COLOR_GREEN, "Kendaraan berhasil diperbaiki.");
    ShowGarageMenuDialog(playerid);
    return 1;
}

stock ProcessDialogVehicleRefuel(playerid)
{
    if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif.");
        return 0;
    }

    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk refuel kendaraan.");
        return 0;
    }

    if (OwnedVehicleFuel[playerid] >= VEHICLE_MAX_FUEL)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Fuel kendaraan sudah penuh.");
        ShowGarageMenuDialog(playerid);
        return 0;
    }

    new needFuel = VEHICLE_MAX_FUEL - OwnedVehicleFuel[playerid];
    new cost = needFuel * VEHICLE_REFUEL_COST_PER_POINT;

    if (PlayerMoney[playerid] < cost)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Biaya full refuel: $%d.", cost);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
    }

    TakePlayerCash(playerid, cost);

    OwnedVehicleFuel[playerid] = VEHICLE_MAX_FUEL;

    if (IsValidGarageSlot(OwnedVehicleSlot[playerid]))
    {
        PlayerGarageFuel[playerid][OwnedVehicleSlot[playerid]] = VEHICLE_MAX_FUEL;
    }

    if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
    {
        ApplyOwnedVehicleParams(playerid);
    }

    SaveActiveVehicleMeta(playerid);
    SavePlayerData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Refuel berhasil. Biaya: $%d. Fuel sekarang: %d/%d.", cost, OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    ShowGarageMenuDialog(playerid);
    return 1;
}


stock ShowDealershipDialog(playerid)
{
    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer untuk mencari dealership terdekat.");
        return 0;
    }

    new dialogText[1024];
    dialogText[0] = EOS;

    for (new i = 0; i < MAX_SHOP_VEHICLES; i++)
    {
        new row[96];
        format(row, sizeof(row), "%d. %s - $%d\n", i + 1, ShopVehicleName[i], ShopVehiclePrice[i]);
        strcat(dialogText, row, sizeof(dialogText));
    }

    ShowPlayerDialog(
        playerid,
        DIALOG_DEALER_MENU,
        DIALOG_STYLE_LIST,
        "LSIF Dealership",
        dialogText,
        "Detail",
        "Tutup"
    );

    return 1;
}

stock ShowDealershipConfirmDialog(playerid, shopIndex)
{
    if (!IsValidShopVehicleIndex(shopIndex))
    {
        return 0;
    }

    PlayerDialogDealerVehicle[playerid] = shopIndex;

    new dialogText[512];
    format(
        dialogText,
        sizeof(dialogText),
        "Vehicle: %s\nModel ID: %d\nPrice: $%d\n\nKendaraan akan masuk ke slot garage kosong pertama.\nLanjutkan pembelian?",
        ShopVehicleName[shopIndex],
        ShopVehicleModel[shopIndex],
        ShopVehiclePrice[shopIndex]
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_DEALER_CONFIRM,
        DIALOG_STYLE_MSGBOX,
        "Confirm Vehicle Purchase",
        dialogText,
        "Buy",
        "Back"
    );
    return 1;
}

stock ProcessDialogVehiclePurchase(playerid, shopIndex)
{
    if (!IsPlayerNearDealership(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk membeli kendaraan.");
        return 0;
    }

    if (!IsValidShopVehicleIndex(shopIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Vehicle shop ID tidak valid.");
        return 0;
    }

    new freeSlot = GetFreeGarageSlot(playerid);

    if (freeSlot == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Garage penuh. Jual salah satu kendaraan dengan /sellveh [slot].");
        return 0;
    }

    new modelid = ShopVehicleModel[shopIndex];
    new price = ShopVehiclePrice[shopIndex];

    if (PlayerMoney[playerid] < price)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Harga %s adalah $%d.", ShopVehicleName[shopIndex], price);
        SendClientMessage(playerid, COLOR_RED, msg);
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
        "INSERT INTO player_vehicles (owner_id, slot, model_id, vehicle_name, color1, color2, pos_x, pos_y, pos_z, pos_a, health, fuel, locked) VALUES (%d, %d, %d, '%e', 1, 1, %f, %f, %f, %f, 1000.0, 100, 0)",
        PlayerDBID[playerid],
        freeSlot + 1,
        modelid,
        ShopVehicleName[shopIndex],
        x + 3.0,
        y,
        z,
        a
    );

    mysql_tquery(g_SQL, query, "OnGarageVehicleBought", "iiii", playerid, freeSlot, modelid, price);
    return 1;
}

stock ShowHouseInteractionDialog(playerid, houseIndex)
{
    if (!IsValidHouseIndex(houseIndex) || !IsPlayerNearHouse(playerid, houseIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumah untuk membuka menu rumah.");
        return 0;
    }

    PlayerDialogHouseIndex[playerid] = houseIndex;

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "Info Rumah\nBeli Rumah\nRumah Saya\nKunci/Buka Rumah\nJual Rumah\nCancel"
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_HOUSE_MENU,
        DIALOG_STYLE_LIST,
        "House Interaction",
        dialogText,
        "Pilih",
        "Tutup"
    );
    return 1;
}

stock ShowHouseInfoDialog(playerid, houseIndex)
{
    if (!IsValidHouseIndex(houseIndex))
    {
        return 0;
    }

    new dialogText[512];
    new ownerStatus[64];

    if (PlayerHouseDBID[playerid] > 0 && PlayerHouseIndex[playerid] == houseIndex)
    {
        format(ownerStatus, sizeof(ownerStatus), "Status: Rumah milikmu");
    }
    else
    {
        format(ownerStatus, sizeof(ownerStatus), "Status: Bisa dibeli jika kamu belum punya rumah");
    }

    format(
        dialogText,
        sizeof(dialogText),
        "House: %s\nPrice: $%d\nLocation: %.2f, %.2f, %.2f\n%s\n\nMasuk/keluar rumah memakai panah custom, bukan ALT.",
        HouseName[houseIndex],
        HousePrice[houseIndex],
        HouseX[houseIndex],
        HouseY[houseIndex],
        HouseZ[houseIndex],
        ownerStatus
    );

    ShowPlayerDialog(playerid, DIALOG_HOUSE_INFO, DIALOG_STYLE_MSGBOX, "House Info", dialogText, "Back", "Tutup");
    return 1;
}

stock ShowHouseBuyConfirmDialog(playerid, houseIndex)
{
    if (!IsValidHouseIndex(houseIndex))
    {
        return 0;
    }

    PlayerDialogHouseIndex[playerid] = houseIndex;

    new dialogText[384];
    format(
        dialogText,
        sizeof(dialogText),
        "House: %s\nPrice: $%d\n\nBeli rumah ini?",
        HouseName[houseIndex],
        HousePrice[houseIndex]
    );

    ShowPlayerDialog(playerid, DIALOG_HOUSE_BUY_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm House Purchase", dialogText, "Buy", "Back");
    return 1;
}

stock ProcessDialogHouseBuy(playerid, houseIndex)
{
    if (!IsValidHouseIndex(houseIndex) || !IsPlayerNearHouse(playerid, houseIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat rumah tersebut untuk membelinya.");
        return 0;
    }

    if (PlayerHouseDBID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah punya rumah. Jual rumah lama dulu jika ingin membeli rumah lain.");
        return 0;
    }

    new price = HousePrice[houseIndex];

    if (PlayerMoney[playerid] < price)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Harga rumah ini $%d.", price);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
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

stock ShowHouseSellConfirmDialog(playerid)
{
    if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
        return 0;
    }

    new houseIndex = PlayerHouseIndex[playerid];
    new sellPrice = (HousePrice[houseIndex] * HOUSE_SELL_PERCENT) / 100;
    new dialogText[384];

    format(
        dialogText,
        sizeof(dialogText),
        "House: %s\nSell price: $%d\n\nJual rumah ini? Visitor di dalam rumah akan dikeluarkan.",
        HouseName[houseIndex],
        sellPrice
    );

    ShowPlayerDialog(playerid, DIALOG_HOUSE_SELL_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Sell House", dialogText, "Sell", "Back");
    return 1;
}

stock ProcessDialogHouseSell(playerid)
{
    if (PlayerHouseDBID[playerid] <= 0 || PlayerHouseIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
        return 0;
    }

    if (PlayerInsideHouse[playerid])
    {
        ExitPlayerHouse(playerid);
    }

    new houseIndex = PlayerHouseIndex[playerid];
    new sellPrice = (HousePrice[houseIndex] * HOUSE_SELL_PERCENT) / 100;
    new query[256];

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInsideHouse[i] && PlayerInsideHouseOwner[i] == playerid && i != playerid)
        {
            KickPlayerFromHouse(i);
            SendClientMessage(i, COLOR_YELLOW, "Rumah dijual oleh owner. Kamu dikeluarkan dari rumah.");
        }
    }

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

stock ShowBusinessInteractionDialog(playerid, businessIndex)
{
    if (!IsValidBusinessIndex(businessIndex) || !IsPlayerNearBusiness(playerid, businessIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat business untuk membuka menu business.");
        return 0;
    }

    PlayerDialogBusinessIndex[playerid] = businessIndex;

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "Info Business\nBeli Business\nBusiness Saya\nCollect Income\nUpgrade Business\nJual Business\nCancel"
    );

    ShowPlayerDialog(
        playerid,
        DIALOG_BUSINESS_MENU,
        DIALOG_STYLE_LIST,
        "Business Interaction",
        dialogText,
        "Pilih",
        "Tutup"
    );
    return 1;
}

stock ShowBusinessInfoDialog(playerid, businessIndex)
{
    if (!IsValidBusinessIndex(businessIndex))
    {
        return 0;
    }

    new dialogText[512];
    format(
        dialogText,
        sizeof(dialogText),
        "Business: %s\nPrice: $%d\nBase Income: $%d/min\nLocation: %.2f, %.2f, %.2f",
        BusinessName[businessIndex],
        BusinessPrice[businessIndex],
        BusinessIncomePerMinute[businessIndex],
        BusinessX[businessIndex],
        BusinessY[businessIndex],
        BusinessZ[businessIndex]
    );

    ShowPlayerDialog(playerid, DIALOG_BUSINESS_INFO, DIALOG_STYLE_MSGBOX, "Business Info", dialogText, "Back", "Tutup");
    return 1;
}

stock ShowMyBusinessDialog(playerid)
{
    if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    new businessIndex = PlayerBusinessIndex[playerid];
    new currentIncome = GetBusinessIncomePerMinute(businessIndex, PlayerBusinessLevel[playerid]);
    new dialogText[512];

    format(
        dialogText,
        sizeof(dialogText),
        "Business: %s\nLevel: %d/%d\nBase Income: $%d/min\nCurrent Income: $%d/min\nTotal Collected: $%d\nMax Collect: $%d",
        BusinessName[businessIndex],
        PlayerBusinessLevel[playerid],
        BUSINESS_MAX_LEVEL,
        BusinessIncomePerMinute[businessIndex],
        currentIncome,
        PlayerBusinessTotalCollected[playerid],
        BUSINESS_MAX_COLLECT
    );

    ShowPlayerDialog(playerid, DIALOG_BUSINESS_INFO, DIALOG_STYLE_MSGBOX, "My Business", dialogText, "Back", "Tutup");
    return 1;
}

stock ShowBusinessBuyConfirmDialog(playerid, businessIndex)
{
    if (!IsValidBusinessIndex(businessIndex))
    {
        return 0;
    }

    PlayerDialogBusinessIndex[playerid] = businessIndex;

    new dialogText[384];
    format(
        dialogText,
        sizeof(dialogText),
        "Business: %s\nPrice: $%d\nIncome: $%d/min\n\nBeli business ini?",
        BusinessName[businessIndex],
        BusinessPrice[businessIndex],
        BusinessIncomePerMinute[businessIndex]
    );

    ShowPlayerDialog(playerid, DIALOG_BUSINESS_BUY_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Business Purchase", dialogText, "Buy", "Back");
    return 1;
}

stock ProcessDialogBusinessBuy(playerid, businessIndex)
{
    if (!IsValidBusinessIndex(businessIndex) || !IsPlayerNearBusiness(playerid, businessIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat business tersebut untuk membelinya.");
        return 0;
    }

    if (PlayerBusinessDBID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah punya business. Jual business lama dulu jika ingin membeli business lain.");
        return 0;
    }

    new price = BusinessPrice[businessIndex];

    if (PlayerMoney[playerid] < price)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Harga business ini $%d.", price);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO player_businesses (owner_id, business_index, business_name, price, income_per_minute, business_level, total_collected, pos_x, pos_y, pos_z, last_collected) VALUES (%d, %d, '%e', %d, %d, 1, 0, %f, %f, %f, NOW())",
        PlayerDBID[playerid],
        businessIndex,
        BusinessName[businessIndex],
        price,
        BusinessIncomePerMinute[businessIndex],
        BusinessX[businessIndex],
        BusinessY[businessIndex],
        BusinessZ[businessIndex]
    );

    mysql_tquery(g_SQL, query, "OnPlayerBusinessBought", "iii", playerid, businessIndex, price);
    return 1;
}

stock ShowBusinessUpgradeConfirmDialog(playerid)
{
    if (!IsBusinessOwner(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    if (PlayerBusinessLevel[playerid] >= BUSINESS_MAX_LEVEL)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Business kamu sudah level maksimal.");
        return 0;
    }

    new cost = GetBusinessUpgradeCost(PlayerBusinessLevel[playerid]);
    new newLevel = PlayerBusinessLevel[playerid] + 1;
    new businessIndex = PlayerBusinessIndex[playerid];
    new nextIncome = GetBusinessIncomePerMinute(businessIndex, newLevel);
    new dialogText[384];

    format(
        dialogText,
        sizeof(dialogText),
        "Business: %s\nUpgrade: Lv %d -> Lv %d\nCost: $%d\nNew Income: $%d/min\n\nLanjut upgrade?",
        BusinessName[businessIndex],
        PlayerBusinessLevel[playerid],
        newLevel,
        cost,
        nextIncome
    );

    ShowPlayerDialog(playerid, DIALOG_BUSINESS_UPGRADE_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Business Upgrade", dialogText, "Upgrade", "Back");
    return 1;
}

stock ProcessDialogBusinessUpgrade(playerid)
{
    if (!IsBusinessOwner(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    if (PlayerBusinessLevel[playerid] >= BUSINESS_MAX_LEVEL)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Business kamu sudah level maksimal.");
        return 0;
    }

    new cost = GetBusinessUpgradeCost(PlayerBusinessLevel[playerid]);
    new newLevel = PlayerBusinessLevel[playerid] + 1;

    if (PlayerMoney[playerid] < cost)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Biaya upgrade: $%d.", cost);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
    }

    TakePlayerCash(playerid, cost);

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_businesses SET business_level=%d WHERE id=%d AND owner_id=%d LIMIT 1",
        newLevel,
        PlayerBusinessDBID[playerid],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnBusinessUpgraded", "iii", playerid, newLevel, cost);
    return 1;
}

stock ProcessDialogBusinessCollect(playerid)
{
    if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    new query[512];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT business_index, income_per_minute, business_level, total_collected, TIMESTAMPDIFF(MINUTE, last_collected, NOW()) AS minutes_passed FROM player_businesses WHERE owner_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnBusinessCollectLoaded", "i", playerid);
    return 1;
}

stock ShowBusinessSellConfirmDialog(playerid)
{
    if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    new businessIndex = PlayerBusinessIndex[playerid];
    new sellPrice = (BusinessPrice[businessIndex] * BUSINESS_SELL_PERCENT) / 100;
    new dialogText[384];

    format(
        dialogText,
        sizeof(dialogText),
        "Business: %s\nSell price: $%d\n\nJual business ini?",
        BusinessName[businessIndex],
        sellPrice
    );

    ShowPlayerDialog(playerid, DIALOG_BUSINESS_SELL_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Sell Business", dialogText, "Sell", "Back");
    return 1;
}

stock ProcessDialogBusinessSell(playerid)
{
    if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
        return 0;
    }

    new businessIndex = PlayerBusinessIndex[playerid];
    new sellPrice = (BusinessPrice[businessIndex] * BUSINESS_SELL_PERCENT) / 100;
    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "DELETE FROM player_businesses WHERE id=%d AND owner_id=%d LIMIT 1",
        PlayerBusinessDBID[playerid],
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerBusinessSold", "ii", playerid, sellPrice);
    return 1;
}

stock HandleWorldInteractKey(playerid)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 0;
    }

    if (PlayerInsideHouse[playerid])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Kamu sedang berada di dalam rumah.");
        SendClientMessage(playerid, COLOR_WHITE, "Untuk keluar ruangan, sentuh panah keluar. /exithouse tetap tersedia sebagai fallback.");
        return 1;
    }

    if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak bisa memakai ALT interaction saat job/race aktif.");
        return 1;
    }

    if (IsPlayerNearBankPoint(playerid))
    {
        ShowATMDialog(playerid);
        return 1;
    }

    if (IsPlayerNearDealership(playerid))
    {
        ShowDealershipMainDialog(playerid);
        return 1;
    }

    new nearestHouse = GetNearestHouse(playerid);

    if (nearestHouse != -1 && IsPlayerNearHouse(playerid, nearestHouse))
    {
        ShowHouseInteractionDialog(playerid, nearestHouse);
        return 1;
    }

    new nearestBusiness = GetNearestBusiness(playerid);

    if (nearestBusiness != -1 && IsPlayerNearBusiness(playerid, nearestBusiness))
    {
        ShowBusinessInteractionDialog(playerid, nearestBusiness);
        return 1;
    }

    ShowInteractionNoPoint(playerid);
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 1;
    }

    if (PlayerHouseExitPickup[playerid] != -1 && pickupid == PlayerHouseExitPickup[playerid])
    {
        if (IsPlayerInHousePickupCooldown(playerid))
        {
            return 1;
        }

        ExitPlayerHouse(playerid);
        return 1;
    }

    for (new i = 0; i < MAX_HOUSES; i++)
    {
        if (pickupid == HouseExteriorPickup[i])
        {
            if (IsPlayerInHousePickupCooldown(playerid))
            {
                return 1;
            }

            if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
            {
                SendClientMessage(playerid, COLOR_RED, "Tidak bisa masuk rumah saat job/race aktif.");
                return 1;
            }

            if (PlayerHouseDBID[playerid] > 0 && PlayerHouseIndex[playerid] == i)
            {
                EnterPlayerHouse(playerid);
                return 1;
            }

            SendClientMessage(playerid, COLOR_YELLOW, "Panah rumah terdeteksi.");
            SendClientMessage(playerid, COLOR_WHITE, "Jika ini rumahmu, gunakan /gohome atau /myhouse. Jika ingin membeli, tekan ALT untuk info lalu /buyhouse [id].");
            return 1;
        }
    }

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

    if (PlayerFindingBusiness[playerid])
    {
        new businessIndex = PlayerFindingBusinessIndex[playerid];

        if (IsValidBusinessIndex(businessIndex) && IsPlayerNearBusiness(playerid, businessIndex))
        {
            DisablePlayerCheckpoint(playerid);
            PlayerFindingBusiness[playerid] = 0;

            SendClientMessage(playerid, COLOR_GREEN, "Kamu sudah sampai di lokasi business.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /buybiz [id] jika ingin membeli business ini.");
            return 1;
        }
    }

    if (PlayerFindingDealer[playerid])
    {
        if (IsPlayerNearDealership(playerid))
        {
            DisablePlayerCheckpoint(playerid);
            PlayerFindingDealer[playerid] = 0;

            SendClientMessage(playerid, COLOR_GREEN, "Kamu sudah sampai di dealership.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /vehicleshop untuk melihat kendaraan.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /buyvehicle [id] untuk membeli kendaraan.");
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

    if (newstate == PLAYER_STATE_DRIVER)
    {
        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID && GetPlayerVehicleID(playerid) == OwnedVehicleID[playerid])
        {
            if (OwnedVehicleFuel[playerid] <= 0)
            {
                OwnedVehicleFuel[playerid] = 0;
                StopVehicleEngineDueFuel(playerid);
            }
        }
    }

    if (PlayerWorking[playerid])
    {
        if ((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && newstate == PLAYER_STATE_ONFOOT)
        {
            StartWorkVehicleGrace(playerid);
        }

        if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
        {
            if (IsCurrentWorkVehicleValid(playerid))
            {
                ClearWorkVehicleGrace(playerid);
            }
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

public OnBetaWhitelistCheck(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Whitelist check gagal. Coba reconnect.");
        SetTimerEx("DelayedKick", 1000, false, "i", playerid);
        return 1;
    }

    new totalActive;
    new allowed;
    new username[MAX_PLAYER_NAME];

    cache_get_value_name_int(0, "total_active", totalActive);
    cache_get_value_name_int(0, "allowed", allowed);
    GetPlayerAccountName(playerid, username, sizeof(username));

    if (totalActive == 0 && CLOSED_BETA_ALLOW_EMPTY)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Closed beta whitelist masih kosong. Bootstrap mode aktif.");
        CheckPlayerAccount(playerid);
        return 1;
    }

    if (allowed > 0)
    {
        SendClientMessage(playerid, COLOR_GREEN, "Whitelist closed beta valid. Melanjutkan login/register...");
        CheckPlayerAccount(playerid);
        return 1;
    }

    SendClientMessage(playerid, COLOR_RED, "Kamu belum masuk whitelist LSIF Closed Beta.");
    SendClientMessage(playerid, COLOR_WHITE, "Hubungi admin untuk ditambahkan ke whitelist.");
    print("[BETA] Player ditolak whitelist.");
    SetTimerEx("DelayedKick", 1500, false, "i", playerid);
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

    CheckBetaWhitelist(playerid);
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

        if (PlayerWorking[i] && !IsCurrentWorkVehicleValid(i))
        {
            CheckWorkVehicleGrace(i);
        }
        else if (PlayerWorking[i])
        {
            ClearWorkVehicleGrace(i);
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

public OnPlayerOrgLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        ResetPlayerOrgData(playerid);
        return 1;
    }

    cache_get_value_name_int(0, "org_id", PlayerOrgID[playerid]);
    cache_get_value_name_int(0, "rank_level", PlayerOrgRank[playerid]);
    cache_get_value_name(0, "name", PlayerOrgName[playerid], 64);
    cache_get_value_name_int(0, "bank_money", PlayerOrgBankMoney[playerid]);

    new msg[144];
    format(msg, sizeof(msg), "Organisasi dimuat: %s.", PlayerOrgName[playerid]);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    return 1;
}

public OnOrgListLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== ORGANIZATIONS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada organisasi.");
        return 1;
    }

    new orgid;
    new name[64];
    new ownerName[24];
    new bankMoney;
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", orgid);
        cache_get_value_name(i, "name", name, sizeof(name));
        cache_get_value_name(i, "owner_name", ownerName, sizeof(ownerName));
        cache_get_value_name_int(i, "bank_money", bankMoney);

        format(msg, sizeof(msg), "#%d %s | Owner: %s | Bank: $%d", orgid, name, ownerName, bankMoney);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnOrgCreated(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new orgid = cache_insert_id();

    if (orgid <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal membuat organisasi. Nama mungkin sudah dipakai.");
        return 1;
    }

    TakePlayerCash(playerid, ORG_CREATE_PRICE);

    new playerName[MAX_PLAYER_NAME];
    new query[512];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO organization_members (org_id, player_id, player_name, rank_level) VALUES (%d, %d, '%e', %d)",
        orgid,
        PlayerDBID[playerid],
        playerName,
        ORG_RANK_OWNER
    );

    mysql_tquery(g_SQL, query);

    PlayerOrgID[playerid] = orgid;
    PlayerOrgRank[playerid] = ORG_RANK_OWNER;

    format(PlayerOrgName[playerid], 64, "%s", PlayerPendingOrgName[playerid]);
    PlayerOrgBankMoney[playerid] = 0;

    SendClientMessage(playerid, COLOR_GREEN, "Organisasi berhasil dibuat. Kamu menjadi Owner.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /org untuk melihat info organisasi.");

    SavePlayerData(playerid);
    LoadPlayerOrganization(playerid);
    return 1;
}

public OnOrgInviteAccepted(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new inviterid = PlayerOrgInvite[playerid];

    if (inviterid == INVALID_PLAYER_ID || !IsPlayerConnected(inviterid))
    {
        SendClientMessage(playerid, COLOR_RED, "Invite gagal karena inviter tidak online.");
        PlayerOrgInvite[playerid] = INVALID_PLAYER_ID;
        return 1;
    }

    PlayerOrgID[playerid] = PlayerOrgID[inviterid];
    PlayerOrgRank[playerid] = ORG_RANK_MEMBER;
    format(PlayerOrgName[playerid], 64, "%s", PlayerOrgName[inviterid]);
    PlayerOrgBankMoney[playerid] = PlayerOrgBankMoney[inviterid];
    PlayerOrgInvite[playerid] = INVALID_PLAYER_ID;

    SendClientMessage(playerid, COLOR_GREEN, "Kamu berhasil bergabung ke organisasi.");

    new msg[144];
    new playerName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    format(msg, sizeof(msg), "[ORG] %s bergabung ke organisasi.", playerName);
    SendMessageToOrg(PlayerOrgID[playerid], COLOR_CYAN, msg);

    return 1;
}

public OnOrgMembersLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== ORG MEMBERS ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Tidak ada member.");
        return 1;
    }

    new memberName[24];
    new rank;
    new rankName[32];
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "player_name", memberName, sizeof(memberName));
        cache_get_value_name_int(i, "rank_level", rank);

        GetOrgRankName(rank, rankName, sizeof(rankName));

        format(msg, sizeof(msg), "%s - %s (%d)", memberName, rankName, rank);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnOrgInfoLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Data organisasi tidak ditemukan.");
        return 1;
    }

    new orgid;
    new name[64];
    new ownerName[24];
    new bankMoney;
    new memberCount;
    new rankName[32];
    new msg[144];

    cache_get_value_name_int(0, "id", orgid);
    cache_get_value_name(0, "name", name, sizeof(name));
    cache_get_value_name(0, "owner_name", ownerName, sizeof(ownerName));
    cache_get_value_name_int(0, "bank_money", bankMoney);
    cache_get_value_name_int(0, "member_count", memberCount);

    GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

    SendClientMessage(playerid, COLOR_YELLOW, "========== ORG INFO ==========");

    format(msg, sizeof(msg), "Org ID: %d | Name: %s", orgid, name);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Owner: %s | Members: %d", ownerName, memberCount);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Bank: $%d", bankMoney);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Your Rank: %s (%d)", rankName, PlayerOrgRank[playerid]);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    return 1;
}

public OnOrgRankUpdated(playerid, targetid, newRank)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();

    if (affectedRows <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal mengubah rank organisasi.");
        return 1;
    }

    if (IsPlayerConnected(targetid))
    {
        PlayerOrgRank[targetid] = newRank;

        new rankName[32];
        new msg[144];

        GetOrgRankName(newRank, rankName, sizeof(rankName));

        format(msg, sizeof(msg), "Rank organisasi kamu diubah menjadi %s (%d).", rankName, newRank);
        SendClientMessage(targetid, COLOR_YELLOW, msg);

        format(msg, sizeof(msg), "Rank player ID %d berhasil diubah menjadi %s.", targetid, rankName);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREEN, "Rank organisasi berhasil diubah.");
    }

    return 1;
}

public OnOrgMemberKicked(playerid, targetid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();

    if (affectedRows <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal mengeluarkan member.");
        return 1;
    }

    new msg[144];

    if (IsPlayerConnected(targetid))
    {
        new targetName[MAX_PLAYER_NAME];
        GetPlayerName(targetid, targetName, sizeof(targetName));

        format(msg, sizeof(msg), "%s dikeluarkan dari organisasi.", targetName);
        SendMessageToOrg(PlayerOrgID[playerid], COLOR_YELLOW, msg);

        ResetPlayerOrgData(targetid);
        SendClientMessage(targetid, COLOR_RED, "Kamu dikeluarkan dari organisasi.");
    }

    SendClientMessage(playerid, COLOR_GREEN, "Member berhasil dikeluarkan.");
    return 1;
}

public OnOrgDisbanded(playerid, orgid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerOrgID[i] == orgid)
        {
            ResetPlayerOrgData(i);
            SendClientMessage(i, COLOR_RED, "Organisasi kamu telah dibubarkan.");
        }
    }

    SendClientMessage(playerid, COLOR_GREEN, "Organisasi berhasil dibubarkan.");
    return 1;
}


public OnOrgMembersDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[1536];
    new memberName[24];
    new rank;
    new rankName[32];
    new line[128];

    format(dialogText, sizeof(dialogText), "Member\tRank\n");

    if (rows == 0)
    {
        strcat(dialogText, "Tidak ada member\t-\n", sizeof(dialogText));
    }
    else
    {
        for (new i = 0; i < rows; i++)
        {
            cache_get_value_name(i, "player_name", memberName, sizeof(memberName));
            cache_get_value_name_int(i, "rank_level", rank);
            GetOrgRankName(rank, rankName, sizeof(rankName));

            format(line, sizeof(line), "%s\t%s (%d)\n", memberName, rankName, rank);
            strcat(dialogText, line, sizeof(dialogText));
        }
    }

    ShowPlayerDialog(playerid, DIALOG_ORG_MEMBERS, DIALOG_STYLE_TABLIST_HEADERS, "Organization Members", dialogText, "Back", "Tutup");
    return 1;
}

public OnOrgListDialogLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[1536];
    new orgid;
    new name[64];
    new ownerName[24];
    new bankMoney;
    new line[160];

    format(dialogText, sizeof(dialogText), "ID\tName\tOwner\tBank\n");

    if (rows == 0)
    {
        strcat(dialogText, "-\tBelum ada organisasi\t-\t-\n", sizeof(dialogText));
    }
    else
    {
        for (new i = 0; i < rows; i++)
        {
            cache_get_value_name_int(i, "id", orgid);
            cache_get_value_name(i, "name", name, sizeof(name));
            cache_get_value_name(i, "owner_name", ownerName, sizeof(ownerName));
            cache_get_value_name_int(i, "bank_money", bankMoney);

            format(line, sizeof(line), "%d\t%s\t%s\t$%d\n", orgid, name, ownerName, bankMoney);
            strcat(dialogText, line, sizeof(dialogText));
        }
    }

    ShowPlayerDialog(playerid, DIALOG_ORG_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Organizations", dialogText, "Back", "Tutup");
    return 1;
}

public OnPlayerBusinessLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        PlayerBusinessDBID[playerid] = 0;
        PlayerBusinessIndex[playerid] = -1;
        return 1;
    }

    cache_get_value_name_int(0, "id", PlayerBusinessDBID[playerid]);
    cache_get_value_name_int(0, "business_index", PlayerBusinessIndex[playerid]);
    cache_get_value_name_int(0, "business_level", PlayerBusinessLevel[playerid]);
    cache_get_value_name_int(0, "total_collected", PlayerBusinessTotalCollected[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Data business berhasil dimuat. Gunakan /mybiz.");
    return 1;
}

public OnPlayerBusinessBought(playerid, businessIndex, price)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new insertId = cache_insert_id();

    if (insertId <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal membeli business. Database insert gagal.");
        return 1;
    }

    TakePlayerCash(playerid, price);

    PlayerBusinessDBID[playerid] = insertId;
    PlayerBusinessIndex[playerid] = businessIndex;
    PlayerBusinessLevel[playerid] = 1;
    PlayerBusinessTotalCollected[playerid] = 0;

    new msg[144];

    format(msg, sizeof(msg), "Kamu berhasil membeli business: %s seharga $%d.", BusinessName[businessIndex], price);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /mybiz untuk info business.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /collectbiz untuk mengambil passive income.");

    SavePlayerData(playerid);
    return 1;
}

public OnBusinessCollectLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Data business tidak ditemukan.");
        return 1;
    }

    new businessIndex;
    new incomePerMinute;
    new businessLevel;
    new totalCollected;
    new minutesPassed;

    cache_get_value_name_int(0, "business_index", businessIndex);
    cache_get_value_name_int(0, "income_per_minute", incomePerMinute);
    cache_get_value_name_int(0, "business_level", businessLevel);
    cache_get_value_name_int(0, "total_collected", totalCollected);
    cache_get_value_name_int(0, "minutes_passed", minutesPassed);

    if (minutesPassed < 1)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Business belum menghasilkan income baru. Coba lagi nanti.");
        return 1;
    }

    new currentIncome = incomePerMinute * businessLevel;
    new earned = minutesPassed * currentIncome;

    if (earned > BUSINESS_MAX_COLLECT)
    {
        earned = BUSINESS_MAX_COLLECT;
    }

    new newTotalCollected = totalCollected + earned;

    PlayerBusinessLevel[playerid] = businessLevel;
    PlayerBusinessTotalCollected[playerid] = newTotalCollected;

    GivePlayerCash(playerid, earned);
    SavePlayerData(playerid);

    new query[256];

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE player_businesses SET total_collected=%d, last_collected=NOW() WHERE owner_id=%d LIMIT 1",
        newTotalCollected,
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query);

    new msg[144];

    format(msg, sizeof(msg), "Business income dikumpulkan: $%d dari %d menit.", earned, minutesPassed);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Business: %s | Level: %d | Income/minute: $%d", BusinessName[businessIndex], businessLevel, currentIncome);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    return 1;
}

public OnPlayerBusinessSold(playerid, sellPrice)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    GivePlayerCash(playerid, sellPrice);

    PlayerBusinessDBID[playerid] = 0;
    PlayerBusinessIndex[playerid] = -1;

    new msg[144];

    format(msg, sizeof(msg), "Business berhasil dijual. Kamu menerima $%d.", sellPrice);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SavePlayerData(playerid);
    return 1;
}

public OnBusinessUpgraded(playerid, newLevel, cost)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();

    if (affectedRows <= 0)
    {
        GivePlayerCash(playerid, cost);
        SendClientMessage(playerid, COLOR_RED, "Upgrade business gagal. Uang dikembalikan.");
        return 1;
    }

    PlayerBusinessLevel[playerid] = newLevel;

    SavePlayerData(playerid);

    new businessIndex = PlayerBusinessIndex[playerid];
    new currentIncome = GetBusinessIncomePerMinute(businessIndex, PlayerBusinessLevel[playerid]);
    new msg[144];

    format(msg, sizeof(msg), "Business berhasil upgrade ke level %d.", newLevel);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Income sekarang: $%d/minute.", currentIncome);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    return 1;
}

public OnBusinessTopLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    SendClientMessage(playerid, COLOR_YELLOW, "========== BUSINESS TOP ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Belum ada data business.");
        return 1;
    }

    new username[24];
    new businessName[64];
    new level;
    new totalCollected;
    new msg[144];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "username", username, sizeof(username));
        cache_get_value_name(i, "business_name", businessName, sizeof(businessName));
        cache_get_value_name_int(i, "business_level", level);
        cache_get_value_name_int(i, "total_collected", totalCollected);

        format(
            msg,
            sizeof(msg),
            "%d. %s | %s | Lv %d | Collected: $%d",
            i + 1,
            username,
            businessName,
            level,
            totalCollected
        );
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnGarageLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    ResetPlayerGarageData(playerid);
    ResetOwnedVehicleData(playerid);

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Garage kosong. Beli kendaraan di dealership.");
        return 1;
    }

    new dbid;
    new slot;
    new slotIndex;
    new modelid;
    new locked;
    new Float:x, Float:y, Float:z, Float:a;

    new vehicleName[32];
    new fuel;
    new Float:health;

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", dbid);
        cache_get_value_name_int(i, "slot", slot);
        cache_get_value_name_int(i, "model_id", modelid);
        cache_get_value_name_float(i, "pos_x", x);
        cache_get_value_name_float(i, "pos_y", y);
        cache_get_value_name_float(i, "pos_z", z);
        cache_get_value_name_float(i, "pos_a", a);
        cache_get_value_name_int(i, "locked", locked);
        cache_get_value_name(i, "vehicle_name", vehicleName, sizeof(vehicleName));
        cache_get_value_name_float(i, "health", health);
        cache_get_value_name_int(i, "fuel", fuel);

        slotIndex = slot - 1;

        if (!IsValidGarageSlot(slotIndex))
        {
            continue;
        }

        PlayerGarageDBID[playerid][slotIndex] = dbid;
        PlayerGarageModel[playerid][slotIndex] = modelid;
        PlayerGarageLocked[playerid][slotIndex] = locked;
        format(PlayerGarageName[playerid][slotIndex], 32, "%s", vehicleName);
        PlayerGarageHealth[playerid][slotIndex] = health;
        PlayerGarageFuel[playerid][slotIndex] = fuel;

        PlayerGarageX[playerid][slotIndex] = x;
        PlayerGarageY[playerid][slotIndex] = y;
        PlayerGarageZ[playerid][slotIndex] = z;
        PlayerGarageA[playerid][slotIndex] = a;
    }

    for (new s = 0; s < MAX_GARAGE_SLOTS; s++)
    {
        if (PlayerGarageDBID[playerid][s] > 0)
        {
            SetActiveVehicleFromGarage(playerid, s);
            break;
        }
    }

    new msg[144];
    format(msg, sizeof(msg), "Garage berhasil dimuat. Total kendaraan: %d/%d. Gunakan /garage.", CountPlayerGarageVehicles(playerid), MAX_GARAGE_SLOTS);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    return 1;
}

public OnGarageVehicleBought(playerid, slotIndex, modelid, price)
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

    PlayerGarageDBID[playerid][slotIndex] = insertId;
    PlayerGarageModel[playerid][slotIndex] = modelid;
    PlayerGarageLocked[playerid][slotIndex] = 0;
    format(PlayerGarageName[playerid][slotIndex], 32, "Vehicle");
    PlayerGarageHealth[playerid][slotIndex] = 1000.0;
    PlayerGarageFuel[playerid][slotIndex] = VEHICLE_MAX_FUEL;

    new Float:x, Float:y, Float:z, Float:a;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    PlayerGarageX[playerid][slotIndex] = x + 3.0;
    PlayerGarageY[playerid][slotIndex] = y;
    PlayerGarageZ[playerid][slotIndex] = z;
    PlayerGarageA[playerid][slotIndex] = a;

    SetActiveVehicleFromGarage(playerid, slotIndex);

    new msg[144];
    format(msg, sizeof(msg), "Kamu berhasil membeli kendaraan model %d seharga $%d.", modelid, price);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Kendaraan masuk ke garage slot %d. Gunakan /myveh %d.", slotIndex + 1, slotIndex + 1);
    SendClientMessage(playerid, COLOR_CYAN, msg);

    SavePlayerData(playerid);
    return 1;
}

public OnGarageVehicleSold(playerid, slotIndex, sellPrice)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();

    if (affectedRows <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal menjual kendaraan.");
        return 1;
    }

    GivePlayerCash(playerid, sellPrice);

    if (OwnedVehicleSlot[playerid] == slotIndex)
    {
        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            DestroyOwnedVehicleLabel(playerid);
            DestroyVehicle(OwnedVehicleID[playerid]);
        }

        ResetOwnedVehicleData(playerid);
    }

    PlayerGarageDBID[playerid][slotIndex] = 0;
    PlayerGarageModel[playerid][slotIndex] = 0;
    PlayerGarageLocked[playerid][slotIndex] = 0;

    PlayerGarageX[playerid][slotIndex] = SPAWN_X + 3.0;
    PlayerGarageY[playerid][slotIndex] = SPAWN_Y;
    PlayerGarageZ[playerid][slotIndex] = SPAWN_Z;
    PlayerGarageA[playerid][slotIndex] = SPAWN_A;

    new msg[144];
    format(msg, sizeof(msg), "Kendaraan slot %d berhasil dijual. Kamu menerima $%d.", slotIndex + 1, sellPrice);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    SavePlayerData(playerid);
    return 1;
}

public OnWhitelistAdded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    SendClientMessage(playerid, COLOR_GREEN, "Whitelist beta berhasil ditambahkan/diaktifkan.");
    return 1;
}

public OnWhitelistRemoved(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();
    new msg[144];

    if (affectedRows > 0)
    {
        format(msg, sizeof(msg), "Whitelist %s berhasil dinonaktifkan.", PlayerLastWhitelistQuery[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }
    else
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Username tidak ditemukan di whitelist atau sudah nonaktif.");
    }

    return 1;
}

public OnWhitelistListLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new username[24];
    new addedBy[24];
    new createdAt[32];
    new msg[144];

    SendClientMessage(playerid, COLOR_YELLOW, "========== BETA WHITELIST ==========");

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Whitelist aktif kosong.");
        return 1;
    }

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "username", username, sizeof(username));
        cache_get_value_name(i, "added_by", addedBy, sizeof(addedBy));
        cache_get_value_name(i, "created_at", createdAt, sizeof(createdAt));

        format(msg, sizeof(msg), "%d. %s | Added by: %s | %s", i + 1, username, addedBy, createdAt);
        SendClientMessage(playerid, COLOR_WHITE, msg);
    }

    return 1;
}

public OnWhitelistCheckLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new msg[144];

    if (rows == 0)
    {
        format(msg, sizeof(msg), "%s tidak ditemukan di whitelist.", PlayerLastWhitelistQuery[playerid]);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        return 1;
    }

    new username[24];
    new addedBy[24];
    new createdAt[32];
    new active;

    cache_get_value_name(0, "username", username, sizeof(username));
    cache_get_value_name_int(0, "active", active);
    cache_get_value_name(0, "added_by", addedBy, sizeof(addedBy));
    cache_get_value_name(0, "created_at", createdAt, sizeof(createdAt));

    format(msg, sizeof(msg), "Whitelist: %s | Active: %d | Added by: %s", username, active, addedBy);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    format(msg, sizeof(msg), "Created: %s", createdAt);
    SendClientMessage(playerid, COLOR_WHITE, msg);

    return 1;
}


public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
    if (!PlayerLoggedIn[playerid])
    {
        return 1;
    }

    if ((newkeys & KEY_SUBMISSION) && !(oldkeys & KEY_SUBMISSION))
    {
        HandleVehicleMissionKey(playerid);
        return 1;
    }

    if ((newkeys & KEY_WALK) && !(oldkeys & KEY_WALK))
    {
        HandleWorldInteractKey(playerid);
        return 1;
    }

    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (!PlayerLoggedIn[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus login/register terlebih dahulu.");
        return 1;
    }
    if (!strcmp(cmdtext, "/interact", true))
    {
        HandleWorldInteractKey(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/maplegend", true))
    {
        ShowMapLegendDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/refreshicons", true))
    {
        ApplyLSIFMapIcons(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Map icon LSIF sudah direfresh.");
        return 1;
    }


    if (!strcmp(cmdtext, "/adminmenu", true))
    {
        ShowAdminDashboardMenu(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/betamenu", true))
    {
        ShowBetaDashboardMenu(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF HELP ==========");
        SendClientMessage(playerid, COLOR_WHITE, "/help - Menampilkan bantuan");
        SendClientMessage(playerid, COLOR_WHITE, "ALT - Interaksi dunia; ATM, dealer, house, business, dan garage service memakai Dialog UI");
        SendClientMessage(playerid, COLOR_WHITE, "Tombol 2 - Khusus start job/vehicle mission saat driver kendaraan job");
        SendClientMessage(playerid, COLOR_WHITE, "/maplegend - Penjelasan icon radar/map LSIF");
        SendClientMessage(playerid, COLOR_WHITE, "/refreshicons - Refresh icon radar/map LSIF");
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
        SendClientMessage(playerid, COLOR_WHITE, "/garage - Melihat slot kendaraan");
        SendClientMessage(playerid, COLOR_WHITE, "/myveh [slot] - Spawn kendaraan dari garage");
        SendClientMessage(playerid, COLOR_WHITE, "/sellveh [slot] - Jual kendaraan dari garage");
        SendClientMessage(playerid, COLOR_WHITE, "/park - Simpan posisi kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/lock - Kunci/buka kendaraan pribadi");
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
        SendClientMessage(playerid, COLOR_WHITE, "/visithouse [id] - Masuk rumah player jika unlocked/diundang");
        SendClientMessage(playerid, COLOR_WHITE, "/invitehouse [id] - Undang player ke rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/kickhouse [id] - Keluarkan visitor dari rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/housevisitors - Lihat visitor rumah");
        SendClientMessage(playerid, COLOR_WHITE, "/orgmenu - Menu dialog organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/adminmenu - Dialog dashboard admin closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/betamenu - Dialog whitelist/beta management");
        SendClientMessage(playerid, COLOR_WHITE, "/orgs - Melihat daftar organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/createorg [nama] - Membuat organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/org - Info organisasi kamu");
        SendClientMessage(playerid, COLOR_WHITE, "/inviteorg [id] - Invite player ke organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/acceptorg - Terima invite organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/leaveorg - Keluar dari organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/orgmembers - Lihat member organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/orgchat [msg] atau /oc [msg] - Chat organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/orginfo - Detail organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/setorgrank [id] [rank] - Ubah rank organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/kickorg [id] - Keluarkan member organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/disbandorg - Bubarkan organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/orgbank - Melihat saldo bank organisasi");
        SendClientMessage(playerid, COLOR_WHITE, "/orgdeposit [amount/all] - Deposit cash ke org bank");
        SendClientMessage(playerid, COLOR_WHITE, "/orgwithdraw [amount] - Withdraw org bank, Admin+");
        SendClientMessage(playerid, COLOR_WHITE, "/businesses - Melihat daftar business");
        SendClientMessage(playerid, COLOR_WHITE, "/findbiz [id] - Cari lokasi business");
        SendClientMessage(playerid, COLOR_WHITE, "/cancelbiz - Hapus checkpoint business");
        SendClientMessage(playerid, COLOR_WHITE, "/buybiz [id] - Beli business");
        SendClientMessage(playerid, COLOR_WHITE, "/mybiz - Info business pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/collectbiz - Ambil income business");
        SendClientMessage(playerid, COLOR_WHITE, "/sellbiz - Jual business");
        SendClientMessage(playerid, COLOR_WHITE, "/upgradebiz - Upgrade level business");
        SendClientMessage(playerid, COLOR_WHITE, "/biztop - Leaderboard business income");
        SendClientMessage(playerid, COLOR_WHITE, "/dealerships - Melihat daftar dealership");
        SendClientMessage(playerid, COLOR_WHITE, "/finddealer - Cari dealership terdekat");
        SendClientMessage(playerid, COLOR_WHITE, "/canceldealer - Hapus checkpoint dealership");
        SendClientMessage(playerid, COLOR_WHITE, "/vehicleshop - Melihat daftar kendaraan");
        SendClientMessage(playerid, COLOR_WHITE, "/buyvehicle [id] - Beli kendaraan di dealership");
        SendClientMessage(playerid, COLOR_WHITE, "/vehstatus - Status kendaraan aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/fuelinfo - Melihat info fuel kendaraan aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/renameveh [slot] [name] - Ganti nama kendaraan");
        SendClientMessage(playerid, COLOR_WHITE, "/repairveh - Repair kendaraan di dealership");
        SendClientMessage(playerid, COLOR_WHITE, "/refuelveh - Isi fuel kendaraan di dealership");
        SendClientMessage(playerid, COLOR_WHITE, "/motd - Melihat pengumuman closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/serverrules - Membaca aturan server");
        SendClientMessage(playerid, COLOR_WHITE, "/betahelp - Starter guide closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/starterpack - Klaim starter pack beta sekali");
        SendClientMessage(playerid, COLOR_WHITE, "/whereami - Cek posisi/interior/debug lokasi");
        SendClientMessage(playerid, COLOR_WHITE, "/bugreport [text] - Laporkan bug closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/suggest [text] - Kirim saran closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/version - Melihat versi server");
        SendClientMessage(playerid, COLOR_WHITE, "/changelog - Melihat ringkasan update closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/credits - Melihat credit project LSIF");
        SendClientMessage(playerid, COLOR_WHITE, "/betaguide - Panduan ringkas closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/staff - Melihat staff/admin online");

        return 1;
    }

    if (!strcmp(cmdtext, "/motd", true))
    {
        ShowBetaMOTD(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/serverrules", true))
    {
        ShowServerRules(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/betahelp", true))
    {
        SendBetaGuide(playerid);
        return 1;
    }


    if (!strcmp(cmdtext, "/version", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF VERSION ==========");
        SendClientMessage(playerid, COLOR_WHITE, "Server: LSIF - Los Santos Indonesia Freeroam");
        SendClientMessage(playerid, COLOR_WHITE, "Version: v0.17H Map Legend & World Markers");
        SendClientMessage(playerid, COLOR_WHITE, "Stage: Closed Beta Candidate");
        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /changelog untuk melihat ringkasan update.");
        return 1;
    }

    if (!strcmp(cmdtext, "/changelog", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF CHANGELOG ==========");
        SendClientMessage(playerid, COLOR_WHITE, "v0.16D: Release polish, version, credits, staff, beta guide.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.16D.1: Temporary /veh engine fix for manual engine mode.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.17F: Organization info, members, bank, invite, rank, kick, leave, dan disband memakai Dialog UI.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.17B: house arrow enter/exit, ALT transaksi/menu, dan job vehicle grace timer.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.16C: Admin beta dashboard dan monitoring reports/logs.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.16B: Starter pack, bug report, suggestion, feedback handling.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.16A: Whitelist, MOTD, rules, closed beta gate.");
        SendClientMessage(playerid, COLOR_WHITE, "Core: jobs, race, house, org, business, dealership, garage, fuel.");
        return 1;
    }

    if (!strcmp(cmdtext, "/credits", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF CREDITS ==========");
        SendClientMessage(playerid, COLOR_WHITE, "Founder/Developer: Adriano");
        SendClientMessage(playerid, COLOR_WHITE, "Project: Los Santos Indonesia Freeroam");
        SendClientMessage(playerid, COLOR_WHITE, "Engine: open.mp / SA-MP compatible server");
        SendClientMessage(playerid, COLOR_WHITE, "Thanks: Closed beta testers yang bantu lapor bug dan saran.");
        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /bugreport dan /suggest untuk bantu pengembangan.");
        return 1;
    }

    if (!strcmp(cmdtext, "/betaguide", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== CLOSED BETA GUIDE ==========");
        SendClientMessage(playerid, COLOR_WHITE, "1. Klaim modal awal: /starterpack");
        SendClientMessage(playerid, COLOR_WHITE, "2. Mulai kerja: naik kendaraan job lalu tekan tombol 2. Command /work tetap fallback");
        SendClientMessage(playerid, COLOR_WHITE, "3. Beli kendaraan: /finddealer, /vehicleshop, /buyvehicle [id]");
        SendClientMessage(playerid, COLOR_WHITE, "4. Simpan uang: /findbank lalu /deposit [amount/all]");
        SendClientMessage(playerid, COLOR_WHITE, "5. Aktivitas lanjutan: /houses, /businesses, /orgs, /races");
        SendClientMessage(playerid, COLOR_CYAN, "Lapor bug: /bugreport [text] | Saran: /suggest [text]");
        return 1;
    }

    if (!strcmp(cmdtext, "/staff", true))
    {
        new name[MAX_PLAYER_NAME];
        new rankName[32];
        new msg[144];
        new found = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "========== STAFF ONLINE ==========");

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
            SendClientMessage(playerid, COLOR_WHITE, "Tidak ada staff online saat ini.");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/starterpack", true))
    {
        if (PlayerStarterPackClaimed[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Starter pack sudah pernah kamu klaim.");
            return 1;
        }

        GivePlayerCash(playerid, STARTER_CASH);
        GivePlayerBankMoney(playerid, STARTER_BANK);
        GivePlayerXPEx(playerid, STARTER_XP);

        PlayerStarterPackClaimed[playerid] = 1;
        SavePlayerData(playerid);

        SendClientMessage(playerid, COLOR_GREEN, "Starter pack berhasil diklaim.");
        SendStarterPackInfo(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/whereami", true))
    {
        ShowWhereAmI(playerid);
        return 1;
    }

    if (strfind(cmdtext, "/bugreport ", true) == 0)
    {
        new message[255];
        format(message, sizeof(message), "%s", cmdtext[11]);

        if (strlen(message) < 5)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /bugreport [jelaskan bug minimal 5 karakter]");
            return 1;
        }

        CreateFeedbackReport(playerid, "bug", message);
        return 1;
    }

    if (!strcmp(cmdtext, "/bugreport", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /bugreport [jelaskan bug]");
        return 1;
    }

    if (strfind(cmdtext, "/suggest ", true) == 0)
    {
        new message[255];
        format(message, sizeof(message), "%s", cmdtext[9]);

        if (strlen(message) < 5)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /suggest [saran minimal 5 karakter]");
            return 1;
        }

        CreateFeedbackReport(playerid, "suggest", message);
        return 1;
    }

    if (!strcmp(cmdtext, "/suggest", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /suggest [saran]");
        return 1;
    }

    if (!strcmp(cmdtext, "/feedbacks", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(
            g_SQL,
            "SELECT id, reporter_name, type, message, created_at FROM feedback_reports WHERE status='open' ORDER BY id DESC LIMIT 5",
            "OnFeedbackListLoaded",
            "i",
            playerid
        );
        return 1;
    }

    if (strfind(cmdtext, "/closefeedback ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new feedbackStr[16];
        new note[128];

        if (!GetFirstParamAndRest(cmdtext[15], feedbackStr, sizeof(feedbackStr), note, sizeof(note)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /closefeedback [id] [note]");
            return 1;
        }

        if (!IsNumericString(feedbackStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Feedback ID harus angka.");
            return 1;
        }

        new feedbackid = strval(feedbackStr);
        new adminName[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerName(playerid, adminName, sizeof(adminName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE feedback_reports SET status='closed', handled_by_id=%d, handled_by_name='%e', close_note='%e', closed_at=NOW() WHERE id=%d AND status='open' LIMIT 1",
            PlayerDBID[playerid],
            adminName,
            note,
            feedbackid
        );

        mysql_tquery(g_SQL, query, "OnFeedbackClosed", "ii", playerid, feedbackid);

        new detail[160];
        format(detail, sizeof(detail), "closefeedback id=%d note=%s", feedbackid, note);
        LogAdminAction(playerid, INVALID_PLAYER_ID, "CLOSE_FEEDBACK", detail);
        return 1;
    }

    if (!strcmp(cmdtext, "/closefeedback", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /closefeedback [id] [note]");
        return 1;
    }


    if (strfind(cmdtext, "/abroadcast ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_ADMIN))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Admin untuk menggunakan broadcast.");
            return 1;
        }

        new message[128];
        format(message, sizeof(message), "%s", cmdtext[12]);

        if (strlen(message) < 1)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /abroadcast [message]");
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new msg[160];

        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(msg, sizeof(msg), "[ADMIN BROADCAST] %s: %s", adminName, message);
        SendClientMessageToAll(COLOR_ORANGE, msg);

        LogAdminAction(playerid, INVALID_PLAYER_ID, "ABROADCAST", message);
        return 1;
    }

    if (!strcmp(cmdtext, "/abroadcast", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /abroadcast [message]");
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

        new engine;
        new lights;
        new alarm;
        new doors;
        new bonnet;
        new boot;
        new objective;

        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
        SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);

        SendClientMessage(playerid, COLOR_GREEN, "Kendaraan berhasil diperbaiki dan mesin dinyalakan.");
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

        if (PlayerVehicle[playerid] == INVALID_VEHICLE_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "Gagal membuat kendaraan sementara.");
            return 1;
        }

        SetVehicleParamsEx(
            PlayerVehicle[playerid],
            1, // engine ON for temporary /veh vehicles
            0, // lights OFF
            0, // alarm OFF
            0, // doors unlocked
            0, // bonnet closed
            0, // boot closed
            0  // objective off
        );

        PutPlayerInVehicle(playerid, PlayerVehicle[playerid], 0);

        new msg[144];
        format(msg, sizeof(msg), "Kendaraan temporary model ID %d berhasil dibuat dan mesin dinyalakan.", modelid);
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

        format(msg, sizeof(msg), "Starter Pack Claimed: %s", PlayerStarterPackClaimed[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Garage: %d/%d vehicles", CountPlayerGarageVehicles(playerid), MAX_GARAGE_SLOTS);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (OwnedVehicleSlot[playerid] != -1)
        {
            format(msg, sizeof(msg), "Active Vehicle Slot: %d | Model: %d", OwnedVehicleSlot[playerid] + 1, OwnedVehicleModel[playerid]);
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

        if (PlayerOrgID[playerid] > 0)
        {
            new rankName[32];
            GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

            format(msg, sizeof(msg), "Organization: %s | Rank: %s", PlayerOrgName[playerid], rankName);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Organization: None");
        }

        if (PlayerBusinessDBID[playerid] > 0 && PlayerBusinessIndex[playerid] != -1)
        {
            format(
                msg,
                sizeof(msg),
                "Business: %s | Lv: %d | Collected: $%d",
                BusinessName[PlayerBusinessIndex[playerid]],
                PlayerBusinessLevel[playerid],
                PlayerBusinessTotalCollected[playerid]
            );
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Business: None");
        }

        return 1;
    }

    if (strfind(cmdtext, "/buyveh ", true) == 0)
    {
        new modelStr[16];
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Command ini sekarang hanya untuk owner/dev.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /vehicleshop dan /buyvehicle [id] di dealership.");
            return 1;
        }

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
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /myveh [slot]");
        SendClientMessage(playerid, COLOR_WHITE, "Contoh: /myveh 1");
        SendClientMessage(playerid, COLOR_WHITE, "Lihat slot kendaraan: /garage");
        return 1;
    }

    if (strfind(cmdtext, "/myveh ", true) == 0)
    {
        new slotStr[16];

        if (!GetOneParam(cmdtext[7], slotStr, sizeof(slotStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /myveh [slot]");
            return 1;
        }

        if (!IsNumericString(slotStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot harus angka.");
            return 1;
        }

        new slotIndex = strval(slotStr) - 1;

        if (!IsValidGarageSlot(slotIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot tidak valid.");
            return 1;
        }

        if (PlayerGarageDBID[playerid][slotIndex] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong.");
            return 1;
        }

        SetActiveVehicleFromGarage(playerid, slotIndex);
        SpawnOwnedVehicle(playerid);

        new msg[144];
        format(msg, sizeof(msg), "Kendaraan slot %d sekarang aktif.", slotIndex + 1);
        SendClientMessage(playerid, COLOR_GREEN, msg);

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
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /sellveh [slot]");
        SendClientMessage(playerid, COLOR_WHITE, "Contoh: /sellveh 1");
        SendClientMessage(playerid, COLOR_WHITE, "Lihat slot kendaraan: /garage");
        return 1;
    }

    if (strfind(cmdtext, "/sellveh ", true) == 0)
    {
        new slotStr[16];

        if (!GetOneParam(cmdtext[9], slotStr, sizeof(slotStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /sellveh [slot]");
            return 1;
        }

        if (!IsNumericString(slotStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot harus angka.");
            return 1;
        }

        new slotIndex = strval(slotStr) - 1;

        if (!IsValidGarageSlot(slotIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot tidak valid.");
            return 1;
        }

        if (PlayerGarageDBID[playerid][slotIndex] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong.");
            return 1;
        }

        new modelid = PlayerGarageModel[playerid][slotIndex];
        new basePrice = GetVehicleBasePrice(modelid);
        new sellPrice = basePrice / 2;

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM player_vehicles WHERE id=%d AND owner_id=%d LIMIT 1",
            PlayerGarageDBID[playerid][slotIndex],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnGarageVehicleSold", "iii", playerid, slotIndex, sellPrice);
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

        SendClientMessage(playerid, COLOR_CYAN, "Beli kendaraan baru di dealership: /finddealer, /vehicleshop, /buyvehicle [id].");

        if (OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Active Slot: None");
        }
        else
        {
            format(msg, sizeof(msg), "Active Slot: %d", OwnedVehicleSlot[playerid] + 1);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        format(msg, sizeof(msg), "Name: %s | Fuel: %d/%d | Health: %.1f", OwnedVehicleName[playerid], OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL, OwnedVehicleHealth[playerid]);
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
        SendClientMessage(playerid, COLOR_WHITE, "/feedbacks - Lihat feedback/bug/saran terbuka");
        SendClientMessage(playerid, COLOR_WHITE, "/closefeedback [id] [note] - Tutup feedback");
        SendClientMessage(playerid, COLOR_WHITE, "/acinfo - Melihat informasi basic anti-cheat");
        SendClientMessage(playerid, COLOR_WHITE, "/setfuel [amount] - Set fuel kendaraan aktif, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/serverinfo - Info server dan uptime");
        SendClientMessage(playerid, COLOR_WHITE, "/dbping - Test koneksi database");
        SendClientMessage(playerid, COLOR_WHITE, "/saveall - Simpan semua player, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/playerinfo [id] - Debug data player");
        SendClientMessage(playerid, COLOR_WHITE, "/vehdebug - Debug kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/jobdebug - Debug job/race aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/buyveh [modelid] - Beli kendaraan pribadi");
        SendClientMessage(playerid, COLOR_WHITE, "/abroadcast [message] - Broadcast admin ke semua player");
        SendClientMessage(playerid, COLOR_WHITE, "/wladd [username] - Tambah whitelist beta, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/wlremove [username] - Nonaktifkan whitelist beta, Owner only");
        SendClientMessage(playerid, COLOR_WHITE, "/wlcheck [username] - Cek whitelist beta");
        SendClientMessage(playerid, COLOR_WHITE, "/whitelist - Lihat 10 whitelist aktif");
        SendClientMessage(playerid, COLOR_WHITE, "/betastatus - Dashboard status closed beta");
        SendClientMessage(playerid, COLOR_WHITE, "/playerlist - List player online");
        SendClientMessage(playerid, COLOR_WHITE, "/onlineadmins - List admin online");
        SendClientMessage(playerid, COLOR_WHITE, "/recentbugs - Bug report terbaru");
        SendClientMessage(playerid, COLOR_WHITE, "/recentreports - Player report terbaru");
        SendClientMessage(playerid, COLOR_WHITE, "/recentfeedback - Feedback/suggest terbaru");
        SendClientMessage(playerid, COLOR_WHITE, "/recentlogs - Admin log terbaru");
        SendClientMessage(playerid, COLOR_WHITE, "/adminmenu - Dashboard admin berbasis dialog");
        SendClientMessage(playerid, COLOR_WHITE, "/betamenu - Dashboard beta/whitelist berbasis dialog");
        SendClientMessage(playerid, COLOR_WHITE, "/version, /changelog, /credits, /staff - Release info commands");

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
        SendClientMessage(playerid, COLOR_CYAN, "Visitor: /invitehouse [id], /kickhouse [id], /housevisitors.");
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

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInsideHouse[i] && PlayerInsideHouseOwner[i] == playerid && i != playerid)
            {
                KickPlayerFromHouse(i);
                SendClientMessage(i, COLOR_YELLOW, "Rumah dijual oleh owner. Kamu dikeluarkan dari rumah.");
            }
        }

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

        new ownerid = PlayerInsideHouseOwner[playerid];

        if (PlayerInsideHouse[playerid] && ownerid != INVALID_PLAYER_ID && IsPlayerConnected(ownerid))
        {
            new ownerName[MAX_PLAYER_NAME];
            GetPlayerName(ownerid, ownerName, sizeof(ownerName));

            format(msg, sizeof(msg), "Inside owner: %s [%d]", ownerName, ownerid);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        format(msg, sizeof(msg), "Virtual World: %d", GetPlayerHouseVirtualWorld(playerid));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Command: /enterhouse, /exithouse, /lockhouse, /gohome, /sellhouse.");
        return 1;
    }

    if (strfind(cmdtext, "/visithouse ", true) == 0)
    {
        new targetStr[16];

        if (!GetOneParam(cmdtext[12], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /visithouse [playerid]");
            return 1;
        }

        if (!IsNumericString(targetStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        new ownerid = strval(targetStr);

        if (!IsPlayerConnected(ownerid) || !PlayerLoggedIn[ownerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Owner tidak online/login.");
            return 1;
        }

        if (!IsPlayerHouseOwner(ownerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player tersebut belum punya rumah.");
            return 1;
        }

        EnterHouseAsVisitor(playerid, ownerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/visithouse", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /visithouse [playerid]");
        return 1;
    }

    if (strfind(cmdtext, "/invitehouse ", true) == 0)
    {
        if (!IsPlayerHouseOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[13], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /invitehouse [playerid]");
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
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak perlu invite diri sendiri.");
            return 1;
        }

        PlayerHouseInvite[targetid] = playerid;

        new ownerName[MAX_PLAYER_NAME];
        new targetName[MAX_PLAYER_NAME];
        new msg[144];

        GetPlayerName(playerid, ownerName, sizeof(ownerName));
        GetPlayerName(targetid, targetName, sizeof(targetName));

        format(msg, sizeof(msg), "Kamu mengundang %s ke rumahmu.", targetName);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "%s mengundang kamu ke rumahnya. Gunakan /visithouse %d saat dekat rumahnya.", ownerName, playerid);
        SendClientMessage(targetid, COLOR_GREEN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/invitehouse", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /invitehouse [playerid]");
        return 1;
    }

    if (strfind(cmdtext, "/kickhouse ", true) == 0)
    {
        if (!IsPlayerHouseOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[11], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kickhouse [playerid]");
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

        if (!PlayerInsideHouse[targetid] || PlayerInsideHouseOwner[targetid] != playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak sedang berada di rumahmu.");
            return 1;
        }

        KickPlayerFromHouse(targetid);

        SendClientMessage(playerid, COLOR_GREEN, "Player berhasil dikeluarkan dari rumah.");
        SendClientMessage(targetid, COLOR_YELLOW, "Kamu dikeluarkan dari rumah oleh owner.");

        return 1;
    }

    if (!strcmp(cmdtext, "/kickhouse", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kickhouse [playerid]");
        return 1;
    }

    if (!strcmp(cmdtext, "/housevisitors", true))
    {
        if (!IsPlayerHouseOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya rumah.");
            return 1;
        }

        new found = 0;
        new name[MAX_PLAYER_NAME];
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== HOUSE VISITORS ==========");

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInsideHouse[i] && PlayerInsideHouseOwner[i] == playerid && i != playerid)
            {
                GetPlayerName(i, name, sizeof(name));

                format(msg, sizeof(msg), "%s [%d]", name, i);
                SendClientMessage(playerid, COLOR_WHITE, msg);

                found++;
            }
        }

        if (!found)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tidak ada visitor di rumahmu.");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/orgmenu", true))
    {
        ShowOrgMenuDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/orgs", true))
    {
        mysql_tquery(
            g_SQL,
            "SELECT id, name, owner_name, bank_money FROM organizations ORDER BY id ASC LIMIT 10",
            "OnOrgListLoaded",
            "i",
            playerid
        );
        return 1;
    }

    if (strfind(cmdtext, "/createorg ", true) == 0)
    {
        if (PlayerOrgID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam organisasi.");
            return 1;
        }

        new orgName[64];

        format(orgName, sizeof(orgName), "%s", cmdtext[11]);

        if (strlen(orgName) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Nama organisasi minimal 3 karakter.");
            return 1;
        }

        if (PlayerMoney[playerid] < ORG_CREATE_PRICE)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Biaya membuat organisasi: $%d.", ORG_CREATE_PRICE);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        new playerName[MAX_PLAYER_NAME];
        new query[768];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(PlayerPendingOrgName[playerid], 64, "%s", orgName);

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO organizations (name, owner_id, owner_name, bank_money) VALUES ('%e', %d, '%e', 0)",
            orgName,
            PlayerDBID[playerid],
            playerName
        );

        mysql_tquery(g_SQL, query, "OnOrgCreated", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/org", true))
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /orgs atau /createorg [nama].");
            return 1;
        }

        new rankName[32];
        new msg[144];

        GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

        SendClientMessage(playerid, COLOR_YELLOW, "========== ORGANIZATION ==========");

        format(msg, sizeof(msg), "Name: %s", PlayerOrgName[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Org ID: %d | Rank: %d (%s)", PlayerOrgID[playerid], PlayerOrgRank[playerid], rankName);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (PlayerOrgRank[playerid] >= ORG_RANK_ADMIN)
        {
            SendClientMessage(playerid, COLOR_ORANGE, "Org Admin: /setorgrank [id] [rank], /kickorg [id], /orgwithdraw [amount]");
        }

        if (PlayerOrgRank[playerid] >= ORG_RANK_OWNER)
        {
            SendClientMessage(playerid, COLOR_ORANGE, "Org Owner: /disbandorg");
        }

        SendClientMessage(playerid, COLOR_CYAN, "Command: /orginfo, /orgmembers, /orgbank, /orgdeposit [amount/all], /orgchat [msg].");
        return 1;
    }

    if (strfind(cmdtext, "/inviteorg ", true) == 0)
    {
        if (PlayerOrgID[playerid] <= 0 || PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal admin organisasi untuk invite.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[11], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /inviteorg [playerid]");
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

        if (PlayerOrgID[targetid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Target sudah tergabung dalam organisasi.");
            return 1;
        }

        PlayerOrgInvite[targetid] = playerid;

        new msg[144];
        new inviterName[MAX_PLAYER_NAME];

        GetPlayerName(playerid, inviterName, sizeof(inviterName));

        format(msg, sizeof(msg), "Kamu mengundang player ID %d ke organisasi %s.", targetid, PlayerOrgName[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        format(msg, sizeof(msg), "%s mengundang kamu ke organisasi %s. Gunakan /acceptorg.", inviterName, PlayerOrgName[playerid]);
        SendClientMessage(targetid, COLOR_GREEN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/acceptorg", true))
    {
        if (PlayerOrgID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam organisasi.");
            return 1;
        }

        new inviterid = PlayerOrgInvite[playerid];

        if (inviterid == INVALID_PLAYER_ID || !IsPlayerConnected(inviterid) || PlayerOrgID[inviterid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada invite organisasi aktif.");
            PlayerOrgInvite[playerid] = INVALID_PLAYER_ID;
            return 1;
        }

        new playerName[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO organization_members (org_id, player_id, player_name, rank_level) VALUES (%d, %d, '%e', %d)",
            PlayerOrgID[inviterid],
            PlayerDBID[playerid],
            playerName,
            ORG_RANK_MEMBER
        );

        mysql_tquery(g_SQL, query, "OnOrgInviteAccepted", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/leaveorg", true))
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        if (PlayerOrgRank[playerid] >= ORG_RANK_OWNER)
        {
            SendClientMessage(playerid, COLOR_RED, "Owner tidak bisa leave. Nanti kita buat /disbandorg di v0.13B.");
            return 1;
        }

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM organization_members WHERE player_id=%d LIMIT 1",
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query);

        ResetPlayerOrgData(playerid);

        SendClientMessage(playerid, COLOR_YELLOW, "Kamu keluar dari organisasi.");
        return 1;
    }

    if (strfind(cmdtext, "/orgchat ", true) == 0)
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new message[128];
        format(message, sizeof(message), "%s", cmdtext[9]);

        if (strlen(message) < 1)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /orgchat [message]");
            return 1;
        }

        new playerName[MAX_PLAYER_NAME];
        new msg[160];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(msg, sizeof(msg), "[ORG] %s: %s", playerName, message);
        SendMessageToOrg(PlayerOrgID[playerid], COLOR_CYAN, msg);

        return 1;
    }

    if (strfind(cmdtext, "/oc ", true) == 0)
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new message[128];
        format(message, sizeof(message), "%s", cmdtext[4]);

        new playerName[MAX_PLAYER_NAME];
        new msg[160];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(msg, sizeof(msg), "[ORG] %s: %s", playerName, message);
        SendMessageToOrg(PlayerOrgID[playerid], COLOR_CYAN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/orgmembers", true))
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT player_name, rank_level FROM organization_members WHERE org_id=%d ORDER BY rank_level DESC, player_name ASC LIMIT 20",
            PlayerOrgID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnOrgMembersLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/orginfo", true))
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT o.id, o.name, o.owner_name, o.bank_money, COUNT(om.id) AS member_count FROM organizations o LEFT JOIN organization_members om ON om.org_id = o.id WHERE o.id=%d GROUP BY o.id, o.name, o.owner_name, o.bank_money LIMIT 1",
            PlayerOrgID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnOrgInfoLoaded", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/setorgrank ", true) == 0)
    {
        if (!IsOrgOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner organisasi yang bisa mengubah rank.");
            return 1;
        }

        new targetStr[16];
        new rankStr[16];

        if (!GetTwoParams(cmdtext[12], targetStr, sizeof(targetStr), rankStr, sizeof(rankStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setorgrank [playerid] [rank]");
            SendClientMessage(playerid, COLOR_WHITE, "Rank valid: 1=Member, 3=Admin, 5=Owner");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(rankStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan rank harus angka.");
            return 1;
        }

        new targetid = strval(targetStr);
        new newRank = strval(rankStr);

        if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
            return 1;
        }

        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa mengubah rank diri sendiri.");
            return 1;
        }

        if (PlayerOrgID[targetid] != PlayerOrgID[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target bukan anggota organisasi kamu.");
            return 1;
        }

        if (!IsValidOrgRank(newRank))
        {
            SendClientMessage(playerid, COLOR_RED, "Rank tidak valid. Gunakan 1, 3, atau 5.");
            return 1;
        }

        if (newRank == ORG_RANK_OWNER)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Transfer owner akan dibuat terpisah di v0.13C. Untuk sekarang gunakan rank 1 atau 3.");
            return 1;
        }

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE organization_members SET rank_level=%d WHERE player_id=%d AND org_id=%d LIMIT 1",
            newRank,
            PlayerDBID[targetid],
            PlayerOrgID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnOrgRankUpdated", "iii", playerid, targetid, newRank);
        return 1;
    }

    if (strfind(cmdtext, "/kickorg ", true) == 0)
    {
        if (!IsOrgAdmin(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk kick member.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[9], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kickorg [playerid]");
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
            SendClientMessage(playerid, COLOR_RED, "Gunakan /leaveorg untuk keluar sendiri.");
            return 1;
        }

        if (PlayerOrgID[targetid] != PlayerOrgID[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Target bukan anggota organisasi kamu.");
            return 1;
        }

        if (PlayerOrgRank[targetid] >= ORG_RANK_OWNER)
        {
            SendClientMessage(playerid, COLOR_RED, "Owner tidak bisa dikick.");
            return 1;
        }

        if (PlayerOrgRank[targetid] >= PlayerOrgRank[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak bisa kick anggota dengan rank sama/lebih tinggi.");
            return 1;
        }

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM organization_members WHERE player_id=%d AND org_id=%d LIMIT 1",
            PlayerDBID[targetid],
            PlayerOrgID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnOrgMemberKicked", "ii", playerid, targetid);
        return 1;
    }

    if (!strcmp(cmdtext, "/disbandorg", true))
    {
        if (!IsOrgOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner organisasi yang bisa membubarkan organisasi.");
            return 1;
        }

        new orgid = PlayerOrgID[playerid];
        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM organization_members WHERE org_id=%d",
            orgid
        );
        mysql_tquery(g_SQL, query);

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM organizations WHERE id=%d LIMIT 1",
            orgid
        );
        mysql_tquery(g_SQL, query, "OnOrgDisbanded", "ii", playerid, orgid);

        return 1;
    }

    if (!strcmp(cmdtext, "/orgbank", true))
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new rankName[32];
        new msg[144];

        GetOrgRankName(PlayerOrgRank[playerid], rankName, sizeof(rankName));

        SendClientMessage(playerid, COLOR_YELLOW, "========== ORG BANK ==========");

        format(msg, sizeof(msg), "Organization: %s", PlayerOrgName[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Your Rank: %s (%d)", rankName, PlayerOrgRank[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Org Bank: $%d", PlayerOrgBankMoney[playerid]);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Command: /orgdeposit [amount/all]");

        if (PlayerOrgRank[playerid] >= ORG_RANK_ADMIN)
        {
            SendClientMessage(playerid, COLOR_CYAN, "Admin+: /orgwithdraw [amount]");
        }

        return 1;
    }

    if (strfind(cmdtext, "/orgdeposit ", true) == 0)
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        new amountStr[32];

        if (!GetOneParam(cmdtext[12], amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /orgdeposit [amount/all]");
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

        if (!IsValidOrgBankAmount(amount))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah deposit organisasi tidak valid.");
            return 1;
        }

        if (PlayerMoney[playerid] < amount)
        {
            SendClientMessage(playerid, COLOR_RED, "Cash kamu tidak cukup.");
            return 1;
        }

        TakePlayerCash(playerid, amount);

        new newBank = PlayerOrgBankMoney[playerid] + amount;

        SyncOrgBankMoney(PlayerOrgID[playerid], newBank);
        SaveOrgBankMoney(PlayerOrgID[playerid], newBank);
        SavePlayerData(playerid);

        new playerName[MAX_PLAYER_NAME];
        new msg[160];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(msg, sizeof(msg), "[ORG BANK] %s deposit $%d. Org bank sekarang: $%d.", playerName, amount, newBank);
        SendMessageToOrg(PlayerOrgID[playerid], COLOR_CYAN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/orgdeposit", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /orgdeposit [amount/all]");
        return 1;
    }

    if (strfind(cmdtext, "/orgwithdraw ", true) == 0)
    {
        if (PlayerOrgID[playerid] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam organisasi.");
            return 1;
        }

        if (PlayerOrgRank[playerid] < ORG_RANK_ADMIN)
        {
            SendClientMessage(playerid, COLOR_RED, "Minimal Admin organisasi untuk withdraw.");
            return 1;
        }

        new amountStr[32];

        if (!GetOneParam(cmdtext[13], amountStr, sizeof(amountStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /orgwithdraw [amount]");
            return 1;
        }

        if (!IsNumericString(amountStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Amount harus angka.");
            return 1;
        }

        new amount = strval(amountStr);

        if (!IsValidOrgBankAmount(amount))
        {
            SendClientMessage(playerid, COLOR_RED, "Jumlah withdraw organisasi tidak valid.");
            return 1;
        }

        if (PlayerOrgBankMoney[playerid] < amount)
        {
            SendClientMessage(playerid, COLOR_RED, "Saldo bank organisasi tidak cukup.");
            return 1;
        }

        new newBank = PlayerOrgBankMoney[playerid] - amount;

        SyncOrgBankMoney(PlayerOrgID[playerid], newBank);
        SaveOrgBankMoney(PlayerOrgID[playerid], newBank);

        GivePlayerCash(playerid, amount);
        SavePlayerData(playerid);

        new playerName[MAX_PLAYER_NAME];
        new msg[160];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(msg, sizeof(msg), "[ORG BANK] %s withdraw $%d. Org bank sekarang: $%d.", playerName, amount, newBank);
        SendMessageToOrg(PlayerOrgID[playerid], COLOR_ORANGE, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/orgwithdraw", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /orgwithdraw [amount]");
        return 1;
    }

    if (!strcmp(cmdtext, "/businesses", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== BUSINESSES ==========");

        for (new i = 0; i < MAX_BUSINESSES; i++)
        {
            format(
                msg,
                sizeof(msg),
                "%d. %s | Price: $%d | Income: $%d/min",
                i + 1,
                BusinessName[i],
                BusinessPrice[i],
                BusinessIncomePerMinute[i]
            );
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /findbiz [id] untuk mencari business.");
        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /buybiz [id] saat dekat lokasi business.");
        return 1;
    }

    if (strfind(cmdtext, "/findbiz ", true) == 0)
    {
        new bizStr[16];

        if (!GetOneParam(cmdtext[9], bizStr, sizeof(bizStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /findbiz [business_id]");
            return 1;
        }

        if (!IsNumericString(bizStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Business ID harus angka.");
            return 1;
        }

        new businessIndex = strval(bizStr) - 1;

        if (!IsValidBusinessIndex(businessIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Business ID tidak valid.");
            return 1;
        }

        if (PlayerWorking[playerid] || PlayerRace[playerid] != RACE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan job/race aktif dulu.");
            return 1;
        }

        SetPlayerCheckpoint(
            playerid,
            BusinessX[businessIndex],
            BusinessY[businessIndex],
            BusinessZ[businessIndex],
            BUSINESS_ACCESS_RADIUS
        );

        PlayerFindingBusiness[playerid] = 1;
        PlayerFindingBusinessIndex[playerid] = businessIndex;

        new msg[144];
        format(msg, sizeof(msg), "Checkpoint diarahkan ke business: %s.", BusinessName[businessIndex]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /cancelbiz untuk menghapus checkpoint.");

        return 1;
    }

    if (!strcmp(cmdtext, "/findbiz", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /findbiz [business_id]");
        return 1;
    }

    if (!strcmp(cmdtext, "/cancelbiz", true))
    {
        if (!PlayerFindingBusiness[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang mencari business.");
            return 1;
        }

        DisablePlayerCheckpoint(playerid);
        PlayerFindingBusiness[playerid] = 0;
        PlayerFindingBusinessIndex[playerid] = -1;

        SendClientMessage(playerid, COLOR_YELLOW, "Checkpoint business dihapus.");
        return 1;
    }

    if (strfind(cmdtext, "/buybiz ", true) == 0)
    {
        new bizStr[16];

        if (!GetOneParam(cmdtext[8], bizStr, sizeof(bizStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /buybiz [business_id]");
            return 1;
        }

        if (!IsNumericString(bizStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Business ID harus angka.");
            return 1;
        }

        if (PlayerBusinessDBID[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah punya business. Gunakan /sellbiz dulu.");
            return 1;
        }

        new businessIndex = strval(bizStr) - 1;

        if (!IsValidBusinessIndex(businessIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Business ID tidak valid.");
            return 1;
        }

        if (!IsPlayerNearBusiness(playerid, businessIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat business tersebut untuk membelinya.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /findbiz [id].");
            return 1;
        }

        new price = BusinessPrice[businessIndex];

        if (PlayerMoney[playerid] < price)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Harga business ini $%d.", price);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO player_businesses (owner_id, business_index, business_name, price, income_per_minute, business_level, total_collected, pos_x, pos_y, pos_z, last_collected) VALUES (%d, %d, '%e', %d, %d, 1, 0, %f, %f, %f, NOW())",
            PlayerDBID[playerid],
            businessIndex,
            BusinessName[businessIndex],
            price,
            BusinessIncomePerMinute[businessIndex],
            BusinessX[businessIndex],
            BusinessY[businessIndex],
            BusinessZ[businessIndex]
        );

        mysql_tquery(g_SQL, query, "OnPlayerBusinessBought", "iii", playerid, businessIndex, price);
        return 1;
    }

    if (!strcmp(cmdtext, "/mybiz", true))
    {
        if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
            return 1;
        }

        new businessIndex = PlayerBusinessIndex[playerid];
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== MY BUSINESS ==========");

        format(msg, sizeof(msg), "Business: %s", BusinessName[businessIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "DBID: %d | Price: $%d", PlayerBusinessDBID[playerid], BusinessPrice[businessIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        new currentIncome = GetBusinessIncomePerMinute(businessIndex, PlayerBusinessLevel[playerid]);

        format(msg, sizeof(msg), "Level: %d/%d", PlayerBusinessLevel[playerid], BUSINESS_MAX_LEVEL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Base Income: $%d/min | Current Income: $%d/min", BusinessIncomePerMinute[businessIndex], currentIncome);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Total Collected: $%d | Max collect: $%d", PlayerBusinessTotalCollected[playerid], BUSINESS_MAX_COLLECT);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        if (PlayerBusinessLevel[playerid] < BUSINESS_MAX_LEVEL)
        {
            new upgradeCost = GetBusinessUpgradeCost(PlayerBusinessLevel[playerid]);

            format(msg, sizeof(msg), "Next upgrade cost: $%d. Gunakan /upgradebiz.", upgradeCost);
            SendClientMessage(playerid, COLOR_CYAN, msg);
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREEN, "Business sudah mencapai level maksimal.");
        }

        format(msg, sizeof(msg), "Location: %.2f, %.2f, %.2f", BusinessX[businessIndex], BusinessY[businessIndex], BusinessZ[businessIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Command: /collectbiz, /sellbiz.");
        return 1;
    }

    if (!strcmp(cmdtext, "/collectbiz", true))
    {
        if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
            return 1;
        }

        new query[512];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "SELECT business_index, income_per_minute, business_level, total_collected, TIMESTAMPDIFF(MINUTE, last_collected, NOW()) AS minutes_passed FROM player_businesses WHERE owner_id=%d LIMIT 1",
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnBusinessCollectLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/sellbiz", true))
    {
        if (PlayerBusinessDBID[playerid] <= 0 || PlayerBusinessIndex[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
            return 1;
        }

        new businessIndex = PlayerBusinessIndex[playerid];
        new sellPrice = (BusinessPrice[businessIndex] * BUSINESS_SELL_PERCENT) / 100;
        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "DELETE FROM player_businesses WHERE id=%d AND owner_id=%d LIMIT 1",
            PlayerBusinessDBID[playerid],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnPlayerBusinessSold", "ii", playerid, sellPrice);
        return 1;
    }

    if (!strcmp(cmdtext, "/upgradebiz", true))
    {
        if (!IsBusinessOwner(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu belum punya business.");
            return 1;
        }

        if (PlayerBusinessLevel[playerid] >= BUSINESS_MAX_LEVEL)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Business kamu sudah level maksimal.");
            return 1;
        }

        new cost = GetBusinessUpgradeCost(PlayerBusinessLevel[playerid]);
        new newLevel = PlayerBusinessLevel[playerid] + 1;

        if (PlayerMoney[playerid] < cost)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Biaya upgrade: $%d.", cost);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        TakePlayerCash(playerid, cost);

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE player_businesses SET business_level=%d WHERE id=%d AND owner_id=%d LIMIT 1",
            newLevel,
            PlayerBusinessDBID[playerid],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query, "OnBusinessUpgraded", "iii", playerid, newLevel, cost);
        return 1;
    }

    if (!strcmp(cmdtext, "/biztop", true))
    {
        mysql_tquery(
            g_SQL,
            "SELECT p.username, b.business_name, b.business_level, b.total_collected FROM player_businesses b JOIN players p ON p.id = b.owner_id ORDER BY b.total_collected DESC LIMIT 5",
            "OnBusinessTopLoaded",
            "i",
            playerid
        );
        return 1;
    }

    if (!strcmp(cmdtext, "/dealerships", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== DEALERSHIPS ==========");

        for (new i = 0; i < MAX_DEALERSHIPS; i++)
        {
            format(msg, sizeof(msg), "%d. %s", i + 1, DealershipName[i]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /finddealer untuk mencari dealership terdekat.");
        return 1;
    }

    if (!strcmp(cmdtext, "/finddealer", true))
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

        new nearest = GetNearestDealership(playerid);

        if (nearest == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Dealership tidak ditemukan.");
            return 1;
        }

        SetPlayerCheckpoint(
            playerid,
            DealershipX[nearest],
            DealershipY[nearest],
            DealershipZ[nearest],
            DEALERSHIP_ACCESS_RADIUS
        );

        PlayerFindingDealer[playerid] = 1;

        new msg[144];
        format(msg, sizeof(msg), "Checkpoint diarahkan ke: %s.", DealershipName[nearest]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /canceldealer untuk menghapus checkpoint.");

        return 1;
    }

    if (!strcmp(cmdtext, "/canceldealer", true))
    {
        if (!PlayerFindingDealer[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu tidak sedang mencari dealership.");
            return 1;
        }

        DisablePlayerCheckpoint(playerid);
        PlayerFindingDealer[playerid] = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "Checkpoint dealership dihapus.");
        return 1;
    }

    if (!strcmp(cmdtext, "/vehicleshop", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== VEHICLE SHOP ==========");

        for (new i = 0; i < MAX_SHOP_VEHICLES; i++)
        {
            format(
                msg,
                sizeof(msg),
                "%d. %s | Model: %d | Price: $%d",
                i + 1,
                ShopVehicleName[i],
                ShopVehicleModel[i],
                ShopVehiclePrice[i]
            );
            SendClientMessage(playerid, COLOR_WHITE, msg);
        }

        if (IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_GREEN, "Status: kamu berada dekat dealership.");
        }
        else
        {
            new distance = GetNearestDealershipDistance(playerid);
            format(msg, sizeof(msg), "Status: tidak dekat dealership. Terdekat sekitar %d unit.", distance);
            SendClientMessage(playerid, COLOR_YELLOW, msg);
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer untuk mencari dealership.");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/buyvehicle", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /buyvehicle [shop_id]");
        SendClientMessage(playerid, COLOR_WHITE, "Lihat daftar kendaraan: /vehicleshop");
        return 1;
    }

    if (strfind(cmdtext, "/buyvehicle ", true) == 0)
    {
        new vehicleStr[16];
        new msg[144];

        if (!GetOneParam(cmdtext[12], vehicleStr, sizeof(vehicleStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /buyvehicle [shop_id]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /buyvehicle 1");
            return 1;
        }

        if (!IsNumericString(vehicleStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Vehicle shop ID harus angka.");
            return 1;
        }

        if (!IsPlayerNearDealership(playerid))
        {
            new distance = GetNearestDealershipDistance(playerid);

            format(msg, sizeof(msg), "Kamu harus berada dekat dealership. Dealership terdekat sekitar %d unit.", distance);
            SendClientMessage(playerid, COLOR_RED, msg);
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer.");
            return 1;
        }

        new freeSlot = GetFreeGarageSlot(playerid);

        if (freeSlot == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Garage penuh. Jual salah satu kendaraan dengan /sellveh [slot].");
            return 1;
        }

        new shopIndex = strval(vehicleStr) - 1;

        if (!IsValidShopVehicleIndex(shopIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Vehicle shop ID tidak valid.");
            return 1;
        }

        new modelid = ShopVehicleModel[shopIndex];
        new price = ShopVehiclePrice[shopIndex];

        if (PlayerMoney[playerid] < price)
        {
            format(msg, sizeof(msg), "Cash tidak cukup. Harga %s adalah $%d.", ShopVehicleName[shopIndex], price);
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
            "INSERT INTO player_vehicles (owner_id, slot, model_id, vehicle_name, color1, color2, pos_x, pos_y, pos_z, pos_a, health, fuel, locked) VALUES (%d, %d, %d, '%e', 1, 1, %f, %f, %f, %f, 1000.0, 100, 0)",
            PlayerDBID[playerid],
            freeSlot + 1,
            modelid,
            ShopVehicleName[shopIndex],
            x + 3.0,
            y,
            z,
            a
        );

        mysql_tquery(g_SQL, query, "OnGarageVehicleBought", "iiii", playerid, freeSlot, modelid, price);
        return 1;
    }

    if (!strcmp(cmdtext, "/garage", true))
    {
        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== GARAGE ==========");

        for (new i = 0; i < MAX_GARAGE_SLOTS; i++)
        {
            if (PlayerGarageDBID[playerid][i] > 0)
            {
                format(
                    msg,
                    sizeof(msg),
                    "Slot %d: %s | Model %d | Fuel %d | HP %.0f",
                    i + 1,
                    PlayerGarageName[playerid][i],
                    PlayerGarageModel[playerid][i],
                    PlayerGarageFuel[playerid][i],
                    PlayerGarageHealth[playerid][i]
                );
                SendClientMessage(playerid, COLOR_WHITE, msg);
            }
            else
            {
                format(msg, sizeof(msg), "Slot %d: Empty", i + 1);
                SendClientMessage(playerid, COLOR_WHITE, msg);
            }
        }

        format(msg, sizeof(msg), "Active slot: %d", OwnedVehicleSlot[playerid] + 1);
        SendClientMessage(playerid, COLOR_CYAN, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /myveh [slot], /park, /lock, /sellveh [slot].");
        return 1;
    }

    if (!strcmp(cmdtext, "/vehstatus", true))
    {
        if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif. Gunakan /garage dan /myveh [slot].");
            return 1;
        }

        new msg[144];
        new Float:health = OwnedVehicleHealth[playerid];

        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            GetVehicleHealth(OwnedVehicleID[playerid], health);
            OwnedVehicleHealth[playerid] = health;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "========== VEHICLE STATUS ==========");

        format(msg, sizeof(msg), "Slot: %d | Name: %s", OwnedVehicleSlot[playerid] + 1, OwnedVehicleName[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Model: %d | DBID: %d", OwnedVehicleModel[playerid], OwnedVehicleDBID[playerid]);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Health: %.1f/1000 | Fuel: %d/%d", health, OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Locked: %s", OwnedVehicleLocked[playerid] ? ("Yes") : ("No"));
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Fuel consumption: %d fuel / %d detik", FUEL_CONSUME_AMOUNT, FUEL_TIMER_INTERVAL / 1000);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        return 1;
    }


    if (!strcmp(cmdtext, "/fuelinfo", true))
    {
        if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif. Gunakan /garage dan /myveh [slot].");
            return 1;
        }

        new msg[144];

        SendClientMessage(playerid, COLOR_YELLOW, "========== FUEL INFO ==========");

        format(msg, sizeof(msg), "Vehicle: %s | Slot: %d", OwnedVehicleName[playerid], OwnedVehicleSlot[playerid] + 1);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Fuel: %d/%d", OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Consumption: %d fuel setiap %d detik saat dikendarai.", FUEL_CONSUME_AMOUNT, FUEL_TIMER_INTERVAL / 1000);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Refuel di dealership: /finddealer lalu /refuelveh.");
        return 1;
    }

    if (strfind(cmdtext, "/setfuel ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menggunakan command ini.");
            return 1;
        }

        if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif.");
            return 1;
        }

        new fuelStr[16];

        if (!GetOneParam(cmdtext[9], fuelStr, sizeof(fuelStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setfuel [0-100]");
            return 1;
        }

        if (!IsNumericString(fuelStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Fuel harus angka.");
            return 1;
        }

        new fuel = strval(fuelStr);

        if (fuel < 0 || fuel > VEHICLE_MAX_FUEL)
        {
            SendClientMessage(playerid, COLOR_RED, "Fuel harus 0 sampai 100.");
            return 1;
        }

        OwnedVehicleFuel[playerid] = fuel;
        SyncActiveVehicleFuelToGarage(playerid);
        SaveActiveVehicleFuel(playerid);

        if (fuel <= 0 && OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            StopVehicleEngineDueFuel(playerid);
        }
        else if (fuel > 0 && OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            ApplyOwnedVehicleParams(playerid);
        }

        new msg[144];
        format(msg, sizeof(msg), "Fuel kendaraan aktif diset menjadi %d/%d.", OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/setfuel", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menggunakan command ini.");
            return 1;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setfuel [0-100]");
        return 1;
    }

    if (strfind(cmdtext, "/renameveh ", true) == 0)
    {
        new slotStr[16];
        new newName[32];

        if (!GetFirstParamAndRest(cmdtext[11], slotStr, sizeof(slotStr), newName, sizeof(newName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /renameveh [slot] [name]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /renameveh 1 Infernus Merah");
            return 1;
        }

        if (!IsNumericString(slotStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot harus angka.");
            return 1;
        }

        if (strlen(newName) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Nama kendaraan minimal 3 karakter.");
            return 1;
        }

        new slotIndex = strval(slotStr) - 1;

        if (!IsValidGarageSlot(slotIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Slot tidak valid.");
            return 1;
        }

        if (PlayerGarageDBID[playerid][slotIndex] <= 0)
        {
            SendClientMessage(playerid, COLOR_RED, "Slot garage ini kosong.");
            return 1;
        }

        format(PlayerGarageName[playerid][slotIndex], 32, "%s", newName);

        if (OwnedVehicleSlot[playerid] == slotIndex)
        {
            format(OwnedVehicleName[playerid], 32, "%s", newName);

            if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
            {
                CreateOwnedVehicleLabel(playerid);
            }
        }

        new query[256];

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "UPDATE player_vehicles SET vehicle_name='%e' WHERE id=%d AND owner_id=%d LIMIT 1",
            newName,
            PlayerGarageDBID[playerid][slotIndex],
            PlayerDBID[playerid]
        );

        mysql_tquery(g_SQL, query);

        new msg[144];
        format(msg, sizeof(msg), "Kendaraan slot %d berhasil diberi nama: %s.", slotIndex + 1, newName);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        return 1;
    }

    if (!strcmp(cmdtext, "/renameveh", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /renameveh [slot] [name]");
        return 1;
    }

    if (!strcmp(cmdtext, "/repairveh", true))
    {
        if (OwnedVehicleID[playerid] == INVALID_VEHICLE_ID || OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif yang sedang spawn.");
            return 1;
        }

        if (!IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk repair kendaraan.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer.");
            return 1;
        }

        if (PlayerMoney[playerid] < VEHICLE_REPAIR_COST)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Biaya repair: $%d.", VEHICLE_REPAIR_COST);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        TakePlayerCash(playerid, VEHICLE_REPAIR_COST);

        SetVehicleHealth(OwnedVehicleID[playerid], 1000.0);
        OwnedVehicleHealth[playerid] = 1000.0;

        if (IsValidGarageSlot(OwnedVehicleSlot[playerid]))
        {
            PlayerGarageHealth[playerid][OwnedVehicleSlot[playerid]] = 1000.0;
        }

        SaveActiveVehicleMeta(playerid);
        SavePlayerData(playerid);

        SendClientMessage(playerid, COLOR_GREEN, "Kendaraan berhasil diperbaiki.");
        return 1;
    }

    if (!strcmp(cmdtext, "/refuelveh", true))
    {
        if (OwnedVehicleDBID[playerid] <= 0 || OwnedVehicleSlot[playerid] == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Tidak ada kendaraan aktif.");
            return 1;
        }

        if (!IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat dealership untuk refuel kendaraan.");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /finddealer.");
            return 1;
        }

        if (OwnedVehicleFuel[playerid] >= VEHICLE_MAX_FUEL)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Fuel kendaraan sudah penuh.");
            return 1;
        }

        new needFuel = VEHICLE_MAX_FUEL - OwnedVehicleFuel[playerid];
        new cost = needFuel * VEHICLE_REFUEL_COST_PER_POINT;

        if (PlayerMoney[playerid] < cost)
        {
            new msg[144];
            format(msg, sizeof(msg), "Cash tidak cukup. Biaya full refuel: $%d.", cost);
            SendClientMessage(playerid, COLOR_RED, msg);
            return 1;
        }

        TakePlayerCash(playerid, cost);

        OwnedVehicleFuel[playerid] = VEHICLE_MAX_FUEL;

        if (IsValidGarageSlot(OwnedVehicleSlot[playerid]))
        {
            PlayerGarageFuel[playerid][OwnedVehicleSlot[playerid]] = VEHICLE_MAX_FUEL;
        }

        if (OwnedVehicleID[playerid] != INVALID_VEHICLE_ID)
        {
            ApplyOwnedVehicleParams(playerid);
        }

        SaveActiveVehicleMeta(playerid);
        SavePlayerData(playerid);

        new msg[144];
        format(msg, sizeof(msg), "Refuel berhasil. Biaya: $%d. Fuel sekarang: %d/%d.", cost, OwnedVehicleFuel[playerid], VEHICLE_MAX_FUEL);
        SendClientMessage(playerid, COLOR_GREEN, msg);

        return 1;
    }


    if (strfind(cmdtext, "/wladd ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menambah whitelist beta.");
            return 1;
        }

        new targetName[24];

        if (!GetOneParam(cmdtext[7], targetName, sizeof(targetName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wladd [username]");
            return 1;
        }

        new adminName[MAX_PLAYER_NAME];
        new query[512];

        GetPlayerName(playerid, adminName, sizeof(adminName));

        mysql_format(
            g_SQL,
            query,
            sizeof(query),
            "INSERT INTO beta_whitelist (username, added_by, note, active) VALUES ('%e', '%e', 'manual_add', 1) ON DUPLICATE KEY UPDATE added_by='%e', note='manual_add', active=1, updated_at=NOW()",
            targetName,
            adminName,
            adminName
        );

        mysql_tquery(g_SQL, query, "OnWhitelistAdded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/wladd", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wladd [username]");
        return 1;
    }

    if (strfind(cmdtext, "/wlremove ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menonaktifkan whitelist beta.");
            return 1;
        }

        new targetName[24];

        if (!GetOneParam(cmdtext[10], targetName, sizeof(targetName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wlremove [username]");
            return 1;
        }

        format(PlayerLastWhitelistQuery[playerid], 24, "%s", targetName);

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE beta_whitelist SET active=0, updated_at=NOW() WHERE username='%e' LIMIT 1", targetName);
        mysql_tquery(g_SQL, query, "OnWhitelistRemoved", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/wlremove", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wlremove [username]");
        return 1;
    }

    if (strfind(cmdtext, "/wlcheck ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new targetName[24];

        if (!GetOneParam(cmdtext[9], targetName, sizeof(targetName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wlcheck [username]");
            return 1;
        }

        format(PlayerLastWhitelistQuery[playerid], 24, "%s", targetName);

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "SELECT username, active, added_by, created_at FROM beta_whitelist WHERE username='%e' LIMIT 1", targetName);
        mysql_tquery(g_SQL, query, "OnWhitelistCheckLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/wlcheck", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /wlcheck [username]");
        return 1;
    }

    if (!strcmp(cmdtext, "/whitelist", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT username, added_by, created_at FROM beta_whitelist WHERE active=1 ORDER BY id DESC LIMIT 10", "OnWhitelistListLoaded", "i", playerid);
        return 1;
    }


    if (!strcmp(cmdtext, "/betastatus", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new uptimeText[64];
        new msg[144];
        new adminCount = 0;

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] > 0)
            {
                adminCount++;
            }
        }

        FormatUptime(GetTickCount() - g_ServerStartTick, uptimeText, sizeof(uptimeText));

        SendClientMessage(playerid, COLOR_YELLOW, "========== CLOSED BETA STATUS ==========");

        format(msg, sizeof(msg), "Gamemode: LSIF Dev v0.17H Map Markers");
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Uptime: %s", uptimeText);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        format(msg, sizeof(msg), "Players: %d online | %d logged | Admins: %d", CountOnlinePlayers(), CountLoggedPlayers(), adminCount);
        SendClientMessage(playerid, COLOR_WHITE, msg);

        SendClientMessage(playerid, COLOR_CYAN, "Dashboard: /playerlist, /onlineadmins, /recentbugs, /recentreports, /recentfeedback, /recentlogs");
        return 1;
    }

    if (!strcmp(cmdtext, "/playerlist", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new name[MAX_PLAYER_NAME];
        new msg[144];
        new found = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "========== ONLINE PLAYERS ==========");

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i))
            {
                GetPlayerName(i, name, sizeof(name));
                format(msg, sizeof(msg), "[%d] %s | Login: %d | Admin: %d | DBID: %d", i, name, PlayerLoggedIn[i], PlayerAdmin[i], PlayerDBID[i]);
                SendClientMessage(playerid, COLOR_WHITE, msg);
                found++;
            }
        }

        if (!found)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tidak ada player online.");
        }

        return 1;
    }

    if (!strcmp(cmdtext, "/onlineadmins", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        new name[MAX_PLAYER_NAME];
        new rankName[32];
        new msg[144];
        new found = 0;

        SendClientMessage(playerid, COLOR_YELLOW, "========== ONLINE ADMINS ==========");

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerAdmin[i] > 0)
            {
                GetPlayerName(i, name, sizeof(name));
                GetAdminRankName(PlayerAdmin[i], rankName, sizeof(rankName));

                format(msg, sizeof(msg), "[%d] %s | Level %d | %s", i, name, PlayerAdmin[i], rankName);
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

    if (!strcmp(cmdtext, "/recentbugs", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT id, reporter_name, message FROM feedback_reports WHERE type='bug' AND status='open' ORDER BY id DESC LIMIT 5", "OnRecentBugsLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/recentfeedback", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT id, reporter_name, type, message FROM feedback_reports WHERE status='open' ORDER BY id DESC LIMIT 5", "OnRecentFeedbackLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/recentreports", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT id, reporter_name, target_name, reason FROM reports WHERE status='open' ORDER BY id DESC LIMIT 5", "OnRecentReportsLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/recentlogs", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_HELPER))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu bukan admin.");
            return 1;
        }

        mysql_tquery(g_SQL, "SELECT id, admin_name, target_name, action, detail FROM admin_logs ORDER BY id DESC LIMIT 5", "OnRecentLogsLoaded", "i", playerid);
        return 1;
    }

    SendClientMessage(playerid, COLOR_RED, "Command tidak ditemukan. Gunakan /help.");
    return 1;
}
