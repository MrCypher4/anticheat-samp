#define MAX_TROLL_DISTANCE 1500.0
#define MAX_HEIGHT 500.0
#define MAX_SPAM_TIME 3000
#define RAPID_FIRE_LIMIT 100
#define TELEPORT_MAX_DISTANCE 200.0
#define CBUG_THRESHOLD 0.3
#define AIRBREAK_Z_LIMIT 500.0
#define FCRASH_THRESHOLD 200
#define MAX_CARS_IN_VEHICLE 5
#define VEHICLE_TROLL_DISTANCE 20.0

static lastChatTime[MAX_PLAYERS];
static lastWeaponFireTime[MAX_PLAYERS];
static playerSpawnWeapons[MAX_PLAYERS];
static lastPosition[MAX_PLAYERS][3];
static vehicleLogs[MAX_PLAYERS][MAX_CARS_IN_VEHICLE];
static lastCommandTime[MAX_PLAYERS];

public OnPlayerConnect(playerid) {
    lastChatTime[playerid] = 0;
    lastWeaponFireTime[playerid] = 0;
    playerSpawnWeapons[playerid] = 0;
    lastPosition[playerid][0] = 0.0;
    lastPosition[playerid][1] = 0.0;
    lastPosition[playerid][2] = 0.0;
    for (new i = 0; i < MAX_CARS_IN_VEHICLE; i++) {
        vehicleLogs[playerid][i] = 0;
    }
}

public OnPlayerUpdate(playerid) {
    new Float:playerPosX, Float:playerPosY, Float:playerPosZ;
    GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);

    if (playerPosZ > AIRBREAK_Z_LIMIT || playerPosZ < -AIRBREAK_Z_LIMIT) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Airbreak terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Airbreak");
        return 1;
    }

    if (playerPosZ > MAX_HEIGHT || playerPosZ < -MAX_HEIGHT) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Terbang terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Terbang");
        return 1;
    }

    if (IsPlayerMoving(playerid, playerPosX, playerPosY, playerPosZ)) {
        new Float:dist = Float:Distance(lastPosition[playerid][0], lastPosition[playerid][1], lastPosition[playerid][2], playerPosX, playerPosY, playerPosZ);
        if (dist > MAX_TROLL_DISTANCE) {
            Kick(playerid);
            SendClientMessage(playerid, 0xFF0000FF, "Troll terdeteksi. Anda telah dikeluarkan.");
            LogCheat(playerid, "Troll");
            return 1;
        }
    }
    lastPosition[playerid][0] = playerPosX;
    lastPosition[playerid][1] = playerPosY;
    lastPosition[playerid][2] = playerPosZ;

    return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, Float:targetX, Float:targetY, Float:targetZ) {
    new currentTime = GetTickCount();

    if (weaponid == 35 || weaponid == 36 || weaponid == 37) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Spawn gun terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Spawn Gun");
        return 1;
    }

    if (weaponid == 24 && (currentTime - lastWeaponFireTime[playerid] < RAPID_FIRE_LIMIT)) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Rapid Fire terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Rapid Fire");
        return 1;
    }

    lastWeaponFireTime[playerid] = currentTime;
    return 1;
}

public OnPlayerTakeDamage(playerid, attackerid, Float:amount, weaponid, bodypart) {
    new Float:playerPosX1, Float:playerPosY1, Float:playerPosZ1;
    new Float:playerPosX2, Float:playerPosY2, Float:playerPosZ2;
    GetPlayerPos(playerid, playerPosX1, playerPosY1, playerPosZ1);
    GetPlayerPos(attackerid, playerPosX2, playerPosY2, playerPosZ2);
    new dist = Float:Distance(playerPosX1, playerPosY1, playerPosZ1, playerPosX2, playerPosY2, playerPosZ2);

    if (dist > TELEPORT_MAX_DISTANCE) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Teleport terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Teleport");
        return 1;
    }
    return 1;
}

public OnPlayerText(playerid, text[]) {
    new currentTime = GetTickCount();
    if (currentTime - lastChatTime[playerid] < MAX_SPAM_TIME) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Spam chat terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Spam Chat");
        return 0;
    }
    lastChatTime[playerid] = currentTime;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if (strstr(cmdtext, "rcon") != -1 || strstr(cmdtext, "rcon_password") != -1) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "RCON Abuse terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "RCON Abuse");
        return 1;
    }
    return 0;
}

public IsPlayerMoving(playerid, Float:playerPosX, Float:playerPosY, Float:playerPosZ) {
    new Float:lastPosX, Float:lastPosY, Float:lastPosZ;
    GetPlayerPos(playerid, lastPosX, lastPosY, lastPosZ);
    new Float:dist = Float:Distance(lastPosX, lastPosY, lastPosZ, playerPosX, playerPosY, playerPosZ);
    return dist > 5.0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, seatid) {
    if (IsPlayerCarTrolling(playerid, vehicleid)) {
        Kick(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "Car Troll terdeteksi. Anda telah dikeluarkan.");
        LogCheat(playerid, "Car Troll");
        return 1;
    }
    return 1;
}

public IsPlayerCarTrolling(playerid, vehicleid) {
    // Logic for detecting car trolling (e.g. using vehicles inappropriately)
    new playerPosX, playerPosY, playerPosZ;
    GetPlayerPos(playerid, playerPosX, playerPosY, playerPosZ);

    for (new i = 0; i < MAX_CARS_IN_VEHICLE; i++) {
        if (vehicleLogs[playerid][i] == vehicleid) {
            new Float:dist = Float:Distance(playerPosX, playerPosY, playerPosZ, vehicleLogs[playerid][i]);
            if (dist < VEHICLE_TROLL_DISTANCE) {
                return true;
            }
        }
    }
    return false;
}

public LogCheat(playerid, cheatName[]) {
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new logMessage[128];
    format(logMessage, sizeof(logMessage), "[CHEAT LOG] Player: %s, Cheat: %s, IP: %s", playerName, cheatName, GetPlayerIP(playerid));
    SendLogToServer(logMessage);
}

public SendLogToServer(const logMessage[]) {
    // Placeholder for sending log to a file or database for further investigation
}
