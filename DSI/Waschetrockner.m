%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Waschetrockner %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Tageslastgang vom Wäschetrockner, hier wird
%sein typischer Lastgang dargestellt und verwendet. Bitte sehe die Bilder
%auf Seite 21.
function P = Waschetrockner(Startspunkt)
%WaschetrocknerSummary of this function goes here
%   Detailed explanation goes here

lastgang=[2000 2000 2000 1500 1300 900];
P=[zeros(1,Startspunkt-1) lastgang zeros(1,192-Startspunkt-5)];

end

