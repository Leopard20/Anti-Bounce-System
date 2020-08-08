params ["_veh", "_obj"];
_cos = vectorUp _veh vectorCos [0,0,1];
if (_cos < cos ABS_minAngle && {
	!(_obj isKindOf "LAND") && {
		vectorMagnitude velocity _veh < 2 && ABS_AssistUnflip && {
			!(player in _veh) || {
				!ABS_NoAutoUnflipPlayer && {CBA_missionTime >= _veh getVariable ["ABS_manualUnflip", 0]}
			}
		}
	}
}) then {
	(boundingBoxReal _veh) params ["_c1", "_c2", "_size"];
	_c1 params ["_x1", "_y1", "_z1"];
	_c2 params ["_x2", "_y2"];
	
	_pz = [];
	
	(getCenterOfMass _veh) params ["", "_y","_z"];
	{
		_p = [_x,_y,_z];
		_pz pushBack [(_veh modelToWorldWorld _p)#2,_p];
	} forEach [_x1,_x2];
	
	_pz sort false;
	
	_p = _pz#0#1;

	//t_points1 = [_veh modelToWorldWorld _p];
	
	_veh addForce [_veh vectorModelToWorld [0,0,-0.0225*getMass _veh*(1-_cos)], _p];
};