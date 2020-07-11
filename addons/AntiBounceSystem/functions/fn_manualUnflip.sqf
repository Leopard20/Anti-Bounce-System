//abc_fnc_manualunflip_hold={
_veh = objectParent player;
private ["_VUP", "_cos"];
if (!isNull _veh && { //in veh
	_VUP = vectorUp _veh;
	_cos = _VUP vectorCos [0,0,1];
	_cos <= cos ABS_minAngle && { //flipped
		vectorMagnitude velocity _veh < 2 && {
			_veh isKindOf "CAR" || {_veh isKindOf "TANK" || {_veh isKindOf "MOTORCYCLE"}}
		}
	}
}) then {
	params ["_xx", "_yy"];
	(boundingBoxReal _veh) params ["_c1", "_c2", "_size"];
	_c1 params ["_x1", "_y1", "_z1"];
	_c2 params ["_x2", "_y2"];
	_xc = (_x1 + _x2)/2;
	_yc = (_y1 + _y2)/2;
	_x = abs(_x1 - _x2)/2;
	_y = abs(_y1 - _y2)/2;
	
	_force = 0.5*(1-_cos)*getMass _veh*(1 - 0.65*abs _yy);
	_veh addForce [_veh vectorModelToWorld [0,0,-_force], [_xx*_x + _xc, _yy*_y + _yc, getCenterOfMass _veh select 2]];
};
//}