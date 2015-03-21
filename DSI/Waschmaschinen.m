%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Waschmaschinen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Tageslastgang vom Waschmaschinen, hier wird
%sein typischer Lastgang dargestellt und verwendet. Bitte sehe die Bilder
%auf Seite 18.
function [P, Q] = Waschmaschinen(Startspunkt)
%WASCHMASCHINEN Summary of this function goes here
%   Detailed explanation goes here
  
lastgang=[100 2000 900 100 100 300 50];
P=[zeros(1,Startspunkt-1) lastgang zeros(1,192-Startspunkt-6)];

Q=P*tan(acos(0.83));
end

