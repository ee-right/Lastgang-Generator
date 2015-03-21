%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Load Profile for One Day %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function lastprofil = Calculation(handles)
%CALCULATION Summary of this function goes here
%   Detailed explanation goes here

% initialsieren die Lastgänge
% Sum Load
lastprofil.all     = zeros(1,96);
lastprofil.all_dlc = zeros(1,96);
lastprofil.all_ps  = zeros(1,96);
lastprofil.all_rtp = zeros(1,96);

lastprofil_blind.all     = zeros(1,96);
lastprofil_blind.all_dlc = zeros(1,96);
lastprofil_blind.all_ps  = zeros(1,96);
lastprofil_blind.all_rtp = zeros(1,96);

lastprofil.all_solar = zeros(1,96); %Solar

% mehr Haushalte zusammen in ein Vektor
lastprofil_singal.normal = []; 
lastprofil_singal.ps     = [];
lastprofil_singal.dlc    = [];
lastprofil_singal.rtp    = [];

lastprofil_singal.normal_blind = [];
lastprofil_singal.ps_blind     = [];
lastprofil_singal.dlc_blind    = [];
lastprofil_singal.rtp_blind    = [];

lastprofil_singal.solar  = []; %Solar Wirkleistung
lastprofil_singal.cosphi = []; %Solar cosphi

lastgang_rtp=[]; % RTP

% definieren die Anfangsdaten

% Pennetration of House Appliance
handles.struct_dd.waschmaschine=handles.struct_sgd.waschmaschine;
handles.struct_dd.waeschetrockner=handles.struct_sgd.waeschetrockner;
handles.struct_dd.geschirr=handles.struct_sgd.geschirr;
handles.struct_dd.warmwasser=handles.struct_sgd.warmwasser;
handles.struct_dd.warmwasserspeicher=handles.struct_sgd.warmwasserspeicher;
handles.struct_dd.heizung=handles.struct_sgd.heizung;
handles.struct_dd.heatingpump=handles.struct_sgd.heatingpump;

% Penetration of Photovoltaic
handles.struct_dd.solar_1=handles.struct_sgd.solar_1;
handles.struct_dd.solar_2=handles.struct_sgd.solar_2;
handles.struct_dd.solar_3=handles.struct_sgd.solar_3;

% Penetration of Consumption Optimization
handles.struct_eff.licht=str2num(handles.struct_eff.licht)/100;
handles.struct_eff.waeschetrockner=str2num(handles.struct_eff.waeschetrockner)/100;
handles.struct_eff.waschmaschine=str2num(handles.struct_eff.waschmaschine)/100;
handles.struct_eff.warmwasser=str2num(handles.struct_eff.warmwasser)/100;
handles.struct_eff.geschirr=str2num(handles.struct_eff.geschirr)/100;
handles.struct_eff.heizung=str2num(handles.struct_eff.heizung)/100;

% E-Auto Penetration
% handles.struct_dd.eauto_e_1=handles.struct_sgd.eauto_e_1;
% handles.struct_dd.eauto_e_2=handles.struct_sgd.eauto_e_2;
% handles.struct_dd.eauto_e_3=handles.struct_sgd.eauto_e_3;
% handles.struct_dd.eauto_z_1=handles.struct_sgd.eauto_z_1;
% handles.struct_dd.eauto_z_2=handles.struct_sgd.eauto_z_2;
% handles.struct_dd.eauto_z_3=handles.struct_sgd.eauto_z_3;
% handles.struct_dd.eauto_verbrauch=handles.struct_sgd.eauto_verbrauch;
% handles.struct_dd.eauto_leistung=handles.struct_sgd.eauto_leistung;
% handles.struct_dd.eauto_kapazitaet=handles.struct_sgd.eauto_kapazitaet;
% handles.struct_dd.eauto_temp=handles.struct_sgd.eauto_temp;


% Solarenegie
handles = Einstrahlungsenergie(handles);

% Häufigkeitsverteilung
handles = haeufigkeitsverteilung(handles);

% Heizung oder nicht
if strcmp(handles.season_type, 'Sommer')
    handles.heizperiode='Nein';           
else
    handles.heizperiode='Ja';
end

