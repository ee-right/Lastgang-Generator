%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Kreiselpump %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Umwälzpumpe. Für Detail
%bitte sehen die Bilder auf Seite 41.
function [lastgang, blind] = Kreiselpumpe(handles, Anzahl)
%KREISELPUMPE Summary of this function goes here
%   Detailed explanation goes here
P=[30 30 30 30 30 30 30 30 30 30 30 30 32.5 35 37.5 40 42.5 45 47.5 50 58 ...
    66 74 82 88 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 ...
    90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 ...
    90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 86 78 70 62 54 ...
    46 38 34];

switch Anzahl
    case 1
        lastgang=P./4;
    case 2
        lastgang=P./2;
    case 3
        lastgang=P./1;
end


if strcmp(handles.heizperiode, 'Nein')
    lastgang=lastgang*0;
end

blind=lastgang*tan(acos(0.83));
end



