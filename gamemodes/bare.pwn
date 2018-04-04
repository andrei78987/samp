#include <a_samp>
#include <core>
#include <float>
#include <sscanf2>
#include <zcmd.txt>

#define SCM	SendClientMessage

#pragma tabsize 0

enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pSex,
    pAge,
   	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pSkin,
	pTeam,
	pAccent
}
new PlayerInfo[MAX_PLAYERS][pInfo];

CMD:setadmin(playerid, params[])
{
	new targetid, level, targ, lvl;
	sscanf(params,"i", targ, lvl);
	sscanf(params,"ui", targetid, level);
	//PlayerInfo[targetid][pAdmin] = level;
 	if (targetid == 0 && level == 0)
  		return SCM(playerid, -1, "Syntaxa /setadmin [id player] [level]");
 	else if(IsPlayerConnected(targetid) == 0)
		return SCM(targetid, -1, "Erroare: Acest player nu e conectat");
	else if(level < 0 || level > 7)
	    return SCM(targetid, -1, "Erroare: Nu exista acest admin level");
    else
	{
		new string[128], pName[MAX_PLAYER_NAME], target[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pName, sizeof(pName));
		GetPlayerName(targetid, target, sizeof(target));
		format(string, sizeof(string), "Tu iai setat lui  %s Admin level la %i", target, level);
		SCM(playerid, -1, string);
		format(string, sizeof(string), "Admin level al tau este %i setat de %s", level, pName);
		SCM(targetid, -1, string);
		PlayerInfo[targetid][pAdmin] = level;
 	}
	return 1;
}

COMMAND:goto(playerid, params[])
{
	new targetid;
	new Float:x, Float:y, Float:z;
	sscanf(params,"i", targetid);
	if (targetid == 0)
        return SCM(playerid, -1, "Syntaxa /goto [id player]");
	else if(INVALID_PLAYER_ID == targetid)
		return SCM(targetid, -1, "Erroare: Acest player nu e conectat");
	///if (targetid == 0)
      //  return SCM(playerid, -1, "Syntaxa /getcar [id masina]");
	GetPlayerPos(targetid, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	SCM(playerid, -1, "Te-ai teleportat cu succes");
	return 1;
}

COMMAND:cr(playerid, params[])
{
	if (!IsPlayerInAnyVehicle(playerid))
 	return	SCM(playerid, -1, "Nu esti intr-o masina");

	RepairVehicle(GetPlayerVehicleID(playerid));
	SCM(playerid, -1, "Masina reparata cu succes");
	return 1;
}

COMMAND:getcar(playerid, params[])
{
	new type;
	new Float:x, Float:y, Float:z;
	sscanf(params,"i", type);
	if (type == 0)
	{
        SCM(playerid, -1, "Syntaxa /getcar [id masina]");
        return 1;
	}
	else if (type < 400 || type > 611)
	{
	    SCM(playerid, -1, "Acest vehicul nu exista");
        return 1;
	}
	GetPlayerPos(playerid, x, y, z);
	CreateVehicle(type, x+2, y, z, 1, -1, -1, -1);
	SCM(playerid, -1, "Masina spawnata cu succes");
return 1;
}

COMMAND:givemoney(playerid, params[])
{
	//SCM(playerid, -1, "asd");
	new targetid, ammount;
	sscanf(params,"ui", targetid, ammount);
	if (targetid == 0 && ammount == 0)
	{
  		SCM(targetid, -1, "Syntaxa /givemoney [targetid] [ammount]");
	}
	else if(INVALID_PLAYER_ID == targetid)
	{
		SCM(targetid, -1, "Acest player nu e conectat");
	}
	else if (!IsPlayerAdmin(playerid))
	{
    	SCM(targetid, -1, "Trebuie sa fii admin");
	}
	else
	{
     	GivePlayerMoney(targetid, ammount);
		SCM(targetid, -1, "Bani trimisi cu succes");
	}
  return 1;
}

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}
