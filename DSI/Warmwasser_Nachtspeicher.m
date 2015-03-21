%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Warmwasser %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Warmwasserbereitstellung.
function lastgang = Warmwasser_Nachtspeicher(handles, Anzahl, Startspunkt)
%WARMWASSER Summary of this function goes here
%   Detailed explanation goes here
% definieren die Zeitachse-systeme
lastgang_zwischenwert=zeros(1,192);
lastgang=zeros(1,96);

% definieren den Stromverbrauch pro Tag
switch Anzahl
    case 1
        Verbrauch=704600/365;
    case 2
        Verbrauch=1247850/365;
    case 3
        Verbrauch=2103633/365;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Tagsverlauf                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    
    if handles.ausstattung.warmwasserspeicher==1
        P=2700;        
        dauer=ceil(56*Verbrauch*warmwasser_faktor/2700);
        lastgang_zwischenwert(Startspunkt:Startspunkt+dauer-1)=P;
        lastgang=lastgang_zwischenwert(1:96)+lastgang_zwischenwert(97:192);
         
    elseif handles.ausstattung.warmwasser==1 %!!!!!!!!!!!!
        while sum(lastgang)<=56*Verbrauch*warmwasser_faktor
            
            % Nutzungsverteilung für den Bereich Warmwasser
            if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_werktag;  
                index_start=randi([1, int32(max(warmwasser))]);             
            elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_samstag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_sonntag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_werktag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_samstag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_sonntag;  
                index_start=randi([1, int32(max(warmwasser))]);
            end
    
            [Asort,index]=sort(warmwasser(:)-index_start);
            startpunkt= Asort==min(Asort(Asort>=0));
            start.warmwasser=find(warmwasser==warmwasser(index(startpunkt)));
            lastgang(start.warmwasser)=18000;
        end
    else
        lastgang(1:96)=0;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Jahresverlauf                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    % Nutzungsverteilung für den Bereich Warmwasser   
    if handles.ausstattung.warmwasserspeicher==1
        P=2700;        
        dauer=ceil(4*Verbrauch*365*handles.warmwasser_verteilung(handles.struct_sgd.solar_day)/270000);
        lastgang_zwischenwert(Startspunkt:Startspunkt+dauer-1)=P;
        lastgang=lastgang_zwischenwert(1:96)+lastgang_zwischenwert(97:192);
         
    elseif handles.ausstattung.warmwasser==1 %Durchlauf Warmwasser
        while sum(lastgang)<=4*Verbrauch*365*handles.warmwasser_verteilung(handles.struct_sgd.solar_day)/100
            
            % Nutzungsverteilung für den Bereich Warmwasser
            if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_werktag;  
                index_start=randi([1, int32(max(warmwasser))]);             
            elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_samstag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
                warmwasser=handles.warmwasser_sonntag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_werktag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_samstag;  
                index_start=randi([1, int32(max(warmwasser))]);
            elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
                warmwasser=handles.warmwasser_sonntag;  
                index_start=randi([1, int32(max(warmwasser))]);
            end
    
            [Asort,index]=sort(warmwasser(:)-index_start);
            startpunkt= Asort==min(Asort(Asort>=0));
            start.warmwasser=find(warmwasser==warmwasser(index(startpunkt)));
            lastgang(start.warmwasser)=18000;
        end
    else
        lastgang(1:96)=0;
    end
end	
