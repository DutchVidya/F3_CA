// CA Hierarchy setup 
// Author: Poulern (@me for issues)
// Server execution only and run once at the start of mission

//Side tickets available (Where one ticket = 1 respawn, default 5 for vehicles) per team in addition to the group tickets;
// Change to for example _caEastTickets = 49 if needed for TvTs/events with multiple sides
_caWestTickets = 50;
_caEastTickets = _caWestTickets;
_caIndependentTickets = _caWestTickets;

//To create a seperate hierarchy for another side, just copy this code block and change the variable reference ([west] spawn _hierarchy) near the bottom 
_hierarchy = {
_side = _this select 0;

/*
Parameters for ca_fnc_setupGroup, which is what the setup below uses to setup each group. 
 * 0: Side (Side): This is set automatically, if you need to set up for multiple sides copy the _hierachy code block and name it _westhierarchy, _easthierachy etc. as needed and change the call below.
 * 1: Superior (String): The groupid of the group that ranks above it in the hierarchy, if equal to groupid, then the group is an independent group or its own platoon.
 * 2:  Groupid (String): The groupid that is set in the editor field callsign.
 * 3: Short range radio channel (Number): What channel the 343 will be on by default and on respawn. 
 * 4: Long range radio Array (Array): Array of channels the long range radios will be on by default and on respawn. There will be one radio given per channel to ranks set in ca_acre2settings.sqf
 * 5: Group color (String): The color of the group in the hierarchy and its groupmarker. Available colors: "ColorBlack","ColorGrey","ColorRed","ColorBrown","ColorOrange","ColorYellow","ColorKhaki","ColorGreen","ColorBlue","ColorPink","ColorWhite"
 * 6: Group tickets (Number): The number of tickets this group gets to play with at the start of the mission. 
 * 7: Group marker (Boolean): Should each team get a group marker assigned to them? Default: True. 
 * 8: Group type (String): What markertype the unit has. This is if you want to use the non-automatic mode that the groupmarker uses. For non smooth markers its any A3 marker, for smooth markers its "b_hq","b_inf","b_support","b_motor_inf","b_mortar","b_maint","b_mech_inf","b_armor","b_recon","b_air","b_plane","b_art"

[_side,"ASL","CO",1,[4,1],"ColorRed",5] spawn ca_fnc_setupGroup;
[_side,"ELEMENT","ELEMENT IMMEDIATELY ABOVE THEM IN THE HIERARCHY",SR radio channel,[LR radio channels],"ColorOfgroup",Number of group tickets 123,Should the group get a map marker true/false,"grouptype aka which marker they get"] spawn ca_fnc_setupGroup;
*/

[_side,"CO","CO",16,[4,5,6],"ColorYellow",3] spawn ca_fnc_setupGroup;

	[_side,"ASL","CO",1,[4,1],"ColorRed",5] spawn ca_fnc_setupGroup;
		[_side,"A1","ASL",2,[1],"ColorRed",2] spawn ca_fnc_setupGroup;
		[_side,"A2","ASL",3,[1],"ColorRed",2] spawn ca_fnc_setupGroup;
		[_side,"AV","ASL",4,[5,1],"ColorRed",2] spawn ca_fnc_setupGroup;

	[_side,"BSL","CO",5,[4,2],"ColorBlue",5] spawn ca_fnc_setupGroup;
		[_side,"B1","BSL",6,[2],"ColorBlue",2] spawn ca_fnc_setupGroup;
		[_side,"B2","BSL",7,[2],"ColorBlue",2] spawn ca_fnc_setupGroup;
		[_side,"BV","BSL",8,[5,2],"ColorBlue",2] spawn ca_fnc_setupGroup;

	[_side,"CSL","CO",9,[4,3],"ColorGreen",5] spawn ca_fnc_setupGroup;
		[_side,"C1","CSL",10,[3],"ColorGreen",2] spawn ca_fnc_setupGroup;
		[_side,"C2","CSL",11,[3],"ColorGreen",2] spawn ca_fnc_setupGroup;
		[_side,"CV","CSL",12,[5,3],"ColorGreen",2] spawn ca_fnc_setupGroup;

	[_side,"MMG","CO",13,[4,8],"ColorOrange",5] spawn ca_fnc_setupGroup;
		[_side,"MAT","MMG",14,[8],"ColorOrange",2] spawn ca_fnc_setupGroup;

	[_side,"ENG","CO",15,[5],"ColorGrey",2,true,"b_maint"] spawn ca_fnc_setupGroup;
};

//Individual speicalist markers (ie medic markers). Refer to assinggear files for a complete list of f3 loadout classes (eg dc, ftl, eng, sp, pp, vc etc.)
_caSpecialistMarkerClasses = ["m","uav","eng"];

