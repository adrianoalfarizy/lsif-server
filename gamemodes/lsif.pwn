#include <open.mp>
#include <a_mysql>
#pragma dynamic 131072

#define COLOR_WHITE     0xFFFFFFFF
#define COLOR_GREEN     0x00FF00FF
#define COLOR_RED       0xFF0000FF
#define COLOR_YELLOW    0xFFFF00FF
#define COLOR_CYAN      0x00FFFFFF
#define COLOR_ORANGE    0xFF9900FF
#define COLOR_GRAY      0xAAAAAAFF
#define COLOR_PURPLE    0xAA66CCFF

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
#define DIALOG_JOB_GUIDE_MENU 1059
#define DIALOG_JOB_GUIDE_DETAIL 1060
#define DIALOG_WEAPON_SHOP 1061
#define DIALOG_WEAPON_CONFIRM 1062
#define DIALOG_WEAPON_INFO 1063
#define DIALOG_LOADOUT_INFO 1064
#define DIALOG_WEAPON_LICENSE 1065
#define DIALOG_GANG_MENU 1066
#define DIALOG_GANG_INFO 1067
#define DIALOG_TURF_MAP 1068
#define DIALOG_GANG_COLOR 1069
#define DIALOG_GANG_CREATE_INPUT 1070
#define DIALOG_GANG_MEMBERS 1071
#define DIALOG_GANG_INVITE 1072
#define DIALOG_GANG_LEAVE_CONFIRM 1073
#define DIALOG_GANG_DISBAND_CONFIRM 1074
#define DIALOG_GANG_LIST 1075
#define DIALOG_GANG_HQ_MENU 1076
#define DIALOG_GANG_KICK_INPUT 1077
#define DIALOG_GANG_KICK_CONFIRM 1078
#define DIALOG_GANG_SETRANK_INPUT 1079
#define DIALOG_NEARBY_INTERACTION 1080
#define DIALOG_LOC_MENU 1081
#define DIALOG_LOC_CREATE_TYPE 1082
#define DIALOG_LOC_CREATE_NAME 1083
#define DIALOG_LOC_LIST 1084
#define DIALOG_LOC_ICON_PRESETS 1085
#define DIALOG_DYNAMIC_LOCATION_INFO 1086


#define MAX_NEARBY_INTERACTIONS 8
#define INTERACT_TYPE_ATM 1
#define INTERACT_TYPE_DEALERSHIP 2
#define INTERACT_TYPE_AMMUNATION 3
#define INTERACT_TYPE_GANG_HQ 4
#define INTERACT_TYPE_HOUSE 5
#define INTERACT_TYPE_BUSINESS 6
#define INTERACT_TYPE_DYNAMIC_LOCATION 7


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
#define JOB_BUS         4
#define JOB_POLICE      5

#define WORK_NONE       0
#define WORK_COURIER    1
#define WORK_TAXI       2
#define WORK_TRUCKER    3
#define WORK_BUS        4
#define WORK_POLICE     5

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

#define VEHICLE_BUS       431
#define VEHICLE_COACH     437

#define VEHICLE_POLICE_LS 596
#define VEHICLE_POLICE_SF 597
#define VEHICLE_POLICE_LV 598
#define VEHICLE_POLICE_RANGER 599
#define VEHICLE_POLICE_BIKE 523
#define VEHICLE_ENFORCER 427

#define MAX_BUS_STOPS 6
#define BUS_COOLDOWN_SECONDS 45
#define BUS_REWARD_PER_STOP 180
#define BUS_XP_PER_STOP 12
#define BUS_COMPLETE_BONUS 500
#define BUS_COMPLETE_XP_BONUS 35

#define MAX_POLICE_TARGETS 6
#define POLICE_COOLDOWN_SECONDS 60
#define POLICE_BASE_REWARD 900
#define POLICE_BASE_XP 55

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

#define MAX_TERRITORIES 6
#define TERRITORY_ACCESS_RADIUS 80.0
#define TERRITORY_ZONE_ALPHA 0x55
#define DEFAULT_GANG_COLOR 0xFFFFFFFF
#define MAX_GANG_COLOR_PRESETS 8
#define MAX_PRESET_GANGS 4
#define GANG_HQ_ACCESS_RADIUS 8.0
#define GANG_CREATE_PRICE 75000 // deprecated after v0.20A.2

#define GANG_RANK_NONE      0
#define GANG_RANK_MEMBER    1
#define GANG_RANK_SOLDIER   2
#define GANG_RANK_ENFORCER  3
#define GANG_RANK_UNDERBOSS 4
#define GANG_RANK_LEADER    5

#define MAX_BUSINESSES 5
#define BUSINESS_ACCESS_RADIUS 5.0
#define BUSINESS_SELL_PERCENT 70
#define BUSINESS_MAX_COLLECT 500000

#define BUSINESS_MAX_LEVEL 5
#define BUSINESS_UPGRADE_BASE_COST 50000
#define BUSINESS_UPGRADE_COST_MULTIPLIER 2

#define MAX_DEALERSHIPS 3
#define DEALERSHIP_ACCESS_RADIUS 8.0

#define MAX_AMMUNATIONS 3
#define AMMUNATION_ACCESS_RADIUS 7.0
#define MAX_WEAPON_SHOP_ITEMS 9
#define MAX_SAVED_WEAPON_LOADOUT MAX_WEAPON_SHOP_ITEMS
#define DEFAULT_WEAPON_LICENSE 1

#define MAX_SHOP_VEHICLES 12

#define WORLD_MARKER_PICKUP_MODEL 1239
#define WORLD_MARKER_PICKUP_TYPE 1
#define WORLD_LABEL_DRAW_DISTANCE 22.0

#define MAPICON_BASE_ATM 0
#define MAPICON_BASE_HOUSE 8
#define MAPICON_BASE_BUSINESS 16
#define MAPICON_BASE_DEALER 24
#define MAPICON_BASE_RACE 35
#define MAPICON_BASE_JOB 40
#define MAPICON_BASE_BUS_STOP 48
#define MAPICON_BASE_AMMUNATION 30
#define MAPICON_BASE_TERRITORY 58
#define MAPICON_BASE_GANG_HQ 70

#define MAPICON_TYPE_ATM 52
#define MAPICON_TYPE_HOUSE 31
#define MAPICON_TYPE_BUSINESS 52
#define MAPICON_TYPE_DEALER 55
#define MAPICON_TYPE_RACE 53
#define MAPICON_TYPE_JOB 51
#define MAPICON_TYPE_BUS_STOP 55
#define MAPICON_TYPE_AMMUNATION 6
#define MAPICON_TYPE_TERRITORY 19
#define MAPICON_TYPE_GANG_HQ 19

#define MAX_DYNAMIC_LOCATIONS 15
#define MAPICON_BASE_DYNAMIC 80
#define LOC_TYPE_SIZE 24
#define LOC_NAME_SIZE 64
#define LOC_LABEL_SIZE 96
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
new PlayerAuthDialogShown[MAX_PLAYERS];

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
new PlayerBusStop[MAX_PLAYERS];
new PlayerPoliceTarget[MAX_PLAYERS];

new Float:BusStopX[MAX_BUS_STOPS] =
{
    1807.9344,
    1672.5364,
    1369.8120,
    1195.1022,
    1529.5574,
    1807.9344
};

new Float:BusStopY[MAX_BUS_STOPS] =
{
    -1908.1141,
        -1734.7712,
        -1579.4437,
        -1324.8833,
        -1030.2186,
        -1908.1141
    };

new Float:BusStopZ[MAX_BUS_STOPS] =
{
    13.5781,
    13.5469,
    13.5469,
    13.3984,
    23.9063,
    13.5781
};

new BusStopName[MAX_BUS_STOPS][48] =
{
    "Unity Station",
    "Commerce",
    "Pershing Square",
    "Market",
    "Mulholland",
    "Unity Station Return"
};

new Float:PoliceTargetX[MAX_POLICE_TARGETS] =
{
    2185.2810,
    1942.9137,
    1525.7268,
    1131.3441,
    2407.8320,
    2695.3125
};

new Float:PoliceTargetY[MAX_POLICE_TARGETS] =
{
    -1677.2144,
        -2124.5295,
        -1675.2481,
        -1370.4922,
        -1238.7169,
        -1704.3347
    };

new Float:PoliceTargetZ[MAX_POLICE_TARGETS] =
{
    15.0859,
    13.5469,
    13.5469,
    13.7357,
    24.0000,
    11.8438
};

new PoliceTargetName[MAX_POLICE_TARGETS][48] =
{
    "Idlewood disturbance",
    "Willowfield suspect",
    "Commerce pursuit call",
    "Market incident",
    "East LS robbery call",
    "Ganton backup call"
};

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
new PlayerOrgColor[MAX_PLAYERS]; // deprecated/unused after v0.20A.1, kept for safe compatibility
new PlayerSelectedOrgTarget[MAX_PLAYERS];

new PlayerGangID[MAX_PLAYERS];
new PlayerGangRank[MAX_PLAYERS];
new PlayerGangInvite[MAX_PLAYERS];
new PlayerGangName[MAX_PLAYERS][64];
new PlayerPendingGangName[MAX_PLAYERS][64];
new PlayerGangColor[MAX_PLAYERS];
new PlayerSelectedGangTarget[MAX_PLAYERS];
new PlayerDialogTerritoryIndex[MAX_PLAYERS];
new PlayerDialogGangID[MAX_PLAYERS];
new PlayerNearbyInteractionCount[MAX_PLAYERS];
new PlayerNearbyInteractionType[MAX_PLAYERS][MAX_NEARBY_INTERACTIONS];
new PlayerNearbyInteractionParam[MAX_PLAYERS][MAX_NEARBY_INTERACTIONS];
new PlayerNearbyInteractionLabel[MAX_PLAYERS][MAX_NEARBY_INTERACTIONS][64];

new GangHQPickup[MAX_PRESET_GANGS];
new Text3D:GangHQLabel[MAX_PRESET_GANGS];

new TerritoryPickup[MAX_TERRITORIES];
new Text3D:TerritoryLabel[MAX_TERRITORIES];
new TerritoryZone[MAX_TERRITORIES];
new TerritoryOwnerGangID[MAX_TERRITORIES];
new TerritoryOwnerColor[MAX_TERRITORIES];
new TerritoryOwnerName[MAX_TERRITORIES][64];

new Float:TerritoryX[MAX_TERRITORIES] =
{
    2229.3215,
    1833.8134,
    1368.9248,
    2421.5427,
    1000.5822,
    1554.8425
};

new Float:TerritoryY[MAX_TERRITORIES] =
{
    -1159.7343,
        -1842.4136,
        -1279.6914,
        -1224.3597,
        -919.9146,
        -1675.6542
    };

new Float:TerritoryZ[MAX_TERRITORIES] =
{
    25.7331,
    13.5781,
    13.5469,
    25.3828,
    42.3281,
    16.1953
};

new Float:TerritoryRadius[MAX_TERRITORIES] =
{
    110.0,
    120.0,
    100.0,
    110.0,
    120.0,
    90.0
};

new TerritoryName[MAX_TERRITORIES][64] =
{
    "Ganton Block",
    "Idlewood District",
    "Market Strip",
    "East Los Santos",
    "Vinewood Hills",
    "Pershing Square"
};

new GangColorValue[MAX_GANG_COLOR_PRESETS] =
{
    0xFFFFFFFF,
    0xFF0000FF,
    0x00FF00FF,
    0x00FFFFFF,
    0xFFFF00FF,
    0xFF9900FF,
    0xAA66CCFF,
    0xAAAAAAFF
};

new GangColorName[MAX_GANG_COLOR_PRESETS][24] =
{
    "White",
    "Red",
    "Green",
    "Cyan",
    "Yellow",
    "Orange",
    "Purple",
    "Gray"
};

new PresetGangID[MAX_PRESET_GANGS] =
{
    1,
    2,
    3,
    4
};

new PresetGangName[MAX_PRESET_GANGS][64] =
{
    "Grove Street Families",
    "Ballas",
    "Los Santos Vagos",
    "Varrios Los Aztecas"
};

new PresetGangShortName[MAX_PRESET_GANGS][24] =
{
    "Grove",
    "Ballas",
    "Vagos",
    "Aztecas"
};

new PresetGangColor[MAX_PRESET_GANGS] =
{
    0x00FF00FF, // Grove green
    0xAA66CCFF, // Ballas purple
    0xFFFF00FF, // Vagos yellow
    0x00FFFFFF  // Aztecas turquoise
};

new PresetGangColorName[MAX_PRESET_GANGS][24] =
{
    "Green",
    "Purple",
    "Yellow",
    "Turquoise"
};

new Float:GangHQX[MAX_PRESET_GANGS] =
{
    2495.4094, // Grove Street / Ganton
    2229.3215, // Ballas / Glen Park-Idlewood
    2421.5427, // Vagos / East LS
    1766.6000  // Aztecas / El Corona
};

new Float:GangHQY[MAX_PRESET_GANGS] =
{
    -1686.1682,
        -1159.7343,
        -1224.3597,
        -1918.3000
    };

new Float:GangHQZ[MAX_PRESET_GANGS] =
{
    13.5153,
    25.7331,
    25.3828,
    13.5600
};

new GangHQName[MAX_PRESET_GANGS][64] =
{
    "Grove Street HQ",
    "Ballas HQ",
    "Los Santos Vagos HQ",
    "Varrios Los Aztecas HQ"
};

