%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     06.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Verteilung_Bearbeitung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm berechnet die Energiebedarfsverteilung jeder
% Elektrogeräte sehe meine Arbeit Seite 14-16
function F_new = Verteilung_Bearbeitung( geraete )
%FREQUENZ_BEARBEITUNG Summary of this function goes here
%   Detailed explanation goes here
mittel = 1/14;
F_t = [];
sum_index = [];
for t=1:365
    F = (-3.92e-10*t^4+3.2e-7*t^3-7.02e-5*t^2+2.1e-3*t+1.24-1);
    if mod(t, 7)==5                   
        if F>=0
            index=geraete.winter_samstag-mittel;     % hausgeräte in Gesamt_Benutzungsfrequenz       
        else
            index=geraete.sommer_samstag-mittel; 
        end 
    elseif mod(t, 7)==6
        if F>=0
            index=geraete.winter_sonntag-mittel;            
        else
            index=geraete.sommer_sonntag-mittel; 
        end 
    else
        if F>=0
            index=geraete.winter_werktag-mittel;            
        else
            index=geraete.sommer_werktag-mittel; 
        end 
    end   
    sum_index=[sum_index index];
    F_t=[F_t F];
end

zwischen(F_t>=0) = sum_index(F_t>=0)/ (sum(sum_index(F_t>=0))/ numel(F_t(F_t>=0)));
 zwischen(F_t<0) = sum_index(F_t<0) / (sum(sum_index(F_t<0)) / numel(F_t(F_t<0)));
    F_t1(F_t>=0) = F_t(F_t>=0)      *  sum(sum_index(F_t>=0))/ sum(F_t(F_t>=0));
     F_t1(F_t<0) = F_t(F_t<0)       *  sum(sum_index(F_t<0)) / sum(F_t(F_t<0));
           F_new = zwischen.*F_t1+mittel;   % Veränderung nur nähr mittel
           F_new = F_new*100/sum(F_new);