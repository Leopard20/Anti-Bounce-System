//abc_fnc_manualunflip={
_veh = objectParent player;
private ["_VUP", "_cos"];
if (!isNull _veh && { //in veh
	_VUP = vectorUp _veh;
	_cos = _VUP vectorCos [0,0,1];
	_cos <= cos ABS_minAngle && { //flipped
		abs (velocity _veh select 2) < 1 && {
			_veh isKindOf "CAR" || {_veh isKindOf "TANK" || {_veh isKindOf "MOTORCYCLE"}}
		}
	}
}) then {
	params ["_xx", "_yy"];
	_force = 2*getMass _veh*(1-_cos);
	_veh addTorque (_veh vectorModelToWorld [_force*_xx,_force*_yy,0]);
};
//}