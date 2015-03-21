%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Informatik %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Informatik.
function [P, Q]= Informatik(handles, Anzahl)
%INFORMATIK Summary of this function goes here
%   Detailed explanation goes here

% definieren die Zeitachse-systeme
zeitachse_24=1:24;
zeitachse_96=0.25:0.25:24;
P=zeros(1, 96);

switch Anzahl
    case 1
        Verbrauch=317400/365;
        gleichzeit_faktor=1;
    case 2
        Verbrauch=468700/365;
        gleichzeit_faktor=1;
    case 3
        Verbrauch=710800/365;
        gleichzeit_faktor=2;
end

% Bereich Informatik
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_winter_werktag; 
    informatik_faktor=0.0816;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_winter_samstag; 
    informatik_faktor=0.0887;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_winter_sonntag; 
    informatik_faktor=0.0901;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_sommer_werktag; 
    informatik_faktor=0.0575;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_sommer_samstag; 
    informatik_faktor=0.0624;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Informatik
    informatik=handles.computer_sommer_sonntag;   
    informatik_faktor=0.0634;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Informatik Tagesverlauf                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.calculation_mode, 'Normal')
    while sum(P)<=(56*Verbrauch*informatik_faktor-500)
        index_start_informatik=randi([1, int32(max(informatik))]);
        [Asort,index]=sort(informatik(:)-index_start_informatik);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.informatik=find(informatik==informatik(index(startpunkt)));
           
        index_dauer=randi([0,8]);
        P(max(1,floor(start.informatik-index_dauer/2)):min(96,floor(start.informatik+index_dauer/2)))=...
            P(max(1,floor(start.informatik-index_dauer/2)):min(96,floor(start.informatik+index_dauer/2)))+250;
        P(P>250*gleichzeit_faktor)=250*gleichzeit_faktor;
    
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Informatik Jahresverlauf                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
else
    while sum(P)<=(4*Verbrauch*365*handles.info_verteilung(handles.struct_sgd.solar_day)/100-500)
        index_start_informatik=randi([1, int32(max(informatik))]);
        [Asort,index]=sort(informatik(:)-index_start_informatik);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.informatik=find(informatik==informatik(index(startpunkt)));
           
        index_dauer=randi([0,8]);
        P(max(1,floor(start.informatik-index_dauer/2)):min(96,floor(start.informatik+index_dauer/2)))=...
            P(max(1,floor(start.informatik-index_dauer/2)):min(96,floor(start.informatik+index_dauer/2)))+250;
        P(P>250*gleichzeit_faktor)=250*gleichzeit_faktor;
    
    end
end

Q=-P*tan(acos(0.8));


