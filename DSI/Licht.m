%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Licht %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Wohnraumbeleuchtung.
function  P=Licht(handles, Anzahl)
% Licht_and_Entertainment Summary of this function goes here
% Detailed explanation goes here

% definieren die Zeitachse-systeme
zeitachse_24=0.5:23.5;
zeitachse_96=0.125:0.25:23.875;
P=zeros(1, 96);

% Nutzungsverteilung für Beleuchtung je nach dem Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    licht=handles.licht_winter_werktag; 
    Licht_faktor=0.0808;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    licht=handles.licht_winter_samstag;
    Licht_faktor=0.0868;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    licht=handles.licht_winter_sonntag;   
    Licht_faktor=0.0838;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    licht=handles.licht_sommer_werktag; 
    Licht_faktor=0.0608;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    licht=handles.licht_sommer_samstag; 
    Licht_faktor=0.0619;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    licht=handles.licht_sommer_sonntag;   
    Licht_faktor=0.0595;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Licht Tagesverlauf                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.calculation_mode, 'Normal') 
    switch Anzahl                             % Unterscheidung nach Anzahl der Personen
        case 1        
            Verbrauch=14*Licht_faktor*4*198000/365;   
        case 2
            Verbrauch=14*Licht_faktor*4*344300/365;
        case 3
            Verbrauch=14*Licht_faktor*4*602600/365;
    end
    
    while sum(P)<=Verbrauch-100
        index_start_licht=randi([1, int32(max(licht))]);
        [Asort,index]=sort(licht(:)-index_start_licht);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.licht=find(licht==licht(index(startpunkt)));
           
        index_dauer=randi([0,8]);
        P(max(1,floor(start.licht-index_dauer/2)):min(96,floor(start.licht+index_dauer/2)))=...
            P(max(1,floor(start.licht-index_dauer/2)):min(96,floor(start.licht+index_dauer/2)))+25;
    
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Licht Jahresverlauf                       %   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
else                
    switch Anzahl   % Unterscheidung nach Anzahl der Personen
        case 1        
            Verbrauch=4*handles.licht_verteilung(handles.struct_sgd.solar_day)*198000/100;   
        case 2
            Verbrauch=4*handles.licht_verteilung(handles.struct_sgd.solar_day)*344300/100;
        case 3
            Verbrauch=4*handles.licht_verteilung(handles.struct_sgd.solar_day)*602600/100;
    end
    
    while sum(P)<=Verbrauch-100
        index_start_licht=randi([1, int32(max(licht))]);
        [Asort,index]=sort(licht(:)-index_start_licht);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.licht=find(licht==licht(index(startpunkt)));
           
        index_dauer=randi([0,8]);
        P(max(1,floor(start.licht-index_dauer/2)):min(96,floor(start.licht+index_dauer/2)))=...
            P(max(1,floor(start.licht-index_dauer/2)):min(96,floor(start.licht+index_dauer/2)))+25;
    
    end  
end