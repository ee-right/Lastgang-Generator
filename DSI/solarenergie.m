%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% solarenergie %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm berechnet die Einspeisung einer PV-Anlage in Abhängigkeit von
% von der Dachneigung, Modulfläche usw. Bitte sehe Gl.5.19 bis Gl.5.33.
function [P, cosphi, Q] = solarenergie(handles, tag)
%SOLARENERGIE Summary of this function goes here
%   Detailed explanation goes here
% Dachdaten
%Photovoltaikanlage

if handles.ausstattung.solar==0       % wenn es keine PV-Anlage gibt
    P=zeros(1,96);
    cosphi=ones(1,96);
    Q=zeros(1,96);
else       % Einlesen der manuell eingegebenen Werte
    solar_orient=str2num(handles.struct_sgd.solar_orient);
    solar_neigung=str2num(handles.struct_sgd.solar_neigung);
    solar_size=str2num(handles.struct_sgd.solar_size);
    Wirkungsgrad_Zelle=0.17; % Wirkungsgrad der (PV-Zelle Kristallines Si)
    Wirkungsgrad_Temp=0.912; % Wirkungsgrad der Temperatur (Temperatur Differenz 20 K und Kristallines Si)
    Wirkungsgrad_Schmutzung=0.95; % Wirkungsgrad der Verschmutzung
    PR=Wirkungsgrad_Zelle*Wirkungsgrad_Temp*Wirkungsgrad_Schmutzung;
    albedo=0.2; % Der Reflexionsgrad des Untergrundes Albedo = 0.2
    
    %Strahlungsangebot
    G_bt=(handles.solar_G_bh(tag, : ).*(sin(handles.solar_Gamma_s(tag, :))*cos(pi*solar_neigung/180)...
        -cos(handles.solar_Gamma_s(tag, :)).*(cos(pi*(handles.solar_alpha_s(tag, :)-solar_orient)/180))*sin(pi*solar_neigung/180)))...
        ./sin(handles.solar_Gamma_s(tag, :));
    G_dt=handles.solar_G_dh(tag, : )*(1+cos(solar_neigung))/2+(handles.solar_G_dh(tag, : )+handles.solar_G_bh(tag, : ))* albedo*(1-cos(solar_neigung))/2;
    G_dt(G_dt<=0)=0;
    G_bt(G_bt<=0)=0;
    G_t=G_dt+G_bt;
    
    P_dc_ein=G_t*solar_size*PR; % Gesamt Einspeisungsleistung (DC)
    
    grenze=139*solar_size*0.89/0.955; % installierte Leistung des Wechselrichters (DC)
    % 139 w/m2 (p-Si PV-Model Modelleistungsdichte)
    
    % Wirkungsgrad des Wechselrichters
    P_ac(P_dc_ein<=0.1*grenze & P_dc_ein>=0)=P_dc_ein(P_dc_ein<=0.1*grenze & P_dc_ein>=0).*(0.77+1.4*P_dc_ein(P_dc_ein<=0.1*grenze & P_dc_ein>=0)/grenze);
    P_ac(P_dc_ein<=0.2*grenze & P_dc_ein>0.1*grenze)=P_dc_ein(P_dc_ein<=0.2*grenze & P_dc_ein>0.1*grenze).*(0.88+0.3*P_dc_ein(P_dc_ein<=0.2*grenze & P_dc_ein>0.1*grenze)/grenze);
    P_ac(P_dc_ein<=0.35*grenze & P_dc_ein>0.2*grenze)=P_dc_ein(P_dc_ein<=0.35*grenze & P_dc_ein>0.2*grenze).*(0.92+0.1*P_dc_ein(P_dc_ein<=0.35*grenze & P_dc_ein>0.2*grenze)/grenze);
    P_ac(P_dc_ein<=grenze & P_dc_ein>0.35*grenze)=P_dc_ein(P_dc_ein<=grenze & P_dc_ein>0.35*grenze)*0.955;
    P_ac(P_dc_ein>grenze)=grenze*0.955;
    
    cosphi(P_ac<=0.5*grenze*0.955)=1;  % cosphi
    cosphi(P_ac>0.5*grenze*0.955)=(1-(P_ac(P_ac>0.5*grenze*0.955)/(grenze*0.955)-0.5)/10);
    P = P_ac; % Wirkleistung nach Wechselrichter (AC)
    Q = P_ac.*tan(acos(cosphi)); % induktiv (plus hausgeräte Blindleistung)
end

end

