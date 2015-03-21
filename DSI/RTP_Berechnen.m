%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% RTP_Berechnen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang von RTP-Tarifen. Der
%Programm bestimmt den Startzeitpunkt von Waschmaschinen und Geschirrspüler
%stochastisch, unter Berücksichtigung der RTP-Tarifen und normale Häufigkeitsverteilung. 
%Für Detail bitte sehen Seite 74-75.
function lastgang = RTP_Berechnen(Preisstruktur, lastgang_normal, handles)
%RTP_BERECHNEN Summary of this function goes here
%   Detailed explanation goes here

 struct_sp = startpunkt_rtp(Preisstruktur, lastgang_normal, handles);
 
 lastgang.waschmaschine   = lastgang_normal.waschmaschine;
 lastgang.waeschetrockner = lastgang_normal.waeschetrockner;
 lastgang.geschirrspueler = lastgang_normal.geschirrspueler;
 lastgang.kochen          = lastgang_normal.kochen;
 lastgang.kuehlschrank    = lastgang_normal.kuehlschrank;
 lastgang.warmwasser      = lastgang_normal.warmwasser;
 lastgang.heizung         = lastgang_normal.heizung;
 lastgang.pumpe           = lastgang_normal.pumpe;
 lastgang.entertainment   = lastgang_normal.entertainment;
 lastgang.info            = lastgang_normal.info;
 lastgang.licht           = lastgang_normal.licht;
 lastgang.diverses        = lastgang_normal.diverses;
 lastgang.solar           = lastgang_normal.solar;
 
 lastgang.waschmaschine_blind = lastgang_normal.waschmaschine_blind;
 lastgang.kuehlschrank_blind  = lastgang_normal.kuehlschrank_blind;
 lastgang.pumpe_blind         = lastgang_normal.pumpe_blind;
 lastgang.entertainment_blind = lastgang_normal.entertainment_blind;
 lastgang.info_blind          = lastgang_normal.info_blind;
 lastgang.solar_blind         = lastgang_normal.solar_blind;
   
 if struct_sp.waschmaschine ~= 0 && sum(lastgang_normal.waschmaschine)~= 0
     [lastgang.waschmaschine, lastgang.waschmaschine_blind]= Waschmaschinen(struct_sp.waschmaschine);
     if sum(lastgang_normal.waeschetrockner)~= 0
         lastgang.waeschetrockner= Waschetrockner(struct_sp.waeschetrockner);
     end
 end
 
 if struct_sp.geschirrspueler ~= 0 && sum(lastgang_normal.geschirrspueler)~= 0
     lastgang.geschirrspueler= Geschirr(struct_sp.geschirrspueler);    
 end
 
 % Effizienz Steigung!!!
 lastgang.waschmaschine       = lastgang.waschmaschine*lastgang_normal.faktor_waschmaschine;       
 lastgang.waschmaschine_blind = lastgang.waschmaschine_blind*lastgang_normal.faktor_waschmaschine;
 lastgang.waeschetrockner     = lastgang.waeschetrockner*lastgang_normal.faktor_waeschetrockner;
 lastgang.geschirrspueler     = lastgang.geschirrspueler*lastgang_normal.faktor_geschirrspueler;
 
 % Gesamtverbrauch von einer Haushalt
 lastgang.single_rtp = lastgang.waschmaschine(1:96)+lastgang.waschmaschine(97:192)+...
                       lastgang.waeschetrockner(1:96)+lastgang.waeschetrockner(97:192)+...
                       lastgang.geschirrspueler(1:96)+lastgang.geschirrspueler(97:192)+...
                       lastgang.kochen+...
                       lastgang.kuehlschrank+...
                       lastgang.warmwasser+...
                       lastgang.heizung+...
                       lastgang.pumpe+...
                       lastgang.entertainment+...
                       lastgang.info+...
                       lastgang.licht+...
                       lastgang.diverses-...   
                       lastgang.solar;

 lastgang.single_blindlesitung_rtp = lastgang.waschmaschine_blind(1:96)+lastgang.waschmaschine_blind(97:192)+...
                                     lastgang.kuehlschrank_blind+...
                                     lastgang.pumpe_blind+...
                                     lastgang.entertainment_blind+...
                                     lastgang.info_blind+...
                                     lastgang.solar_blind;
  
 end


