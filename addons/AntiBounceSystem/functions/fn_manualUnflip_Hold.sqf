//abc_fnc_manualunflip_hold={
_veh = objectParent player;
private ["_cos"];
if (!isNull _veh && { //in veh
	_VUP = vectorUp _veh;
	_cos = _VUP vectorCos [0,0,1];
	_cos <= cos ABS_minAngle && { //flipped
		vectorMagnitude velocity _veh < 2 && {
			_veh isKindOf "CAR" || {_veh isKindOf "TANK" || {_veh isKindOf "MOTORCYCLE"}}
		}
	}
}) then {
	_veh setVariable ["ABS_manualUnflip", CBA_missionTime + 0.5, true];
	
	params ["_xx", "_yy"];
	params ["_c1", "_c2"];
	
	(if (_xx + _yy > 0) then {
		(boundingBoxReal _veh select 1)
	} else {
		(boundingBoxReal _veh select 0)
	}) params ["_x1", "_y1"];
	
	(getCenterOfMass _veh) params ["_x", "_y", "_z"];
	
	_force = 0.07*(1-_cos)*getMass _veh*(1 - 0.65*abs _yy);
	_veh addForce [_veh vectorModelToWorld [0,0,-_force], [_xx* abs _x1 + abs _yy * _x, _yy * abs _y1 + abs _xx* _y, _z]];
};
//}