/*
  SHK_pos

  Version 0.24
  Author: Shuko (shuko@quakenet, miika@miikajarvinen.fi)
  Contributors: Cool=Azroul13, Hatifnat

  Forum: http://forums.bistudio.com/showthread.php?162695-SHK_pos

  Marker Based Selection
    Required Parameters:
      0 String   Area marker's name.

    Optional Parameters:
      1 Number            Water position. Default is only land positions allowed.
                            0   Find closest land. Search outwards 360 degrees (20 degree steps) and 20m steps.
                            1   Allow water positions.
                            2   Find only water positions.
      2 Array or String   One or multiple blacklist area markers which are excluded from the main marker area.
      3 Array, Number, Object or Vehicle Type         Force finding large enough empty position.
                            0   Max range from the selection position to look for empty space. Default is 200.
                            1   Vehicle or vehicle type to fit into an empty space.

                            Examples:
                              [...,[300,heli]]       Array with distance and vehicle object.
                              [...,350]              Only distance given
                              [...,(typeof heli)]    Only vehicle type given
                              [...,heli]             Only vehicle object given

  Position Based Selection
    Required Parameters:
      0 Object or Position  Anchor point from where the relative position is calculated from.
      1 Array or Number     Distance from anchor.

    Optional Parameters:
      2 Array of Number     Direction from anchor. Default is random between 0 and 360.
      3 Number              Water position. Default is only land positions allowed.
                              0   Find closest land. Search outwards 360 degrees (20 degree steps) and 20m steps.
                              1   Allow water positions.
                              2   Find only water positions.
      4 Array               Road positions.
                              0  Number  Road position forcing. Default is 0.
                                   0    Do not search for road positions.
                                   1    Find closest road position. Return the generated random position if none found.
                                   2    Find closest road position. Return empty array if none found.
                              1  Number   Road search range. Default is 200m.
      5 Array, Number, Object or Vehicle Type         Force finding large enough empty position.
                              0   Max range from the selection position to look for empty space. Default is 200.
                              1   Vehicle or vehicle type to fit into an empty space.

                            Examples:
                              [...,[300,heli]]       Array with distance and vehicle object.
                              [...,350]              Only distance given
                              [...,(typeof heli)]    Only vehicle type given
                              [...,heli]             Only vehicle object given

  Usage:
    include CfgFunctions.hpp in description.ext:
      class CfgFunctions
      {
        #include "shk_pos\CfgFunctions.hpp"
      };

    Actually getting the position:
      pos = [parameters] call SHK_fnc_executeFindPosition;
*/
diag_log format ["_this: [%1]", _this];
private ["_pos"];
_pos = [];

// Only marker is given as parameter
if (typename _this == "STRING") then {
  _pos = [_this] call SHK_fnc_findRandomPositionInMarker;

// Parameter array
} else {
  if (typename (_this select 0) == "STRING") then {
    _pos = _this call SHK_fnc_findRandomPositionInMarker;
  } else {
      diag_log format ["Calling SHK_fnc_findPosition with %1", _this];
    _pos = _this call SHK_fnc_findPosition;
  };
};

// Return position
_pos