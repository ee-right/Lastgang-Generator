%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     13.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% bearbeitung_verteilung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm berechnet die Häufigkeitsverteilung auf
%15-Minuten-Auflösung, die Eingaben sind die Häufigkeitsverteilung auf
%Ein-Stunde-Auflösung. 
function verteilung = bearbeitung_verteilung( haeufigkeit )
%VERTEILUNG_BEARBEITUNG Summary of this function goes here
%   Detailed explanation goes here
% definieren die Zeitachse-systeme

zeitachse_24=0.5:25.5;
zeitachse_96=0.125:0.25:25.875;

verteilung_index=interp1(zeitachse_24, haeufigkeit, zeitachse_96, 'spline', 'extrap');
verteilung_index(verteilung_index<=0)=1/100000;

% Indizes ausrechnen zum Berechnen der Verteilung
for i=1:26
    if haeufigkeit(i)~=0
        verteilung_index(4*i-3:4*i)=verteilung_index(4*i-3:4*i)*haeufigkeit(i)/sum(verteilung_index(4*i-3:4*i)); 
    else
        verteilung_index(4*i-3:4*i)=[0 0 0 0];
    end
end

% Verteilung ausrechnen
for i=1:96
    verteilung(i)=round(sum(verteilung_index(5:i+4))*1000000);
    if i>1 && verteilung(i)==verteilung(i-1) && verteilung(i)~=0
        verteilung(i)=verteilung(i)+1;
    end
end
