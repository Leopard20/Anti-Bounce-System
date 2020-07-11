//hint "END";
params ["_veh", "_obj"];
_vup = vectorUp _veh;
_v = velocity _veh;
_time = CBA_missionTime;
(_veh getVariable ["ABS_contactParams", [_v,_time]]) params ["_v0", "_t"];

_dt = (_time - _t) max 1e-2;
_v1 = vectorMagnitude _v;
_v0 = vectorMagnitude _v0;

//systemChat str ((_v1 - _v0)/_dt);

if ((_v1 - _v0)/_dt > 15) then {
	_v = [_v#0*0.01,_v#1*0.01,1];
};

if (_v#2 > 0) then {
	if !(_obj isKindOf "LAND") then {_veh addForce [[0,0,0.01*getMass _veh], getCenterOfMass _veh]};
	_v set [2,(_v#2 *1e-2) min 1];
	
	
	[[_veh, _v], {
		_this remoteExecCall ["setVelocity", owner (_this#0)]
	}] remoteExecCall ["call", 2];
};