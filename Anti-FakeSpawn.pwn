//Name:Simple Anti FakeSpawn
//Developer: VatierSynth
//Features: block player entry without clear connection, anti-bypass system
//Program Script: pawn, anti fakespawn programs
//version: no version
© 2025 vatierasynth All Right Reversed

#define SPAWN_LOCKED 0
#define SPAWN_UNLOCKED 1

new g_PlayerSpawnState[MAX_PLAYERS];
new g_SpawnTimestamp[MAX_PLAYERS];
new bool:g_HasRequestedClass[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
    g_PlayerSpawnState[playerid] = SPAWN_LOCKED;
    g_SpawnTimestamp[playerid] = 0;
    g_HasRequestedClass[playerid] = false;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    g_PlayerSpawnState[playerid] = SPAWN_LOCKED;
    g_SpawnTimestamp[playerid] = 0;
    g_HasRequestedClass[playerid] = false;
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    g_PlayerSpawnState[playerid] = SPAWN_LOCKED;
    g_SpawnTimestamp[playerid] = gettime();
    g_HasRequestedClass[playerid] = true;
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if (!g_HasRequestedClass[playerid])
    {
        BanEx(playerid, "FakeSpawn: No class request (Button Press Detected)");
        return 0;
    }
    if (g_PlayerSpawnState[playerid] != SPAWN_UNLOCKED)
    {
        Kick(playerid);
        return 0;
    }
    if (gettime() - g_SpawnTimestamp[playerid] < 1)
    {
        BanEx(playerid, "FakeSpawn: Spawned too fast after class (Button Press Detected)");
        return 0;
    }
    g_PlayerSpawnState[playerid] = SPAWN_LOCKED;
    g_HasRequestedClass[playerid] = false;
    return 1;
}

stock AllowPlayerSpawnNow(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    g_PlayerSpawnState[playerid] = SPAWN_UNLOCKED;
    g_SpawnTimestamp[playerid] = gettime();
    return 1;
}
