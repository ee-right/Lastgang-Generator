%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Geschirrspüler %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Tageslastgang vom Geschirrspüler, hier wird
%sein typischer Lastgang dargestellt und verwendet. Bitte sehe die Bilder
%auf Seite 22.
function P = Geschirr(Startspunkt)
%GESCHIRR Summary of this function goes here
%   Detailed explanation goes here

lastgang=[100 2000 100 100 100 2000 300 200];
P=[zeros(1,Startspunkt-1) lastgang zeros(1,192-Startspunkt-7)];

end

