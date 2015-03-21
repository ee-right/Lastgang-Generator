%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     23.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Ausstattungsgrad %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm ber�cksichtigt den Ausstattungszustand der Elektroger�te
% im Haushalt. sehe Seite 13, Abbildung 4.2.
function handles = Ausstattungsgrad(handles, Anzahl, i)
%AUSSTATTUNGSGRAD Summary of this function goes here
%   Detailed explanation goes here

% initialisieren
% Anfangszustand: keine Ger�te
handles.ausstattung.waschmaschine=0;
handles.ausstattung.waeschetrockner=0;
handles.ausstattung.geschirr=0;
handles.ausstattung.warmwasserspeicher=0;
handles.ausstattung.warmwasser=0;
handles.ausstattung.heizung=0;
handles.ausstattung.heatingpump=0;   
handles.ausstattung.solar=0;

% Waschmaschine
% Zufallszahl zwischen 1 und 100
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahl, so
% besitzt man eine Waschmaschine.
index=randi([1,100]); 
if index<=str2num(handles.struct_dd.waschmaschine) 
    handles.ausstattung.waschmaschine=1;
end

% W�schetrockner
% Zufallszahl zwischen 1 und 100
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahl, so
% besitzt man einen W�schetrockner.
index=randi([1,100]);
if index<=str2num(handles.struct_dd.waeschetrockner)  
    handles.ausstattung.waeschetrockner=1;
end

% Geschirrsp�ler
% Zufallszahl zwischen 1 und 100
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahl, so
% besitzt man einen Geschirrsp�ler.
index=randi([1,100]);
if index<=str2num(handles.struct_dd.geschirr)  
    handles.ausstattung.geschirr=1;
end

% Warmwasserbereitung
% Zufallszahl zwischen 1 und 100
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahl, so
% besitzt man einen Warmwasserspeicher.
% Ist diese Zufallszahl gr��er als die eingegebene Zahl f�r Warmwasser-
% speicher und kleiner als die eingegebene Zahl f�r Warmwasser, so 
% erzeugt man Warmwasser.
index=randi([1,100]);
if index<=str2num(handles.struct_dd.warmwasserspeicher) 
    handles.ausstattung.warmwasserspeicher=1;
elseif index>str2num(handles.struct_dd.warmwasserspeicher) && index<=str2num(handles.struct_dd.warmwasser)
    handles.ausstattung.warmwasser=1;
end

% Elektroheizung
% Zufallszahl zwischen 1 und 1000
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahl, so
% besitzt man eine Elektroheizung.
% Ist diese Zufallszahl gr��er als die eingegebene Zahl f�r Elektroheizung
% und kleiner gleich der Summe der eingegebenen Zahlen f�r Heizung und
% W�rmepumpe, so hat man eine W�rmepumpe.
index=randi([1,1000]); 
if index <= (str2num(handles.struct_dd.heizung)*10) 
    handles.ausstattung.heizung=1;
elseif index>(str2num(handles.struct_dd.heizung)*10) && index <= ((str2num(handles.struct_dd.heizung)+str2num(handles.struct_dd.heatingpump))*10)  
    handles.ausstattung.heatingpump=1;
end

% Photovoltaikanlage
% Zufallszahl zwischen 1 und 100
% Ist diese Zufallszahl kleiner oder gleich der eingegebenen Zahlen, so
% besitzt man eine Photovoltaikanlage.
% Case 1: 1-Personen-Haushalt
% Case 2: 2-3-Personen-Haushalte
% Case 3: 4-Personen-Haushalte oder mehr
index=randi([1,100]);
switch Anzahl
     case 1     
         if index <= str2num(handles.struct_dd.solar_1)
             handles.ausstattung.solar=1;
         end           
     case 2
         if index <= str2num(handles.struct_dd.solar_2)
             handles.ausstattung.solar=1;
         end             
     case 3
         if index <= str2num(handles.struct_dd.solar_3)
             handles.ausstattung.solar=1;
         end   
end
