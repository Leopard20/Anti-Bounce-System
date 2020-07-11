params ["_veh"];

_veh removeEventHandler ["EpeContactStart", _veh getVariable ["ABS_ContactStart_EH", -1]];

_veh removeEventHandler ["EpeContact", _veh getVariable ["ABS_Contact_EH", -1]];

_veh removeEventHandler ["EpeContactEnd", _veh getVariable ["ABS_ContactEnd_EH", -1]];

_veh setVariable ["ABS_EHs_Added", false, true];