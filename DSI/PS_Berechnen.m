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
%Programm bestimmt den Startzeitpunkt von Waschmaschinen und Geschirrsp�ler
%stochastisch, unter Ber�cksichtigung der TOU-Tarifen und normale H�ufigkeitsverteilung. 
%F�r Detail bitte sehen Seite 69-70.
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
 %                             W�schetrockner                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 lastgang.waeschetrockner = Waschetrockner(struct_sp.waschmaschine+9);      
 lastgang.waeschetrockner = lastgang.waeschetrockner*handles.ausstattung.waeschetrockner*handles.benutzung.waeschetrockner;
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %                             Geschirrsp�ler                             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 lastgang.geschirrspueler = Geschirr(struct_sp.geschirrspueler);
 lastgang.geschirrspueler = lastgang.geschirrspueler*handles.ausstattung.geschirr*handles.benutzung.geschirr;
 
end

