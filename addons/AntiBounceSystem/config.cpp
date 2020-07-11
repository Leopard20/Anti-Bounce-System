class CfgPatches
{
	class AntiBounceSystem
	{
		units[]={};
		weapons[] = {};
		requiredVersion = 1.98;
		requiredAddons[] = {"CBA_Extended_EventHandlers"};
		name = "Anti-Bounce System";
		author = "Leopard20"; 
	};
};

class CfgFunctions {
	class ABS {
		class functions
		{
			file = "AntiBounceSystem\functions";
			class contact_end {};
			class contact {};
			class addEHs {};
			class removeEHs {};
			class manualUnflip {};
			class manualUnflip_Hold {};
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class AIO_AIMENU 
	{
		init = "call compile preProcessFileLineNumbers 'AntiBounceSystem\XEH_preInit.sqf'";
	};
};

class Extended_InitPost_EventHandlers {
    class Car {
        class ABS_addEHs {
            init = "call ABS_fnc_addEHs";
        };
    };
	
	class Tank {
        class ABS_addEHs {
            init = "call ABS_fnc_addEHs";
        };
    };
	
	class Motorcycle {
        class ABS_addEHs {
            init = "call ABS_fnc_addEHs";
        };
    };
};