//=================Anti-Airbreak-VatieraSynth=================//
#define MAX_PLAYERS 1000

new Float:LastPos[MAX_PLAYERS][3];
new LastTick[MAX_PLAYERS];
new CheatWarn[MAX_PLAYERS];

public OnPlayerUpdate(playerid)
{
    if(!IsPlayerConnected(playerid)) return 1;

    new tickcount = GetTickCount();
    new elapsed = tickcount - LastTick[playerid];
    if(elapsed < 50) elapsed = 50;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new Float:dx = floatsub(x, LastPos[playerid][0]);
    new Float:dy = floatsub(y, LastPos[playerid][1]);
    new Float:dz = floatsub(z, LastPos[playerid][2]);

    new Float:distance = floatsqroot(floatpower(dx, 2) + floatpower(dy, 2) + floatpower(dz, 2));
    new Float:speed = (distance * 1000.0) / float(elapsed);

    if(!IsPlayerInAnyVehicle(playerid))
    {
        if(distance > 5.5 && floatabs(dz) < 1.5 || speed > 28.0)
        {
            CheatWarn[playerid]++;
            if(CheatWarn[playerid] >= 3)
            {
                new msg[128];
                format(msg, sizeof(msg), "{FF0000}Anti-Cheat: Anda di kick karena Terdeteksi Menggunakan Cheat (%d/3)", CheatWarn[playerid]);
                SendClientMessage(playerid, -1, msg);
                Kick(playerid);
                return 1;
            }
            else
            {
                new warnmsg[128];
                format(warnmsg, sizeof(warnmsg), "{FF6600}Peringatan Anti-Cheat: Deteksi gerakan tidak normal (%d/3)", CheatWarn[playerid]);
                SendClientMessage(playerid, -1, warnmsg);
            }
        }
    }

    LastPos[playerid][0] = x;
    LastPos[playerid][1] = y;
    LastPos[playerid][2] = z;
    LastTick[playerid] = tickcount;
    return 1;
}

public OnPlayerConnect(playerid)
{
    LastPos[playerid][0] = 0.0;
    LastPos[playerid][1] = 0.0;
    LastPos[playerid][2] = 0.0;
    LastTick[playerid] = GetTickCount();
    CheatWarn[playerid] = 0;
    return 1;
}

public OnPlayerSpawn(playerid)
{
    CheatWarn[playerid] = 0;
    return 1;
}