new DynamicLocationCount;
new DynamicLocationDBID[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationEnabled[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationMapIcon[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationPickupModel[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationInterior[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationVirtualWorld[MAX_DYNAMIC_LOCATIONS];
new Float:DynamicLocationX[MAX_DYNAMIC_LOCATIONS];
new Float:DynamicLocationY[MAX_DYNAMIC_LOCATIONS];
new Float:DynamicLocationZ[MAX_DYNAMIC_LOCATIONS];
new Float:DynamicLocationA[MAX_DYNAMIC_LOCATIONS];
new Float:DynamicLocationRadius[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationType[MAX_DYNAMIC_LOCATIONS][LOC_TYPE_SIZE];
new DynamicLocationName[MAX_DYNAMIC_LOCATIONS][LOC_NAME_SIZE];
new DynamicLocationLabelText[MAX_DYNAMIC_LOCATIONS][LOC_LABEL_SIZE];
new DynamicLocationPickup[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationObjectModel[MAX_DYNAMIC_LOCATIONS];
new DynamicLocationObjectID[MAX_DYNAMIC_LOCATIONS];
new Text3D:DynamicLocation3DLabel[MAX_DYNAMIC_LOCATIONS];

new PlayerPendingLocCreateType[MAX_PLAYERS][LOC_TYPE_SIZE];

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
new PlayerDialogWeaponIndex[MAX_PLAYERS];
new PlayerWeaponLicense[MAX_PLAYERS];
new PlayerSavedWeaponOwned[MAX_PLAYERS][MAX_SAVED_WEAPON_LOADOUT];
new PlayerSavedWeaponAmmo[MAX_PLAYERS][MAX_SAVED_WEAPON_LOADOUT];

new BankPointPickup[MAX_BANK_POINTS];
new Text3D:BankPointLabel[MAX_BANK_POINTS];

new DealershipPickup[MAX_DEALERSHIPS];
new Text3D:DealershipLabel[MAX_DEALERSHIPS];

new AmmuNationPickup[MAX_AMMUNATIONS];
new Text3D:AmmuNationLabel[MAX_AMMUNATIONS];

new BusinessPickup[MAX_BUSINESSES];
new Text3D:BusinessLabel[MAX_BUSINESSES];

new Text3D:HouseExteriorLabel[MAX_HOUSES];
new RaceStartPickup;
new Text3D:RaceStartLabel;

#define MAX_JOB_WORLD_MARKERS 5

new JobWorldPickup[MAX_JOB_WORLD_MARKERS];
new Text3D:JobWorldLabel[MAX_JOB_WORLD_MARKERS];

new BusStopPickup[MAX_BUS_STOPS];
new Text3D:BusStopLabel[MAX_BUS_STOPS];

new Float:JobWorldX[MAX_JOB_WORLD_MARKERS] =
{
    2112.8467, // Taxi / vehicle mission stand
    2102.8870, // Courier depot
    2460.3918, // Trucker cargo depot
    1807.9344, // Bus terminal
    1554.8425  // LSPD / Vigilante point
};

new Float:JobWorldY[MAX_JOB_WORLD_MARKERS] =
{
    -1788.3153,
        -1806.4775,
        -2114.8193,
        -1908.1141,
        -1675.6542
    };

new Float:JobWorldZ[MAX_JOB_WORLD_MARKERS] =
{
    13.5547,
    13.5547,
    13.5469,
    13.5781,
    16.1953
};

new JobWorldName[MAX_JOB_WORLD_MARKERS][48] =
{
    "Taxi Mission Stand",
    "Courier Depot",
    "Trucker Cargo Depot",
    "Bus Terminal",
    "Police Vigilante HQ"
};

new JobWorldGuide[MAX_JOB_WORLD_MARKERS][96] =
{
    "Naik Taxi/Cabbie lalu tekan tombol 2 untuk Taxi Mission.",
    "Naik Burrito/Boxville/Mule/Pony/Rumpo lalu tekan tombol 2 untuk Courier.",
    "Naik truck valid lalu tekan tombol 2 untuk Trucker Mission.",
    "Naik Bus/Coach lalu tekan tombol 2 untuk Bus Route.",
    "Naik kendaraan polisi lalu tekan tombol 2 untuk Vigilante Mission."
};

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

new Float:AmmuNationX[MAX_AMMUNATIONS] =
{
    1368.7429, // Market Ammu-Nation
    2400.4875, // Willowfield Ammu-Nation
    242.0057   // Blueberry Ammu-Nation / fallback area
};

new Float:AmmuNationY[MAX_AMMUNATIONS] =
{
    -1279.8015,
        -1981.9600,
        -178.1069
    };

new Float:AmmuNationZ[MAX_AMMUNATIONS] =
{
    13.5469,
    13.5469,
    1.5781
};

new AmmuNationName[MAX_AMMUNATIONS][64] =
{
    "Market Ammu-Nation",
    "Willowfield Ammu-Nation",
    "Blueberry Ammu-Nation"
};

new WeaponShopWeaponID[MAX_WEAPON_SHOP_ITEMS] =
{
    22, // Colt 45
    23, // Silenced Pistol
    24, // Desert Eagle
    25, // Shotgun
    28, // Micro SMG
    29, // MP5
    30, // AK-47
    31, // M4
    33  // Rifle
};

new WeaponShopAmmo[MAX_WEAPON_SHOP_ITEMS] =
{
    60,
    60,
    35,
    40,
    150,
    150,
    180,
    180,
    40
};

new WeaponShopPrice[MAX_WEAPON_SHOP_ITEMS] =
{
    2500,
    4500,
    7000,
    6000,
    9000,
    12000,
    15000,
    18000,
    10000
};

new WeaponShopName[MAX_WEAPON_SHOP_ITEMS][32] =
{
    "Colt 45",
    "Silenced Pistol",
    "Desert Eagle",
    "Shotgun",
    "Micro SMG",
    "MP5",
    "AK-47",
    "M4",
    "Rifle"
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
forward EnsureAuthDialog(playerid);
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
forward OnPlayerWeaponsLoaded(playerid);
forward ApplySavedWeaponLoadout(playerid);
forward OnGangTerritoriesLoaded();
forward OnGangTerritoryGangLookup(playerid, territoryIndex, gangid);
forward OnGangColorUpdated(playerid, colorIndex);
forward OnPlayerGangLoaded(playerid);
forward OnGangCreated(playerid);
forward OnGangInviteAccepted(playerid);
forward OnGangMembersLoaded(playerid);
forward OnGangListLoaded(playerid);
forward OnDynamicLocationsLoaded();
forward OnDynamicLocationCreated(playerid);
forward OnDynamicLocationUpdated(playerid);
forward OnDynamicLocationDeleted(playerid);
forward OnDynamicLocationPurged(playerid);



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
    PlayerAuthDialogShown[playerid] = 0;

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
    ResetPlayerGangData(playerid);
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
    ResetBusWorkData(playerid);
    ResetPoliceWorkData(playerid);

    PlayerLastX[playerid] = SPAWN_X;
    PlayerLastY[playerid] = SPAWN_Y;
    PlayerLastZ[playerid] = SPAWN_Z;
    PlayerLastA[playerid] = SPAWN_A;

    PlayerMoneyMismatchCount[playerid] = 0;
    PlayerLastACWarningTick[playerid] = 0;
    format(PlayerLastWhitelistQuery[playerid], 24, "-");
    PlayerStarterPackClaimed[playerid] = 0;
    PlayerWeaponLicense[playerid] = DEFAULT_WEAPON_LICENSE;
    ResetPlayerWeaponLoadoutData(playerid);

    SyncPlayerMoneyHUD(playerid);
    return 1;
}

stock ShowRegisterDialog(playerid)
{
    PlayerAuthDialogShown[playerid] = 1;
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
    PlayerAuthDialogShown[playerid] = 1;
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
        "UPDATE players SET money=%d, bank_money=%d, xp=%d, level=%d, admin_level=%d, current_job=%d, spawn_house=%d, starter_pack_claimed=%d, weapon_license=%d, pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f WHERE id=%d LIMIT 1",
        PlayerMoney[playerid],
        PlayerBankMoney[playerid],
        PlayerXP[playerid],
        PlayerLevel[playerid],
        PlayerAdmin[playerid],
        PlayerJob[playerid],
        PlayerSpawnHouse[playerid],
        PlayerStarterPackClaimed[playerid],
        PlayerWeaponLicense[playerid],
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

    if (jobid == JOB_BUS)
    {
        format(output, size, "Bus Driver");
        return 1;
    }

    if (jobid == JOB_POLICE)
    {
        format(output, size, "Police / Vigilante");
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


stock IsBusVehicleModel(modelid)
{
    if (modelid == VEHICLE_BUS) return 1;
    if (modelid == VEHICLE_COACH) return 1;
    return 0;
}

stock IsPlayerInBusVehicle(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid)) return 0;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
    return IsBusVehicleModel(GetVehicleModel(GetPlayerVehicleID(playerid)));
}

stock IsPoliceVehicleModel(modelid)
{
    if (modelid == VEHICLE_POLICE_LS) return 1;
    if (modelid == VEHICLE_POLICE_SF) return 1;
    if (modelid == VEHICLE_POLICE_LV) return 1;
    if (modelid == VEHICLE_POLICE_RANGER) return 1;
    if (modelid == VEHICLE_POLICE_BIKE) return 1;
    if (modelid == VEHICLE_ENFORCER) return 1;
    return 0;
}

stock IsPlayerInPoliceVehicle(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid)) return 0;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 0;
    return IsPoliceVehicleModel(GetVehicleModel(GetPlayerVehicleID(playerid)));
}

stock ResetBusWorkData(playerid)
{
    PlayerBusStop[playerid] = -1;
    return 1;
}

stock ResetPoliceWorkData(playerid)
{
    PlayerPoliceTarget[playerid] = -1;
    return 1;
}

stock GetBusCooldownLeft(playerid)
{
    new lastTick = PlayerLastWorkTick[playerid];
    if (lastTick == 0) return 0;
    new elapsed = (GetTickCount() - lastTick) / 1000;
    if (elapsed >= BUS_COOLDOWN_SECONDS) return 0;
    return BUS_COOLDOWN_SECONDS - elapsed;
}

stock GetPoliceCooldownLeft(playerid)
{
    new lastTick = PlayerLastWorkTick[playerid];
    if (lastTick == 0) return 0;
    new elapsed = (GetTickCount() - lastTick) / 1000;
    if (elapsed >= POLICE_COOLDOWN_SECONDS) return 0;
    return POLICE_COOLDOWN_SECONDS - elapsed;
}

stock StartBusWork(playerid)
{
    if (PlayerJob[playerid] != JOB_BUS)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum bekerja sebagai bus driver. Naik Bus/Coach lalu tekan tombol 2 untuk auto-join.");
        return 0;
    }
    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang menjalankan pekerjaan lain.");
        return 0;
    }
    new cooldownLeft = GetBusCooldownLeft(playerid);
    if (cooldownLeft > 0)
    {
        new msg[144];
        format(msg, sizeof(msg), "Bus mission cooldown: %d detik.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        return 0;
    }
    if (!IsPlayerInBusVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus menjadi driver Bus/Coach untuk mulai bus mission.");
        return 0;
    }
    PlayerWorking[playerid] = 1;
    PlayerWorkType[playerid] = WORK_BUS;
    PlayerWorkPoint[playerid] = 0;
    PlayerBusStop[playerid] = 0;
    PlayerWorkExitTick[playerid] = 0;
    SetPlayerCheckpoint(playerid, BusStopX[0], BusStopY[0], BusStopZ[0], 7.0);
    GameTextForPlayer(playerid, "~g~Bus Mission Started", 3000, 3);
    SendClientMessage(playerid, COLOR_GREEN, "Bus Mission dimulai. Ikuti checkpoint halte berurutan.");
    SendClientMessage(playerid, COLOR_WHITE, "Tetap gunakan kendaraan bus yang sama. Keluar terlalu lama akan membatalkan mission.");
    return 1;
}

stock CompleteBusWork(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_BUS) return 0;
    new totalMoney = (BUS_REWARD_PER_STOP * MAX_BUS_STOPS) + BUS_COMPLETE_BONUS;
    new totalXP = (BUS_XP_PER_STOP * MAX_BUS_STOPS) + BUS_COMPLETE_XP_BONUS;
    GivePlayerCash(playerid, BUS_COMPLETE_BONUS);
    GivePlayerXPEx(playerid, BUS_COMPLETE_XP_BONUS);
    AddJobProgress(playerid, "bus", totalMoney, totalXP);
    DisablePlayerCheckpoint(playerid);
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = GetTickCount();
    ResetBusWorkData(playerid);
    GameTextForPlayer(playerid, "~g~Bus Route Complete", 3500, 3);
    SendClientMessage(playerid, COLOR_GREEN, "Bus route selesai. Bonus route diberikan.");
    SavePlayerData(playerid);
    return 1;
}

stock HandleBusCheckpoint(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_BUS) return 0;
    if (!IsPlayerInBusVehicle(playerid))
    {
        StartWorkVehicleGrace(playerid);
        return 1;
    }
    new stop = PlayerBusStop[playerid];
    if (stop < 0 || stop >= MAX_BUS_STOPS)
    {
        CancelPlayerWork(playerid);
        SendClientMessage(playerid, COLOR_RED, "Bus route error. Mission dibatalkan.");
        return 1;
    }
    GivePlayerCash(playerid, BUS_REWARD_PER_STOP);
    GivePlayerXPEx(playerid, BUS_XP_PER_STOP);
    new msg[144];
    format(msg, sizeof(msg), "Halte %s selesai. Reward: $%d dan %d XP.", BusStopName[stop], BUS_REWARD_PER_STOP, BUS_XP_PER_STOP);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    stop++;
    if (stop >= MAX_BUS_STOPS)
    {
        CompleteBusWork(playerid);
        return 1;
    }
    PlayerBusStop[playerid] = stop;
    PlayerWorkPoint[playerid] = stop;
    SetPlayerCheckpoint(playerid, BusStopX[stop], BusStopY[stop], BusStopZ[stop], 7.0);
    format(msg, sizeof(msg), "Bus route berikutnya: %s.", BusStopName[stop]);
    SendClientMessage(playerid, COLOR_CYAN, msg);
    return 1;
}

stock StartPoliceWork(playerid)
{
    if (PlayerJob[playerid] != JOB_POLICE)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum bekerja sebagai police/vigilante. Naik police vehicle lalu tekan tombol 2 untuk auto-join.");
        return 0;
    }
    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sedang menjalankan pekerjaan lain.");
        return 0;
    }
    new cooldownLeft = GetPoliceCooldownLeft(playerid);
    if (cooldownLeft > 0)
    {
        new msg[144];
        format(msg, sizeof(msg), "Vigilante cooldown: %d detik.", cooldownLeft);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        return 0;
    }
    if (!IsPlayerInPoliceVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus menjadi driver kendaraan polisi untuk mulai Vigilante Mission.");
        return 0;
    }
    new target = random(MAX_POLICE_TARGETS);
    PlayerWorking[playerid] = 1;
    PlayerWorkType[playerid] = WORK_POLICE;
    PlayerWorkPoint[playerid] = target;
    PlayerPoliceTarget[playerid] = target;
    PlayerWorkExitTick[playerid] = 0;
    SetPlayerCheckpoint(playerid, PoliceTargetX[target], PoliceTargetY[target], PoliceTargetZ[target], 8.0);
    new msg[144];
    format(msg, sizeof(msg), "Vigilante Mission dimulai: menuju %s.", PoliceTargetName[target]);
    GameTextForPlayer(playerid, "~b~Vigilante Mission", 3000, 3);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Tahap basic: capai area suspect untuk menyelesaikan panggilan.");
    return 1;
}

stock HandlePoliceCheckpoint(playerid)
{
    if (!PlayerWorking[playerid] || PlayerWorkType[playerid] != WORK_POLICE) return 0;
    if (!IsPlayerInPoliceVehicle(playerid))
    {
        StartWorkVehicleGrace(playerid);
        return 1;
    }
    new target = PlayerPoliceTarget[playerid];
    if (target < 0 || target >= MAX_POLICE_TARGETS) target = 0;
    GivePlayerCash(playerid, POLICE_BASE_REWARD);
    GivePlayerXPEx(playerid, POLICE_BASE_XP);
    AddJobProgress(playerid, "police", POLICE_BASE_REWARD, POLICE_BASE_XP);
    DisablePlayerCheckpoint(playerid);
    PlayerWorking[playerid] = 0;
    PlayerWorkType[playerid] = WORK_NONE;
    PlayerWorkPoint[playerid] = -1;
    PlayerLastWorkTick[playerid] = GetTickCount();
    ResetPoliceWorkData(playerid);
    new msg[144];
    format(msg, sizeof(msg), "Vigilante call selesai di %s. Reward: $%d dan %d XP.", PoliceTargetName[target], POLICE_BASE_REWARD, POLICE_BASE_XP);
    GameTextForPlayer(playerid, "~g~Vigilante Complete", 3500, 3);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SavePlayerData(playerid);
    return 1;
}

stock SendVehicleMissionHint(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        return 0;
    }

    new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

    if (IsTaxiVehicleModel(modelid))
    {
        GameTextForPlayer(playerid, "~y~Tombol 2~w~: Taxi Mission", 3500, 3);
        SendClientMessage(playerid, COLOR_CYAN, "Vehicle Mission: tekan tombol 2 untuk mulai Taxi Mission.");
        return 1;
    }

    if (IsCourierVehicleModel(modelid))
    {
        GameTextForPlayer(playerid, "~y~Tombol 2~w~: Courier Mission", 3500, 3);
        SendClientMessage(playerid, COLOR_CYAN, "Vehicle Mission: tekan tombol 2 untuk mulai Courier Mission.");
        return 1;
    }

    if (IsTruckerVehicleModel(modelid))
    {
        GameTextForPlayer(playerid, "~y~Tombol 2~w~: Trucker Mission", 3500, 3);
        SendClientMessage(playerid, COLOR_CYAN, "Vehicle Mission: tekan tombol 2 untuk mulai Trucker Mission.");
        return 1;
    }

    if (IsBusVehicleModel(modelid))
    {
        GameTextForPlayer(playerid, "~y~Tombol 2~w~: Bus Route", 3500, 3);
        SendClientMessage(playerid, COLOR_CYAN, "Vehicle Mission: tekan tombol 2 untuk mulai Bus Driver route.");
        return 1;
    }

    if (IsPoliceVehicleModel(modelid))
    {
        GameTextForPlayer(playerid, "~y~Tombol 2~w~: Vigilante Mission", 3500, 3);
        SendClientMessage(playerid, COLOR_CYAN, "Vehicle Mission: tekan tombol 2 untuk mulai Police/Vigilante Mission.");
        return 1;
    }

    return 0;
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

    if (PlayerWorkType[playerid] == WORK_BUS)
    {
        return IsPlayerInBusVehicle(playerid);
    }

    if (PlayerWorkType[playerid] == WORK_POLICE)
    {
        return IsPlayerInPoliceVehicle(playerid);
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
    ResetBusWorkData(playerid);
    ResetPoliceWorkData(playerid);

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

    if (jobid == JOB_BUS)
    {
        format(output, size, "bus");
        return 1;
    }

    if (jobid == JOB_POLICE)
    {
        format(output, size, "police");
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
    if (!strcmp(jobCode, "bus", true)) return 1;
    if (!strcmp(jobCode, "police", true)) return 1;

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

    if (workType == WORK_BUS)
    {
        format(output, size, "Bus Driver");
        return 1;
    }

    if (workType == WORK_POLICE)
    {
        format(output, size, "Police / Vigilante");
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
    PlayerDialogTerritoryIndex[playerid] = -1;
    PlayerDialogGangID[playerid] = 0;
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


stock ResetPlayerGangData(playerid)
{
    PlayerGangID[playerid] = 0;
    PlayerGangRank[playerid] = GANG_RANK_NONE;
    PlayerGangInvite[playerid] = INVALID_PLAYER_ID;
    PlayerGangColor[playerid] = DEFAULT_GANG_COLOR;
    PlayerSelectedGangTarget[playerid] = INVALID_PLAYER_ID;
    PlayerDialogTerritoryIndex[playerid] = -1;
    PlayerDialogGangID[playerid] = 0;
    format(PlayerGangName[playerid], 64, "None");
    format(PlayerPendingGangName[playerid], 64, "None");
    return 1;
}

stock GetGangRankName(rank, output[], size)
{
    if (rank >= GANG_RANK_LEADER)
    {
        format(output, size, "Gang Boss");
        return 1;
    }

    if (rank >= GANG_RANK_UNDERBOSS)
    {
        format(output, size, "Underboss");
        return 1;
    }

    if (rank >= GANG_RANK_ENFORCER)
    {
        format(output, size, "Enforcer");
        return 1;
    }

    if (rank >= GANG_RANK_SOLDIER)
    {
        format(output, size, "Soldier");
        return 1;
    }

    if (rank >= GANG_RANK_MEMBER)
    {
        format(output, size, "Member");
        return 1;
    }

    format(output, size, "None");
    return 1;
}

stock IsGangLeader(playerid)
{
    if (PlayerGangID[playerid] > 0 && PlayerGangRank[playerid] >= GANG_RANK_LEADER)
    {
        return 1;
    }

    return 0;
}

stock IsGangEnforcer(playerid)
{
    if (PlayerGangID[playerid] > 0 && PlayerGangRank[playerid] >= GANG_RANK_ENFORCER)
    {
        return 1;
    }

    return 0;
}

stock LoadPlayerGang(playerid)
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
        "SELECT gm.gang_id, gm.rank_level, g.name, g.gang_color FROM gang_members gm JOIN gangs g ON g.id = gm.gang_id WHERE gm.player_id=%d LIMIT 1",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerGangLoaded", "i", playerid);
    return 1;
}

stock SendMessageToGang(gangid, color, const message[])
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerGangID[i] == gangid)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}

stock GetPresetGangIndexByID(gangid)
{
    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        if (PresetGangID[i] == gangid)
        {
            return i;
        }
    }

    return -1;
}

stock IsPresetGangID(gangid)
{
    return GetPresetGangIndexByID(gangid) != -1;
}

stock GetNearestGangHQ(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(playerid, GangHQX[i], GangHQY[i], GangHQZ[i]);

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock IsPlayerNearGangHQ(playerid, gangIndex)
{
    if (gangIndex < 0 || gangIndex >= MAX_PRESET_GANGS)
    {
        return 0;
    }

    if (GetPlayerDistanceFromPoint(playerid, GangHQX[gangIndex], GangHQY[gangIndex], GangHQZ[gangIndex]) <= GANG_HQ_ACCESS_RADIUS)
    {
        return 1;
    }

    return 0;
}

stock ShowGangHQDialog(playerid, gangid)
{
    new gangIndex = GetPresetGangIndexByID(gangid);

    if (gangIndex == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Gang HQ tidak valid.");
        return 0;
    }

    PlayerDialogGangID[playerid] = gangid;

    new title[96];
    new body[384];

    format(title, sizeof(title), "%s", PresetGangName[gangIndex]);

    if (PlayerGangID[playerid] == gangid)
    {
        format(
            body,
            sizeof(body),
            "Gang Info
            Gang Members
            Leave Gang
            Kick Member(Gang Boss)
            Turf Map
            Organization Menu"
        );
    }
    else
    {
        format(
            body,
            sizeof(body),
            "Gang Info
            Join Gang
            Turf Map
            Organization Menu"
        );
    }

    ShowPlayerDialog(playerid, DIALOG_GANG_HQ_MENU, DIALOG_STYLE_LIST, title, body, "Select", "Close");
    return 1;
}

stock ProcessJoinPresetGang(playerid, gangid)
{
    new gangIndex = GetPresetGangIndexByID(gangid);

    if (gangIndex == -1)
    {
        SendClientMessage(playerid, COLOR_RED, "Gang tidak valid.");
        return 0;
    }

    if (PlayerGangID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam gang. Gunakan /leavegang dulu.");
        return 0;
    }

    if (!IsPlayerNearGangHQ(playerid, gangIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada di HQ gang untuk bergabung.");
        return 0;
    }

    new playerName[MAX_PLAYER_NAME];
    new query[512];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO gang_members (gang_id, player_id, player_name, rank_level) VALUES (%d, %d, '%e', %d) ON DUPLICATE KEY UPDATE gang_id=VALUES(gang_id), player_name=VALUES(player_name), rank_level=VALUES(rank_level)",
        gangid,
        PlayerDBID[playerid],
        playerName,
        GANG_RANK_MEMBER
    );

    mysql_tquery(g_SQL, query);

    PlayerGangID[playerid] = gangid;
    PlayerGangRank[playerid] = GANG_RANK_MEMBER;
    PlayerGangColor[playerid] = PresetGangColor[gangIndex];
    format(PlayerGangName[playerid], 64, "%s", PresetGangName[gangIndex]);

    new msg[160];
    format(msg, sizeof(msg), "Kamu bergabung dengan %s.", PresetGangName[gangIndex]);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "[GANG] %s bergabung ke %s.", playerName, PresetGangName[gangIndex]);
    SendMessageToGang(gangid, PresetGangColor[gangIndex], msg);

    return 1;
}

