%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Elektroheizung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von Elektroheizung. Der
%Programm bestimmt den Zeitpunkt nach Benutzungsvektor , um den Geräte zu
%starten. Bitte sehe Seite 28.
function lastgang = Elektroheizung(handles, Anzahl)
%ELEKTROHEIZUNG Summary of this function goes here
%   Detailed explanation goes here
% Verschiebung ist nur bei Load Control möglich, da die Kunden die
% Nachtspeicherheizung nicht bedingen dürfen, Price Signal geht leider
% nicht.

% definieren die Zeitachse-systeme
lastgang=zeros(1,96);

switch Anzahl
    case 1        
        verbrauch=11094000/264;
    case 2
        verbrauch=15532000/264;
    case 3
        verbrauch=21745000/264;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Jahresverlauf                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

if strcmp(handles.heizperiode, 'Ja')
    
    if handles.ausstattung.heizung==1 % Nachtspeicherheizung
        dauer=ceil(verbrauch*4/10500);    
        P=zeros(1,192);
        start=[85:96];
        start_heizung=start(randi([1, numel(start)]));
        P(start_heizung:min(120,start_heizung+dauer-1))=10500;
        nachlade=randi([49,52]);
        P(nachlade:nachlade+start_heizung+dauer-120-2)=10500;
        lastgang=P(1:96)+P(97:192);
    elseif handles.ausstattung.heatingpump==1 % Heat Pump Model
        COP=4;
        
        Heatingpump=[1187 2374 3561 4748 5935 7122 8310 9497 10684 11871 13058 14245 15432 16619 17806 18993 20180 21367 22555 23742 24929 26116 27303 28490 29677 30864 ...
            32051 33238 33621 33877 33878 33879 33880 33881 35097 36499 38209 39811 41279 42612 43851 45049 45981 46785 47588 48392 49196 50000 51187 52374 53561 54748 55935 ...
            57122 58310 59497 60684 61871 63058 64245 65432 66619 67806 68993 70180 71367 72555 73742 74929 76116 77303 78490 79677 80864 82051 83238 83621 83877 83878 83879 ...
            83880 83881 85097 86499 88209 89811 91279 92612 93851 95049 95981 96785 97588 98392 99196 100000];
        while sum(lastgang) <= 4*(verbrauch/COP)
            index=randi([1,100000]);
            [Asort,index]=sort(Heatingpump(:)-index);
            startpunkt= Asort==min(Asort(Asort>=0));
            startpunkt=find(Heatingpump==Heatingpump(index(startpunkt)));
            lastgang(startpunkt)=1800;
            lastgang(78:82)=0;
            lastgang(30:34)=0;
        end
        
    else
        lastgang=zeros(1,96);
    end
elseif strcmp(handles.heizperiode, 'Nein')
    lastgang=zeros(1,96);
end

end

