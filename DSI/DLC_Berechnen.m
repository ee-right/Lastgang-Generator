%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% DLC Berechnen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von Direct Load Control. Der
%Programm sucht nach den Zeitpunkt mit minimaler Last, um den Geräte zu
%starten. Bitte sehe den Ablaufdiagramm auf Seite 77, Abbildung 6.12.
function lastgang = DLC_Berechnen(handles, Anzahl, lastprofil, lastgang_normal)
%DLC_BERECHNEN Summary of this function goes here
%   Detailed explanation goes here
struct_sp=[];
        
% tag=1;
% [ausstattung, P, cosphi, lastgang, lastgang_Jahres]=solargesamt(handles, Anzahl, tag);
% % Gesamtlastgang: Summe der einzelnen Lastgänge

lastprofil.all_dlc = lastprofil.all_dlc+...
                     lastgang_normal.kochen+...
                     lastgang_normal.kuehlschrank+...
                     lastgang_normal.entertainment+...
                     lastgang_normal.info+...
                     lastgang_normal.licht+...
                     lastgang_normal.diverses-...
                     lastgang_normal.solar;
    
% Waschmaschine
struct_sp.waschmaschine = find(lastprofil.all_dlc==min(lastprofil.all_dlc))-1;
if struct_sp.waschmaschine<1
    struct_sp.waschmaschine = struct_sp.waschmaschine+96;
end

[lastgang.waschmaschine, lastgang.waschmaschine_blind] = Waschmaschinen(struct_sp.waschmaschine);
lastgang.waschmaschine = lastgang.waschmaschine*handles.benutzung.waschmaschine*handles.ausstattung.waschmaschine;
lastgang.waschmaschine_blind = lastgang.waschmaschine_blind*handles.ausstattung.waschmaschine*handles.benutzung.waschmaschine;

% Wäschetrockner
lastgang.waeschetrockner = Waschetrockner(struct_sp.waschmaschine+9);
lastgang.waeschetrockner = lastgang.waeschetrockner*handles.benutzung.waeschetrockner*handles.ausstattung.waeschetrockner;

lastprofil.all_dlc = lastprofil.all_dlc+...
                     lastgang.waschmaschine(1:96)+lastgang.waschmaschine(97:192)+...
                     lastgang.waeschetrockner(1:96)+lastgang.waeschetrockner(97:192);


% Geschirrspüler unter Berücksichtigung der Benutzungsfrequenz
struct_sp.geschirrspueler = find(lastprofil.all_dlc==min(lastprofil.all_dlc))-1;
lastgang.geschirrspueler = Geschirr(struct_sp.geschirrspueler);
lastgang.geschirrspueler = lastgang.geschirrspueler*handles.benutzung.geschirr*handles.ausstattung.geschirr;

lastprofil.all_dlc = lastprofil.all_dlc+...
                     lastgang.geschirrspueler(1:96)+lastgang.geschirrspueler(97:192);

% Heizung unter Berücksichtigung der Ausstattungsgrad
lastgang.heizung = DLC_Heizung(handles, lastprofil.all_dlc, Anzahl);
lastprofil.all_dlc = lastprofil.all_dlc+...
                     lastgang.heizung;

% Warmwasser unter Berücksichtigung der Ausstattungsgrad
if handles.ausstattung.warmwasserspeicher==1 
    lastgang.warmwasser = DLC_Warmwasser(handles, lastprofil.all_dlc, Anzahl);
else
    lastgang.warmwasser = lastgang_normal.warmwasser(1:96);
end

% Lastprofil aktualisieren
lastprofil.all_dlc = lastprofil.all_dlc+...
                     lastgang.warmwasser;

end