stock ProcessKickGangMember(playerid, targetid)
{
    if (!IsGangLeader(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Gang Boss yang bisa kick member gang.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
        return 0;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, COLOR_RED, "Gunakan /leavegang untuk keluar sendiri.");
        return 0;
    }

    if (PlayerGangID[targetid] != PlayerGangID[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target bukan anggota gang kamu.");
        return 0;
    }

    if (PlayerGangRank[targetid] >= PlayerGangRank[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Tidak bisa kick rank yang sama/lebih tinggi.");
        return 0;
    }

    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gang_members WHERE player_id=%d LIMIT 1", PlayerDBID[targetid]);
    mysql_tquery(g_SQL, query);

    new targetName[MAX_PLAYER_NAME];
    new msg[160];

    GetPlayerName(targetid, targetName, sizeof(targetName));

    ResetPlayerGangData(targetid);
    SendClientMessage(targetid, COLOR_RED, "Kamu dikeluarkan dari gang oleh Gang Boss.");

    format(msg, sizeof(msg), "%s dikeluarkan dari gang.", targetName);
    SendMessageToGang(PlayerGangID[playerid], COLOR_YELLOW, msg);
    SendClientMessage(playerid, COLOR_GREEN, "Member berhasil dikeluarkan dari gang.");

    return 1;
}

stock ProcessSetGangRank(playerid, targetid, rank)
{
    if (!IsAdminLevel(playerid, ADMIN_OWNER))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner server yang bisa set rank gang.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid] || PlayerGangID[targetid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login atau belum punya gang.");
        return 0;
    }

    if (rank < GANG_RANK_MEMBER || rank > GANG_RANK_LEADER)
    {
        SendClientMessage(playerid, COLOR_RED, "Rank valid: 1 Member, 2 Soldier, 3 Enforcer, 4 OG, 5 Gang Boss.");
        return 0;
    }

    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE gang_members SET rank_level=%d WHERE player_id=%d LIMIT 1", rank, PlayerDBID[targetid]);
    mysql_tquery(g_SQL, query);

    PlayerGangRank[targetid] = rank;

    new rankName[32];
    new msg[144];
    GetGangRankName(rank, rankName, sizeof(rankName));

    format(msg, sizeof(msg), "Rank gang target diset menjadi %s (%d).", rankName, rank);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "Rank gang kamu diubah menjadi %s (%d).", rankName, rank);
    SendClientMessage(targetid, COLOR_YELLOW, msg);
    return 1;
}

stock ResetGangTerritoryData()
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        TerritoryPickup[i] = -1;
        TerritoryLabel[i] = Text3D:INVALID_3DTEXT_ID;
        TerritoryOwnerGangID[i] = 0;
        TerritoryOwnerColor[i] = COLOR_GRAY;
        format(TerritoryOwnerName[i], 64, "Neutral");
    }

    return 1;
}

stock IsValidTerritoryIndex(territoryIndex)
{
    if (territoryIndex < 0 || territoryIndex >= MAX_TERRITORIES)
    {
        return 0;
    }

    return 1;
}

stock GetTerritoryZoneColor(territoryIndex)
{
    if (!IsValidTerritoryIndex(territoryIndex))
    {
        return 0x77777755;
    }

    new color = TerritoryOwnerColor[territoryIndex];

    if (TerritoryOwnerGangID[territoryIndex] <= 0)
    {
        color = 0x777777FF;
    }

    // LSIF colors use RGBA format. Keep RGB, replace alpha with a transparent value.
    return (color & 0xFFFFFF00) | TERRITORY_ZONE_ALPHA;
}

stock CreateTerritoryGangZones()
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryZone[i] != -1)
        {
            GangZoneDestroy(TerritoryZone[i]);
            TerritoryZone[i] = -1;
        }

        new Float:minX = TerritoryX[i] - TerritoryRadius[i];
        new Float:minY = TerritoryY[i] - TerritoryRadius[i];
        new Float:maxX = TerritoryX[i] + TerritoryRadius[i];
        new Float:maxY = TerritoryY[i] + TerritoryRadius[i];

        TerritoryZone[i] = GangZoneCreate(minX, minY, maxX, maxY);
    }

    print("[LSIF] Territory colored GangZones created from territory center/radius.");
    return 1;
}

stock DestroyTerritoryGangZones()
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryZone[i] != -1)
        {
            GangZoneDestroy(TerritoryZone[i]);
            TerritoryZone[i] = -1;
        }
    }

    return 1;
}

stock ApplyTerritoryZones(playerid)
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryZone[i] != -1)
        {
            GangZoneShowForPlayer(playerid, TerritoryZone[i], GetTerritoryZoneColor(i));
        }
    }

    return 1;
}

stock HideTerritoryZones(playerid)
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryZone[i] != -1)
        {
            GangZoneHideForPlayer(playerid, TerritoryZone[i]);
        }
    }

    return 1;
}

stock RefreshTerritoryZoneForAll(territoryIndex)
{
    if (!IsValidTerritoryIndex(territoryIndex))
    {
        return 0;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && TerritoryZone[territoryIndex] != -1)
        {
            GangZoneHideForPlayer(i, TerritoryZone[territoryIndex]);
            GangZoneShowForPlayer(i, TerritoryZone[territoryIndex], GetTerritoryZoneColor(territoryIndex));
        }
    }

    return 1;
}

stock RefreshAllPlayerTerritoryZones()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            HideTerritoryZones(i);
            ApplyTerritoryZones(i);
        }
    }

    return 1;
}

stock GetGangColorIndexByValue(color)
{
    for (new i = 0; i < MAX_GANG_COLOR_PRESETS; i++)
    {
        if (GangColorValue[i] == color)
        {
            return i;
        }
    }

    return 0;
}

stock CountGangTerritories(gangid)
{
    new count = 0;

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryOwnerGangID[i] == gangid)
        {
            count++;
        }
    }

    return count;
}

stock UpdateTerritoryMarkerLabel(territoryIndex)
{
    if (!IsValidTerritoryIndex(territoryIndex))
    {
        return 0;
    }

    if (TerritoryLabel[territoryIndex] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(TerritoryLabel[territoryIndex]);
        TerritoryLabel[territoryIndex] = Text3D:INVALID_3DTEXT_ID;
    }

    new labelText[192];
    format(
        labelText,
        sizeof(labelText),
        "[TURF] %s\nOwner Gang: %s\n/gangmenu atau /turfmap",
        TerritoryName[territoryIndex],
        TerritoryOwnerName[territoryIndex]
    );

    TerritoryLabel[territoryIndex] = Create3DTextLabel(
                                         labelText,
                                         TerritoryOwnerColor[territoryIndex],
                                         TerritoryX[territoryIndex],
                                         TerritoryY[territoryIndex],
                                         TerritoryZ[territoryIndex] + 0.8,
                                         WORLD_LABEL_DRAW_DISTANCE,
                                         0,
                                         true
                                     );

    return 1;
}

stock RefreshAllTerritoryLabels()
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        UpdateTerritoryMarkerLabel(i);
    }

    return 1;
}

stock RefreshAllPlayerMapIcons()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            RemoveLSIFMapIcons(i);
            ApplyLSIFMapIcons(i);
        }
    }

    return 1;
}

stock LoadGangTerritories()
{
    ResetGangTerritoryData();
    mysql_tquery(g_SQL, "SELECT territory_index, owner_gang_id, owner_gang_name, owner_color FROM gang_territories ORDER BY territory_index ASC", "OnGangTerritoriesLoaded");
    return 1;
}

stock ShowGangMenuDialog(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_GANG_MENU,
        DIALOG_STYLE_LIST,
        "LSIF Gang Menu",
        "Gang Info\nTurf Map\nGang Members\nLeave Gang\nKick Member (Gang Boss)\nGang HQ List\nOrganization Menu",
        "Select",
        "Close"
    );
    return 1;
}

stock ShowGangInfoDialog(playerid)
{
    new dialogText[768];
    new rankName[32];
    new colorIndex = GetGangColorIndexByValue(PlayerGangColor[playerid]);

    if (PlayerGangID[playerid] <= 0)
    {
        format(dialogText, sizeof(dialogText), "Kamu belum tergabung dalam gang.\n\nGang berbeda dari Organization.\nOrganization = ekonomi/bisnis/job.\nGang = territory/turf/area control.\n\nUntuk join gang, datang ke HQ gang lalu tekan ALT.");
    }
    else
    {
        GetGangRankName(PlayerGangRank[playerid], rankName, sizeof(rankName));
        format(
            dialogText,
            sizeof(dialogText),
            "Gang: %s\nGang ID: %d\nRank: %s (%d)\nGang Color: %s\nTerritories Owned: %d/%d\n\nCatatan: Gang adalah faction preset offline-like. Nama, HQ, dan warna tidak bisa diubah player.",
            PlayerGangName[playerid],
            PlayerGangID[playerid],
            rankName,
            PlayerGangRank[playerid],
            GangColorName[colorIndex],
            CountGangTerritories(PlayerGangID[playerid]),
            MAX_TERRITORIES
        );
    }

    ShowPlayerDialog(playerid, DIALOG_GANG_INFO, DIALOG_STYLE_MSGBOX, "Gang Info", dialogText, "Back", "Close");
    return 1;
}

stock ShowTurfMapDialog(playerid)
{
    new dialogText[1536];
    new line[192];

    format(dialogText, sizeof(dialogText), "Territory\tOwner Gang\tRadius\n");

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        format(line, sizeof(line), "%d. %s\t%s\t%.0f\n", i + 1, TerritoryName[i], TerritoryOwnerName[i], TerritoryRadius[i]);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_TURF_MAP, DIALOG_STYLE_TABLIST_HEADERS, "LSIF Turf Map", dialogText, "Back", "Close");
    return 1;
}

stock ShowGangColorDialog(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "Gang color fixed mengikuti versi offline GTA SA dan tidak bisa diubah player.");
    return 1;
}

stock ApplyGangColorToOnlineMembers(gangid, color)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerLoggedIn[i] && PlayerGangID[i] == gangid)
        {
            PlayerGangColor[i] = color;
        }
    }

    return 1;
}

stock ApplyGangColorToTerritories(gangid, color)
{
    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryOwnerGangID[i] == gangid)
        {
            TerritoryOwnerColor[i] = color;
            UpdateTerritoryMarkerLabel(i);
        }
    }

    RefreshAllPlayerMapIcons();
    return 1;
}

stock ShowGangMembersDialog(playerid)
{
    if (PlayerGangID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam gang.");
        return 0;
    }

    new query[512];
    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "SELECT player_name, rank_level FROM gang_members WHERE gang_id=%d ORDER BY rank_level DESC, player_name ASC LIMIT 30",
        PlayerGangID[playerid]
    );
    mysql_tquery(g_SQL, query, "OnGangMembersLoaded", "i", playerid);
    return 1;
}

stock ShowGangCreateDialog(playerid)
{
    if (PlayerGangID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam gang.");
        return 0;
    }

    new dialogText[256];
    format(dialogText, sizeof(dialogText), "Biaya membuat gang: $%d\nCash kamu: $%d\n\nMasukkan nama gang baru.", GANG_CREATE_PRICE, PlayerMoney[playerid]);
    ShowPlayerDialog(playerid, DIALOG_GANG_CREATE_INPUT, DIALOG_STYLE_INPUT, "Create Gang", dialogText, "Create", "Back");
    return 1;
}

stock ProcessCreateGang(playerid, const gangName[])
{
    if (PlayerGangID[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah tergabung dalam gang.");
        return 0;
    }

    if (strlen(gangName) < 3)
    {
        SendClientMessage(playerid, COLOR_RED, "Nama gang minimal 3 karakter.");
        return 0;
    }

    if (PlayerMoney[playerid] < GANG_CREATE_PRICE)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Biaya membuat gang: $%d.", GANG_CREATE_PRICE);
        SendClientMessage(playerid, COLOR_RED, msg);
        return 0;
    }

    new playerName[MAX_PLAYER_NAME];
    new query[512];

    GetPlayerName(playerid, playerName, sizeof(playerName));
    format(PlayerPendingGangName[playerid], 64, "%s", gangName);

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO gangs (name, leader_id, leader_name, gang_color, reputation, bank_money) VALUES ('%e', %d, '%e', %d, 0, 0)",
        gangName,
        PlayerDBID[playerid],
        playerName,
        DEFAULT_GANG_COLOR
    );

    mysql_tquery(g_SQL, query, "OnGangCreated", "i", playerid);
    return 1;
}

stock ProcessGangInvite(playerid, targetid)
{
    if (PlayerGangID[playerid] <= 0 || PlayerGangRank[playerid] < GANG_RANK_ENFORCER)
    {
        SendClientMessage(playerid, COLOR_RED, "Minimal Enforcer gang untuk invite.");
        return 0;
    }

    if (!IsPlayerConnected(targetid) || !PlayerLoggedIn[targetid])
    {
        SendClientMessage(playerid, COLOR_RED, "Target tidak online/login.");
        return 0;
    }

    if (PlayerGangID[targetid] > 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Target sudah tergabung dalam gang.");
        return 0;
    }

    PlayerGangInvite[targetid] = playerid;

    new inviterName[MAX_PLAYER_NAME];
    new msg[160];

    GetPlayerName(playerid, inviterName, sizeof(inviterName));

    format(msg, sizeof(msg), "Kamu mengundang player ID %d ke gang %s.", targetid, PlayerGangName[playerid]);
    SendClientMessage(playerid, COLOR_GREEN, msg);

    format(msg, sizeof(msg), "%s mengundang kamu ke gang %s. Gunakan /acceptgang.", inviterName, PlayerGangName[playerid]);
    SendClientMessage(targetid, COLOR_GREEN, msg);
    return 1;
}

stock ProcessLeaveGang(playerid)
{
    if (PlayerGangID[playerid] <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum tergabung dalam gang.");
        return 0;
    }

    new gangid = PlayerGangID[playerid];
    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gang_members WHERE player_id=%d LIMIT 1", PlayerDBID[playerid]);
    mysql_tquery(g_SQL, query);

    ResetPlayerGangData(playerid);
    SendClientMessage(playerid, COLOR_YELLOW, "Kamu keluar dari gang.");

    new msg[128];
    format(msg, sizeof(msg), "[GANG] Seseorang keluar dari gang.");
    SendMessageToGang(gangid, COLOR_YELLOW, msg);
    return 1;
}