%% 1 Pers. Haushalt
% Berechnung der Lastprofile für 1-Personen-Haushalte
for i=1:str2num(handles.anzahl_HH_1)
    [lastgang, lastgang_normal] = Haushalt_Berechnen(handles, 1, lastprofil);
    lastgang_rtp = [lastgang_rtp lastgang_normal];
    
    if handles.cb_normal==1
        lastprofil.all = lastprofil.all+lastgang.single; % Total Load Profile (Active Power) include PV Feed-in
        lastprofil_blind.all = lastprofil_blind.all+lastgang.single_blindlesitung;
        lastprofil_singal.normal = [lastprofil_singal.normal, (lastgang.single+lastgang_normal.solar)'];
        lastprofil_singal.normal_blind = [lastprofil_singal.normal_blind, (lastgang.single_blindlesitung-lastgang_normal.solar_blind)'];
        lastprofil_singal.solar = [lastprofil_singal.solar, lastgang_normal.solar'];
        lastprofil_singal.cosphi = [lastprofil_singal.cosphi, lastgang_normal.cosphi'];          
        lastprofil.all_solar = lastprofil.all_solar+lastgang_normal.solar;
    end
    
    if handles.cb_ps==1
        lastprofil.all_ps=lastprofil.all_ps+lastgang.single_ps;
        lastprofil_blind.all_ps=lastprofil_blind.all_ps+lastgang.single_blindlesitung_ps;
        lastprofil_singal.ps=[lastprofil_singal.ps, (lastgang.single_ps+lastgang_normal.solar)'];  
        lastprofil_singal.ps_blind=[lastprofil_singal.ps_blind, (lastgang.single_blindlesitung_ps-lastgang_normal.solar_blind)'];
    end
    
    if handles.cb_dlc==1
        lastprofil.all_dlc=lastprofil.all_dlc+lastgang.single_dlc;
        lastprofil_blind.all_dlc=lastprofil_blind.all_ps+lastgang.single_blindlesitung_dlc;
        lastprofil_singal.dlc=[lastprofil_singal.dlc, (lastgang.single_dlc+lastgang_normal.solar)']; 
        lastprofil_singal.dlc_blind=[lastprofil_singal.dlc_blind, (lastgang.single_blindlesitung_dlc-lastgang_normal.solar_blind)'];
    end
end

%% 2-3 Pers. Haushalt
% Berechnung der Lastprofile für 2-3-Personen-Haushalte
for i=1:str2num(handles.anzahl_HH_2_3)
    [lastgang, lastgang_normal] = Haushalt_Berechnen(handles, 2, lastprofil);
    lastgang_rtp=[lastgang_rtp lastgang_normal];
    
    if handles.cb_normal==1
        lastprofil.all=lastprofil.all+lastgang.single;        
        lastprofil_blind.all=lastprofil_blind.all+lastgang.single_blindlesitung;
        lastprofil_singal.normal=[lastprofil_singal.normal, (lastgang.single+lastgang_normal.solar)'];
        lastprofil_singal.normal_blind=[lastprofil_singal.normal_blind, (lastgang.single_blindlesitung-lastgang_normal.solar_blind)']; 
        lastprofil_singal.solar=[lastprofil_singal.solar, lastgang_normal.solar'];
        lastprofil_singal.cosphi=[lastprofil_singal.cosphi, lastgang_normal.cosphi'];          
        lastprofil.all_solar=lastprofil.all_solar+lastgang_normal.solar;
    end
    
    if handles.cb_ps==1
        lastprofil.all_ps=lastprofil.all_ps+lastgang.single_ps;
        lastprofil_blind.all_ps=lastprofil_blind.all_ps+lastgang.single_blindlesitung_ps;
        lastprofil_singal.ps=[lastprofil_singal.ps, (lastgang.single_ps+lastgang_normal.solar)'];  
        lastprofil_singal.ps_blind=[lastprofil_singal.ps_blind, (lastgang.single_blindlesitung_ps-lastgang_normal.solar_blind)'];
    end
    
    if handles.cb_dlc==1
        lastprofil.all_dlc=lastprofil.all_dlc+lastgang.single_dlc;
        lastprofil_blind.all_dlc=lastprofil_blind.all_ps+lastgang.single_blindlesitung_dlc;
        lastprofil_singal.dlc=[lastprofil_singal.dlc, (lastgang.single_dlc+lastgang_normal.solar)']; 
        lastprofil_singal.dlc_blind=[lastprofil_singal.dlc_blind, (lastgang.single_blindlesitung_dlc-lastgang_normal.solar_blind)'];
    end
end
%% 4+ Pers. Haushalt
% Berechnung der Lastprofile für 4-Personen-Haushalte
for i=1:str2num(handles.anzahl_HH_4) 
    [lastgang, lastgang_normal] = Haushalt_Berechnen(handles, 3, lastprofil);
    lastgang_rtp=[lastgang_rtp lastgang_normal];
        
    if handles.cb_normal==1
        lastprofil.all=lastprofil.all+lastgang.single;
        lastprofil_blind.all=lastprofil_blind.all+lastgang.single_blindlesitung;
        lastprofil_singal.normal=[lastprofil_singal.normal, (lastgang.single+lastgang_normal.solar)'];
        lastprofil_singal.normal_blind=[lastprofil_singal.normal_blind, (lastgang.single_blindlesitung-lastgang_normal.solar_blind)'];
        lastprofil_singal.solar=[lastprofil_singal.solar, lastgang_normal.solar'];    % Solar Wirkleistung
        lastprofil_singal.cosphi=[lastprofil_singal.cosphi, lastgang_normal.cosphi']; % Solar cosphi
        lastprofil.all_solar=lastprofil.all_solar+lastgang_normal.solar;              % Total Solar Wirkleistung
    end
    
    if handles.cb_ps==1
        lastprofil.all_ps=lastprofil.all_ps+lastgang.single_ps;
        lastprofil_blind.all_ps=lastprofil_blind.all_ps+lastgang.single_blindlesitung_ps;
        lastprofil_singal.ps=[lastprofil_singal.ps, (lastgang.single_ps+lastgang_normal.solar)'];  
        lastprofil_singal.ps_blind=[lastprofil_singal.ps_blind, (lastgang.single_blindlesitung_ps-lastgang_normal.solar_blind)'];
    end
    
    if handles.cb_dlc==1
        lastprofil.all_dlc=lastprofil.all_dlc+lastgang.single_dlc;
        lastprofil_blind.all_dlc=lastprofil_blind.all_dlc+lastgang.single_blindlesitung_dlc;
        lastprofil_singal.dlc=[lastprofil_singal.dlc, (lastgang.single_dlc+lastgang_normal.solar)']; 
        lastprofil_singal.dlc_blind=[lastprofil_singal.dlc_blind, (lastgang.single_blindlesitung_dlc-lastgang_normal.solar_blind)'];
    end
end

%% RTP
% RTP Maßnahme mit einfließen lassen
if handles.cb_rtp==1
    Preisstruktur = RTP_Struktur(lastprofil.all);
    for i=1:str2num(handles.anzahl_HH_4)+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)        
        %%Lastgang von RTP
        lastgang_normal = lastgang_rtp(i);
        lastgang = RTP_Berechnen(Preisstruktur, lastgang_normal, handles);
        lastprofil.all_rtp = lastprofil.all_rtp+lastgang.single_rtp;
        lastprofil_blind.all_rtp = lastprofil_blind.all_rtp+lastgang.single_blindlesitung_rtp;
        lastprofil_singal.rtp = [lastprofil_singal.rtp, (lastgang.single_rtp+lastgang_normal.solar)']; 
        lastprofil_singal.rtp_blind = [lastprofil_singal.rtp_blind, (lastgang.single_blindlesitung_rtp-lastgang_normal.solar_blind)'];
    end    
end
%%

% Random allocation sequence (because the sequence is always from 1-Person Haushalt to 4+ Haushalt)  
reihfolge=randperm(size(lastprofil_singal.normal,2));


%% write the result
% Ausgabe des Lastprofils bei normaler Berechnung
if handles.cb_normal==1
    lastprofil_singal.normal=lastprofil_singal.normal(:,reihfolge);
    lastprofil_singal.solar=lastprofil_singal.solar(:,reihfolge);
    lastprofil_singal.normal_blind=lastprofil_singal.normal_blind(:,reihfolge);
    lastprofil_singal.cosphi=lastprofil_singal.cosphi(:,reihfolge); % Solar cosphi
    initiative.cb_normal=1;
    initiative.cb_ps=0;
    initiative.cb_dlc=0;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(lastprofil.all, initiative, lastprofil_singal.normal, lastprofil_singal.normal_blind);
end

% Ausgabe des Lastprofils mit TOU-Maßnahme
if handles.cb_ps==1
    lastprofil_singal.ps=lastprofil_singal.ps(:,reihfolge);
    lastprofil_singal.ps_blind=lastprofil_singal.ps_blind(:,reihfolge);    
    initiative.cb_normal=0;
    initiative.cb_ps=1;
    initiative.cb_dlc=0;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(lastprofil.all_ps, initiative, lastprofil_singal.ps, lastprofil_singal.ps_blind);
end

% Ausgabe des Lastprofils mit DLC-Maßnahme
if handles.cb_dlc==1
    lastprofil_singal.dlc=lastprofil_singal.dlc(:,reihfolge);
    lastprofil_singal.dlc_blind=lastprofil_singal.dlc_blind(:,reihfolge);    
    initiative.cb_normal=0;
    initiative.cb_ps=0;
    initiative.cb_dlc=1;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(lastprofil.all_dlc, initiative, lastprofil_singal.dlc, lastprofil_singal.dlc_blind);
end

% Ausgabe des Lastprofils mit RTP-Maßnahme
if handles.cb_rtp==1
    lastprofil_singal.rtp=lastprofil_singal.rtp(:,reihfolge);
    lastprofil_singal.rtp_blind=lastprofil_singal.rtp_blind(:,reihfolge);    
    initiative.cb_normal=0;
    initiative.cb_ps=0;
    initiative.cb_dlc=0;
    initiative.cb_rtp=1;
    initiative.solar=0;
    resultschematic(lastprofil.all_rtp, initiative, lastprofil_singal.rtp, lastprofil_singal.rtp_blind);
end

end
