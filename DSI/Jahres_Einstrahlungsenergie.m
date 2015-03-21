%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     23.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Jahres_Einstralungsenergie %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm berechnet die Einstrahlungsintensität der Sonne in Abhängigkeit von
% von der Sonnenposition und der Wetterbedingung. Bitte sehe Gl.5.1 bis
% Gl.5.18.
function handles = Jahres_Einstrahlungsenergie(handles)
%JAHRES_EINSTRAHLUNGSENERGIE Summary of this function goes here
%   Detailed explanation goes here

% Einlesen der manuellen Eingaben
ort_breite=str2num(handles.struct_sgd.ort_breite);
ort_lange=str2num(handles.struct_sgd.ort_lange);

% Errechnet "Wetterbedingungen" aus Zufallszahlen, siehe "wetterbedingungen"
wetter_jahr=wetterbedingung();

for tag=1:365
    G_on=1376*(1+0.033*cos(2*pi*tag/180));   
    
    % Sonnenposition
    J=360*tag/365;
    sigma=0.3948-23.2559*cos(pi*(J+9.1)/180)-0.3915*cos(pi*(2*J+5.4)/180)-...
        0.1764*cos(pi*(3*J+105.2)/180);
    C=(0.0066+7.3525*cos(pi*(J+85.9)/180)+9.9359*cos(pi*(2*J+108.9)/180)+...
        0.3387*cos(pi*(3*J+105.2)/180))/60;
   
    MOZ=(0:0.25:23.75)-4*(15-ort_lange)/60;
    omega=(12-MOZ+C)*15;
    
    handles.solar_Gamma_s(tag, 1:96)=asin(cos(pi*omega/180)*cos(pi*ort_breite/180)*cos(pi*sigma/180)+sin(pi*ort_breite/180)*sin(pi*sigma/180));
    handles.solar_alpha_s(tag, MOZ<=12)=180-180/pi*acos((sin(handles.solar_Gamma_s(tag, MOZ<=12))*sin(pi*ort_breite/180)-...
        sin(pi*sigma/180))./(cos(handles.solar_Gamma_s(tag, MOZ<=12))*cos(pi*ort_breite/180)));
    handles.solar_alpha_s(tag, MOZ>12)=180+180/pi*acos((sin(handles.solar_Gamma_s(tag, MOZ>12))*sin(pi*ort_breite/180)-...
        sin(pi*sigma/180))./(cos(handles.solar_Gamma_s(tag, MOZ>12))*cos(pi*ort_breite/180)));
    
    G_oh=G_on.*sin(handles.solar_Gamma_s(tag, 1:96));
    G_oh(handles.solar_Gamma_s(tag, :)<=0)=0;
           
    % Air Mass in Abhängigkeit von Sonnenposition
    AM=1./(sin(handles.solar_Gamma_s(tag, :))+0.50572*((96.07995-90+180/pi*handles.solar_Gamma_s(tag, :)).^-1.6364));
        
    G_oh(AM>38)=0;
    
    %Himmelklarheit
    k_T=wetter_jahr(tag,:).*(1.1*0.7.^(AM.^0.678));
    
    %direkte Strahlung und diffuse Strahlung nach Himmelklarheit
    for t=1:96 
        G_h(t)=k_T(t)*G_oh(t);
        if wetter_jahr(tag, t)>=0 && wetter_jahr(tag, t)<=0.22           
            solar_G_bh(t)=0.09*wetter_jahr(tag, t)*G_h(t);
            solar_G_dh(t)=(1-0.09*wetter_jahr(tag, t))*G_h(t);
        elseif wetter_jahr(tag, t)>0.22 && wetter_jahr(tag, t)<=0.80
            solar_G_bh(t)=(0.0489+0.1604*wetter_jahr(tag, t)-4.388*((wetter_jahr(tag, t))^2)+16.638*((wetter_jahr(tag, t))^3)-12.336*((wetter_jahr(tag, t))^4))*G_h(t);
            solar_G_dh(t)=(0.9511-0.1604*wetter_jahr(tag, t)+4.388*((wetter_jahr(tag, t))^2)-16.638*((wetter_jahr(tag, t))^3)+12.336*((wetter_jahr(tag, t))^4))*G_h(t);
        else
            solar_G_bh(t)=0.835*G_h(t);
            solar_G_dh(t)=0.165*G_h(t);          
        end
    end   
    
    %Solarstrahlung
    handles.solar_G_bh(tag, : )=solar_G_bh;
    handles.solar_G_dh(tag, : )=solar_G_dh;

end

end