%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     23.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Gesamt_Benutzungsfrequenz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm berechnet die Energiebedarfsverteilung jeder
% Elektrogeräte sehe meine Arbeit Seite 14-16
function handles = Gesamt_Benutzungsfrequenz(handles)
%GESAMT_BENUTZUNGSFREQUENZ Summary of this function goes here
%   Detailed explanation goes here
waschmaschine.winter_werktag=0.086;            
waschmaschine.sommer_werktag=0.0601; 
waschmaschine.winter_samstag=0.0861;            
waschmaschine.sommer_samstag=0.0632; 
waschmaschine.winter_sonntag=0.076;            
waschmaschine.sommer_sonntag=0.0442; 
waschmaschine_verteilung=Verteilung_Bearbeitung(waschmaschine);

geschirr.winter_samstag=0.104;            
geschirr.sommer_samstag=0.0692; 
geschirr.winter_sonntag=0.1104;            
geschirr.sommer_sonntag=0.069; 
geschirr.winter_werktag=0.0778;            
geschirr.sommer_werktag=0.0517; 
geschirr_verteilung=Verteilung_Bearbeitung(geschirr);

licht.winter_samstag=0.0868;            
licht.sommer_samstag=0.0619; 
licht.winter_sonntag=0.0838;            
licht.sommer_sonntag=0.0595; 
licht.winter_werktag=0.0808;            
licht.sommer_werktag=0.0608; 
handles.licht_verteilung=Verteilung_Bearbeitung(licht);

kochen.winter_samstag=0.0951;            
kochen.sommer_samstag=0.0546; 
kochen.winter_sonntag=0.1233;            
kochen.sommer_sonntag=0.0710; 
kochen.winter_werktag=0.0747;            
kochen.sommer_werktag=0.0565; 
handles.kochen_verteilung=Verteilung_Bearbeitung(kochen);

entertainment.winter_samstag=0.0887;            
entertainment.sommer_samstag=0.0624; 
entertainment.winter_sonntag=0.0901;            
entertainment.sommer_sonntag=0.0634; 
entertainment.winter_werktag=0.0816;            
entertainment.sommer_werktag=0.0575; 
handles.entertainment_verteilung=Verteilung_Bearbeitung(entertainment);

info.winter_samstag=0.0887;            
info.sommer_samstag=0.0624; 
info.winter_sonntag=0.0901;            
info.sommer_sonntag=0.0634; 
info.winter_werktag=0.0816;            
info.sommer_werktag=0.0575; 
handles.info_verteilung=Verteilung_Bearbeitung(info);

warmwasser.winter_samstag=0.1011;            
warmwasser.sommer_samstag=0.0597; 
warmwasser.winter_sonntag=0.1001;            
warmwasser.sommer_sonntag=0.063; 
warmwasser.winter_werktag=0.077;            
warmwasser.sommer_werktag=0.0582; 
handles.warmwasser_verteilung=Verteilung_Bearbeitung(warmwasser);

for i = 1:365
    handles.waschmaschine_verteilung(i)=round(sum(waschmaschine_verteilung(1:i))*10000);
    handles.geschirr_verteilung(i)=round(sum(geschirr_verteilung(1:i))*10000);
end
end

