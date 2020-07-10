//#include "\a3\editor_f\Data\Scripts\dikCodes.h"

/* 
[
    ABS_Zeus_Enabled, // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Create Zeus Module", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Anti-Bounce System", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting
    1, // "global" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
    } // function that will be executed once on mission start && every time the setting is changed.
] call CBA_fnc_addSetting;
*/

/* 

	Function: CBA_fnc_addKeybind

	Description:
	 Adds || updates the keybind handler for a specified mod action, && associates
	 a function with that keybind being pressed.

	Parameters:
	 _modName           Name of the registering mod [String]
	 _actionId  	    Id of the key action. [String]
	 _displayName       Pretty name, || an array of strings for the pretty name && a tool tip [String]
	 _downCode          Code for down event, empty string for no code. [Code]
	 _upCode            Code for up event, empty string for no code. [Code]

	 Optional:
	 _defaultKeybind    The keybinding data in the format [DIK, [shift, ctrl, alt]] [Array]
	 _holdKey           Will the key fire every frame while down [Bool]
	 _holdDelay         How long after keydown will the key event fire, in seconds. [Float]
	 _overwrite         Overwrite any previously stored default keybind [Bool]

*/ 

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

["ABS_enableMod", "CHECKBOX", ["Enable Anti-Bounce System", "Master switch for all vehicles. Requires mission restart."], "Anti-Bounce System" ,true, 1, {}, true] call CBA_Settings_fnc_init;
["ABS_AssistUnflip", "CHECKBOX", ["Enable automatic unflip assistant", "Gives vehicles a small boost to help them unflip."], "Anti-Bounce System" ,true, 1, {}, true] call CBA_Settings_fnc_init;
["ABS_NoAutoUnflipPlayer", "CHECKBOX", ["Disable automatic unflip assistant for player vehicles", "Players can use manual unflip. See the mod's CBA keybinding section. Use this to avoid conflicts."], "Anti-Bounce System" ,true, 1, {}, true] call CBA_Settings_fnc_init;
["ABS_minAngle", "SLIDER", ["Minimum angle to use manual unflipping", "0 means vehicle is perfectly upright, 90 means on the side, etc."], "Anti-Bounce System" ,[45, 90, 60, 0], 1] call CBA_Settings_fnc_init;
["ABS_perFrameKey", "LIST", ["Manual unflip: Key press mode (Hold is recommended)", "Hold mode fires every frame when the key is down, even if not in vehicle (waste of performance, but minimal). It looks better."], "Anti-Bounce System" ,[[true, false], ["Hold", "Tap"], 0], 0, {
	if !(ABS_enableMod) exitWith {};
	if (ABS_perFrameKey) then {
		["Anti-Bounce System","ABS_MoveUpKey", "Unflip - Forward boost", {[1,0] call ABS_fnc_manualUnflip_Hold}, "", [DIK_W, [false, false, false]], true] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveLeftKey", "Unflip - Leftward boost", {[0,1] call ABS_fnc_manualUnflip_Hold}, "", [DIK_A, [false, false, false]], true] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveRightKey", "Unflip - Rightward boost", {[0,-1] call ABS_fnc_manualUnflip_Hold}, "", [DIK_D, [false, false, false]], true] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveBackKey", "Unflip - Backward boost", {[-1,0] call ABS_fnc_manualUnflip_Hold}, "", [DIK_S, [false, false, false]], true] call CBA_fnc_addKeybind;
	} else {
		["Anti-Bounce System","ABS_MoveUpKey", "Unflip - Forward boost", {[1,0] call ABS_fnc_manualUnflip}, "", [DIK_W, [false, false, false]], false] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveLeftKey", "Unflip - Leftward boost", {[0,1] call ABS_fnc_manualUnflip}, "", [DIK_A, [false, false, false]], false] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveRightKey", "Unflip - Rightward boost", {[0,-1] call ABS_fnc_manualUnflip}, "", [DIK_D, [false, false, false]], false] call CBA_fnc_addKeybind;
		["Anti-Bounce System","ABS_MoveBackKey", "Unflip - Backward boost", {[-1,0] call ABS_fnc_manualUnflip}, "", [DIK_S, [false, false, false]], false] call CBA_fnc_addKeybind;
	};
}] call CBA_Settings_fnc_init;

/*
if !(ABS_enableMod) exitWith {};

if (ABS_perFrameKey) then {
	["Anti-Bounce System","ABS_MoveUpKey", "Unflip - Forward boost", {[1,0] call ABS_fnc_manualUnflip_Hold}, "", [DIK_W, [false, false, false]], true] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveLeftKey", "Unflip - Leftward boost", {[0,1] call ABS_fnc_manualUnflip_Hold}, "", [DIK_A, [false, false, false]], true] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveRightKey", "Unflip - Rightward boost", {[0,-1] call ABS_fnc_manualUnflip_Hold}, "", [DIK_D, [false, false, false]], true] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveBackKey", "Unflip - Backward boost", {[-1,0] call ABS_fnc_manualUnflip_Hold}, "", [DIK_S, [false, false, false]], true] call CBA_fnc_addKeybind;
} else {
	["Anti-Bounce System","ABS_MoveUpKey", "Unflip - Forward boost", {[1,0] call ABS_fnc_manualUnflip}, "", [DIK_W, [false, false, false]], false] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveLeftKey", "Unflip - Leftward boost", {[0,1] call ABS_fnc_manualUnflip}, "", [DIK_A, [false, false, false]], false] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveRightKey", "Unflip - Rightward boost", {[0,-1] call ABS_fnc_manualUnflip}, "", [DIK_D, [false, false, false]], false] call CBA_fnc_addKeybind;
	["Anti-Bounce System","ABS_MoveBackKey", "Unflip - Backward boost", {[-1,0] call ABS_fnc_manualUnflip}, "", [DIK_S, [false, false, false]], false] call CBA_fnc_addKeybind;
};
*/
