%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Preis Signal Berechnen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von TOU-Tarifen. Der
%Programm bestimmt den Startzeitpunkt von Waschmaschinen und Geschirrspüler
%stochastisch, unter Berücksichtigung der TOU-Tarifen und normale Häufigkeitsverteilung. 
%Für Detail bitte sehen Seite 69-70.
function lastgang=PS_Berechnen(handles, Anzahl)
%PS_BERECHNEN Summary of this function goes here
%   Detailed explanation goes here

 [struct_sp, handles] = startpunkt(handles);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Waschmaschine                              %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 [lastgang.waschmaschine, lastgang.waschmaschine_blind] = Waschmaschinen(struct_sp.waschmaschine);
 lastgang.waschmaschine = lastgang.waschmaschine*handles.ausstattung.waschmaschine*handles.benutzung.waschmaschine;
 lastgang.waschmaschine_blind = lastgang.waschmaschine_blind*handles.ausstattung.waschmaschine*handles.benutzung.waschmaschine;
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Wäschetrockner                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 lastgang.waeschetrockner = Waschetrockner(struct_sp.waschmaschine+9);      
 lastgang.waeschetrockner = lastgang.waeschetrockner*handles.ausstattung.waeschetrockner*handles.benutzung.waeschetrockner;
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Geschirrspüler                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.geschirrspueler = Geschirr(struct_sp.geschirrspueler);
 lastgang.geschirrspueler = lastgang.geschirrspueler*handles.ausstattung.geschirr*handles.benutzung.geschirr;
 
end

