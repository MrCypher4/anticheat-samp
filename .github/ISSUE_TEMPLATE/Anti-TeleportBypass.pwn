//Dev: vatiera
//dikhususkan untuk protection terhadap teleport yang menggunakan metode Bypass

#define MAX_SPEED_ONFOOT 16.0
#define MAX_SPEED_INCAR 320.0
#define MAX_TELEPORT_DISTANCE 100.0
#define TELEPORT_CHECK_INTERVAL 500
#define FREEZE_ON_DETECT true

new Float:g_lastPosX[MAX_PLAYERS], Float:g_lastPosY[MAX_PLAYERS], Float:g_lastPosZ[MAX_PLAYERS];
new g_lastCheckTime[MAX_PLAYERS];
new bool:g_isJustSpawned[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
    g_isJustSpawned[playerid] = true;
    return 1;
}

public OnPlayerSpawn(playerid)
{
    g_isJustSpawned[playerid] = true;
    return 1;
}

public OnPlayerUpdate(playerid)
{
    if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid))
        return 1;
    
    new currentTime = GetTickCount();
    
    if (currentTime - g_lastCheckTime[playerid] >= TELEPORT_CHECK_INTERVAL)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        
        new Float:dist = floatsqroot(
            (x - g_lastPosX[playerid])*(x - g_lastPosX[playerid]) +
            (y - g_lastPosY[playerid])*(y - g_lastPosY[playerid]) +
            (z - g_lastPosZ[playerid])*(z - g_lastPosZ[playerid])
        );
        
        new Float:speed = dist / (float(TELEPORT_CHECK_INTERVAL) / 1000.0);
        
        if (g_isJustSpawned[playerid])
        {
            g_isJustSpawned[playerid] = false;
        }
        else
        {
            if (dist > MAX_TELEPORT_DISTANCE)
            {
                AntiTeleportDetected(playerid, "Distance Jump");
            }
            else
            {
                if (IsPlayerInAnyVehicle(playerid))
                {
                    if (speed > MAX_SPEED_INCAR)
                    {
                        AntiTeleportDetected(playerid, "Speed Hack Vehicle");
                    }
                }
                else
                {
                    if (speed > MAX_SPEED_ONFOOT)
                    {
                        AntiTeleportDetected(playerid, "Speed Hack OnFoot");
                    }
                }
            }
        }
        
        g_lastPosX[playerid] = x;
        g_lastPosY[playerid] = y;
        g_lastPosZ[playerid] = z;
        g_lastCheckTime[playerid] = currentTime;
    }
    
    return 1;
}

stock AntiTeleportDetected(playerid, const reason[])
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    
    new msg[128];
    format(msg, sizeof(msg), "[AntiTeleport] %s terdeteksi: %s", name, reason);
    SendClientMessageToAll(0xFF0000FF, msg);
    
    if (FREEZE_ON_DETECT)
    {
        TogglePlayerControllable(playerid, 0);
        SendClientMessage(playerid, 0xFF0000FF, "Kamu dibekukan karena terdeteksi teleport / speed hack.");
    }
    else
    {
        Kick(playerid);
    }
}