stock ProcessDisbandGang(playerid)
{
    if (!IsGangLeader(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Leader gang yang bisa membubarkan gang.");
        return 0;
    }

    new gangid = PlayerGangID[playerid];
    new query[256];

    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gang_members WHERE gang_id=%d", gangid);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gangs WHERE id=%d LIMIT 1", gangid);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof(query), "UPDATE gang_territories SET owner_gang_id=0, owner_gang_name='Neutral', owner_color=%d WHERE owner_gang_id=%d", COLOR_GRAY, gangid);
    mysql_tquery(g_SQL, query);

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryOwnerGangID[i] == gangid)
        {
            TerritoryOwnerGangID[i] = 0;
            TerritoryOwnerColor[i] = COLOR_GRAY;
            format(TerritoryOwnerName[i], 64, "Neutral");
            UpdateTerritoryMarkerLabel(i);
        }
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerGangID[i] == gangid)
        {
            ResetPlayerGangData(i);
            SendClientMessage(i, COLOR_RED, "Gang kamu telah dibubarkan.");
        }
    }

    RefreshAllPlayerMapIcons();
    return 1;
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
    SetGameModeText("SAIF Dev v0.21B.1 Dynamic Fix");

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

    ResetGangTerritoryData();
    CreateHouseExteriorPickups();
    CreateWorldInteractionMarkers();
    LoadGangTerritories();
    LoadDynamicLocations();

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
        ResetBusWorkData(i);
        ResetPoliceWorkData(i);
        ResetPlayerHouseData(i);
        ResetPlayerOrgData(i);
        ResetPlayerGangData(i);
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
    print("[LSIF] Map icons, 3D labels, ALT world markers, turf markers, dan colored GangZones aktif.");
    print("[LSIF] Dynamic World Location Core aktif: radar icon, 3D label, pickup, dan editor lokasi admin.");
    print("[SAIF] Gamemode v0.21B.1 Dynamic Location Integration Fix berhasil dijalankan.");
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
    // Safety net: jika callback ban/whitelist/account gagal terpanggil, paksa flow auth lanjut.
    SetTimerEx("EnsureAuthDialog", 3000, false, "i", playerid);
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
    PlayerAuthDialogShown[playerid] = 0;
    PlayerFindingBank[playerid] = 0;
    ResetPlayerOrgData(playerid);
    ResetPlayerGangData(playerid);

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
    SetTimerEx("ApplySavedWeaponLoadout", 1000, false, "i", playerid);
    ApplyLSIFMapIcons(playerid);

    SendClientMessage(playerid, COLOR_CYAN, "Kamu berhasil spawn di Los Santos.");
    SendClientMessage(playerid, COLOR_WHITE, "Closed Beta: gunakan /betaguide untuk alur awal dan /bugreport jika menemukan bug.");
    SendClientMessage(playerid, COLOR_WHITE, "Command cepat: /help, /starterpack, /jobs, /jobguide, /maplegend. Cari marker [ALT] untuk interaksi dunia.");

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
        "Gamemode: LSIF Dev v0.19B Weapon License\n\nUptime: %s\nPlayers Online: %d\nLogged Players: %d\nAdmins Online: %d\n\nClosed Beta: ACTIVE\nWhitelist: ENABLED after first active whitelist user\n\nMenu terkait:\n/adminmenu\n/betamenu",
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

    if (dialogid == DIALOG_NEARBY_INTERACTION)
    {
        if (!response)
        {
            return 1;
        }

        ExecuteNearbyInteraction(playerid, listitem);
        return 1;
    }


    if (dialogid == DIALOG_LOC_MENU)
    {
        if (!response)
        {
            return 1;
        }

        switch (listitem)
        {
            case 0: ShowDynamicLocationCreateTypeMenu(playerid);
            case 1: ShowDynamicLocationListDialog(playerid);
            case 2: ShowDynamicLocationIconPresetDialog(playerid);
            case 3:
            {
                LoadDynamicLocations();
                SendClientMessage(playerid, COLOR_GREEN, "Dynamic locations sedang direload dari database.");
            }
            case 4: ShowDynamicLocationHelp(playerid);
            case 5:
            {
                SendClientMessage(playerid, COLOR_YELLOW, "Remove/Delete Notes:");
                SendClientMessage(playerid, COLOR_WHITE, "/locdisable [id] = hide/nonaktifkan lokasi, bisa dikembalikan dengan /locenable.");
                SendClientMessage(playerid, COLOR_WHITE, "/locdelete atau /locremove [id] = hard delete dari database.");
                SendClientMessage(playerid, COLOR_WHITE, "ID MySQL AUTO_INCREMENT tetap lanjut walau row dihapus. Itu normal dan aman.");
            }
        }
        return 1;
    }

    if (dialogid == DIALOG_LOC_CREATE_TYPE)
    {
        if (!response)
        {
            ShowDynamicLocationEditorMenu(playerid);
            return 1;
        }

        switch (listitem)
        {
            case 0: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "atm");
            case 1: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "dealer");
            case 2: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "ammunation");
            case 3: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "gang_hq");
            case 4: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "job");
            case 5: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "race");
            case 6: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "business");
            case 7: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "house");
            case 8: format(PlayerPendingLocCreateType[playerid], LOC_TYPE_SIZE, "interior");
        }

        ShowDynamicLocationNameInput(playerid);
        return 1;
    }

    if (dialogid == DIALOG_LOC_CREATE_NAME)
    {
        if (!response)
        {
            ShowDynamicLocationCreateTypeMenu(playerid);
            return 1;
        }

        if (strlen(inputtext) < 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Nama lokasi minimal 3 karakter.");
            ShowDynamicLocationNameInput(playerid);
            return 1;
        }

        CreateDynamicLocationAtPlayer(playerid, PlayerPendingLocCreateType[playerid], inputtext);
        return 1;
    }

    if (dialogid == DIALOG_LOC_LIST || dialogid == DIALOG_LOC_ICON_PRESETS)
    {
        if (response)
        {
            ShowDynamicLocationEditorMenu(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_DYNAMIC_LOCATION_INFO)
    {
        return 1;
    }

    if (dialogid == DIALOG_JOB_GUIDE_MENU)
    {
        if (!response)
        {
            return 1;
        }

        ShowJobGuideDetail(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_JOB_GUIDE_DETAIL)
    {
        if (response)
        {
            ShowJobGuideMenu(playerid);
        }

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




    if (dialogid == DIALOG_GANG_MENU)
    {
        if (!response)
        {
            return 1;
        }

        if (listitem == 0)
        {
            ShowGangInfoDialog(playerid);
            return 1;
        }

        if (listitem == 1)
        {
            ShowTurfMapDialog(playerid);
            return 1;
        }

        if (listitem == 2)
        {
            ShowGangMembersDialog(playerid);
            return 1;
        }

        if (listitem == 3)
        {
            ShowPlayerDialog(playerid, DIALOG_GANG_LEAVE_CONFIRM, DIALOG_STYLE_MSGBOX, "Leave Gang", "Yakin ingin keluar dari gang?", "Leave", "Back");
            return 1;
        }

        if (listitem == 4)
        {
            if (!IsGangLeader(playerid))
            {
                SendClientMessage(playerid, COLOR_RED, "Hanya Gang Boss yang bisa kick member.");
                return 1;
            }

            ShowPlayerDialog(playerid, DIALOG_GANG_KICK_INPUT, DIALOG_STYLE_INPUT, "Kick Gang Member", "Masukkan player ID member yang ingin dikeluarkan.", "Next", "Back");
            return 1;
        }

        if (listitem == 5)
        {
            mysql_tquery(g_SQL, "SELECT id, name, leader_name, reputation FROM gangs WHERE id BETWEEN 1 AND 4 ORDER BY id ASC", "OnGangListLoaded", "i", playerid);
            return 1;
        }

        if (listitem == 6)
        {
            ShowOrgMenuDialog(playerid);
            return 1;
        }

        return 1;
    }

    if (dialogid == DIALOG_GANG_HQ_MENU)
    {
        if (!response)
        {
            return 1;
        }

        new gangid = PlayerDialogGangID[playerid];

        if (!IsPresetGangID(gangid))
        {
            SendClientMessage(playerid, COLOR_RED, "Gang HQ tidak valid.");
            return 1;
        }

        if (PlayerGangID[playerid] == gangid)
        {
            if (listitem == 0)
            {
                ShowGangInfoDialog(playerid);
                return 1;
            }

            if (listitem == 1)
            {
                ShowGangMembersDialog(playerid);
                return 1;
            }

            if (listitem == 2)
            {
                ShowPlayerDialog(playerid, DIALOG_GANG_LEAVE_CONFIRM, DIALOG_STYLE_MSGBOX, "Leave Gang", "Yakin ingin keluar dari gang?", "Leave", "Back");
                return 1;
            }

            if (listitem == 3)
            {
                if (!IsGangLeader(playerid))
                {
                    SendClientMessage(playerid, COLOR_RED, "Hanya Gang Boss yang bisa kick member.");
                    return 1;
                }

                ShowPlayerDialog(playerid, DIALOG_GANG_KICK_INPUT, DIALOG_STYLE_INPUT, "Kick Gang Member", "Masukkan player ID member yang ingin dikeluarkan.", "Next", "Back");
                return 1;
            }

            if (listitem == 4)
            {
                ShowTurfMapDialog(playerid);
                return 1;
            }

            if (listitem == 5)
            {
                ShowOrgMenuDialog(playerid);
                return 1;
            }
        }
        else
        {
            if (listitem == 0)
            {
                ShowGangInfoDialog(playerid);
                return 1;
            }

            if (listitem == 1)
            {
                ProcessJoinPresetGang(playerid, gangid);
                return 1;
            }

            if (listitem == 2)
            {
                ShowTurfMapDialog(playerid);
                return 1;
            }

            if (listitem == 3)
            {
                ShowOrgMenuDialog(playerid);
                return 1;
            }
        }

        return 1;
    }

    if (dialogid == DIALOG_GANG_KICK_INPUT)
    {
        if (!response)
        {
            ShowGangMenuDialog(playerid);
            return 1;
        }

        if (!IsNumericString(inputtext))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        PlayerSelectedGangTarget[playerid] = strval(inputtext);
        ShowPlayerDialog(playerid, DIALOG_GANG_KICK_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Kick", "Yakin ingin mengeluarkan player ini dari gang?", "Kick", "Back");
        return 1;
    }

    if (dialogid == DIALOG_GANG_KICK_CONFIRM)
    {
        if (response)
        {
            ProcessKickGangMember(playerid, PlayerSelectedGangTarget[playerid]);
        }
        else
        {
            ShowGangMenuDialog(playerid);
        }

        PlayerSelectedGangTarget[playerid] = INVALID_PLAYER_ID;
        return 1;
    }

    if (dialogid == DIALOG_GANG_INFO || dialogid == DIALOG_TURF_MAP || dialogid == DIALOG_GANG_MEMBERS || dialogid == DIALOG_GANG_LIST)
    {
        if (response)
        {
            ShowGangMenuDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_GANG_CREATE_INPUT)
    {
        if (!response)
        {
            ShowGangMenuDialog(playerid);
            return 1;
        }

        ProcessCreateGang(playerid, inputtext);
        return 1;
    }

    if (dialogid == DIALOG_GANG_INVITE)
    {
        if (!response)
        {
            ShowGangMenuDialog(playerid);
            return 1;
        }

        if (!IsNumericString(inputtext))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        ProcessGangInvite(playerid, strval(inputtext));
        return 1;
    }

    if (dialogid == DIALOG_GANG_LEAVE_CONFIRM)
    {
        if (response)
        {
            ProcessLeaveGang(playerid);
        }
        else
        {
            ShowGangMenuDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_GANG_DISBAND_CONFIRM)
    {
        if (response)
        {
            ProcessDisbandGang(playerid);
        }
        else
        {
            ShowGangMenuDialog(playerid);
        }
        return 1;
    }

    if (dialogid == DIALOG_GANG_COLOR)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gang color fixed mengikuti versi offline GTA SA.");
        ShowGangMenuDialog(playerid);
        return 1;
    }

    if (dialogid == DIALOG_LOADOUT_INFO || dialogid == DIALOG_WEAPON_LICENSE)
    {
        return 1;
    }

    if (dialogid == DIALOG_WEAPON_SHOP)
    {
        if (!response)
        {
            return 1;
        }

        if (!IsPlayerNearAmmuNation(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat Ammu-Nation.");
            return 1;
        }

        ShowWeaponConfirmDialog(playerid, listitem);
        return 1;
    }

    if (dialogid == DIALOG_WEAPON_CONFIRM)
    {
        if (!response)
        {
            ShowWeaponShopDialog(playerid);
            return 1;
        }

        ProcessWeaponPurchase(playerid, PlayerDialogWeaponIndex[playerid]);
        return 1;
    }

    if (dialogid == DIALOG_WEAPON_INFO)
    {
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
            "INSERT INTO players (username, password_hash, money, bank_money, xp, level, admin_level, current_job, starter_pack_claimed, weapon_license, pos_x, pos_y, pos_z, pos_a, last_ip, last_login) VALUES ('%e', SHA2('%e', 256), 500, 0, 0, 1, 0, 0, 0, %d, %f, %f, %f, %f, '%e', NOW())",
            username,
            inputtext,
            DEFAULT_WEAPON_LICENSE,
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
            "SELECT id, money, bank_money, xp, level, admin_level, skin, current_job, spawn_house, starter_pack_claimed, weapon_license, pos_x, pos_y, pos_z, pos_a FROM players WHERE username='%e' AND password_hash=SHA2('%e', 256) LIMIT 1",
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
    PlayerWeaponLicense[playerid] = DEFAULT_WEAPON_LICENSE;
    ResetPlayerWeaponLoadoutData(playerid);
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
    cache_get_value_name_int(0, "weapon_license", PlayerWeaponLicense[playerid]);

    cache_get_value_name_float(0, "pos_x", PlayerLastX[playerid]);
    cache_get_value_name_float(0, "pos_y", PlayerLastY[playerid]);
    cache_get_value_name_float(0, "pos_z", PlayerLastZ[playerid]);
    cache_get_value_name_float(0, "pos_a", PlayerLastA[playerid]);

    PlayerLoggedIn[playerid] = 1;

    ApplyLoadedPlayerData(playerid);
    LoadPlayerGarage(playerid);
    LoadPlayerHouse(playerid);
    LoadPlayerOrganization(playerid);
    LoadPlayerGang(playerid);
    LoadPlayerBusiness(playerid);
    LoadPlayerWeaponLoadout(playerid);

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
    if (!PlayerLoggedIn[playerid]) return 0;
    if (PlayerWorking[playerid])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Kamu sudah sedang menjalankan vehicle mission. Gunakan /cancelwork jika ingin membatalkan.");
        return 1;
    }
    if (!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Tombol 2 digunakan untuk mulai vehicle mission saat kamu menjadi driver kendaraan job.");
        SendClientMessage(playerid, COLOR_WHITE, "Contoh: Taxi/Cabbie, delivery van, truck, bus, atau police vehicle.");
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
    if (IsPlayerInBusVehicle(playerid))
    {
        if (PlayerJob[playerid] != JOB_BUS)
        {
            PlayerJob[playerid] = JOB_BUS;
            SavePlayerData(playerid);
            SendClientMessage(playerid, COLOR_CYAN, "Vehicle mission: kamu otomatis aktif sebagai Bus Driver.");
        }
        StartBusWork(playerid);
        return 1;
    }
    if (IsPlayerInPoliceVehicle(playerid))
    {
        if (PlayerJob[playerid] != JOB_POLICE)
        {
            PlayerJob[playerid] = JOB_POLICE;
            SavePlayerData(playerid);
            SendClientMessage(playerid, COLOR_CYAN, "Vehicle mission: kamu otomatis aktif sebagai Police / Vigilante.");
        }
        StartPoliceWork(playerid);
        return 1;
    }
    new msg[144];
    format(msg, sizeof(msg), "Model kendaraan %d belum punya vehicle mission. Tombol 2 khusus start job/mission kendaraan.", GetVehicleModel(GetPlayerVehicleID(playerid)));
    SendClientMessage(playerid, COLOR_YELLOW, msg);
    return 1;
}


stock ResetDynamicLocationArrays()
{
    DynamicLocationCount = 0;

    for (new i = 0; i < MAX_DYNAMIC_LOCATIONS; i++)
    {
        DynamicLocationDBID[i] = 0;
        DynamicLocationEnabled[i] = 0;
        DynamicLocationMapIcon[i] = 0;
        DynamicLocationPickupModel[i] = WORLD_MARKER_PICKUP_MODEL;
        DynamicLocationObjectModel[i] = 0;
        DynamicLocationObjectID[i] = -1;
        DynamicLocationInterior[i] = 0;
        DynamicLocationVirtualWorld[i] = 0;
        DynamicLocationX[i] = 0.0;
        DynamicLocationY[i] = 0.0;
        DynamicLocationZ[i] = 0.0;
        DynamicLocationA[i] = 0.0;
        DynamicLocationRadius[i] = 3.0;
        format(DynamicLocationType[i], LOC_TYPE_SIZE, "none");
        format(DynamicLocationName[i], LOC_NAME_SIZE, "None");
        format(DynamicLocationLabelText[i], LOC_LABEL_SIZE, "");
        DynamicLocationPickup[i] = -1;
        DynamicLocationObjectID[i] = -1;
        DynamicLocation3DLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    return 1;
}

stock GetDynamicLocationColor(const locationType[])
{
    if (!strcmp(locationType, "atm", true)) return COLOR_CYAN;
    if (!strcmp(locationType, "dealer", true)) return COLOR_GREEN;
    if (!strcmp(locationType, "dealership", true)) return COLOR_GREEN;
    if (!strcmp(locationType, "ammunation", true)) return COLOR_ORANGE;
    if (!strcmp(locationType, "house", true)) return COLOR_WHITE;
    if (!strcmp(locationType, "business", true)) return COLOR_YELLOW;
    if (!strcmp(locationType, "gang_hq", true)) return COLOR_PURPLE;
    if (!strcmp(locationType, "job", true)) return COLOR_CYAN;
    if (!strcmp(locationType, "race", true)) return COLOR_ORANGE;
    if (!strcmp(locationType, "interior", true)) return COLOR_WHITE;
    return COLOR_GRAY;
}

stock GetDefaultDynamicLocationIcon(const locationType[])
{
    if (!strcmp(locationType, "atm", true)) return MAPICON_TYPE_ATM;
    if (!strcmp(locationType, "dealer", true) || !strcmp(locationType, "dealership", true)) return MAPICON_TYPE_DEALER;
    if (!strcmp(locationType, "ammunation", true)) return MAPICON_TYPE_AMMUNATION;
    if (!strcmp(locationType, "house", true)) return MAPICON_TYPE_HOUSE;
    if (!strcmp(locationType, "business", true)) return MAPICON_TYPE_BUSINESS;
    if (!strcmp(locationType, "gang_hq", true)) return MAPICON_TYPE_GANG_HQ;
    if (!strcmp(locationType, "race", true)) return MAPICON_TYPE_RACE;
    if (!strcmp(locationType, "job", true)) return MAPICON_TYPE_JOB;
    return MAPICON_TYPE_JOB;
}

stock GetDefaultDynamicLocationObject(const locationType[])
{
    if (!strcmp(locationType, "atm", true)) return 2942; // ATM object
    if (!strcmp(locationType, "ammunation", true)) return 1239; // info marker fallback
    if (!strcmp(locationType, "dealer", true) || !strcmp(locationType, "dealership", true)) return 1239;
    if (!strcmp(locationType, "gang_hq", true)) return 1239;
    if (!strcmp(locationType, "race", true)) return 1239;
    if (!strcmp(locationType, "job", true)) return 1239;
    if (!strcmp(locationType, "business", true)) return 1239;
    if (!strcmp(locationType, "house", true)) return 1272;
    return 1239;
}

stock IsPlayerNearDynamicLocationIndex(playerid, locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        return 0;
    }

    if (!DynamicLocationEnabled[locationIndex])
    {
        return 0;
    }

    if (DynamicLocationInterior[locationIndex] != GetPlayerInterior(playerid))
    {
        return 0;
    }

    if (DynamicLocationVirtualWorld[locationIndex] != -1 && DynamicLocationVirtualWorld[locationIndex] != GetPlayerVirtualWorld(playerid))
    {
        return 0;
    }

    if (GetPlayerDistanceFromPoint(playerid, DynamicLocationX[locationIndex], DynamicLocationY[locationIndex], DynamicLocationZ[locationIndex]) <= DynamicLocationRadius[locationIndex])
    {
        return 1;
    }

    return 0;
}


stock DynamicLocationMatches(locationIndex, const keyword[])
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        return 0;
    }

    if (strfind(DynamicLocationType[locationIndex], keyword, true) != -1)
    {
        return 1;
    }

    if (strfind(DynamicLocationName[locationIndex], keyword, true) != -1)
    {
        return 1;
    }

    return 0;
}

stock DynamicLocationIsATM(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "atm")) return 1;
    if (DynamicLocationMatches(locationIndex, "bank")) return 1;
    return 0;
}

stock DynamicLocationIsDealer(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "dealer")) return 1;
    if (DynamicLocationMatches(locationIndex, "dealership")) return 1;
    if (DynamicLocationMatches(locationIndex, "vehicle")) return 1;
    return 0;
}

stock DynamicLocationIsAmmu(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "ammu")) return 1;
    if (DynamicLocationMatches(locationIndex, "ammunation")) return 1;
    if (DynamicLocationMatches(locationIndex, "weapon")) return 1;
    return 0;
}

stock DynamicLocationIsGangHQ(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "gang_hq")) return 1;
    if (DynamicLocationMatches(locationIndex, "gang")) return 1;
    if (DynamicLocationMatches(locationIndex, "hq")) return 1;
    if (DynamicLocationMatches(locationIndex, "grove")) return 1;
    if (DynamicLocationMatches(locationIndex, "ballas")) return 1;
    if (DynamicLocationMatches(locationIndex, "vagos")) return 1;
    if (DynamicLocationMatches(locationIndex, "aztecas")) return 1;
    return 0;
}

stock DynamicLocationIsJob(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "job")) return 1;
    if (DynamicLocationMatches(locationIndex, "taxi")) return 1;
    if (DynamicLocationMatches(locationIndex, "courier")) return 1;
    if (DynamicLocationMatches(locationIndex, "trucker")) return 1;
    if (DynamicLocationMatches(locationIndex, "bus")) return 1;
    if (DynamicLocationMatches(locationIndex, "police")) return 1;
    return 0;
}

stock DynamicLocationIsRace(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "race")) return 1;
    return 0;
}

stock DynamicLocationIsHouse(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "house")) return 1;
    if (DynamicLocationMatches(locationIndex, "home")) return 1;
    return 0;
}

stock DynamicLocationIsBusiness(locationIndex)
{
    if (DynamicLocationMatches(locationIndex, "business")) return 1;
    if (DynamicLocationMatches(locationIndex, "biz")) return 1;
    return 0;
}

stock GetDynamicLocationGangID(locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        return 0;
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        if (strfind(DynamicLocationName[locationIndex], PresetGangShortName[i], true) != -1)
        {
            return PresetGangID[i];
        }

        if (strfind(DynamicLocationName[locationIndex], PresetGangName[i], true) != -1)
        {
            return PresetGangID[i];
        }

        if (strfind(DynamicLocationType[locationIndex], PresetGangShortName[i], true) != -1)
        {
            return PresetGangID[i];
        }

        if (strfind(DynamicLocationType[locationIndex], PresetGangName[i], true) != -1)
        {
            return PresetGangID[i];
        }
    }

    return 0;
}

stock ExecuteDynamicLocationFunction(playerid, locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        SendClientMessage(playerid, COLOR_RED, "Dynamic location tidak valid.");
        return 0;
    }

    if (!IsPlayerNearDynamicLocationIndex(playerid, locationIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari dynamic location tersebut.");
        return 0;
    }

    if (DynamicLocationIsATM(locationIndex))
    {
        ShowATMDialog(playerid);
        return 1;
    }

    if (DynamicLocationIsDealer(locationIndex))
    {
        ShowDealershipMainDialog(playerid);
        return 1;
    }

    if (DynamicLocationIsAmmu(locationIndex))
    {
        ShowWeaponShopDialog(playerid);
        return 1;
    }

    if (DynamicLocationIsGangHQ(locationIndex))
    {
        new gangid = GetDynamicLocationGangID(locationIndex);

        if (gangid > 0)
        {
            ShowGangHQDialog(playerid, gangid);
            return 1;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "Dynamic Gang HQ belum terhubung ke gang preset.");
        SendClientMessage(playerid, COLOR_WHITE, "Tips: gunakan nama/type yang memuat Grove, Ballas, Vagos, atau Aztecas.");
        ShowGangMenuDialog(playerid);
        return 1;
    }

    if (DynamicLocationIsHouse(locationIndex))
    {
        new nearestHouse = GetNearestHouse(playerid);

        if (nearestHouse != -1 && IsPlayerNearHouse(playerid, nearestHouse))
        {
            ShowHouseInteractionDialog(playerid, nearestHouse);
            return 1;
        }

        ShowDynamicLocationInfoDialog(playerid, locationIndex);
        return 1;
    }

    if (DynamicLocationIsBusiness(locationIndex))
    {
        new nearestBusiness = GetNearestBusiness(playerid);

        if (nearestBusiness != -1 && IsPlayerNearBusiness(playerid, nearestBusiness))
        {
            ShowBusinessInteractionDialog(playerid, nearestBusiness);
            return 1;
        }

        ShowDynamicLocationInfoDialog(playerid, locationIndex);
        return 1;
    }

    if (DynamicLocationIsJob(locationIndex))
    {
        ShowJobGuideMenu(playerid);
        return 1;
    }

    if (DynamicLocationIsRace(locationIndex))
    {
        SendClientMessage(playerid, COLOR_CYAN, "Race marker dynamic terdeteksi. Gunakan /races atau /joinrace ls sebagai fallback.");
        return 1;
    }

    ShowDynamicLocationInfoDialog(playerid, locationIndex);
    return 1;
}

