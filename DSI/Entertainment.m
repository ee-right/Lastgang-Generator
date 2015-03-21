%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Entertainment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Unterhaltung. Bitte
%sehe Seite 35.

% Grob eingeteilt wird die Unterhaltung in Fernseher inkl. Satellitanlage
% und Videorecorder, Musikanlage/Radio und Standby-Betrieb.

function  [P, Q]=Entertainment(handles, Anzahl)
% Entertainment Summary of this function goes here
% Detailed explanation goes here

% definieren die Zeitachse-systeme

zeitachse_24_standby=0.5:23.5;
zeitachse_96_standby=0.125:0.25:23.875;

zeitachse_24=1:24;
zeitachse_96=0.25:0.25:24;

P_fernseher=zeros(1, 96);
P_musik=zeros(1, 96);

%start time point
start=[];

Fernseher_faktor=1000;

Musik_faktor=1000;

switch Anzahl
    case 1        
        Verbrauch=283900/365; % Energieverbrauch pro Tag
        gleichzeit_faktor=1;
    case 2
        Verbrauch=464250/365;
        gleichzeit_faktor=2;
    case 3
        Verbrauch=616700/365;
        gleichzeit_faktor=2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              1. Fernseher                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nutzungsverteilung für den Bereich Fernseher, Satellitanlage und Videorecorder 
% je nach dem Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    Fernseher=handles.fernseher_winter_werktag;   
    Fernseher_faktor=0.0816;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    Fernseher=handles.fernseher_winter_samstag;
    Fernseher_faktor=0.0887;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    Fernseher=handles.fernseher_winter_sonntag;     
    Fernseher_faktor=0.0901;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    Fernseher=handles.fernseher_sommer_werktag;
    Fernseher_faktor=0.0575;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    Fernseher=handles.fernseher_sommer_samstag;
    Fernseher_faktor=0.0624;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    Fernseher=handles.fernseher_sommer_sonntag;
    Fernseher_faktor=0.0634;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       1.1 Fernseher Tagsverlauf                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.calculation_mode, 'Normal')    
    while sum(P_fernseher)<=(0.48*56*Verbrauch*Fernseher_faktor-260)  % 48% of insgesamt Verbrauch ist Fernseher      
        index_start_fernseher=randi([1,int32(max(Fernseher))]);  % Fernseher Start Zeit
        [Asort,index]=sort(Fernseher(:)-index_start_fernseher);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.fernseher=find(Fernseher==Fernseher(index(startpunkt)));
           
        index_dauer=randi([0,4]);
        P_fernseher(max(1,floor(start.fernseher-index_dauer/2)):min(96,floor(start.fernseher+index_dauer/2)))=...
            P_fernseher(max(1,floor(start.fernseher-index_dauer/2)):min(96,floor(start.fernseher+index_dauer/2)))+135;
        P_fernseher(P_fernseher>135*gleichzeit_faktor)=135*gleichzeit_faktor;
    
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        1.2 Fernseher Jahresverlauf                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
else
    while sum(P_fernseher)<=(0.48*4*Verbrauch*365*handles.entertainment_verteilung(handles.struct_sgd.solar_day)/100-260)        
        index_start_fernseher=randi([1,int32(max(Fernseher))]); 
        [Asort,index]=sort(Fernseher(:)-index_start_fernseher);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.fernseher=find(Fernseher==Fernseher(index(startpunkt)));
           
        index_dauer=randi([0,4]);
        P_fernseher(max(1,floor(start.fernseher-index_dauer/2)):min(96,floor(start.fernseher+index_dauer/2)))=...
            P_fernseher(max(1,floor(start.fernseher-index_dauer/2)):min(96,floor(start.fernseher+index_dauer/2)))+135;
        P_fernseher(P_fernseher>135*gleichzeit_faktor)=135*gleichzeit_faktor;
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             2. Musik Anlagen                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nutzungsverteilung für den Bereich Musikanlage und Radio je nach dem Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    Musik=handles.musik_winter_werktag;   
    Musik_faktor=0.0677;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    Musik=handles.musik_winter_samstag;
    Musik_faktor=0.0841;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    Musik=handles.musik_winter_sonntag;   
    Musik_faktor=0.0776;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    Musik=handles.musik_sommer_werktag;
    Musik_faktor=0.0677;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    Musik=handles.musik_sommer_samstag;
    Musik_faktor=0.0841;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    Musik=handles.musik_sommer_sonntag;
    Musik_faktor=0.0776;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       2.1 Musik Anlagen Tagsverlauf                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(handles.calculation_mode, 'Normal')    
    while sum(P_musik)<=(0.07*56*Verbrauch*Musik_faktor-65)  % 7% of insgesamt Verbrauch ist Musik
        index_start_musik=randi([1,int32(max(Musik))]);
        [Asort,index]=sort(Musik(:)-index_start_musik);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.musik=find(Musik==Musik(index(startpunkt)));
           
        index_dauer=randi([0,4]);
        dauer=start.musik+index_dauer;
        P_musik(start.musik:min(96,dauer))=P_musik(start.musik:min(96,dauer))+65;
        P_musik(P_musik>65*gleichzeit_faktor)=65*gleichzeit_faktor;
    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       2.2 Musik Anlagen Jahresverlauf                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    while sum(P_musik)<=(0.07*4*Verbrauch*365*handles.entertainment_verteilung(handles.struct_sgd.solar_day)/100-65)  
        index_start_musik=randi([1,int32(max(Musik))]);
        [Asort,index]=sort(Musik(:)-index_start_musik);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.musik=find(Musik==Musik(index(startpunkt)));
           
        index_dauer=randi([0,4]);
        dauer=start.musik+index_dauer;
        P_musik(start.musik:min(96,dauer))=P_musik(start.musik:min(96,dauer))+65;
        P_musik(P_musik>65*gleichzeit_faktor)=65*gleichzeit_faktor;
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             3. Standby                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nutzungsverteilung für den Bereich Standby (alle Stanby_faktor gleich!)
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040];
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040];
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040];   
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040];
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040];
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    standby=[0.042 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 0.043 ...
        0.043 0.043 0.042 0.041 0.041 0.041 0.040 0.037 0.034 0.036 0.040]; 
end

standby=interp1(zeitachse_24_standby, standby, zeitachse_96_standby, 'linear', 'extrap');

P_standby=4*standby*0.45*Verbrauch/sum(standby);  % 45% of insgesamt Verbrauch ist Standby

%Wirkleistung
P=P_standby+P_musik+P_fernseher;

%Scheinleistung
Q=-P_standby*tan(acos(0.55))-P_musik*tan(acos(0.67))-P_fernseher*tan(acos(0.67));
