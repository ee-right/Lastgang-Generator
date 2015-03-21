%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     06.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Load Profile for One Year %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function Jahresverlauf(handles)
%JAHRESVERLAUF Summary of this function goes here
%   Detailed explanation goes here

%initializieren die Zustandsdaten

% Sum Load (Total Year)
struct_rar.jahresverlauf=zeros(1,  35136);  
struct_rar.jahresverlauf_ps=zeros(1,  35136);
struct_rar.jahresverlauf_dlc=zeros(1,  35136);
struct_rar.jahresverlauf_rtp=zeros(1,  35136);
struct_rar.jahresverlauf_blind=zeros(1,  35136);  
struct_rar.jahresverlauf_ps_blind=zeros(1,  35136);
struct_rar.jahresverlauf_dlc_blind=zeros(1,  35136);
struct_rar.jahresverlauf_rtp_blind=zeros(1,  35136);

% mehr Haushalte zusammen in ein Matrix 
lastprofil_singal.normal=[];
lastprofil_singal.ps=[];
lastprofil_singal.rtp=[];
lastprofil_singal.dlc=[];

lastprofil_singal.normal_blind=[];
lastprofil_singal.ps_blind=[];
lastprofil_singal.rtp_blind=[];
lastprofil_singal.dlc_blind=[];

lastprofil_singal.solar=[];  %Solar Wirkleistung
lastprofil_singal.cosphi=[]; %Solar cosphi

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

% Penetration of Consumption Optimization
handles.struct_eff.licht=str2num(handles.struct_eff.licht)/100;
handles.struct_eff.waeschetrockner=str2num(handles.struct_eff.waeschetrockner)/100;
handles.struct_eff.waschmaschine=str2num(handles.struct_eff.waschmaschine)/100;
handles.struct_eff.warmwasser=str2num(handles.struct_eff.warmwasser)/100;
handles.struct_eff.geschirr=str2num(handles.struct_eff.geschirr)/100;
handles.struct_eff.heizung=str2num(handles.struct_eff.heizung)/100;
handles.struct_eff.durchdringung=str2num(handles.struct_eff.durchdringung);

% Penetration of Photovoltaic
handles.struct_dd.solar_1=handles.struct_sgd.solar_1;
handles.struct_dd.solar_2=handles.struct_sgd.solar_2;
handles.struct_dd.solar_3=handles.struct_sgd.solar_3;

h = waitbar(0,'Please wait...'); % ???
    
%Solarenegie
handles = Jahres_Einstrahlungsenergie(handles);

%Ausstattung
anzahl_haushalt = str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4);
handles = Jahres_Ausstattungsgrad(handles, anzahl_haushalt);  % welche Haushalt mit Waschmaschine, W?schetrockner, Geschirrsp?ler, Warmwaseerbereitung und Elektroheizung

%H?ufigkeitsverteilung
handles = haeufigkeitsverteilung(handles);

%Benutzungsfrequenz
handles = Gesamt_Benutzungsfrequenz(handles); % Benutzungsfrequenz ganz Jahr Verteilen

%TOU-Preissignal (Haushalt Teilnahmen Durchdringung)
ps_active= zeros(1, anzahl_haushalt);
n = round(anzahl_haushalt*2/3);    % 66% Haushalte haben das TOU Programm teilgenommen
ps_active(randperm(anzahl_haushalt,n))=1;