stock ShowDynamicLocationInfoDialog(playerid, locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        SendClientMessage(playerid, COLOR_RED, "Dynamic location tidak valid.");
        return 0;
    }

    new body[768];
    format(
        body,
        sizeof(body),
        "ID: %d\nType: %s\nName: %s\n\nPos: %.2f, %.2f, %.2f\nInterior: %d | VW: %d\nRadius ALT: %.1f\nMap Icon: %d\nPickup Model: %d\nObject Model: %d\n\nCatatan: v0.21B.1 membaca type/name dynamic location secara fleksibel untuk membuka dialog asli saat ALT.",
        DynamicLocationDBID[locationIndex],
        DynamicLocationType[locationIndex],
        DynamicLocationName[locationIndex],
        DynamicLocationX[locationIndex],
        DynamicLocationY[locationIndex],
        DynamicLocationZ[locationIndex],
        DynamicLocationInterior[locationIndex],
        DynamicLocationVirtualWorld[locationIndex],
        DynamicLocationRadius[locationIndex],
        DynamicLocationMapIcon[locationIndex],
        DynamicLocationPickupModel[locationIndex],
        DynamicLocationObjectModel[locationIndex]
    );

    ShowPlayerDialog(playerid, DIALOG_DYNAMIC_LOCATION_INFO, DIALOG_STYLE_MSGBOX, "Dynamic Location", body, "Close", "");
    return 1;
}

stock FindDynamicLocationIndexByDBID(dbid)
{
    for (new i = 0; i < DynamicLocationCount; i++)
    {
        if (DynamicLocationDBID[i] == dbid)
        {
            return i;
        }
    }

    return -1;
}

stock DestroyDynamicLocationMarkers()
{
    for (new i = 0; i < MAX_DYNAMIC_LOCATIONS; i++)
    {
        if (DynamicLocationPickup[i] != -1)
        {
            DestroyPickup(DynamicLocationPickup[i]);
            DynamicLocationPickup[i] = -1;
        }

        if (DynamicLocationObjectID[i] != -1)
        {
            DestroyObject(DynamicLocationObjectID[i]);
            DynamicLocationObjectID[i] = -1;
        }

        if (DynamicLocation3DLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(DynamicLocation3DLabel[i]);
            DynamicLocation3DLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    return 1;
}

stock IsDynamicLocationLabelHidden(locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        return 1;
    }

    if (!strcmp(DynamicLocationLabelText[locationIndex], "__hidden__", true))
    {
        return 1;
    }

    if (!strcmp(DynamicLocationLabelText[locationIndex], "0", true))
    {
        return 1;
    }

    if (!strcmp(DynamicLocationLabelText[locationIndex], "none", true))
    {
        return 1;
    }

    return 0;
}

stock CreateDynamicLocationMarker(locationIndex)
{
    if (locationIndex < 0 || locationIndex >= DynamicLocationCount)
    {
        return 0;
    }

    if (!DynamicLocationEnabled[locationIndex])
    {
        return 0;
    }

    new labelText[144];
    new color = GetDynamicLocationColor(DynamicLocationType[locationIndex]);

    if (strlen(DynamicLocationLabelText[locationIndex]) > 0)
    {
        format(labelText, sizeof(labelText), "%s", DynamicLocationLabelText[locationIndex]);
    }
    else
    {
        format(labelText, sizeof(labelText), "[ALT] %s\n%s", DynamicLocationType[locationIndex], DynamicLocationName[locationIndex]);
    }

    if (DynamicLocationPickupModel[locationIndex] > 0)
    {
        DynamicLocationPickup[locationIndex] = CreatePickup(
                DynamicLocationPickupModel[locationIndex],
                WORLD_MARKER_PICKUP_TYPE,
                DynamicLocationX[locationIndex],
                DynamicLocationY[locationIndex],
                DynamicLocationZ[locationIndex] + 0.15,
                DynamicLocationVirtualWorld[locationIndex]
                                               );
    }

    if (DynamicLocationObjectModel[locationIndex] > 0)
    {
        DynamicLocationObjectID[locationIndex] = CreateObject(
                    DynamicLocationObjectModel[locationIndex],
                    DynamicLocationX[locationIndex],
                    DynamicLocationY[locationIndex],
                    DynamicLocationZ[locationIndex],
                    0.0,
                    0.0,
                    DynamicLocationA[locationIndex]
                );
    }

    if (!IsDynamicLocationLabelHidden(locationIndex))
    {
        DynamicLocation3DLabel[locationIndex] = Create3DTextLabel(
                labelText,
                color,
                DynamicLocationX[locationIndex],
                DynamicLocationY[locationIndex],
                DynamicLocationZ[locationIndex] + 0.9,
                WORLD_LABEL_DRAW_DISTANCE,
                DynamicLocationVirtualWorld[locationIndex],
                true
                                                );
    }

    return 1;
}

stock CreateDynamicLocationMarkers()
{
    for (new i = 0; i < DynamicLocationCount; i++)
    {
        CreateDynamicLocationMarker(i);
    }

    return 1;
}

stock ApplyDynamicLocationIcons(playerid)
{
    for (new i = 0; i < DynamicLocationCount; i++)
    {
        if (!DynamicLocationEnabled[i])
        {
            continue;
        }

        if (DynamicLocationMapIcon[i] <= 0)
        {
            continue;
        }

        SetPlayerMapIcon(
            playerid,
            MAPICON_BASE_DYNAMIC + i,
            DynamicLocationX[i],
            DynamicLocationY[i],
            DynamicLocationZ[i],
            DynamicLocationMapIcon[i],
            GetDynamicLocationColor(DynamicLocationType[i]),
            MAPICON_LOCAL
        );
    }

    return 1;
}

stock RemoveDynamicLocationIcons(playerid)
{
    for (new i = 0; i < MAX_DYNAMIC_LOCATIONS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_DYNAMIC + i);
    }

    return 1;
}

stock RefreshAllDynamicLocationIcons()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            RemoveDynamicLocationIcons(i);
            ApplyDynamicLocationIcons(i);
        }
    }

    return 1;
}

stock LoadDynamicLocations()
{
    DestroyDynamicLocationMarkers();
    ResetDynamicLocationArrays();

    mysql_tquery(
        g_SQL,
        "SELECT id, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, label_text, interaction_radius, enabled FROM world_locations WHERE enabled=1 ORDER BY id ASC LIMIT 15",
        "OnDynamicLocationsLoaded"
    );
    return 1;
}

public OnDynamicLocationsLoaded()
{
    new rows = cache_num_rows();
    new limit = rows;

    if (limit > MAX_DYNAMIC_LOCATIONS)
    {
        limit = MAX_DYNAMIC_LOCATIONS;
    }

    DynamicLocationCount = limit;

    for (new i = 0; i < limit; i++)
    {
        cache_get_value_name_int(i, "id", DynamicLocationDBID[i]);
        cache_get_value_name(i, "location_type", DynamicLocationType[i], LOC_TYPE_SIZE);
        cache_get_value_name(i, "display_name", DynamicLocationName[i], LOC_NAME_SIZE);
        cache_get_value_name_float(i, "pos_x", DynamicLocationX[i]);
        cache_get_value_name_float(i, "pos_y", DynamicLocationY[i]);
        cache_get_value_name_float(i, "pos_z", DynamicLocationZ[i]);
        cache_get_value_name_float(i, "pos_a", DynamicLocationA[i]);
        cache_get_value_name_int(i, "interior", DynamicLocationInterior[i]);
        cache_get_value_name_int(i, "virtual_world", DynamicLocationVirtualWorld[i]);
        cache_get_value_name_int(i, "map_icon", DynamicLocationMapIcon[i]);
        cache_get_value_name_int(i, "pickup_model", DynamicLocationPickupModel[i]);
        cache_get_value_name_int(i, "object_model", DynamicLocationObjectModel[i]);
        cache_get_value_name(i, "label_text", DynamicLocationLabelText[i], LOC_LABEL_SIZE);
        cache_get_value_name_float(i, "interaction_radius", DynamicLocationRadius[i]);
        cache_get_value_name_int(i, "enabled", DynamicLocationEnabled[i]);
    }

    CreateDynamicLocationMarkers();
    RefreshAllDynamicLocationIcons();

    new msg[144];
    format(msg, sizeof(msg), "[LSIF] Dynamic world locations loaded: %d.", DynamicLocationCount);
    print(msg);
    return 1;
}

public OnDynamicLocationCreated(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        new insertId = cache_insert_id();
        new msg[144];
        format(msg, sizeof(msg), "Dynamic location berhasil dibuat. ID: %d. Reloading locations...", insertId);
        SendClientMessage(playerid, COLOR_GREEN, msg);
    }

    LoadDynamicLocations();
    return 1;
}

public OnDynamicLocationUpdated(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        SendClientMessage(playerid, COLOR_GREEN, "Dynamic location berhasil diupdate. Reloading locations...");
    }

    LoadDynamicLocations();
    return 1;
}

public OnDynamicLocationDeleted(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Dynamic location dinonaktifkan/di-hide. Gunakan /locenable [id] untuk mengaktifkan lagi.");
    }

    LoadDynamicLocations();
    return 1;
}

public OnDynamicLocationPurged(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Dynamic location benar-benar dihapus dari database. Reloading locations...");
        SendClientMessage(playerid, COLOR_YELLOW, "Catatan: ID SQL auto-increment tetap lanjut dan tidak kembali ke ID lama.");
    }

    LoadDynamicLocations();
    return 1;
}


stock ShowDynamicLocationEditorMenu(playerid)
{
    if (!IsAdminLevel(playerid, ADMIN_OWNER))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa membuka Dynamic Location Editor.");
        return 0;
    }

    ShowPlayerDialog(
        playerid,
        DIALOG_LOC_MENU,
        DIALOG_STYLE_LIST,
        "Dynamic World Location Editor",
        "Create Location\nList Active Locations\nIcon Presets\nReload Locations\nCommand Help\nRemove/Delete Notes",
        "Select",
        "Close"
    );
    return 1;
}

stock ShowDynamicLocationCreateTypeMenu(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_LOC_CREATE_TYPE,
        DIALOG_STYLE_LIST,
        "Create Dynamic Location - Type",
        "atm\ndealer\nammunation\ngang_hq\njob\nrace\nbusiness\nhouse\ninterior",
        "Select",
        "Back"
    );
    return 1;
}

stock ShowDynamicLocationNameInput(playerid)
{
    new body[160];
    format(body, sizeof(body), "Type terpilih: %s\n\nMasukkan nama/display name lokasi.", PlayerPendingLocCreateType[playerid]);
    ShowPlayerDialog(playerid, DIALOG_LOC_CREATE_NAME, DIALOG_STYLE_INPUT, "Create Dynamic Location - Name", body, "Create", "Back");
    return 1;
}

stock CreateDynamicLocationAtPlayer(playerid, const locType[], const locName[])
{
    new Float:x, Float:y, Float:z, Float:a;
    new query[1200];
    new labelText[LOC_LABEL_SIZE];
    new defaultIcon = GetDefaultDynamicLocationIcon(locType);
    new defaultPickup = WORLD_MARKER_PICKUP_MODEL;

    // v0.21A.2: lokasi dynamic default-nya adalah marker/pickup non-solid.
    // Object visual permanen dipisah lewat /locobject agar tidak mengganggu movement/player collision.

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    format(labelText, sizeof(labelText), "[ALT] %s\n%s", locType, locName);

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO world_locations (location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, label_text, interaction_radius, enabled) VALUES ('%e', '%e', '%e', %f, %f, %f, %f, %d, %d, %d, %d, 0, '%e', 3.0, 1)",
        locName,
        locType,
        locName,
        x,
        y,
        z,
        a,
        GetPlayerInterior(playerid),
        GetPlayerVirtualWorld(playerid),
        defaultIcon,
        defaultPickup,
        labelText
    );

    mysql_tquery(g_SQL, query, "OnDynamicLocationCreated", "i", playerid);
    return 1;
}

stock ShowDynamicLocationListDialog(playerid)
{
    new body[2048];
    new line[160];
    new found = 0;

    format(body, sizeof(body), "ID\tType\tName\tIcon\tRadius\n");

    for (new i = 0; i < DynamicLocationCount; i++)
    {
        format(line, sizeof(line), "%d\t%s\t%s\t%d\t%.1f\n", DynamicLocationDBID[i], DynamicLocationType[i], DynamicLocationName[i], DynamicLocationMapIcon[i], DynamicLocationRadius[i]);
        strcat(body, line, sizeof(body));
        found++;
    }

    if (!found)
    {
        ShowPlayerDialog(playerid, DIALOG_LOC_LIST, DIALOG_STYLE_MSGBOX, "Dynamic Locations", "Belum ada lokasi aktif.", "Back", "Close");
        return 1;
    }

    ShowPlayerDialog(playerid, DIALOG_LOC_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Dynamic Locations", body, "Back", "Close");
    return 1;
}

stock ShowDynamicLocationIconPresetDialog(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_LOC_ICON_PRESETS,
        DIALOG_STYLE_MSGBOX,
        "Map Icon Presets",
        "Preset icon awal LSIF/SAIF:\n\nATM/Bank: 52\nHouse: 31\nBusiness: 52\nDealership: 55\nRace: 53\nJob: 51\nAmmu-Nation: 6\nTerritory/Gang HQ: 19\n\nGunakan:\n/locicon [id] [icon]\n\nCatatan: GTA SA/SA-MP punya pilihan icon terbatas, jadi beberapa icon bisa terlihat mirip.",
        "Back",
        "Close"
    );
    return 1;
}

stock ShowDynamicLocationHelp(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "========== DYNAMIC WORLD LOCATION EDITOR ==========");
    SendClientMessage(playerid, COLOR_WHITE, "/loccreate [type] [name] - Buat lokasi di posisi admin");
    SendClientMessage(playerid, COLOR_WHITE, "/loclist [type] - Lihat lokasi aktif, type opsional");
    SendClientMessage(playerid, COLOR_WHITE, "/locinfo [id] - Detail lokasi aktif");
    SendClientMessage(playerid, COLOR_WHITE, "/locmove [id] - Pindahkan lokasi ke posisi admin");
    SendClientMessage(playerid, COLOR_WHITE, "/loclabel [id] [text/off/auto] - Ubah/sembunyikan 3D label");
    SendClientMessage(playerid, COLOR_WHITE, "/locicon [id] [icon] - Ubah radar/map icon");
    SendClientMessage(playerid, COLOR_WHITE, "/locpickup [id] [model] - Ubah marker/pickup visual, 0 untuk hapus");
    SendClientMessage(playerid, COLOR_WHITE, "/locobject [id] [model] - Object mapping solid/visual opsional, 0 untuk hapus");
    SendClientMessage(playerid, COLOR_WHITE, "/lociconlist - Lihat preset icon radar/map");
    SendClientMessage(playerid, COLOR_WHITE, "/locradius [id] [radius] - Ubah radius ALT dynamic location");
    SendClientMessage(playerid, COLOR_WHITE, "/locgoto [id], /locdisable [id], /locenable [id], /locreload");
    SendClientMessage(playerid, COLOR_WHITE, "/locdelete [id] atau /locremove [id] - Hard delete lokasi dari database");
    SendClientMessage(playerid, COLOR_CYAN, "Type awal: atm, dealer, ammunation, gang_hq, job, race, business, house, interior.");
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

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        AmmuNationPickup[i] = -1;
        AmmuNationLabel[i] = Text3D:INVALID_3DTEXT_ID;
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

    for (new i = 0; i < MAX_JOB_WORLD_MARKERS; i++)
    {
        JobWorldPickup[i] = -1;
        JobWorldLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    for (new i = 0; i < MAX_BUS_STOPS; i++)
    {
        BusStopPickup[i] = -1;
        BusStopLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        TerritoryPickup[i] = -1;
        TerritoryLabel[i] = Text3D:INVALID_3DTEXT_ID;
        TerritoryZone[i] = -1;
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        GangHQPickup[i] = -1;
        GangHQLabel[i] = Text3D:INVALID_3DTEXT_ID;
    }

    ResetDynamicLocationArrays();

    RaceStartPickup = -1;
    RaceStartLabel = Text3D:INVALID_3DTEXT_ID;
    return 1;
}

stock CreateWorldInteractionMarkers()
{
    InitWorldMarkerArrays();
    CreateTerritoryGangZones();

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

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        AmmuNationPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, AmmuNationX[i], AmmuNationY[i], AmmuNationZ[i], 0);

        format(labelText, sizeof(labelText), "[ALT] Ammu-Nation\n%s\nWeapon Shop", AmmuNationName[i]);
        AmmuNationLabel[i] = Create3DTextLabel(labelText, COLOR_ORANGE, AmmuNationX[i], AmmuNationY[i], AmmuNationZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
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

    for (new i = 0; i < MAX_JOB_WORLD_MARKERS; i++)
    {
        JobWorldPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, JobWorldX[i], JobWorldY[i], JobWorldZ[i], 0);
        format(labelText, sizeof(labelText), "[JOB] %s\n%s", JobWorldName[i], JobWorldGuide[i]);
        JobWorldLabel[i] = Create3DTextLabel(labelText, COLOR_CYAN, JobWorldX[i], JobWorldY[i], JobWorldZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    for (new i = 0; i < MAX_BUS_STOPS; i++)
    {
        BusStopPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, BusStopX[i], BusStopY[i], BusStopZ[i], 0);
        format(labelText, sizeof(labelText), "[BUS STOP] %s\nBus Mission checkpoint route", BusStopName[i]);
        BusStopLabel[i] = Create3DTextLabel(labelText, COLOR_YELLOW, BusStopX[i], BusStopY[i], BusStopZ[i] + 0.8, WORLD_LABEL_DRAW_DISTANCE, 0, true);
    }

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        TerritoryPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, TerritoryX[i], TerritoryY[i], TerritoryZ[i], 0);
        UpdateTerritoryMarkerLabel(i);
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        GangHQPickup[i] = CreatePickup(WORLD_MARKER_PICKUP_MODEL, WORLD_MARKER_PICKUP_TYPE, GangHQX[i], GangHQY[i], GangHQZ[i], 0);
        format(labelText, sizeof(labelText), "[GANG HQ] %s\nALT: Join / Gang Menu", PresetGangShortName[i]);
        // Offset lebih tinggi agar tidak tumpuk dengan marker/label ALT lain di lokasi yang berdekatan.
        GangHQLabel[i] = Create3DTextLabel(labelText, PresetGangColor[i], GangHQX[i], GangHQY[i], GangHQZ[i] + 2.2, 16.0, 0, true);
    }

    print("[LSIF] World interaction markers, job markers, bus stops, territories, gang HQ, and 3D labels created.");
    print("[LSIF] Gang HQ labels use higher offset to avoid overlapping ALT labels.");
    return 1;
}