// Long radio channels setup
// Long range channel names for 148, 152, 117, Vehicle radios. This correlates to "ALPHA SQUAD" = Channel 1 in the platoon hierarchy array above. 
_caWestLongrangeChannelList = ["ALPHA SQUAD","BRAVO SQUAD","CHARLIE SQUAD","INFANTRY COMMAND","VEHICLE COMMAND","FORWARD AIR CONTROL","AIR COMMAND","WEAPONS SQUAD"];
_caEastLongrangeChannelList = _caWestLongrangeChannelList; // Copy and paste to change for another side eg ["ANNA SQUAD","BORIS SQUAD","CHARITON SQUAD","INFANTRY COMMAND","VEHICLE COMMAND","FORWARD AIR CONTROL","AIR COMMAND","WEAPONS SQUAD"];
_caIndependentLongrangeChannelList = _caWestLongrangeChannelList;
/* Default setup on 343 (short range) for the hierarchy above:
CH1:ASL CH2:A1 CH3:A2 CH4:AV CH5:BSL CH6:B1 CH7:B2 CH8:BV CH9:CSL CH10:C1 CH11:C2 CH12:CV CH13:MMG CH14:MAT CH15:ENG CH16:CO
*/
// ====================================================================================
/* Ranks for various actions like respawning, adjusting the hierachy. CO rank can change all elements of the hierarchy and call respawn waves.
0 - Private
1 - Corporal - Default for Fireteam lead
2 - Sergeant - Default for Squad lead
3 - Lieutenant - Default for Commanding Officer
4 - Captain 
5 - Major
6 - Colonel
*/
_corank = 3;
_slrank = 2;
_ftlrank = 1;

// Respawn settings
// ====================================================================================
// How far away an enemy must be for respawn to be available
ca_enemyradius = 200;
// Delay for when a group can be respawn after the first player enters spectate. If group respawn is ready and another player dies, the respawn timer goes on cooldown again.
// If the timer is low then its reccomended to increase ca_enemyradius so you're unable to respawn in the middle of combat.
ca_grouprespawncooldown = 180;
// Hardcore option: How close you must be to your squad lead or CO to be able to recieve more tickets (Creating a sort of group based rally point system). 
//If the group is out of tickets then they won't be able to respawn (Except with a respawn wave, if you leave that option open as a mission maker). Defaulted to false.
ca_ticketradius = 50;
ca_ticketradiusmechanic = false; 

// END OF SETUP VARIABLES
// Executing setup as described above
// ====================================================================================
// ====================================================================================
sleep 2;

missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_blufor',_caWestLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_opfor',_caEastLongrangeChannelList, true]; 
missionNamespace setVariable ['f_radios_settings_acre2_lr_groups_indfor',_caIndependentLongrangeChannelList, true]; 

missionNamespace setVariable ['ca_corank',_corank, true]; 
missionNamespace setVariable ['ca_slrank',_slrank, true]; 
missionNamespace setVariable ['ca_ftlrank',_ftlrank, true]; 

missionNamespace setVariable ['ca_specialistMarkerClasses',_caSpecialistMarkerClasses, true]; 

ca_allWestPlayerGroups = [];
ca_allEastPlayerGroups = [];
ca_allIndependentPlayerGroups = [];

{
	if (side _x == west) then {ca_allWestPlayerGroups pushBackUnique group _x};
	if (side _x == east) then {ca_allEastPlayerGroups pushBackUnique group _x};
	if (side _x == independent) then {ca_allIndependentPlayerGroups pushBackUnique group _x};
} forEach allunits;

ca_WestJIPgroups = [];
ca_EastJIPgroups = [];
ca_IndependentJIPgroups = [];
sleep 5;
//If using multiple sides for TvT etc. change the _hierarchy code block here.
// ====================================================================================

[west] spawn _hierarchy;
[east] spawn _hierarchy;
[independent] spawn _hierarchy;

sleep 10;
missionNamespace setVariable ['ca_WestJIPgroups',ca_WestJIPgroups, true]; 
missionNamespace setVariable ['ca_EastJIPgroups',ca_EastJIPgroups, true]; 
missionNamespace setVariable ['ca_IndependentJIPgroups',ca_IndependentJIPgroups, true]; 

missionNamespace setVariable ['ca_WestTickets',_caWestTickets, true]; 
missionNamespace setVariable ['ca_EastTickets',_caEastTickets, true]; 
missionNamespace setVariable ['ca_IndependentTickets',_caIndependentTickets, true]; 

missionNamespace setVariable ['ca_enemyradius',ca_enemyradius, true]; 
missionNamespace setVariable ['ca_ticketradius',ca_ticketradius, true]; 
missionNamespace setVariable ['ca_grouprespawncooldown',ca_grouprespawncooldown, true]; 

sleep 2;
missionNamespace setVariable ['ca_platoonsetup',true, true]; 
diag_log "Hierarchy setup done, ca_platoonsetup = true";