%Direct Load Control (Haushalt Teilnahmen Durchdringung)
dlc_active= zeros(1, anzahl_haushalt);
n=round(anzahl_haushalt*str2num(handles.struct_sgd.dlc_durchdringung)/100);
dlc_active(randperm(anzahl_haushalt,n))=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           1-Person Haushalt                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:str2num(handles.anzahl_HH_1)
    
    jahresverlauf            = zeros(1, 96);
    jahresverlauf_ps         = zeros(1, 96);
    jahresverlauf_dlc        = zeros(1, 96);
    
    jahresverlauf_ohnePV     = zeros(1, 96);
    jahresverlauf_ohnePV_ps  = zeros(1, 96);
    jahresverlauf_ohnePV_dlc = zeros(1, 96);
    
    jahresverlauf_blind      = zeros(1, 96);
    jahresverlauf_ps_blind   = zeros(1, 96);
    jahresverlauf_dlc_blind  = zeros(1, 96);
    
    jahresverlauf_solar      = [];
    jahresverlauf_cosphi     = [];
    jahresverlauf_Q          = [];
    
    % definieren der Zustand einer Haushalt
    % Anzahl der Einwohner
    handles.anzahl_HH = 1;

    % Energie sparen und optimieren
    index=randi([1,100]);
    if isfield(handles, 'struct_eff') && handles.struct_eff.active==1 && index<=handles.struct_eff.durchdringung
        handles.spar_active=1;
    else
        handles.spar_active=0;
    end
    
    % TOU Project
    handles.ps_active = ps_active(i);
    
    % Direct Load Control Project
    handles.dlc_active = dlc_active(i);
   
    % ber?cksichtigen die Ausstattungsgrad
    handles = Jahres_Ausstattung_PV(handles, 1, i);
    
    % initialisieren
    handles.ausstattung.waschmaschine=handles.ausstattung.waschmaschine_gesamt(i);
    handles.ausstattung.waeschetrockner=handles.ausstattung.waeschetrockner_gesamt(i);
    handles.ausstattung.geschirr=handles.ausstattung.geschirr_gesamt(i);
    
    if handles.ausstattung.warmwasserbereitstellung(i)==1
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=1;
    elseif handles.ausstattung.warmwasserbereitstellung(i)==2
        handles.ausstattung.warmwasserspeicher=1;
        handles.ausstattung.warmwasser=0;
    else
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=0;
    end
    
    if handles.ausstattung.elektroheizung(i)==1
        handles.ausstattung.heizung=1;
        handles.ausstattung.heatingpump=0; 
    elseif handles.ausstattung.elektroheizung(i)==2
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=1; 
    else
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=0; 
    end
    
    %Benutzungsverteilung von Waschmaschine, Geschirrsp?ler und W?schetrockner
    jahres_benutzung=Jahres_Benutzungsfrequenz(handles, 1); % Jahres_Benutzungsfrequenz - Benutzungsverteilung von Waschmaschine, Geschirrsp?ler und W?schetrockner
    
    for tag=1:365
        if tag>105 && tag<281
            handles.season_type='Sommer';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.sommer_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_werktag_cost_3_max;
            end                
        else
            handles.season_type='Winter';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.winter_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_werktag_cost_3_max;
            end             
        end
        
        if tag>143 && tag<250
            handles.heizperiode='Nein';
            
        else
            handles.heizperiode='Ja';
        end
        
        handles.struct_sgd.solar_day = tag;
        
        % ber?cksichtigen die Benutzungsm?glichkeit an einem Tag
        handles.benutzung.waschmaschine = jahres_benutzung.waschmaschine(tag);
        handles.benutzung.waeschetrockner = jahres_benutzung.waeschetrockner(tag);
        handles.benutzung.geschirr = jahres_benutzung.geschirr(tag);
        
        %% normal Lastgang 
        handles.initiative = 'no';
        [lastgang, lastgang_ohnePV, handles] = Jahresberechnen(handles, tag);
        lastgang_normal = lastgang;
        if handles.struct_sgd.active_rtp==1
            lastgang_rtp = [lastgang_rtp lastgang_normal];
        end
        jahresverlauf        = [jahresverlauf(1:(tag-1)*96) jahresverlauf(((tag-1)*96+1):(tag*96))+lastgang.heute];
        jahresverlauf        = [jahresverlauf lastgang.morgen];
        jahresverlauf_blind  = [jahresverlauf_blind(1:(tag-1)*96) jahresverlauf_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
        jahresverlauf_blind  = [jahresverlauf_blind lastgang.morgen_blind];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV(1:(tag-1)*96) jahresverlauf_ohnePV(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV lastgang.morgen];
        jahresverlauf_solar  = [jahresverlauf_solar lastgang.solar];
        jahresverlauf_Q      = [jahresverlauf_Q lastgang.solar_blind];
        jahresverlauf_cosphi = [jahresverlauf_cosphi lastgang.cosphi];
        
        

        %% lastgang nach Preis Signal
        if handles.struct_sgd.active_ps==1
            handles.initiative = 'Price-Signals';
            
            [lastgang, lastgang_ohnePV] = PS_Jahresberechnen(handles, lastgang_normal);
            
            jahresverlauf_ps        = [jahresverlauf_ps(1:(tag-1)*96) jahresverlauf_ps(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_ps        = [jahresverlauf_ps lastgang.morgen];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind(1:(tag-1)*96) jahresverlauf_ps_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps(1:(tag-1)*96) jahresverlauf_ohnePV_ps(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps lastgang.morgen];
        end
        
        %% Lastgang nach Direct Load Control
        if handles.struct_sgd.active_dlc==1 
            handles.initiative = 'Load-Control';
            
            [lastgang, lastgang_ohnePV] = DLC_Jahresberechnen(handles, struct_rar.jahresverlauf_dlc(((tag-1)*96+1):(tag*96)), lastgang_normal);
            
            jahresverlauf_dlc        = [jahresverlauf_dlc(1:(tag-1)*96) jahresverlauf_dlc(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_dlc        = [jahresverlauf_dlc lastgang.morgen];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind(1:(tag-1)*96) jahresverlauf_dlc_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc(1:(tag-1)*96) jahresverlauf_ohnePV_dlc(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc lastgang.morgen];
        end         
             
    end
    
    if handles.struct_sgd.active_normal==1
        struct_rar.jahresverlauf       = jahresverlauf+struct_rar.jahresverlauf;
        struct_rar.jahresverlauf_blind = jahresverlauf_blind+struct_rar.jahresverlauf_blind;
        lastprofil_singal.normal       = [lastprofil_singal.normal, jahresverlauf_ohnePV(1:35040)'];    
        lastprofil_singal.normal_blind = [lastprofil_singal.normal_blind, (jahresverlauf_blind(1:35040)-jahresverlauf_Q)'];
        lastprofil_singal.solar        = [lastprofil_singal.solar, jahresverlauf_solar'];
        lastprofil_singal.cosphi       = [lastprofil_singal.cosphi, jahresverlauf_cosphi'];
    end
    
    if handles.struct_sgd.active_ps==1
        struct_rar.jahresverlauf_ps       = jahresverlauf_ps+struct_rar.jahresverlauf_ps;
        struct_rar.jahresverlauf_ps_blind = jahresverlauf_ps_blind+struct_rar.jahresverlauf_ps_blind;
        lastprofil_singal.ps              = [lastprofil_singal.ps jahresverlauf_ohnePV_ps(1:35040)'];
        lastprofil_singal.ps_blind        = [lastprofil_singal.ps_blind, (jahresverlauf_ps_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    if handles.struct_sgd.active_dlc==1
        struct_rar.jahresverlauf_dlc       = jahresverlauf_dlc+struct_rar.jahresverlauf_dlc;
        struct_rar.jahresverlauf_dlc_blind = jahresverlauf_dlc_blind+struct_rar.jahresverlauf_dlc_blind;
        lastprofil_singal.dlc              = [lastprofil_singal.dlc jahresverlauf_ohnePV_dlc(1:35040)'];
        lastprofil_singal.dlc_blind        = [lastprofil_singal.dlc_blind (jahresverlauf_dlc_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    % waitbar Zeichnung
    waitbar(i/(str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)),...
    h,sprintf('%s %12.1f %s','Calculating...',100*i/(str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)), '%'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          2_3-Personen Haushalt                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:str2num(handles.anzahl_HH_2_3)
    
    jahresverlauf            = zeros(1, 96);
    jahresverlauf_ps         = zeros(1, 96);
    jahresverlauf_dlc        = zeros(1, 96);
    
    jahresverlauf_ohnePV     = zeros(1, 96);
    jahresverlauf_ohnePV_ps  = zeros(1, 96);
    jahresverlauf_ohnePV_dlc = zeros(1, 96);
    
    jahresverlauf_blind      = zeros(1, 96);
    jahresverlauf_ps_blind   = zeros(1, 96);
    jahresverlauf_dlc_blind  = zeros(1, 96);
    
    jahresverlauf_solar      = [];
    jahresverlauf_cosphi     = [];
    jahresverlauf_Q          = [];
    
    % definieren der Zustand einer Haushalt
    % Anzahl der Einwohner
    handles.anzahl_HH=2;
    
    % Energie sparen und optimieren
    index=randi([1,100]);
    if isfield(handles, 'struct_eff') && handles.struct_eff.active==1 && index<=handles.struct_eff.durchdringung
        handles.spar_active=1;
    else
        handles.spar_active=0;
    end
    
    % TOU Project
    handles.ps_active=ps_active(i+str2num(handles.anzahl_HH_1));   
    
    % Direct Load Control Project
    handles.dlc_active=dlc_active(i+str2num(handles.anzahl_HH_1));
        
    % ber?cksichtigen die Ausstattungsgrad
    handles = Jahres_Ausstattung_PV(handles, 2, i);
    
    % initialisieren
    handles.ausstattung.waschmaschine=handles.ausstattung.waschmaschine_gesamt(i+str2num(handles.anzahl_HH_1));
    handles.ausstattung.waeschetrockner=handles.ausstattung.waeschetrockner_gesamt(i+str2num(handles.anzahl_HH_1));
    handles.ausstattung.geschirr=handles.ausstattung.geschirr_gesamt(i+str2num(handles.anzahl_HH_1));
   
    if handles.ausstattung.warmwasserbereitstellung(i+str2num(handles.anzahl_HH_1))==1
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=1;
    elseif handles.ausstattung.warmwasserbereitstellung(i+str2num(handles.anzahl_HH_1))==2
        handles.ausstattung.warmwasserspeicher=1;
        handles.ausstattung.warmwasser=0;
    else
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=0;
    end
    if handles.ausstattung.elektroheizung(i+str2num(handles.anzahl_HH_1))==1
        handles.ausstattung.heizung=1;
        handles.ausstattung.heatingpump=0; 
    elseif handles.ausstattung.elektroheizung(i+str2num(handles.anzahl_HH_1))==2
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=1; 
    else
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=0; 
    end
    
    %Benutzungsverteilung von Waschmaschine, Geschirrsp?ler und W?schetrockner
    jahres_benutzung=Jahres_Benutzungsfrequenz(handles, 2);    
    for tag=1:365
        if tag>105 && tag<281
            handles.season_type='Sommer';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.sommer_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_werktag_cost_3_max;
            end                
        else
            handles.season_type='Winter';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.winter_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_werktag_cost_3_max;
            end             
        end
        
        if tag>143 && tag<250
            handles.heizperiode='Nein';
            
        else
            handles.heizperiode='Ja';
        end
        
        handles.struct_sgd.solar_day=tag;
        
        % ber?cksichtigen die Benutzungsm?glichkeit an einem Tag
        handles.benutzung.waschmaschine = jahres_benutzung.waschmaschine(tag);
        handles.benutzung.waeschetrockner = jahres_benutzung.waeschetrockner(tag);
        handles.benutzung.geschirr = jahres_benutzung.geschirr(tag);
        
        %% normal Lastgang 
        handles.initiative = 'no';
        [lastgang, lastgang_ohnePV, handles] = Jahresberechnen(handles, tag);
        lastgang_normal = lastgang;
        if handles.struct_sgd.active_rtp==1
            lastgang_rtp = [lastgang_rtp lastgang_normal];
        end
        jahresverlauf        = [jahresverlauf(1:(tag-1)*96) jahresverlauf(((tag-1)*96+1):(tag*96))+lastgang.heute];
        jahresverlauf        = [jahresverlauf lastgang.morgen];
        jahresverlauf_blind  = [jahresverlauf_blind(1:(tag-1)*96) jahresverlauf_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
        jahresverlauf_blind  = [jahresverlauf_blind lastgang.morgen_blind];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV(1:(tag-1)*96) jahresverlauf_ohnePV(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV lastgang.morgen];
        jahresverlauf_solar  = [jahresverlauf_solar lastgang.solar];
        jahresverlauf_Q      = [jahresverlauf_Q lastgang.solar_blind];
        jahresverlauf_cosphi = [jahresverlauf_cosphi lastgang.cosphi];

        %% lastgang nach Preis Signal
        if handles.struct_sgd.active_ps==1
            handles.initiative = 'Price-Signals';
            
            [lastgang, lastgang_ohnePV] = PS_Jahresberechnen(handles, lastgang_normal);
            
            jahresverlauf_ps        = [jahresverlauf_ps(1:(tag-1)*96) jahresverlauf_ps(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_ps        = [jahresverlauf_ps lastgang.morgen];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind(1:(tag-1)*96) jahresverlauf_ps_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps(1:(tag-1)*96) jahresverlauf_ohnePV_ps(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps lastgang.morgen];
        end
        
        %% Lastgang nach Direct Load Control
        if handles.struct_sgd.active_dlc==1 
            handles.initiative = 'Load-Control';
            
            [lastgang, lastgang_ohnePV] = DLC_Jahresberechnen(handles, struct_rar.jahresverlauf_dlc(((tag-1)*96+1):(tag*96)), lastgang_normal);
            
            jahresverlauf_dlc        = [jahresverlauf_dlc(1:(tag-1)*96) jahresverlauf_dlc(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_dlc        = [jahresverlauf_dlc lastgang.morgen];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind(1:(tag-1)*96) jahresverlauf_dlc_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc(1:(tag-1)*96) jahresverlauf_ohnePV_dlc(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc lastgang.morgen];
        end
        %%end   
             
    end
    
    if handles.struct_sgd.active_normal==1
        struct_rar.jahresverlauf       = jahresverlauf+struct_rar.jahresverlauf;
        struct_rar.jahresverlauf_blind = jahresverlauf_blind+struct_rar.jahresverlauf_blind;
        lastprofil_singal.normal       = [lastprofil_singal.normal, jahresverlauf_ohnePV(1:35040)'];    
        lastprofil_singal.normal_blind = [lastprofil_singal.normal_blind, (jahresverlauf_blind(1:35040)-jahresverlauf_Q)'];
        lastprofil_singal.solar        = [lastprofil_singal.solar, jahresverlauf_solar'];
        lastprofil_singal.cosphi       = [lastprofil_singal.cosphi, jahresverlauf_cosphi'];
    end
    
    if handles.struct_sgd.active_ps==1
        struct_rar.jahresverlauf_ps       = jahresverlauf_ps+struct_rar.jahresverlauf_ps;
        struct_rar.jahresverlauf_ps_blind = jahresverlauf_ps_blind+struct_rar.jahresverlauf_ps_blind;
        lastprofil_singal.ps              = [lastprofil_singal.ps jahresverlauf_ohnePV_ps(1:35040)'];
        lastprofil_singal.ps_blind        = [lastprofil_singal.ps_blind, (jahresverlauf_ps_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    if handles.struct_sgd.active_dlc==1
        struct_rar.jahresverlauf_dlc       = jahresverlauf_dlc+struct_rar.jahresverlauf_dlc;
        struct_rar.jahresverlauf_dlc_blind = jahresverlauf_dlc_blind+struct_rar.jahresverlauf_dlc_blind;
        lastprofil_singal.dlc              = [lastprofil_singal.dlc jahresverlauf_ohnePV_dlc(1:35040)'];
        lastprofil_singal.dlc_blind        = [lastprofil_singal.dlc_blind (jahresverlauf_dlc_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    % waitbar HH_2-3 Zeichnung
    waitbar((i+str2num(handles.anzahl_HH_1))/(str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)),...
    h,sprintf('%s %12.1f %s','Calculating...',100*(i+str2num(handles.anzahl_HH_1))/...
    (str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)), '%'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          4_+-Personen Haushalt                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:str2num(handles.anzahl_HH_4)
    
    jahresverlauf            = zeros(1, 96);
    jahresverlauf_ps         = zeros(1, 96);
    jahresverlauf_dlc        = zeros(1, 96);
    
    jahresverlauf_ohnePV     = zeros(1, 96);
    jahresverlauf_ohnePV_ps  = zeros(1, 96);
    jahresverlauf_ohnePV_dlc = zeros(1, 96);
    
    jahresverlauf_blind      = zeros(1, 96);
    jahresverlauf_ps_blind   = zeros(1, 96);
    jahresverlauf_dlc_blind  = zeros(1, 96);
    
    jahresverlauf_solar      = [];
    jahresverlauf_cosphi     = [];
    jahresverlauf_Q          = [];
    
    % definieren der Zustand einer Haushalt
    % Anzahl der Einwohner
    handles.anzahl_HH=3;
    
    % Energie sparen und optimieren
    index=randi([1,100]);
    if isfield(handles, 'struct_eff') && handles.struct_eff.active==1 && index<=handles.struct_eff.durchdringung
        handles.spar_active=1;
    else
        handles.spar_active=0;
    end    
    
    % TOU Project
    handles.ps_active = ps_active(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3));    
    
    % Direct Load Control Project
    handles.dlc_active = dlc_active(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3));
    
    % ber?cksichtigen die Ausstattungsgrad
    handles = Jahres_Ausstattung_PV(handles, 3, i);
    % initialisieren
    handles.ausstattung.waschmaschine = handles.ausstattung.waschmaschine_gesamt(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3));
    handles.ausstattung.waeschetrockner = handles.ausstattung.waeschetrockner_gesamt(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3));
    handles.ausstattung.geschirr = handles.ausstattung.geschirr_gesamt(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3));
    
    if handles.ausstattung.warmwasserbereitstellung(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))==1
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=1;
    elseif handles.ausstattung.warmwasserbereitstellung(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))==2
        handles.ausstattung.warmwasserspeicher=1;
        handles.ausstattung.warmwasser=0;
    else
        handles.ausstattung.warmwasserspeicher=0;
        handles.ausstattung.warmwasser=0;
    end
    if handles.ausstattung.elektroheizung(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))==1
        handles.ausstattung.heizung=1;
        handles.ausstattung.heatingpump=0; 
    elseif handles.ausstattung.elektroheizung(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))==2
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=1; 
    else
        handles.ausstattung.heizung=0;
        handles.ausstattung.heatingpump=0; 
    end
    
    %Benutzungsverteilung von Waschmaschine, Geschirrsp?ler und W?schetrockner
    jahres_benutzung=Jahres_Benutzungsfrequenz(handles, 3);
    
    for tag=1:365
        if tag>105 && tag<281
            handles.season_type='Sommer';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.sommer_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.sommer_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.sommer_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.sommer_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.sommer_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.sommer_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.sommer_werktag_cost_3_max;
            end                
        else
            handles.season_type='Winter';
            if mod(tag, 7)==5
                handles.day_type='Samstag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            elseif mod(tag, 7)==6
                handles.day_type='Sonntag und Feiertag';
                handles.cost_1_min=handles.struct_sgd.winter_wochenende_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_wochenende_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_wochenende_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_wochenende_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_wochenende_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_wochenende_cost_3_max;
            else
                handles.day_type='Werktag';
                handles.cost_1_min=handles.struct_sgd.winter_werktag_cost_1_min;         
                handles.cost_1_max=handles.struct_sgd.winter_werktag_cost_1_max;
                handles.cost_2_min=handles.struct_sgd.winter_werktag_cost_2_min;
                handles.cost_2_max=handles.struct_sgd.winter_werktag_cost_2_max;
                handles.cost_3_min=handles.struct_sgd.winter_werktag_cost_3_min;
                handles.cost_3_max=handles.struct_sgd.winter_werktag_cost_3_max;
            end             
        end
        
        if tag>143 && tag<250
            handles.heizperiode='Nein';
            
        else
            handles.heizperiode='Ja';
        end
        
        handles.struct_sgd.solar_day=tag;
        
        % ber?cksichtigen die Benutzungsm?glichkeit an einem Tag
        handles.benutzung.waschmaschine = jahres_benutzung.waschmaschine(tag);
        handles.benutzung.waeschetrockner = jahres_benutzung.waeschetrockner(tag);
        handles.benutzung.geschirr = jahres_benutzung.geschirr(tag);
        
        %% normal Lastgang 
        handles.initiative = 'no';
        [lastgang, lastgang_ohnePV, handles] = Jahresberechnen(handles, tag);
        lastgang_normal = lastgang;
        if handles.struct_sgd.active_rtp==1
            lastgang_rtp=[lastgang_rtp lastgang_normal];
        end
        jahresverlauf        = [jahresverlauf(1:(tag-1)*96) jahresverlauf(((tag-1)*96+1):(tag*96))+lastgang.heute];
        jahresverlauf        = [jahresverlauf lastgang.morgen];
        jahresverlauf_blind  = [jahresverlauf_blind(1:(tag-1)*96) jahresverlauf_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
        jahresverlauf_blind  = [jahresverlauf_blind lastgang.morgen_blind];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV(1:(tag-1)*96) jahresverlauf_ohnePV(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
        jahresverlauf_ohnePV = [jahresverlauf_ohnePV lastgang.morgen];
        jahresverlauf_solar  = [jahresverlauf_solar lastgang.solar];
        jahresverlauf_Q      = [jahresverlauf_Q lastgang.solar_blind];
        jahresverlauf_cosphi = [jahresverlauf_cosphi lastgang.cosphi];

        %% lastgang nach Preis Signal
        if handles.struct_sgd.active_ps==1
            handles.initiative = 'Price-Signals';
            
            [lastgang, lastgang_ohnePV] = PS_Jahresberechnen(handles, lastgang_normal);
            
            jahresverlauf_ps        = [jahresverlauf_ps(1:(tag-1)*96) jahresverlauf_ps(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_ps        = [jahresverlauf_ps lastgang.morgen];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind(1:(tag-1)*96) jahresverlauf_ps_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_ps_blind  = [jahresverlauf_ps_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps(1:(tag-1)*96) jahresverlauf_ohnePV_ps(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_ps = [jahresverlauf_ohnePV_ps lastgang.morgen];
        end
        
        %% Lastgang nach Direct Load Control
        if handles.struct_sgd.active_dlc==1 
            handles.initiative = 'Load-Control';
            
            [lastgang, lastgang_ohnePV] = DLC_Jahresberechnen(handles, struct_rar.jahresverlauf_dlc(((tag-1)*96+1):(tag*96)), lastgang_normal);
            
            jahresverlauf_dlc        = [jahresverlauf_dlc(1:(tag-1)*96) jahresverlauf_dlc(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_dlc        = [jahresverlauf_dlc lastgang.morgen];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind(1:(tag-1)*96) jahresverlauf_dlc_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_dlc_blind  = [jahresverlauf_dlc_blind lastgang.morgen_blind];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc(1:(tag-1)*96) jahresverlauf_ohnePV_dlc(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_dlc = [jahresverlauf_ohnePV_dlc lastgang.morgen];
        end
        %%end     
    end
      
    if handles.struct_sgd.active_normal==1
        struct_rar.jahresverlauf       = jahresverlauf+struct_rar.jahresverlauf;
        struct_rar.jahresverlauf_blind = jahresverlauf_blind+struct_rar.jahresverlauf_blind;
        lastprofil_singal.normal       = [lastprofil_singal.normal, jahresverlauf_ohnePV(1:35040)'];    
        lastprofil_singal.normal_blind = [lastprofil_singal.normal_blind, (jahresverlauf_blind(1:35040)-jahresverlauf_Q)'];
        lastprofil_singal.solar        = [lastprofil_singal.solar, jahresverlauf_solar'];
        lastprofil_singal.cosphi       = [lastprofil_singal.cosphi, jahresverlauf_cosphi'];
    end
    
    if handles.struct_sgd.active_ps==1
        struct_rar.jahresverlauf_ps       = jahresverlauf_ps+struct_rar.jahresverlauf_ps;
        struct_rar.jahresverlauf_ps_blind = jahresverlauf_ps_blind+struct_rar.jahresverlauf_ps_blind;
        lastprofil_singal.ps              = [lastprofil_singal.ps jahresverlauf_ohnePV_ps(1:35040)'];
        lastprofil_singal.ps_blind        = [lastprofil_singal.ps_blind, (jahresverlauf_ps_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    if handles.struct_sgd.active_dlc==1
        struct_rar.jahresverlauf_dlc       = jahresverlauf_dlc+struct_rar.jahresverlauf_dlc;
        struct_rar.jahresverlauf_dlc_blind = jahresverlauf_dlc_blind+struct_rar.jahresverlauf_dlc_blind;
        lastprofil_singal.dlc              = [lastprofil_singal.dlc jahresverlauf_ohnePV_dlc(1:35040)'];
        lastprofil_singal.dlc_blind        = [lastprofil_singal.dlc_blind (jahresverlauf_dlc_blind(1:35040)-jahresverlauf_Q)'];
    end
    
    % waitbar Zeichnung
    waitbar((i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))/(str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)),...
    h,sprintf('%s %12.1f %s','Calculating...',100*(i+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3))/...
    (str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)), '%'));
end

% waitbar
delete(h);

%% RTP

if handles.struct_sgd.active_rtp==1
    %waitbar
    h = waitbar(0,'Please wait...');
    Jahres_Preisstruktur=[];
    
    for i=1:365
        Preisstruktur = RTP_Struktur(struct_rar.jahresverlauf(((i-1)*96+1):(i*96)));
        Jahres_Preisstruktur = [Jahres_Preisstruktur; Preisstruktur];
    end
    
    for i=1:str2num(handles.anzahl_HH_4)+str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)   
        jahresverlauf_rtp        = zeros(1, 96);
        jahresverlauf_rtp_blind  = zeros(1, 96);
        jahresverlauf_ohnePV_rtp = zeros(1, 96);
        
        for tag=1:365         
            %%Lastgang von RTP
            lastgang_normal = lastgang_rtp(tag+(i-1)*365);
            
            [lastgang, lastgang_ohnePV] = RTP_Jahresberechnen(handles, Jahres_Preisstruktur(tag,:), lastgang_normal);
            
            jahresverlauf_rtp        = [jahresverlauf_rtp(1:(tag-1)*96) jahresverlauf_rtp(((tag-1)*96+1):(tag*96))+lastgang.heute];
            jahresverlauf_rtp        = [jahresverlauf_rtp lastgang.morgen];
            jahresverlauf_rtp_blind  = [jahresverlauf_rtp_blind(1:(tag-1)*96) jahresverlauf_rtp_blind(((tag-1)*96+1):(tag*96))+lastgang.heute_blind];
            jahresverlauf_rtp_blind  = [jahresverlauf_rtp_blind lastgang.morgen_blind];           
            jahresverlauf_ohnePV_rtp = [jahresverlauf_ohnePV_rtp(1:(tag-1)*96) jahresverlauf_ohnePV_rtp(((tag-1)*96+1):(tag*96))+lastgang_ohnePV.heute];
            jahresverlauf_ohnePV_rtp = [jahresverlauf_ohnePV_rtp lastgang.morgen];
                
        end
          
        struct_rar.jahresverlauf_rtp       = jahresverlauf_rtp+struct_rar.jahresverlauf_rtp;
        struct_rar.jahresverlauf_rtp_blind = jahresverlauf_rtp_blind+struct_rar.jahresverlauf_rtp_blind;
        lastprofil_singal.rtp              = [lastprofil_singal.rtp jahresverlauf_ohnePV_rtp(1:35040)'];
        lastprofil_singal.rtp_blind        = [lastprofil_singal.rtp_blind (jahresverlauf_rtp_blind(1:35040)-jahresverlauf_Q)'];
        
        % waitbar
        waitbar(i/(str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)),...
            h,sprintf('%s %12.1f %s','Calculating Real-Time-Pricing...',100*i/...
            (str2num(handles.anzahl_HH_1)+str2num(handles.anzahl_HH_2_3)+str2num(handles.anzahl_HH_4)), '%'));
    end
    
    % waitbar
    delete(h);
end
%% End of RTP

%% ber?cksichtigen Sommerzeit und Winterzeit nur f?r Jahrgang 2013
if handles.struct_sgd.active_normal==1
    lastprofil_singal.normal=[lastprofil_singal.normal(1:28712, :); lastprofil_singal.normal(28709:35040, :)];
    lastprofil_singal.normal_blind=[lastprofil_singal.normal_blind(1:28712, :); lastprofil_singal.normal_blind(28709:35040, :)];
    lastprofil_singal.normal(8553:8556, :)=[];
    lastprofil_singal.normal_blind(8553:8556, :)=[];  
end

if handles.struct_sgd.active_ps==1
    lastprofil_singal.ps=[lastprofil_singal.ps(1:28712, :); lastprofil_singal.ps(28709:35040, :)];
    lastprofil_singal.ps_blind=[lastprofil_singal.ps_blind(1:28712, :); lastprofil_singal.ps_blind(28709:35040, :)];
    lastprofil_singal.ps(8553:8556, :)=[];
    lastprofil_singal.ps_blind(8553:8556, :)=[];
end

if handles.struct_sgd.active_dlc==1
    lastprofil_singal.dlc=[lastprofil_singal.dlc(1:28712, :); lastprofil_singal.dlc(28709:35040, :)];
    lastprofil_singal.dlc_blind=[lastprofil_singal.dlc_blind(1:28712, :); lastprofil_singal.dlc_blind(28709:35040, :)];
    lastprofil_singal.dlc(8553:8556, :)=[];
    lastprofil_singal.dlc_blind(8553:8556, :)=[];
end

if handles.struct_sgd.active_rtp==1
    lastprofil_singal.rtp=[lastprofil_singal.rtp(1:28712, :); lastprofil_singal.rtp(28709:35040, :)];
    lastprofil_singal.rtp_blind=[lastprofil_singal.rtp_blind(1:28712, :); lastprofil_singal.rtp_blind(28709:35040, :)];
    lastprofil_singal.rtp(8553:8556, :)=[];
    lastprofil_singal.rtp_blind(8553:8556, :)=[];
end

%% write the result

% Random allocation sequence
reihfolge=randperm(size(lastprofil_singal.normal,2));

if handles.struct_sgd.active_normal==1
    lastprofil_singal.normal=lastprofil_singal.normal(:,reihfolge);
    lastprofil_singal.solar=lastprofil_singal.solar(:,reihfolge);
    lastprofil_singal.normal_blind=lastprofil_singal.normal_blind(:,reihfolge);
    lastprofil_singal.cosphi=lastprofil_singal.cosphi(:,reihfolge);
    initiative.cb_normal=1;
    initiative.cb_ps=0;
    initiative.cb_dlc=0;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(struct_rar.jahresverlauf(1:35040), initiative, lastprofil_singal.normal, lastprofil_singal.normal_blind);
    initiative.cb_normal=0;
    initiative.solar=1;
    resultschematic(struct_rar.jahresverlauf(1:35040), initiative, lastprofil_singal.solar, lastprofil_singal.cosphi);
end

if handles.struct_sgd.active_ps==1
    lastprofil_singal.ps=lastprofil_singal.ps(:,reihfolge);
    lastprofil_singal.ps_blind=lastprofil_singal.ps_blind(:,reihfolge);
    initiative.cb_normal=0;
    initiative.cb_ps=1;
    initiative.cb_dlc=0;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(struct_rar.jahresverlauf_ps(1:35040), initiative, lastprofil_singal.ps, lastprofil_singal.ps_blind);
end

if handles.struct_sgd.active_dlc==1
    lastprofil_singal.dlc=lastprofil_singal.dlc(:,reihfolge);
    lastprofil_singal.dlc_blind=lastprofil_singal.dlc_blind(:,reihfolge);
    initiative.cb_normal=0;
    initiative.cb_ps=0;
    initiative.cb_dlc=1;
    initiative.cb_rtp=0;
    initiative.solar=0;
    resultschematic(struct_rar.jahresverlauf_dlc(1:35040), initiative, lastprofil_singal.dlc, lastprofil_singal.dlc_blind);
end

if handles.struct_sgd.active_rtp==1
    lastprofil_singal.rtp=lastprofil_singal.rtp(:,reihfolge);
    lastprofil_singal.rtp_blind=lastprofil_singal.rtp_blind(:,reihfolge);
    initiative.cb_normal=0;
    initiative.cb_ps=0;
    initiative.cb_dlc=0;
    initiative.cb_rtp=1;
    initiative.solar=0;
    resultschematic(struct_rar.jahresverlauf_rtp(1:35040), initiative, lastprofil_singal.rtp, lastprofil_singal.rtp_blind);
end

% save variable for later use
% if ~isdir('output\')
%     mkdir('output\');
% end
save lastprofil_singal lastprofil_singal 

end

