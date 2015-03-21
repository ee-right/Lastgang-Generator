%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% DLC Warmwasser %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von Direct Load Control. Der
%Programm sucht nach den Zeitpunkt mit minimaler Last, um den Warmwasserspeicher zu betrieben.
% Es werden die Nutzungsverteilung und der Stromverbrauch bestimmt.
function P = DLC_Warmwasser(handles, lastgang, Anzahl)
%DLC_WARMWASSER Summary of this function goes here
%   Detailed explanation goes here
% definieren die Zeitachse-systeme
P=zeros(1, 96);

if strcmp(handles.calculation_mode, 'Normal')
    % Nutzungsverteilung für den Bereich Warmwasser
    if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
        warmwasser_faktor=0.077;            
    elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
        warmwasser_faktor=0.1011;
    elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
        warmwasser_faktor=0.1001;
    elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
        warmwasser_faktor=0.0582;
    elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
        warmwasser_faktor=0.0597;
    elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
        warmwasser_faktor=0.0630;
    end
    
    % definieren den Stromverbrauch pro Tag
    switch Anzahl
        case 1
            Verbrauch=704600/365;
        case 2
            Verbrauch=1247850/365;
        case 3
            Verbrauch=2100633/365;
    end
    
    while sum(P)<=56*Verbrauch*warmwasser_faktor      
        start.warmwasser=find(lastgang==min(lastgang)); % search for the mindest value
        P(start.warmwasser)=2700;
        lastgang(start.warmwasser)=max(lastgang);
    end     
else
    % definieren den Stromverbrauch pro Tag
    switch Anzahl
        case 1
            Verbrauch=704600*handles.warmwasser_verteilung(handles.struct_sgd.solar_day)/100;
        case 2
            Verbrauch=1247850*handles.warmwasser_verteilung(handles.struct_sgd.solar_day)/100;
        case 3
            Verbrauch=2100633*handles.warmwasser_verteilung(handles.struct_sgd.solar_day)/100;
    end
    
    while sum(P)<=4*Verbrauch      
        start.warmwasser=find(lastgang==min(lastgang)); % search for the mindest value
        P(start.warmwasser)=2700;
        lastgang(start.warmwasser)=max(lastgang);
    end 
end	

