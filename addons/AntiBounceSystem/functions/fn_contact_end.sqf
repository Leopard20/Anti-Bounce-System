params ["_veh", "_obj"];
_vup = vectorUp _veh;
_v = velocity _veh;

_initV = _veh getVariable ["ABS_velocity", _v];

if (_v#2 > 0) then {
	if !(_obj isKindOf "LAND") then {_veh addForce [[0,0,0.01*getMass _veh], getCenterOfMass _veh]};
	_v set [2,(_v#2 *1e-2) min 1];
	
	
	[[_veh, _v], {
		_this remoteExecCall ["setVelocity", owner (_this#0)]
	}] remoteExecCall ["call", 2];
};

_cos = _vup vectorCos [0,0,1];
if (_cos < 0.8 && {!(_obj isKindOf "LAND") && ABS_AssistUnflip && {!(player in _veh) || !ABS_NoAutoUnflipPlayer}}) then {
	
	(boundingBoxReal _veh) params ["_c1", "_c2", "_size"];
	_c1 params ["_x1", "_y1", "_z1"];
	_c2 params ["_x2", "_y2"];
	
	_pz = [];
	
	_z1 = (_veh modelToWorldWorld [0,0,_z1])#2;
	
	{
		_xx = _x;
		{
			_p = [_xx,_x,0];
			_z = (_veh modelToWorldWorld _p)#2;
			_pz pushBack [_z-_z1+_size,_p];
		} forEach [_y1,_y2];
	} forEach [_x1,_x2];
	_pz sort false;
	
	_p1 = _pz#0;
	_p2 = _pz#1;
	
	_z1 = _p1#0;
	_z2 = _p2#0;
	
	_p1 = _p1#1;
	_p2 = _p2#1;
	
	
	_p = ((_p1 vectorMultiply _z1) vectorAdd (_p2 vectorMultiply _z2)) vectorMultiply (_z1/(_z1+_z2));
	
	_veh addForce [_veh vectorModelToWorld [0,0,-0.007*getMass _veh*(1-_cos)], _p];
	
	//_veh addTorque ((_vup vectorCrossProduct [0,0,1]) vectorMultiply getMass _veh);
};