%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Kochen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Kochen. Bitte sehe die
%Bilder auf Seite 38.
function P=Kochen(handles, Anzahl)
%KOCHEN Summary of this function goes here
%   Detailed explanation goes here
P=zeros([1,96]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Tagsverlauf                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.calculation_mode, 'Normal') % ein Tag Lastprofil
    switch Anzahl
        case 1
            Verbrauch=173000/365;
        case 2
            Verbrauch=358000/365;
        case 3
            Verbrauch=504000/365;
    end
    
    if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
        kochen=handles.kochen_winter_werktag;        
        kochen_faktor=0.0747;
    elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
        kochen=handles.kochen_winter_samstag; 
        kochen_faktor=0.0951;
    elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')    
        kochen=handles.kochen_winter_sonntag;
        kochen_faktor=0.1233;
    elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
        kochen=handles.kochen_sommer_werktag;
        kochen_faktor=0.0565;
    elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
        kochen=handles.kochen_sommer_samstag;   
        kochen_faktor=0.0546;
    elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
        kochen=handles.kochen_sommer_sonntag;   
        kochen_faktor=0.0710;
    end
        
    % Einschaltwahrscheinlichkeit von Kochen pro Tag
    while sum(P)<=((14*4*Verbrauch*kochen_faktor)-400)  % *4 weil 1/4 h pro Zeitpunkt
        index_start=randi([1, int32(max(kochen))]);
        [Asort,index]=sort(kochen(:)-index_start);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.kochen=find(kochen==kochen(index(startpunkt))); % Startpunkt gefunden !?
        
        index=randi([1, 4]); % Die Wahrscheinlichkeiten von Elektroherd(1kW)und Backofen(3kW)sind 75% und 25 %   
        if index==1
            P(start.kochen)=3000;
        else
            P(start.kochen)=1000;
        end                   
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Jahresverlauf                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
else % Jahresverlauf
    switch Anzahl
        case 1
            Verbrauch=4*173000*handles.kochen_verteilung(handles.struct_sgd.solar_day)/100;
        case 2
            Verbrauch=4*358000*handles.kochen_verteilung(handles.struct_sgd.solar_day)/100;
        case 3
            Verbrauch=4*504000*handles.kochen_verteilung(handles.struct_sgd.solar_day)/100;
    end
    
    % Einschaltwahrscheinlichkeit von Kochen pro Tag nach unterschiedliche
    % Tagestypen
    while sum(P)<=((Verbrauch)-400)
        if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
            kochen=handles.kochen_winter_werktag;
            index_start=randi([1, int32(max(kochen))]);
            kochen_faktor=0.0747;
        elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
            kochen=handles.kochen_winter_samstag; 
            index_start=randi([1, int32(max(kochen))]);
            kochen_faktor=0.0951;
        elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')    
            kochen=handles.kochen_winter_sonntag;
            index_start=randi([1, int32(max(kochen))]);
            kochen_faktor=0.1233;
        elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
            kochen=handles.kochen_sommer_werktag;
            index_start=randi([1, int32(max(kochen))]);   
            kochen_faktor=0.0565;
        elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
            kochen=handles.kochen_sommer_samstag; 
            index_start=randi([1, int32(max(kochen))]);  
            kochen_faktor=0.0546;
        elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
            kochen=handles.kochen_sommer_sonntag;  
            index_start=randi([1, int32(max(kochen))]); 
            kochen_faktor=0.0710;
        end
               
        [Asort,index]=sort(kochen(:)-index_start);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.kochen=find(kochen==kochen(index(startpunkt)));
        
        index=randi([1, 4]);    
        if index==1
            P(start.kochen)=3000;
        else
            P(start.kochen)=1000;
        end
          
    end
end

end


