%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     20.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Diverse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Restbedarf. Bitte sehe
%Seite 42 und 43.
% Aus den Nutzungen wird der Lastgang bestimmt. Die Nutzungen sind abhängig
% vom Werktag und Saison.
function lastgang = Diverse(handles, Anzahl)
%DIVERSE Summary of this function goes here
%   Detailed explanation goes here

% definieren die Zeitachse-systeme
zeitachse_24=0.5:23.5;
zeitachse_96=0.125:0.25:23.875;


% Bereich Diverse
% Eingabe der Nutzungen abhängig vom Werktag und Saison (siehe Arbeit S.43)
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.45 0.45 0.42 0.40 0.42 0.48 0.60 0.71 0.66 0.60 0.71 ...
        0.75 0.79 0.70 0.71 0.77 0.74 0.77 0.83 0.81 0.77 0.74 0.69 0.49];
    diverse_faktor=0.0804;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.60 0.45 0.39 0.31 0.41 0.40 0.40 0.41 0.58 0.58 0.82 ...
        0.90 0.92 0.89 0.89 0.80 0.82 0.90 1.02 1.00 0.95 0.90 0.90 0.76];
    diverse_faktor=0.0834;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.88 0.63 0.51 0.50 0.58 0.60 0.51 0.41 0.49 0.40 0.49 ...
        0.68 0.75 0.71 0.77 0.81 0.78 0.87 0.98 0.88 0.83 0.71 0.67 0.49];  
    diverse_faktor=0.0704;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.39 0.39 0.39 0.39 0.41 0.41 0.38 0.38 0.49 0.67 0.75 ...
        0.78 0.72 0.74 0.76 0.74 0.72 0.78 0.71 0.55 0.53 0.50 0.43 0.40];
    diverse_faktor=0.0626;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.42 0.30 0.31 0.26 0.30 0.35 0.30 0.23 0.40 0.62 0.71 ...
        0.75 0.70 0.72 0.76 0.71 0.70 0.86 0.80 0.63 0.69 0.61 0.55 0.53];
    diverse_faktor=0.0478;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    % normierte Nutzungsvektoren der Restbedarf
    diverse=[0.60 0.43 0.42 0.41 0.42 0.43 0.44 0.44 0.48 0.51 0.68 ...
        0.70 0.73 0.76 0.81 0.81 0.88 0.93 0.80 0.70 0.70 0.60 0.54 0.52]; 
    diverse_faktor=0.0384;
end

diverse=interp1(zeitachse_24, diverse, zeitachse_96, 'linear', 'extrap');

% Rückgabe des Lastgangs (133300 wh Verbrauchsmenge)
switch Anzahl
    case 1
        lastgang=14*diverse_faktor*4*diverse*133300/(365*sum(diverse));
    case 2
        lastgang=14*diverse_faktor*4*diverse*243550/(365*sum(diverse));
    case 3
        lastgang=14*diverse_faktor*4*diverse*384833/(365*sum(diverse));
end

end

