%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     16.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Berechnen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% In diesem Programm werden die Tageslastgänge aller Haushaltgeräte
% simuliert.
% Dieses Programm dient ausschließlich zum Simulieren. Es ruft dazu mehrere
% Funktionen auf.
function  [lastgang, handles]=Berechnen(handles, Anzahl)
%BERECHNEN Summary of this function goes here
%   Detailed explanation goes here

 [struct_sp, handles]=startpunkt(handles);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Waschmaschine                              %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.waschmaschine, lastgang.waschmaschine_blind] = Waschmaschinen(struct_sp.waschmaschine);
 lastgang.waschmaschine = lastgang.waschmaschine*handles.ausstattung.waschmaschine*handles.benutzung.waschmaschine;
 lastgang.waschmaschine_blind = lastgang.waschmaschine_blind*handles.ausstattung.waschmaschine*handles.benutzung.waschmaschine; % cos(phi) = 0,83
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Wäschetrockner                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.waeschetrockner = Waschetrockner(struct_sp.waschmaschine+randi([7,8]));      % randi([7,8])
 lastgang.waeschetrockner = lastgang.waeschetrockner*handles.ausstattung.waeschetrockner*handles.benutzung.waeschetrockner; % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Geschirrspüler                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.geschirrspueler = Geschirr(struct_sp.geschirrspueler);
 lastgang.geschirrspueler = lastgang.geschirrspueler*handles.ausstattung.geschirr*handles.benutzung.geschirr; % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                                 Kochen                                 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.kochen = Kochen(handles, Anzahl); % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                              Kühlschrank                               %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.kuehlschrank, lastgang.kuehlschrank_blind] = Kuehlschrank(handles, Anzahl); % cos(phi) = 0.9 induktiv!
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                              Warmwasser                                %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.warmwasser = Warmwasser_Nachtspeicher(handles, Anzahl, struct_sp.warmwasser); % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                           Elektroheizung                               %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.heizung = Elektroheizung(handles, Anzahl); % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                           Kreiselpumpe                                 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.pumpe, lastgang.pumpe_blind] = Kreiselpumpe(handles, Anzahl); % cos(phi) = 0.83 induktiv
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                           Entertainment                                %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.entertainment, lastgang.entertainment_blind] = Entertainment(handles, Anzahl); % Fernseher + Musik + Standby, cos(phi) = negativ
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                           Informatik                                   %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.info, lastgang.info_blind] = Informatik(handles, Anzahl); % cos(phi) = 0.8 kapacitiv
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Licht                                      %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.licht = Licht(handles, Anzahl); % cos(phi) = 1
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Diverse                                    %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.diverses = Diverse(handles, Anzahl); % cos(phi) = 1
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Photovoltaic                               %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [lastgang.solar, lastgang.cosphi, lastgang.solar_blind] = solarenergie(handles, str2num(handles.struct_sgd.solar_day)); % cos(phi) nach VDE-AR-N 4105
 
%  lastgang.solar=solarenergie(handles, str2num(handles.struct_sgd.solar_day)); % Florian Liel Änderung????
%  lastgang.eauto_e=Eauto_Last(struct_sp.eauto_e);
end

