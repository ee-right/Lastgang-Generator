%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% DLC Heizung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von Direct Load Control. Der
%Programm sucht nach den Zeitpunkt mit minimaler Last, um den Heizung zu betrieben. 
function P=DLC_Heizung(handles, lastgang, Anzahl)
%DLC_HEIZUNG Summary of this function goes here
%   Detailed explanation goes here

P=zeros(1, 96);
start=[];

switch Anzahl
    case 1
        verbrauch=11094000/264;
    case 2
        verbrauch=15532000/264;
    case 3
        verbrauch=21745000/264;
end

% Berechnung eines Verbrauchswertes abhängig von der Anzahl der Sonnentage.
% Je mehr Sonnentage, desto weniger muss die Heizung in Betrieb sein.

if strcmp(handles.calculation_mode, 'Halbjahr-Verlauf')
    if handles.struct_sgd.solar_day<=31
        verbrauch=verbrauch*1.56;
    elseif handles.struct_sgd.solar_day<=59
        verbrauch=verbrauch*1.43;        
    elseif handles.struct_sgd.solar_day<=90        
        verbrauch=verbrauch*1.11; 
    elseif handles.struct_sgd.solar_day<=120        
        verbrauch=verbrauch*0.76;  
    elseif handles.struct_sgd.solar_day<=144
        verbrauch=verbrauch*0.40;        
    elseif handles.struct_sgd.solar_day<=273
        verbrauch=verbrauch*0.31;        
    elseif handles.struct_sgd.solar_day<=304
        verbrauch=verbrauch*0.76;   
    elseif handles.struct_sgd.solar_day<=334
        verbrauch=verbrauch*1.20; 
    elseif handles.struct_sgd.solar_day<=365
        verbrauch=verbrauch*1.47;         
    end
end

% Bestimmung der Heizperiode
% Falls "Nein": Heizung ist aus -> keine Last
% Falls "Ja": Unterscheidung zwischen Nachspeicherheizung und Wärmepumpe.
% Falls keines von Beidem: keine Heizung -> keine Last

if strcmp(handles.heizperiode, 'Ja')   
    if handles.ausstattung.heizung==1 
        while sum(P)<=4*verbrauch
            start.heizung=find(lastgang==min(lastgang));
            P(start.heizung)=10500;
            lastgang(start.heizung)=max(lastgang);
        end
    elseif handles.ausstattung.heatingpump==1 
        COP=4;
        while sum(P)<=4*verbrauch/COP
            start.heatingpump=find(lastgang==min(lastgang));
            P(start.heatingpump)=1800;
            lastgang(start.heatingpump)=max(lastgang);
        end
    else
        P=zeros(1,96);
    end
else
    P=zeros(1,96);
end


end