stock DestroyWorldInteractionMarkers()
{
    DestroyTerritoryGangZones();

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

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        if (AmmuNationPickup[i] != -1)
        {
            DestroyPickup(AmmuNationPickup[i]);
            AmmuNationPickup[i] = -1;
        }

        if (AmmuNationLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(AmmuNationLabel[i]);
            AmmuNationLabel[i] = Text3D:INVALID_3DTEXT_ID;
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

    for (new i = 0; i < MAX_JOB_WORLD_MARKERS; i++)
    {
        if (JobWorldPickup[i] != -1)
        {
            DestroyPickup(JobWorldPickup[i]);
            JobWorldPickup[i] = -1;
        }

        if (JobWorldLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(JobWorldLabel[i]);
            JobWorldLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_BUS_STOPS; i++)
    {
        if (BusStopPickup[i] != -1)
        {
            DestroyPickup(BusStopPickup[i]);
            BusStopPickup[i] = -1;
        }

        if (BusStopLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(BusStopLabel[i]);
            BusStopLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        if (TerritoryPickup[i] != -1)
        {
            DestroyPickup(TerritoryPickup[i]);
            TerritoryPickup[i] = -1;
        }

        if (TerritoryLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(TerritoryLabel[i]);
            TerritoryLabel[i] = Text3D:INVALID_3DTEXT_ID;
        }
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        if (GangHQPickup[i] != -1)
        {
            DestroyPickup(GangHQPickup[i]);
            GangHQPickup[i] = -1;
        }

        if (GangHQLabel[i] != Text3D:INVALID_3DTEXT_ID)
        {
            Delete3DTextLabel(GangHQLabel[i]);
            GangHQLabel[i] = Text3D:INVALID_3DTEXT_ID;
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

    DestroyDynamicLocationMarkers();

    return 1;
}

stock ApplyLSIFMapIcons(playerid)
{
    ApplyTerritoryZones(playerid);

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

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_AMMUNATION + i, AmmuNationX[i], AmmuNationY[i], AmmuNationZ[i], MAPICON_TYPE_AMMUNATION, COLOR_ORANGE, MAPICON_LOCAL);
    }

    SetPlayerMapIcon(playerid, MAPICON_BASE_RACE, RaceLSX[0], RaceLSY[0], RaceLSZ[0], MAPICON_TYPE_RACE, COLOR_ORANGE, MAPICON_LOCAL);

    for (new i = 0; i < MAX_JOB_WORLD_MARKERS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_JOB + i, JobWorldX[i], JobWorldY[i], JobWorldZ[i], MAPICON_TYPE_JOB, COLOR_CYAN, MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_BUS_STOPS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_BUS_STOP + i, BusStopX[i], BusStopY[i], BusStopZ[i], MAPICON_TYPE_BUS_STOP, COLOR_YELLOW, MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_TERRITORY + i, TerritoryX[i], TerritoryY[i], TerritoryZ[i], MAPICON_TYPE_TERRITORY, TerritoryOwnerColor[i], MAPICON_LOCAL);
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        SetPlayerMapIcon(playerid, MAPICON_BASE_GANG_HQ + i, GangHQX[i], GangHQY[i], GangHQZ[i], MAPICON_TYPE_GANG_HQ, PresetGangColor[i], MAPICON_LOCAL);
    }

    ApplyDynamicLocationIcons(playerid);

    return 1;
}

stock RemoveLSIFMapIcons(playerid)
{
    HideTerritoryZones(playerid);

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

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_AMMUNATION + i);
    }

    RemovePlayerMapIcon(playerid, MAPICON_BASE_RACE);

    for (new i = 0; i < MAX_JOB_WORLD_MARKERS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_JOB + i);
    }

    for (new i = 0; i < MAX_BUS_STOPS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_BUS_STOP + i);
    }

    for (new i = 0; i < MAX_TERRITORIES; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_TERRITORY + i);
    }

    for (new i = 0; i < MAX_PRESET_GANGS; i++)
    {
        RemovePlayerMapIcon(playerid, MAPICON_BASE_GANG_HQ + i);
    }

    RemoveDynamicLocationIcons(playerid);

    return 1;
}

stock ShowJobGuideMenu(playerid)
{
    ShowPlayerDialog(
        playerid,
        DIALOG_JOB_GUIDE_MENU,
        DIALOG_STYLE_LIST,
        "LSIF Job Guide",
        "Taxi Mission\nCourier Mission\nTrucker Mission\nBus Driver Mission\nPolice / Vigilante Mission",
        "Open",
        "Close"
    );
    return 1;
}

stock ShowJobGuideDetail(playerid, jobIndex)
{
    new guideText[1024];
    new title[64];

    if (jobIndex == 0)
    {
        format(title, sizeof(title), "Taxi Mission Guide");
        format(guideText, sizeof(guideText), "Cara mulai:\n1. Naik Taxi atau Cabbie sebagai driver.\n2. Tekan tombol 2 untuk mulai Taxi Mission.\n3. Ambil penumpang di checkpoint pickup.\n4. Antar ke checkpoint dropoff.\n\nReward dihitung berdasarkan jarak. Jika keluar kendaraan terlalu lama, mission batal.");
    }
    else if (jobIndex == 1)
    {
        format(title, sizeof(title), "Courier Mission Guide");
        format(guideText, sizeof(guideText), "Cara mulai:\n1. Naik Burrito, Boxville, Mule, Pony, atau Rumpo.\n2. Tekan tombol 2 untuk mulai Courier Mission.\n3. Ikuti checkpoint delivery.\n\nCocok untuk income awal. Cari marker [JOB] Courier Depot sebagai titik panduan dunia.");
    }
    else if (jobIndex == 2)
    {
        format(title, sizeof(title), "Trucker Mission Guide");
        format(guideText, sizeof(guideText), "Cara mulai:\n1. Naik truck valid: Linerunner, Tanker, Roadtrain, DFT-30, Flatbed, atau Yankee.\n2. Tekan tombol 2.\n3. Ambil cargo di pickup point.\n4. Kirim ke dropoff point.\n\nReward besar, jarak lebih jauh, cocok untuk player yang sudah punya truck.");
    }
    else if (jobIndex == 3)
    {
        format(title, sizeof(title), "Bus Driver Mission Guide");
        format(guideText, sizeof(guideText), "Cara mulai:\n1. Naik Bus atau Coach sebagai driver.\n2. Tekan tombol 2.\n3. Ikuti halte bus berurutan.\n\nSetiap halte memberi reward, selesai route memberi bonus. Cari icon Bus Stop di radar/map.");
    }
    else
    {
        format(title, sizeof(title), "Police / Vigilante Guide");
        format(guideText, sizeof(guideText), "Cara mulai:\n1. Naik police vehicle: Police Car, Ranger, Bike, atau Enforcer.\n2. Tekan tombol 2 untuk menerima call.\n3. Menuju suspect area checkpoint.\n\nTahap saat ini masih basic checkpoint. Nanti bisa dikembangkan menjadi chase/target system.");
    }

    ShowPlayerDialog(playerid, DIALOG_JOB_GUIDE_DETAIL, DIALOG_STYLE_MSGBOX, title, guideText, "Back", "Close");
    return 1;
}

stock ShowMapLegendDialog(playerid)
{
    new dialogText[768];

    format(
        dialogText,
        sizeof(dialogText),
        "Radar/Map Icon LSIF:\n\nATM/Bank - transaksi bank, pakai ALT di marker ATM.\nHouse - rumah/interior; ALT untuk menu, panah untuk masuk/keluar.\nBusiness - beli/manage/collect business dengan ALT.\nDealership - vehicle shop dan garage service dengan ALT.\nAmmu-Nation - weapon shop dengan ALT.\nTerritory/Turf - blok warna transparan di map sesuai owner gang. Lihat /turfmap atau /refreshzones.\nGang HQ - markas gang preset; tekan ALT untuk join/menu gang. Jika satu titik punya beberapa fungsi, ALT membuka Nearby Interaction Menu.\nRace - lokasi race/time trial.\nJob Marker - titik panduan vehicle mission/job.\nBus Stop - rute Bus Driver Mission.\n\nDi dunia, cari 3D label seperti [ALT] ATM, [ALT] Dealership, [ALT] Ammu-Nation, [ALT] Grove/Ballas/Vagos/Aztecas HQ, atau [JOB] Bus Terminal.\nALT = menu/transaksi. Tombol 2 = start vehicle mission/job. Turf map = /gangmenu atau /turfmap. Organization tetap untuk ekonomi/bisnis."
    );

    ShowPlayerDialog(playerid, DIALOG_BETA_MOTD, DIALOG_STYLE_MSGBOX, "LSIF Map Legend", dialogText, "OK", "Tutup");
    return 1;
}

stock ShowInteractionNoPoint(playerid)
{
    SendClientMessage(playerid, COLOR_YELLOW, "Tidak ada interaksi dekatmu.");
    SendClientMessage(playerid, COLOR_WHITE, "ALT dipakai di marker [ALT]: ATM, dealership, Ammu-Nation, house, dan business.");
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


stock ResetPlayerWeaponLoadoutData(playerid)
{
    for (new i = 0; i < MAX_SAVED_WEAPON_LOADOUT; i++)
    {
        PlayerSavedWeaponOwned[playerid][i] = 0;
        PlayerSavedWeaponAmmo[playerid][i] = 0;
    }
    return 1;
}

stock GetWeaponShopIndexFromWeaponID(weaponid)
{
    for (new i = 0; i < MAX_WEAPON_SHOP_ITEMS; i++)
    {
        if (WeaponShopWeaponID[i] == weaponid)
        {
            return i;
        }
    }
    return -1;
}

stock LoadPlayerWeaponLoadout(playerid)
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
        "SELECT weapon_id, ammo FROM player_weapons WHERE player_id=%d ORDER BY weapon_id ASC",
        PlayerDBID[playerid]
    );

    mysql_tquery(g_SQL, query, "OnPlayerWeaponsLoaded", "i", playerid);
    return 1;
}

stock SaveWeaponPurchase(playerid, weaponIndex)
{
    if (!PlayerLoggedIn[playerid] || PlayerDBID[playerid] <= 0)
    {
        return 0;
    }

    if (weaponIndex < 0 || weaponIndex >= MAX_WEAPON_SHOP_ITEMS)
    {
        return 0;
    }

    new query[512];
    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO player_weapons (player_id, weapon_id, weapon_name, ammo, total_purchased, last_purchased_at) VALUES (%d, %d, '%e', %d, 1, NOW()) ON DUPLICATE KEY UPDATE ammo=ammo+VALUES(ammo), total_purchased=total_purchased+1, weapon_name=VALUES(weapon_name), last_purchased_at=NOW()",
        PlayerDBID[playerid],
        WeaponShopWeaponID[weaponIndex],
        WeaponShopName[weaponIndex],
        WeaponShopAmmo[weaponIndex]
    );

    mysql_tquery(g_SQL, query);
    return 1;
}

stock ShowLoadoutDialog(playerid)
{
    new dialogText[1024];
    new found = 0;

    dialogText[0] = EOS;

    for (new i = 0; i < MAX_WEAPON_SHOP_ITEMS; i++)
    {
        if (PlayerSavedWeaponOwned[playerid][i] && PlayerSavedWeaponAmmo[playerid][i] > 0)
        {
            format(dialogText, sizeof(dialogText), "%s%s | Ammo: %d\n", dialogText, WeaponShopName[i], PlayerSavedWeaponAmmo[playerid][i]);
            found++;
        }
    }

    if (!found)
    {
        format(dialogText, sizeof(dialogText), "Belum ada saved weapon loadout.\n\nBeli weapon di Ammu-Nation agar tersimpan.");
    }
    else
    {
        format(dialogText, sizeof(dialogText), "%s\nGunakan /reloadout untuk apply ulang weapon setelah spawn.", dialogText);
    }

    ShowPlayerDialog(playerid, DIALOG_LOADOUT_INFO, DIALOG_STYLE_MSGBOX, "Saved Weapon Loadout", dialogText, "OK", "Tutup");
    return 1;
}

stock ShowWeaponLicenseDialog(playerid)
{
    new dialogText[384];
    format(
        dialogText,
        sizeof(dialogText),
        "Weapon License: %s\n\nLicense ini dipakai untuk akses pembelian weapon di Ammu-Nation.\nClosed beta default: basic license aktif.\n\nSaved loadout: /loadout\nApply ulang loadout: /reloadout",
        PlayerWeaponLicense[playerid] ? ("ACTIVE") : ("INACTIVE")
    );

    ShowPlayerDialog(playerid, DIALOG_WEAPON_LICENSE, DIALOG_STYLE_MSGBOX, "Weapon License", dialogText, "OK", "Tutup");
    return 1;
}

public OnPlayerWeaponsLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    ResetPlayerWeaponLoadoutData(playerid);

    new rows = cache_num_rows();
    new weaponid;
    new ammo;
    new index;

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "weapon_id", weaponid);
        cache_get_value_name_int(i, "ammo", ammo);

        index = GetWeaponShopIndexFromWeaponID(weaponid);

        if (index == -1)
        {
            continue;
        }

        PlayerSavedWeaponOwned[playerid][index] = 1;
        PlayerSavedWeaponAmmo[playerid][index] = ammo;
    }

    if (rows > 0)
    {
        SetTimerEx("ApplySavedWeaponLoadout", 1000, false, "i", playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Saved weapon loadout berhasil dimuat. Gunakan /loadout.");
    }

    return 1;
}

public ApplySavedWeaponLoadout(playerid)
{
    if (!IsPlayerConnected(playerid) || !PlayerLoggedIn[playerid])
    {
        return 1;
    }

    for (new i = 0; i < MAX_WEAPON_SHOP_ITEMS; i++)
    {
        if (PlayerSavedWeaponOwned[playerid][i] && PlayerSavedWeaponAmmo[playerid][i] > 0)
        {
            GivePlayerWeapon(playerid, t_WEAPON:WeaponShopWeaponID[i], PlayerSavedWeaponAmmo[playerid][i]);
        }
    }

    return 1;
}

stock GetNearestAmmuNation(playerid)
{
    new nearest = -1;
    new Float:nearestDistance = 999999.0;

    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        new Float:distance = GetPlayerDistanceFromPoint(playerid, AmmuNationX[i], AmmuNationY[i], AmmuNationZ[i]);

        if (distance < nearestDistance)
        {
            nearestDistance = distance;
            nearest = i;
        }
    }

    return nearest;
}

stock IsPlayerNearAmmuNation(playerid)
{
    for (new i = 0; i < MAX_AMMUNATIONS; i++)
    {
        if (GetPlayerDistanceFromPoint(playerid, AmmuNationX[i], AmmuNationY[i], AmmuNationZ[i]) <= AMMUNATION_ACCESS_RADIUS)
        {
            return 1;
        }
    }

    return 0;
}

