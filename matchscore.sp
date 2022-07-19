
#include <cstrike>
#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name = "Match Score",
	author = "CommonCrayon",
	description = "Print the Score of a Match at the request of a command.",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};

public void OnPluginStart()
{
    RegConsoleCmd("get_score", getScore);
    RegConsoleCmd("get_playerid", getPlayerID);
}

public Action getScore(int client, int args)
{ 
    int ctScore = CS_GetTeamScore(CS_TEAM_CT);
    int tScore = CS_GetTeamScore(CS_TEAM_T);

    char ctName[64];
    char tName[64];

    GetTeamName(CS_TEAM_CT, ctName, sizeof(ctName));
    GetTeamName(CS_TEAM_T, tName, sizeof(tName));
 
    PrintToServer("%s %i - %i %s", ctName, ctScore, tScore, tName);
 
    return Plugin_Handled;
}

public Action getPlayerID(int client, int args)
{
    int noOfUsers = GetClientCount(true);

    for (int i = 1; i <= noOfUsers; i++)
    {
        char nickname[64];

        GetClientName(i, nickname, sizeof(nickname));
        int playerTeam = GetClientTeam(i);
        
        if (playerTeam == 2) {PrintToChatAll("%s - Terrorists", nickname);}
        if (playerTeam == 3) {PrintToChatAll("%s - Counter-Terrorists", nickname);}

    }

    return Plugin_Handled;
}