stock ShowWeaponShopDialog(playerid)
{
    if (!IsPlayerNearAmmuNation(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat Ammu-Nation untuk membuka weapon shop.");
        SendClientMessage(playerid, COLOR_WHITE, "Cari icon Ammu-Nation di radar/map atau marker [ALT] Ammu-Nation.");
        return 0;
    }

    new dialogText[768];
    dialogText[0] = EOS;

    for (new i = 0; i < MAX_WEAPON_SHOP_ITEMS; i++)
    {
        format(dialogText, sizeof(dialogText), "%s%s - $%d - Ammo %d\n", dialogText, WeaponShopName[i], WeaponShopPrice[i], WeaponShopAmmo[i]);
    }

    ShowPlayerDialog(playerid, DIALOG_WEAPON_SHOP, DIALOG_STYLE_LIST, "Ammu-Nation Weapon Shop", dialogText, "Pilih", "Tutup");
    return 1;
}

stock ShowWeaponInfoDialog(playerid)
{
    new dialogText[1024];
    dialogText[0] = EOS;

    for (new i = 0; i < MAX_WEAPON_SHOP_ITEMS; i++)
    {
        format(dialogText, sizeof(dialogText), "%s%d. %s | Weapon ID %d | Ammo %d | Price $%d\n", dialogText, i + 1, WeaponShopName[i], WeaponShopWeaponID[i], WeaponShopAmmo[i], WeaponShopPrice[i]);
    }

    ShowPlayerDialog(playerid, DIALOG_WEAPON_INFO, DIALOG_STYLE_MSGBOX, "Weapon Shop Info / Saved Loadout", dialogText, "OK", "Tutup");
    return 1;
}

stock ShowWeaponConfirmDialog(playerid, weaponIndex)
{
    if (!IsPlayerNearAmmuNation(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu sudah tidak dekat Ammu-Nation.");
        return 0;
    }

    if (weaponIndex < 0 || weaponIndex >= MAX_WEAPON_SHOP_ITEMS)
    {
        SendClientMessage(playerid, COLOR_RED, "Pilihan weapon tidak valid.");
        return 0;
    }

    PlayerDialogWeaponIndex[playerid] = weaponIndex;

    new dialogText[256];
    format(
        dialogText,
        sizeof(dialogText),
        "Weapon: %s\nAmmo: %d\nPrice: $%d\n\nCash kamu: $%d\n\nBeli weapon ini?",
        WeaponShopName[weaponIndex],
        WeaponShopAmmo[weaponIndex],
        WeaponShopPrice[weaponIndex],
        PlayerMoney[playerid]
    );

    ShowPlayerDialog(playerid, DIALOG_WEAPON_CONFIRM, DIALOG_STYLE_MSGBOX, "Confirm Weapon Purchase", dialogText, "Buy", "Back");
    return 1;
}

stock ProcessWeaponPurchase(playerid, weaponIndex)
{
    if (!IsPlayerNearAmmuNation(playerid))
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu harus berada dekat Ammu-Nation untuk membeli weapon.");
        return 0;
    }

    if (weaponIndex < 0 || weaponIndex >= MAX_WEAPON_SHOP_ITEMS)
    {
        SendClientMessage(playerid, COLOR_RED, "Pilihan weapon tidak valid.");
        return 0;
    }

    if (!PlayerWeaponLicense[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Kamu belum punya weapon license.");
        SendClientMessage(playerid, COLOR_WHITE, "Gunakan /weaponlicense untuk cek status license.");
        return 0;
    }

    new price = WeaponShopPrice[weaponIndex];

    if (PlayerMoney[playerid] < price)
    {
        new msg[144];
        format(msg, sizeof(msg), "Cash tidak cukup. Harga %s adalah $%d.", WeaponShopName[weaponIndex], price);
        SendClientMessage(playerid, COLOR_RED, msg);
        ShowWeaponShopDialog(playerid);
        return 0;
    }

    TakePlayerCash(playerid, price);
    GivePlayerWeapon(playerid, t_WEAPON:WeaponShopWeaponID[weaponIndex], WeaponShopAmmo[weaponIndex]);

    PlayerSavedWeaponOwned[playerid][weaponIndex] = 1;
    PlayerSavedWeaponAmmo[playerid][weaponIndex] += WeaponShopAmmo[weaponIndex];

    SaveWeaponPurchase(playerid, weaponIndex);
    SavePlayerData(playerid);

    new msg[144];
    format(msg, sizeof(msg), "Ammu-Nation: kamu membeli %s dengan ammo %d seharga $%d.", WeaponShopName[weaponIndex], WeaponShopAmmo[weaponIndex], price);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    SendClientMessage(playerid, COLOR_WHITE, "Weapon sudah tersimpan ke saved loadout. Gunakan /loadout atau /reloadout.");
    return 1;
}

stock ResetNearbyInteractions(playerid)
{
    PlayerNearbyInteractionCount[playerid] = 0;

    for (new i = 0; i < MAX_NEARBY_INTERACTIONS; i++)
    {
        PlayerNearbyInteractionType[playerid][i] = 0;
        PlayerNearbyInteractionParam[playerid][i] = -1;
        format(PlayerNearbyInteractionLabel[playerid][i], 64, "");
    }

    return 1;
}

stock AddNearbyInteraction(playerid, interactionType, interactionParam, const interactionLabel[])
{
    new index = PlayerNearbyInteractionCount[playerid];

    if (index < 0 || index >= MAX_NEARBY_INTERACTIONS)
    {
        return 0;
    }

    PlayerNearbyInteractionType[playerid][index] = interactionType;
    PlayerNearbyInteractionParam[playerid][index] = interactionParam;
    format(PlayerNearbyInteractionLabel[playerid][index], 64, "%s", interactionLabel);

    PlayerNearbyInteractionCount[playerid]++;
    return 1;
}

stock ExecuteNearbyInteraction(playerid, index)
{
    if (index < 0 || index >= PlayerNearbyInteractionCount[playerid])
    {
        SendClientMessage(playerid, COLOR_RED, "Pilihan interaksi tidak valid.");
        return 0;
    }

    new interactionType = PlayerNearbyInteractionType[playerid][index];
    new interactionParam = PlayerNearbyInteractionParam[playerid][index];

    if (interactionType == INTERACT_TYPE_ATM)
    {
        if (!IsPlayerNearBankPoint(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari ATM.");
            return 0;
        }

        ShowATMDialog(playerid);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_DEALERSHIP)
    {
        if (!IsPlayerNearDealership(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari dealership.");
            return 0;
        }

        ShowDealershipMainDialog(playerid);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_AMMUNATION)
    {
        if (!IsPlayerNearAmmuNation(playerid))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari Ammu-Nation.");
            return 0;
        }

        ShowWeaponShopDialog(playerid);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_GANG_HQ)
    {
        ShowGangHQDialog(playerid, interactionParam);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_HOUSE)
    {
        if (!IsValidHouseIndex(interactionParam) || !IsPlayerNearHouse(playerid, interactionParam))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari rumah tersebut.");
            return 0;
        }

        ShowHouseInteractionDialog(playerid, interactionParam);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_BUSINESS)
    {
        if (!IsValidBusinessIndex(interactionParam) || !IsPlayerNearBusiness(playerid, interactionParam))
        {
            SendClientMessage(playerid, COLOR_RED, "Kamu sudah terlalu jauh dari business tersebut.");
            return 0;
        }

        ShowBusinessInteractionDialog(playerid, interactionParam);
        return 1;
    }

    if (interactionType == INTERACT_TYPE_DYNAMIC_LOCATION)
    {
        return ExecuteDynamicLocationFunction(playerid, interactionParam);
    }

    SendClientMessage(playerid, COLOR_RED, "Interaksi belum tersedia.");
    return 0;
}

stock ShowNearbyInteractionDialog(playerid)
{
    new count = PlayerNearbyInteractionCount[playerid];

    if (count <= 0)
    {
        ShowInteractionNoPoint(playerid);
        return 0;
    }

    if (count == 1)
    {
        return ExecuteNearbyInteraction(playerid, 0);
    }

    new body[512];
    new line[96];

    body[0] = EOS;

    for (new i = 0; i < count; i++)
    {
        format(line, sizeof(line), "%s\n", PlayerNearbyInteractionLabel[playerid][i]);
        strcat(body, line);
    }

    ShowPlayerDialog(playerid, DIALOG_NEARBY_INTERACTION, DIALOG_STYLE_LIST, "Nearby Interaction", body, "Select", "Close");
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

    ResetNearbyInteractions(playerid);

    if (IsPlayerNearBankPoint(playerid))
    {
        AddNearbyInteraction(playerid, INTERACT_TYPE_ATM, -1, "ATM / Bank");
    }

    if (IsPlayerNearDealership(playerid))
    {
        AddNearbyInteraction(playerid, INTERACT_TYPE_DEALERSHIP, -1, "Dealership / Garage Service");
    }

    if (IsPlayerNearAmmuNation(playerid))
    {
        AddNearbyInteraction(playerid, INTERACT_TYPE_AMMUNATION, -1, "Ammu-Nation / Weapon Shop");
    }

    new nearestGangHQ = GetNearestGangHQ(playerid);

    if (nearestGangHQ != -1 && IsPlayerNearGangHQ(playerid, nearestGangHQ))
    {
        new gangLabel[64];
        format(gangLabel, sizeof(gangLabel), "Gang HQ: %s", PresetGangShortName[nearestGangHQ]);
        AddNearbyInteraction(playerid, INTERACT_TYPE_GANG_HQ, PresetGangID[nearestGangHQ], gangLabel);
    }

    new nearestHouse = GetNearestHouse(playerid);

    if (nearestHouse != -1 && IsPlayerNearHouse(playerid, nearestHouse))
    {
        new houseLabel[64];
        format(houseLabel, sizeof(houseLabel), "House: %s", HouseName[nearestHouse]);
        AddNearbyInteraction(playerid, INTERACT_TYPE_HOUSE, nearestHouse, houseLabel);
    }

    new nearestBusiness = GetNearestBusiness(playerid);

    if (nearestBusiness != -1 && IsPlayerNearBusiness(playerid, nearestBusiness))
    {
        new businessLabel[64];
        format(businessLabel, sizeof(businessLabel), "Business: %s", BusinessName[nearestBusiness]);
        AddNearbyInteraction(playerid, INTERACT_TYPE_BUSINESS, nearestBusiness, businessLabel);
    }

    for (new d = 0; d < DynamicLocationCount; d++)
    {
        if (IsPlayerNearDynamicLocationIndex(playerid, d))
        {
            new dynLabel[64];

            if (DynamicLocationIsATM(d))
            {
                format(dynLabel, sizeof(dynLabel), "ATM: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsDealer(d))
            {
                format(dynLabel, sizeof(dynLabel), "Dealership: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsAmmu(d))
            {
                format(dynLabel, sizeof(dynLabel), "Ammu-Nation: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsGangHQ(d))
            {
                format(dynLabel, sizeof(dynLabel), "Gang HQ: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsJob(d))
            {
                format(dynLabel, sizeof(dynLabel), "Job Marker: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsRace(d))
            {
                format(dynLabel, sizeof(dynLabel), "Race Marker: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsHouse(d))
            {
                format(dynLabel, sizeof(dynLabel), "House Marker: %s", DynamicLocationName[d]);
            }
            else if (DynamicLocationIsBusiness(d))
            {
                format(dynLabel, sizeof(dynLabel), "Business Marker: %s", DynamicLocationName[d]);
            }
            else
            {
                format(dynLabel, sizeof(dynLabel), "Dynamic: %s (%s)", DynamicLocationName[d], DynamicLocationType[d]);
            }

            AddNearbyInteraction(playerid, INTERACT_TYPE_DYNAMIC_LOCATION, d, dynLabel);
        }
    }

    return ShowNearbyInteractionDialog(playerid);
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

    if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_BUS)
    {
        HandleBusCheckpoint(playerid);
        return 1;
    }

    if (PlayerWorking[playerid] && PlayerWorkType[playerid] == WORK_POLICE)
    {
        HandlePoliceCheckpoint(playerid);
        return 1;
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

    if (newstate == PLAYER_STATE_DRIVER)
    {
        SendVehicleMissionHint(playerid);
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


public EnsureAuthDialog(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (PlayerLoggedIn[playerid])
    {
        return 1;
    }

    if (PlayerAuthDialogShown[playerid])
    {
        return 1;
    }

    SendClientMessage(playerid, COLOR_YELLOW, "Auth flow fallback aktif. Membuka login/register ulang...");
    CheckBetaWhitelist(playerid);
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


public OnGangTerritoriesLoaded()
{
    new rows = cache_num_rows();
    new territoryIndex;
    new ownerGangID;
    new ownerColor;
    new ownerName[64];

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "territory_index", territoryIndex);
        cache_get_value_name_int(i, "owner_gang_id", ownerGangID);
        cache_get_value_name(i, "owner_gang_name", ownerName, sizeof(ownerName));
        cache_get_value_name_int(i, "owner_color", ownerColor);

        territoryIndex--;

        if (!IsValidTerritoryIndex(territoryIndex))
        {
            continue;
        }

        TerritoryOwnerGangID[territoryIndex] = ownerGangID;
        TerritoryOwnerColor[territoryIndex] = ownerColor;
        format(TerritoryOwnerName[territoryIndex], 64, "%s", ownerName);

        if (TerritoryOwnerGangID[territoryIndex] <= 0)
        {
            TerritoryOwnerColor[territoryIndex] = COLOR_GRAY;
            format(TerritoryOwnerName[territoryIndex], 64, "Neutral");
        }
    }

    RefreshAllTerritoryLabels();
    RefreshAllPlayerMapIcons();
    RefreshAllPlayerTerritoryZones();
    print("[LSIF] Gang territories ownership loaded and colored zones refreshed.");
    return 1;
}

public OnGangTerritoryGangLookup(playerid, territoryIndex, gangid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if (!IsAdminLevel(playerid, ADMIN_OWNER))
    {
        SendClientMessage(playerid, COLOR_RED, "Hanya Owner server yang bisa set territory owner.");
        return 1;
    }

    if (!IsValidTerritoryIndex(territoryIndex))
    {
        SendClientMessage(playerid, COLOR_RED, "Territory ID tidak valid.");
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gang ID tidak ditemukan.");
        return 1;
    }

    new gangName[64];
    new gangColor;
    new query[512];

    cache_get_value_name(0, "name", gangName, sizeof(gangName));
    cache_get_value_name_int(0, "gang_color", gangColor);

    TerritoryOwnerGangID[territoryIndex] = gangid;
    TerritoryOwnerColor[territoryIndex] = gangColor;
    format(TerritoryOwnerName[territoryIndex], 64, "%s", gangName);

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "UPDATE gang_territories SET owner_gang_id=%d, owner_gang_name='%e', owner_color=%d, updated_at=NOW() WHERE territory_index=%d LIMIT 1",
        gangid,
        gangName,
        gangColor,
        territoryIndex + 1
    );
    mysql_tquery(g_SQL, query);

    UpdateTerritoryMarkerLabel(territoryIndex);
    RefreshTerritoryZoneForAll(territoryIndex);
    RefreshAllPlayerMapIcons();

    new msg[144];
    format(msg, sizeof(msg), "Territory %s sekarang dimiliki gang %s.", TerritoryName[territoryIndex], gangName);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    return 1;
}

public OnGangColorUpdated(playerid, colorIndex)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new affectedRows = cache_affected_rows();

    if (affectedRows <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal mengubah gang color.");
        return 1;
    }

    new color = GangColorValue[colorIndex];
    PlayerGangColor[playerid] = color;
    ApplyGangColorToOnlineMembers(PlayerGangID[playerid], color);
    ApplyGangColorToTerritories(PlayerGangID[playerid], color);

    new msg[144];
    format(msg, sizeof(msg), "Gang color kamu diubah menjadi %s.", GangColorName[colorIndex]);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    return 1;
}

public OnPlayerGangLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();

    if (rows == 0)
    {
        ResetPlayerGangData(playerid);
        return 1;
    }

    cache_get_value_name_int(0, "gang_id", PlayerGangID[playerid]);
    cache_get_value_name_int(0, "rank_level", PlayerGangRank[playerid]);
    cache_get_value_name(0, "name", PlayerGangName[playerid], 64);
    cache_get_value_name_int(0, "gang_color", PlayerGangColor[playerid]);

    new msg[144];
    format(msg, sizeof(msg), "Gang dimuat: %s.", PlayerGangName[playerid]);
    SendClientMessage(playerid, COLOR_GREEN, msg);
    return 1;
}

public OnGangCreated(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new gangid = cache_insert_id();

    if (gangid <= 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gagal membuat gang. Nama mungkin sudah dipakai.");
        return 1;
    }

    TakePlayerCash(playerid, GANG_CREATE_PRICE);

    new playerName[MAX_PLAYER_NAME];
    new query[512];

    GetPlayerName(playerid, playerName, sizeof(playerName));

    mysql_format(
        g_SQL,
        query,
        sizeof(query),
        "INSERT INTO gang_members (gang_id, player_id, player_name, rank_level) VALUES (%d, %d, '%e', %d)",
        gangid,
        PlayerDBID[playerid],
        playerName,
        GANG_RANK_LEADER
    );
    mysql_tquery(g_SQL, query);

    PlayerGangID[playerid] = gangid;
    PlayerGangRank[playerid] = GANG_RANK_LEADER;
    PlayerGangColor[playerid] = DEFAULT_GANG_COLOR;
    format(PlayerGangName[playerid], 64, "%s", PlayerPendingGangName[playerid]);

    SendClientMessage(playerid, COLOR_GREEN, "Gang berhasil dibuat. Kamu menjadi Leader.");
    SendClientMessage(playerid, COLOR_WHITE, "Gunakan /gangmenu untuk mengelola gang.");
    return 1;
}

public OnGangInviteAccepted(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new inviterid = PlayerGangInvite[playerid];

    if (inviterid == INVALID_PLAYER_ID || !IsPlayerConnected(inviterid))
    {
        SendClientMessage(playerid, COLOR_RED, "Invite gang gagal karena inviter tidak online.");
        PlayerGangInvite[playerid] = INVALID_PLAYER_ID;
        return 1;
    }

    PlayerGangID[playerid] = PlayerGangID[inviterid];
    PlayerGangRank[playerid] = GANG_RANK_MEMBER;
    PlayerGangColor[playerid] = PlayerGangColor[inviterid];
    format(PlayerGangName[playerid], 64, "%s", PlayerGangName[inviterid]);
    PlayerGangInvite[playerid] = INVALID_PLAYER_ID;

    SendClientMessage(playerid, COLOR_GREEN, "Kamu berhasil bergabung ke gang.");

    new msg[144];
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    format(msg, sizeof(msg), "[GANG] %s bergabung ke gang.", playerName);
    SendMessageToGang(PlayerGangID[playerid], COLOR_PURPLE, msg);
    return 1;
}

public OnGangMembersLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[1536];
    new line[128];
    new memberName[24];
    new rank;
    new rankName[32];

    format(dialogText, sizeof(dialogText), "Name\tRank\n");

    if (rows == 0)
    {
        strcat(dialogText, "Tidak ada member\t-\n", sizeof(dialogText));
    }

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i, "player_name", memberName, sizeof(memberName));
        cache_get_value_name_int(i, "rank_level", rank);
        GetGangRankName(rank, rankName, sizeof(rankName));
        format(line, sizeof(line), "%s\t%s (%d)\n", memberName, rankName, rank);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_GANG_MEMBERS, DIALOG_STYLE_TABLIST_HEADERS, "Gang Members", dialogText, "Back", "Close");
    return 1;
}

public OnGangListLoaded(playerid)
{
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    new rows = cache_num_rows();
    new dialogText[1536];
    new line[160];
    new gangid;
    new name[64];
    new leaderName[24];
    new rep;

    format(dialogText, sizeof(dialogText), "ID\tGang Preset\tType\tRep\n");

    if (rows == 0)
    {
        strcat(dialogText, "-\tBelum ada gang\t-\t-\n", sizeof(dialogText));
    }

    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name_int(i, "id", gangid);
        cache_get_value_name(i, "name", name, sizeof(name));
        cache_get_value_name(i, "leader_name", leaderName, sizeof(leaderName));
        cache_get_value_name_int(i, "reputation", rep);
        format(line, sizeof(line), "%d\t%s\tPreset\t%d\n", gangid, name, rep);
        strcat(dialogText, line, sizeof(dialogText));
    }

    ShowPlayerDialog(playerid, DIALOG_GANG_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Gangs", dialogText, "Back", "Close");
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
        SendClientMessage(playerid, COLOR_GREEN, "Map icon dan territory zone LSIF sudah direfresh.");
        return 1;
    }

    if (!strcmp(cmdtext, "/refreshzones", true))
    {
        HideTerritoryZones(playerid);
        ApplyTerritoryZones(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Territory colored zones sudah direfresh.");
        return 1;
    }

    if (!strcmp(cmdtext, "/weaponshop", true))
    {
        ShowWeaponShopDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/weaponinfo", true))
    {
        ShowWeaponInfoDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/loadout", true))
    {
        ShowLoadoutDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/reloadout", true))
    {
        ResetPlayerWeapons(playerid);
        ApplySavedWeaponLoadout(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Saved weapon loadout sudah di-apply ulang.");
        return 1;
    }

    if (!strcmp(cmdtext, "/weaponlicense", true))
    {
        ShowWeaponLicenseDialog(playerid);
        return 1;
    }

    if (strfind(cmdtext, "/givelicense ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa memberi weapon license.");
            return 1;
        }

        new targetStr[16];

        if (!GetOneParam(cmdtext[13], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /givelicense [playerid]");
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

        PlayerWeaponLicense[targetid] = 1;
        SavePlayerData(targetid);

        SendClientMessage(targetid, COLOR_GREEN, "Kamu menerima basic weapon license dari admin.");
        SendClientMessage(playerid, COLOR_GREEN, "Weapon license berhasil diberikan.");
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


    if (!strcmp(cmdtext, "/gangmenu", true))
    {
        ShowGangMenuDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/ganginfo", true))
    {
        ShowGangInfoDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/gangs", true))
    {
        mysql_tquery(g_SQL, "SELECT id, name, leader_name, reputation FROM gangs WHERE id BETWEEN 1 AND 4 ORDER BY id ASC", "OnGangListLoaded", "i", playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/turfmap", true) || !strcmp(cmdtext, "/territories", true))
    {
        ShowTurfMapDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/gangmembers", true))
    {
        ShowGangMembersDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/gangcolor", true) || strfind(cmdtext, "/gangcolor ", true) == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gang color fixed mengikuti versi offline GTA SA dan tidak bisa diubah player.");
        return 1;
    }

    if (!strcmp(cmdtext, "/creategang", true) || strfind(cmdtext, "/creategang ", true) == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Gang tidak bisa dibuat player. Datang ke HQ gang preset lalu tekan ALT untuk join.");
        return 1;
    }

    if (!strcmp(cmdtext, "/invitegang", true) || strfind(cmdtext, "/invitegang ", true) == 0 || !strcmp(cmdtext, "/acceptgang", true))
    {
        SendClientMessage(playerid, COLOR_RED, "Gang tidak memakai sistem invite. Join gang dilakukan langsung di HQ dengan ALT.");
        return 1;
    }

    if (!strcmp(cmdtext, "/disbandgang", true))
    {
        SendClientMessage(playerid, COLOR_RED, "Gang adalah faction preset offline-like dan tidak bisa dibubarkan player.");
        return 1;
    }

    if (!strcmp(cmdtext, "/leavegang", true))
    {
        ProcessLeaveGang(playerid);
        return 1;
    }

    if (strfind(cmdtext, "/kickgang ", true) == 0)
    {
        new targetStr[16];

        if (!GetOneParam(cmdtext[10], targetStr, sizeof(targetStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kickgang [playerid]");
            return 1;
        }

        if (!IsNumericString(targetStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID harus angka.");
            return 1;
        }

        ProcessKickGangMember(playerid, strval(targetStr));
        return 1;
    }

    if (!strcmp(cmdtext, "/kickgang", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /kickgang [playerid]");
        return 1;
    }

    if (strfind(cmdtext, "/setgangrank ", true) == 0)
    {
        new targetStr[16];
        new rankStr[16];

        if (!GetTwoParams(cmdtext[13], targetStr, sizeof(targetStr), rankStr, sizeof(rankStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setgangrank [playerid] [rank]");
            SendClientMessage(playerid, COLOR_WHITE, "Rank: 1 Member, 2 Soldier, 3 Enforcer, 4 OG, 5 Gang Boss");
            return 1;
        }

        if (!IsNumericString(targetStr) || !IsNumericString(rankStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Player ID dan rank harus angka.");
            return 1;
        }

        ProcessSetGangRank(playerid, strval(targetStr), strval(rankStr));
        return 1;
    }

    if (!strcmp(cmdtext, "/setgangrank", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setgangrank [playerid] [rank]");
        return 1;
    }

    if (strfind(cmdtext, "/setterritory ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner server yang bisa set territory owner.");
            return 1;
        }

        new territoryStr[16];
        new gangStr[16];

        if (!GetTwoParams(cmdtext[14], territoryStr, sizeof(territoryStr), gangStr, sizeof(gangStr)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /setterritory [territory_id] [gang_id]");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan gang_id 0 untuk Neutral. Lihat ID territory di /turfmap dan gang ID di /gangs.");
            return 1;
        }

        if (!IsNumericString(territoryStr) || !IsNumericString(gangStr))
        {
            SendClientMessage(playerid, COLOR_RED, "Territory ID dan Gang ID harus angka.");
            return 1;
        }

        new territoryIndex = strval(territoryStr) - 1;
        new gangid = strval(gangStr);

        if (!IsValidTerritoryIndex(territoryIndex))
        {
            SendClientMessage(playerid, COLOR_RED, "Territory ID tidak valid.");
            return 1;
        }

        if (gangid > 0 && !IsPresetGangID(gangid))
        {
            SendClientMessage(playerid, COLOR_RED, "Gang ID harus gang preset. Lihat /gangs.");
            return 1;
        }

        if (gangid <= 0)
        {
            TerritoryOwnerGangID[territoryIndex] = 0;
            TerritoryOwnerColor[territoryIndex] = COLOR_GRAY;
            format(TerritoryOwnerName[territoryIndex], 64, "Neutral");

            new query[256];
            mysql_format(g_SQL, query, sizeof(query), "UPDATE gang_territories SET owner_gang_id=0, owner_gang_name='Neutral', owner_color=%d, updated_at=NOW() WHERE territory_index=%d LIMIT 1", COLOR_GRAY, territoryIndex + 1);
            mysql_tquery(g_SQL, query);

            UpdateTerritoryMarkerLabel(territoryIndex);
            RefreshAllPlayerMapIcons();
            SendClientMessage(playerid, COLOR_GREEN, "Territory berhasil dikembalikan ke Neutral.");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "SELECT id, name, gang_color FROM gangs WHERE id=%d LIMIT 1", gangid);
        mysql_tquery(g_SQL, query, "OnGangTerritoryGangLookup", "iii", playerid, territoryIndex, gangid);
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
        SendClientMessage(playerid, COLOR_WHITE, "/refreshzones - Refresh blok warna territory/turf");
        SendClientMessage(playerid, COLOR_WHITE, "/weaponshop - Buka Ammu-Nation Weapon Shop, harus dekat Ammu-Nation");
        SendClientMessage(playerid, COLOR_WHITE, "/weaponinfo - Lihat daftar weapon dan harga");
        SendClientMessage(playerid, COLOR_WHITE, "/weaponlicense - Cek status weapon license");
        SendClientMessage(playerid, COLOR_WHITE, "/gangmenu - Menu gang/territory");
        SendClientMessage(playerid, COLOR_WHITE, "/gangs - Lihat daftar gang");
        SendClientMessage(playerid, COLOR_WHITE, "Gang preset: datang ke HQ gang lalu ALT untuk join");
        SendClientMessage(playerid, COLOR_WHITE, "/leavegang - Keluar dari gang | /kickgang [id] - Gang Boss only");
        SendClientMessage(playerid, COLOR_WHITE, "/turfmap - Lihat territory map");
        SendClientMessage(playerid, COLOR_WHITE, "/setgangrank [id] [rank] - Owner server only untuk testing rank gang");
        SendClientMessage(playerid, COLOR_WHITE, "/setterritory [territory] [gang] - Set owner turf, Owner server only");
        SendClientMessage(playerid, COLOR_WHITE, "/loadout - Lihat saved weapon loadout");
        SendClientMessage(playerid, COLOR_WHITE, "/reloadout - Apply ulang saved weapon loadout");
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
        SendClientMessage(playerid, COLOR_WHITE, "/jobguide - Panduan job/vehicle mission");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob courier - Ambil job courier");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob taxi - Ambil job taxi");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob trucker - Ambil job trucker");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob bus - Ambil job bus driver");
        SendClientMessage(playerid, COLOR_WHITE, "/joinjob police - Ambil job police/vigilante");
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
        SendClientMessage(playerid, COLOR_WHITE, "Version: v0.21B.1 Dynamic Location Integration Fix (SAIF candidate)");
        SendClientMessage(playerid, COLOR_WHITE, "Stage: Closed Beta Candidate");
        SendClientMessage(playerid, COLOR_CYAN, "Gunakan /changelog untuk melihat ringkasan update.");
        return 1;
    }

    if (!strcmp(cmdtext, "/changelog", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== LSIF CHANGELOG ==========");
        SendClientMessage(playerid, COLOR_WHITE, "v0.21B.1: Dynamic location integration diperbaiki; type/name kini dibaca lebih fleksibel untuk ATM, dealer, Ammu-Nation, gang HQ, job, race, house, business.");
        SendClientMessage(playerid, COLOR_WHITE, "v0.19B: Weapon license dan saved loadout persistence.");
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

    if (!strcmp(cmdtext, "/jobguide", true))
    {
        ShowJobGuideMenu(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/jobs", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== JOBS ==========");
        SendClientMessage(playerid, COLOR_WHITE, "courier - Delivery van + tombol 2.");
        SendClientMessage(playerid, COLOR_WHITE, "taxi - Taxi/Cabbie + tombol 2.");
        SendClientMessage(playerid, COLOR_WHITE, "trucker - Truck + tombol 2.");
        SendClientMessage(playerid, COLOR_WHITE, "bus - Bus/Coach route + tombol 2.");
        SendClientMessage(playerid, COLOR_WHITE, "police - Police/Vigilante basic call + tombol 2.");
        SendClientMessage(playerid, COLOR_CYAN, "Cara utama: naik kendaraan job lalu tekan tombol 2. /joinjob dan /work tetap fallback.");
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

    if (!strcmp(cmdtext, "/joinjob bus", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan atau batalkan pekerjaan aktif dulu.");
            return 1;
        }

        PlayerJob[playerid] = JOB_BUS;
        SavePlayerData(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Kamu sekarang bekerja sebagai Bus Driver.");
        SendClientMessage(playerid, COLOR_WHITE, "Naik Bus/Coach lalu tekan tombol 2 untuk mulai route.");
        return 1;
    }

    if (!strcmp(cmdtext, "/joinjob police", true) || !strcmp(cmdtext, "/joinjob vigilante", true))
    {
        if (PlayerWorking[playerid])
        {
            SendClientMessage(playerid, COLOR_RED, "Selesaikan atau batalkan pekerjaan aktif dulu.");
            return 1;
        }

        PlayerJob[playerid] = JOB_POLICE;
        SavePlayerData(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Kamu sekarang aktif sebagai Police / Vigilante.");
        SendClientMessage(playerid, COLOR_WHITE, "Naik kendaraan polisi lalu tekan tombol 2 untuk mulai call.");
        return 1;
    }

    if (strfind(cmdtext, "/joinjob", true) == 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /joinjob courier, taxi, trucker, bus, atau police");
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

        if (PlayerJob[playerid] == JOB_BUS)
        {
            StartBusWork(playerid);
            return 1;
        }

        if (PlayerJob[playerid] == JOB_POLICE)
        {
            StartPoliceWork(playerid);
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

        if (PlayerJob[playerid] == JOB_BUS)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tugas: jalankan rute bus antar halte di Los Santos.");
            SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Bus atau Coach. Cara utama: tekan tombol 2 saat menjadi driver.");

            new cooldownLeft = GetBusCooldownLeft(playerid);
            if (cooldownLeft > 0)
            {
                format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
                SendClientMessage(playerid, COLOR_YELLOW, msg);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap menjalankan route.");
            }
            return 1;
        }

        if (PlayerJob[playerid] == JOB_POLICE)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tugas: tanggapi panggilan vigilante di checkpoint suspect area.");
            SendClientMessage(playerid, COLOR_WHITE, "Kendaraan valid: Police car, ranger, bike, atau enforcer. Tekan tombol 2 untuk mulai.");

            new cooldownLeft = GetPoliceCooldownLeft(playerid);
            if (cooldownLeft > 0)
            {
                format(msg, sizeof(msg), "Cooldown: %d detik.", cooldownLeft);
                SendClientMessage(playerid, COLOR_YELLOW, msg);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Cooldown: siap menerima call.");
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
        SendClientMessage(playerid, COLOR_WHITE, "/givelicense [id] - Beri basic weapon license, Owner only");
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
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /jobtop [courier/taxi/trucker/bus/police]");
            return 1;
        }

        if (!IsValidJobCode(jobCode))
        {
            SendClientMessage(playerid, COLOR_RED, "Job tidak valid. Pilih: courier, taxi, trucker, bus, atau police.");
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
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /jobtop [courier/taxi/trucker/bus/police]");
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

        format(msg, sizeof(msg), "Gamemode: LSIF Dev v0.19B Weapon License");
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

    if (!strcmp(cmdtext, "/lociconlist", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa melihat icon preset dynamic location.");
            return 1;
        }

        ShowDynamicLocationIconPresetDialog(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/locmenu", true))
    {
        ShowDynamicLocationEditorMenu(playerid);
        return 1;
    }

    if (!strcmp(cmdtext, "/locreload", true))
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa reload dynamic locations.");
            return 1;
        }

        LoadDynamicLocations();
        SendClientMessage(playerid, COLOR_GREEN, "Dynamic locations sedang direload dari database.");
        return 1;
    }

    if (strfind(cmdtext, "/loccreate ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa membuat dynamic location.");
            return 1;
        }

        new locType[LOC_TYPE_SIZE];
        new locName[LOC_NAME_SIZE];

        if (!GetFirstParamAndRest(cmdtext[11], locType, sizeof(locType), locName, sizeof(locName)))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /loccreate [type] [name]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh: /loccreate atm Idlewood 24/7 ATM");
            return 1;
        }

        CreateDynamicLocationAtPlayer(playerid, locType, locName);
        return 1;
    }

    if (!strcmp(cmdtext, "/loccreate", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /loccreate [type] [name]");
        return 1;
    }

    if (strfind(cmdtext, "/locuse ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa test-use dynamic location.");
            return 1;
        }

        new idStr[16];

        if (!GetOneParam(cmdtext[8], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locuse [id]");
            return 1;
        }

        new locIndex = FindDynamicLocationIndexByDBID(strval(idStr));

        if (locIndex == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Dynamic location tidak ditemukan/aktif. Gunakan /loclist atau /locreload.");
            return 1;
        }

        ExecuteDynamicLocationFunction(playerid, locIndex);
        return 1;
    }

    if (!strcmp(cmdtext, "/locuse", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locuse [id]");
        return 1;
    }

    if (!strcmp(cmdtext, "/loclist", true) || strfind(cmdtext, "/loclist ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa melihat dynamic locations.");
            return 1;
        }

        new filterType[LOC_TYPE_SIZE];
        new useFilter = 0;
        new msg[144];
        new found = 0;

        if (strfind(cmdtext, "/loclist ", true) == 0)
        {
            format(filterType, sizeof(filterType), "%s", cmdtext[9]);
            useFilter = 1;
        }

        SendClientMessage(playerid, COLOR_YELLOW, "========== DYNAMIC LOCATIONS ==========");

        for (new i = 0; i < DynamicLocationCount; i++)
        {
            if (useFilter && strcmp(DynamicLocationType[i], filterType, true))
            {
                continue;
            }

            format(msg, sizeof(msg), "ID %d | %s | %s | Icon %d | VW %d", DynamicLocationDBID[i], DynamicLocationType[i], DynamicLocationName[i], DynamicLocationMapIcon[i], DynamicLocationVirtualWorld[i]);
            SendClientMessage(playerid, COLOR_WHITE, msg);
            found++;
        }

        if (!found)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Tidak ada dynamic location aktif untuk filter tersebut.");
        }

        return 1;
    }

    if (strfind(cmdtext, "/locinfo ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa melihat detail dynamic location.");
            return 1;
        }

        new idStr[16];
        if (!GetOneParam(cmdtext[9], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locinfo [id]");
            return 1;
        }

        new dbid = strval(idStr);
        new locIndex = FindDynamicLocationIndexByDBID(dbid);

        if (locIndex == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Dynamic location tidak ditemukan/aktif. Gunakan /loclist.");
            return 1;
        }

        new msg[144];
        SendClientMessage(playerid, COLOR_YELLOW, "========== LOCATION INFO ==========");
        format(msg, sizeof(msg), "ID %d | Type: %s | Name: %s", DynamicLocationDBID[locIndex], DynamicLocationType[locIndex], DynamicLocationName[locIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);
        format(msg, sizeof(msg), "Pos: %.2f, %.2f, %.2f | A %.2f", DynamicLocationX[locIndex], DynamicLocationY[locIndex], DynamicLocationZ[locIndex], DynamicLocationA[locIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);
        format(msg, sizeof(msg), "Interior: %d | VW: %d | Icon: %d | Pickup: %d | Object: %d | Radius: %.1f", DynamicLocationInterior[locIndex], DynamicLocationVirtualWorld[locIndex], DynamicLocationMapIcon[locIndex], DynamicLocationPickupModel[locIndex], DynamicLocationObjectModel[locIndex], DynamicLocationRadius[locIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);
        format(msg, sizeof(msg), "Label: %s", DynamicLocationLabelText[locIndex]);
        SendClientMessage(playerid, COLOR_WHITE, msg);
        return 1;
    }

    if (strfind(cmdtext, "/locmove ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa memindahkan dynamic location.");
            return 1;
        }

        new idStr[16];
        if (!GetOneParam(cmdtext[9], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locmove [id]");
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
            "UPDATE world_locations SET pos_x=%f, pos_y=%f, pos_z=%f, pos_a=%f, interior=%d, virtual_world=%d WHERE id=%d LIMIT 1",
            x,
            y,
            z,
            a,
            GetPlayerInterior(playerid),
            GetPlayerVirtualWorld(playerid),
            strval(idStr)
        );
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locgoto ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa teleport ke dynamic location.");
            return 1;
        }

        new idStr[16];
        if (!GetOneParam(cmdtext[9], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locgoto [id]");
            return 1;
        }

        new locIndex = FindDynamicLocationIndexByDBID(strval(idStr));
        if (locIndex == -1)
        {
            SendClientMessage(playerid, COLOR_RED, "Dynamic location tidak ditemukan/aktif. Gunakan /loclist.");
            return 1;
        }

        SetPlayerInterior(playerid, DynamicLocationInterior[locIndex]);
        SetPlayerVirtualWorld(playerid, DynamicLocationVirtualWorld[locIndex]);
        SetPlayerPos(playerid, DynamicLocationX[locIndex], DynamicLocationY[locIndex], DynamicLocationZ[locIndex] + 1.0);
        SetPlayerFacingAngle(playerid, DynamicLocationA[locIndex]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport ke dynamic location berhasil.");
        return 1;
    }

    if (strfind(cmdtext, "/locdisable ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa disable dynamic location.");
            return 1;
        }

        new idStr[16];
        if (!GetOneParam(cmdtext[12], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locdisable [id]");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET enabled=0 WHERE id=%d LIMIT 1", strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationDeleted", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locdelete ", true) == 0 || strfind(cmdtext, "/locremove ", true) == 0 || strfind(cmdtext, "/locpurge ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa menghapus dynamic location.");
            return 1;
        }

        new idStr[16];
        new startIndex = 11;
        if (strfind(cmdtext, "/locpurge ", true) == 0) startIndex = 10;

        if (!GetOneParam(cmdtext[startIndex], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locdelete [id] atau /locremove [id]");
            SendClientMessage(playerid, COLOR_WHITE, "Catatan: ini hard delete dari database. /locdisable hanya hide sementara.");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM world_locations WHERE id=%d LIMIT 1", strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationPurged", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locenable ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa enable dynamic location.");
            return 1;
        }

        new idStr[16];
        if (!GetOneParam(cmdtext[11], idStr, sizeof(idStr)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locenable [id]");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET enabled=1 WHERE id=%d LIMIT 1", strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locicon ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa ubah radar icon dynamic location.");
            return 1;
        }

        new idStr[16];
        new iconStr[16];
        if (!GetTwoParams(cmdtext[9], idStr, sizeof(idStr), iconStr, sizeof(iconStr)) || !IsNumericString(idStr) || !IsNumericString(iconStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locicon [id] [icon]");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET map_icon=%d WHERE id=%d LIMIT 1", strval(iconStr), strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locpickup ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa ubah pickup dynamic location.");
            return 1;
        }

        new idStr[16];
        new pickupStr[16];
        if (!GetTwoParams(cmdtext[11], idStr, sizeof(idStr), pickupStr, sizeof(pickupStr)) || !IsNumericString(idStr) || !IsNumericString(pickupStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locpickup [id] [modelid]");
            SendClientMessage(playerid, COLOR_WHITE, "Contoh marker: /locpickup 1 1239. Gunakan 0 untuk hapus marker.");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET pickup_model=%d WHERE id=%d LIMIT 1", strval(pickupStr), strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/locobject ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa ubah object visual dynamic location.");
            return 1;
        }

        new idStr[16];
        new objectStr[16];
        if (!GetTwoParams(cmdtext[11], idStr, sizeof(idStr), objectStr, sizeof(objectStr)) || !IsNumericString(idStr) || !IsNumericString(objectStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locobject [id] [object_modelid]");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan 0 untuk hapus object. Contoh object ATM: /locobject 1 2942");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET object_model=%d WHERE id=%d LIMIT 1", strval(objectStr), strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }


    if (strfind(cmdtext, "/locradius ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa ubah radius dynamic location.");
            return 1;
        }

        new idStr[16];
        new radiusStr[16];
        if (!GetTwoParams(cmdtext[11], idStr, sizeof(idStr), radiusStr, sizeof(radiusStr)) || !IsNumericString(idStr) || !IsNumericString(radiusStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /locradius [id] [radius]");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET interaction_radius=%d WHERE id=%d LIMIT 1", strval(radiusStr), strval(idStr));
        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    if (strfind(cmdtext, "/loclabel ", true) == 0)
    {
        if (!IsAdminLevel(playerid, ADMIN_OWNER))
        {
            SendClientMessage(playerid, COLOR_RED, "Hanya Owner yang bisa ubah label dynamic location.");
            return 1;
        }

        new idStr[16];
        new labelText[LOC_LABEL_SIZE];
        if (!GetFirstParamAndRest(cmdtext[10], idStr, sizeof(idStr), labelText, sizeof(labelText)) || !IsNumericString(idStr))
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Gunakan: /loclabel [id] [text]");
            SendClientMessage(playerid, COLOR_WHITE, "Gunakan /loclabel [id] off untuk hide label, /loclabel [id] auto untuk default label.");
            return 1;
        }

        new query[512];

        if (!strcmp(labelText, "0", true) || !strcmp(labelText, "off", true) || !strcmp(labelText, "none", true) || !strcmp(labelText, "hide", true))
        {
            mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET label_text='__hidden__' WHERE id=%d LIMIT 1", strval(idStr));
        }
        else if (!strcmp(labelText, "auto", true) || !strcmp(labelText, "default", true))
        {
            mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET label_text='' WHERE id=%d LIMIT 1", strval(idStr));
        }
        else
        {
            mysql_format(g_SQL, query, sizeof(query), "UPDATE world_locations SET label_text='%e' WHERE id=%d LIMIT 1", labelText, strval(idStr));
        }

        mysql_tquery(g_SQL, query, "OnDynamicLocationUpdated", "i", playerid);
        return 1;
    }

    SendClientMessage(playerid, COLOR_RED, "Command tidak ditemukan. Gunakan /help.");
    return 1;
}
