%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     13.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% haeufigkeitsverteilung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm berechnet die Häufigkeitsverteilung auf
%15-Minuten-Auflösung, die Eingaben sind die Häufigkeitsverteilung auf
%Ein-Stunde-Auflösung. 
function handles = haeufigkeitsverteilung(handles)
%HAEUFIGKEITSVERTEILUNG Summary of this function goes here
%   Detailed explanation goes here

% 26 Werte statt 24 Werte!!!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Waschmaschine                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
waschmaschine_winter_werktag=[0.002 0 0 0 0 0 0 0.01 0.036 0.077 0.128 0.123 0.092 0.092 0.072 0.062 0.056...
    0.051 0.041 0.041 0.046 0.031 0.029 0.01 0.002 0];
handles.waschmaschine_winter_werktag=bearbeitung_verteilung(waschmaschine_winter_werktag);
%Winter, Samstag
waschmaschine_winter_samstag=[0.004 0 0 0 0 0 0 0.01 0.025 0.049 0.088 0.128 0.128 0.088 0.079 0.079 0.074...
    0.049 0.044 0.044 0.044 0.039 0.020 0.01 0.004 0];
handles.waschmaschine_winter_samstag=bearbeitung_verteilung(waschmaschine_winter_samstag);
%Winter, Sonntag
waschmaschine_winter_sonntag=[0.012 0 0 0 0 0 0 0 0.007 0.018 0.059 0.117 0.117 0.103 0.088 0.081 0.066...
    0.051 0.059 0.073 0.066 0.044 0.022 0.018 0.012 0];
handles.waschmaschine_winter_sonntag=bearbeitung_verteilung(waschmaschine_winter_sonntag);
%Sommer, Werktag
waschmaschine_sommer_werktag=[0 0 0 0 0 0 0 0.012 0.058 0.081 0.092 0.104 0.087 0.081 0.058 0.052 0.058...
    0.058 0.069 0.035 0.069 0.064 0.0226 0.0002 0.0002 0]; % 23+24 Uhr 0 - 0.0002 / 22 Uhr 0.023 - 0.0226
handles.waschmaschine_sommer_werktag=bearbeitung_verteilung(waschmaschine_sommer_werktag);
%Sommer, Samstag
waschmaschine_sommer_samstag=[0.003 0 0 0 0 0 0 0.007 0.015 0.081 0.111 0.118 0.103 0.118 0.089 0.066 0.052...
    0.044 0.044 0.037 0.037 0.044 0.022 0.007 0.003 0];
handles.waschmaschine_sommer_samstag=bearbeitung_verteilung(waschmaschine_sommer_samstag);
%Sommer, Sonntag
waschmaschine_sommer_sonntag=[0.007 0 0 0 0 0 0 0.004 0.018 0.024 0.059 0.110 0.123 0.110 0.066 0.070 0.064...
    0.044 0.044 0.061 0.066 0.066 0.044 0.022 0.007 0];
handles.waschmaschine_sommer_sonntag=bearbeitung_verteilung(waschmaschine_sommer_sonntag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Wäschetrockner direkt nach Waschmaschine                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Geschirrspüler                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
geschirr_winter_werktag=[0.014 0.005 0.00292 0.00004 0.00004 0.00004 0.00004 0.00292 0.022 0.054 0.049 0.033 0.054 0.049 0.049...
    0.082 0.109 0.054 0.027 0.049 0.082 0.131 0.082 0.049 0.014 0.005]; % 3+4+5+6 Uhr 0 - 0.00004 / 2+7 Uhr 0.003 - 0.00292
handles.geschirr_winter_werktag=bearbeitung_verteilung(geschirr_winter_werktag);
%Winter, Samstag
geschirr_winter_samstag=[0.011 0.011 0.022 0.0215 0.0003 0.00035 0.00035 0.0215 0.022 0.033 0.056 0.089 0.089 0.078 0.078...
    0.112 0.096 0.045 0.067 0.033 0.022 0.033 0.033 0.022 0.011 0.011]; % 4 Uhr 0 - 0.0003 + 5+6 Uhr 0 - 0.00035 / 3+7 Uhr 0.022 - 0.0215
handles.geschirr_winter_samstag=bearbeitung_verteilung(geschirr_winter_samstag);
%Winter, Sonntag
geschirr_winter_sonntag=[0.009 0 0.005 0.018 0.009 0.004 0.004 0.015 0.005 0.005 0.036 0.091 0.091 0.109 0.054...
    0.154 0.091 0.073 0.054 0.045 0.036 0.045 0.027 0.018 0.009 0];
handles.geschirr_winter_sonntag=bearbeitung_verteilung(geschirr_winter_sonntag);
%Sommer, Werktag
geschirr_sommer_werktag=[0.004 0.00081 0.0015 0.0004 0.0004 0.0004 0.00049 0.0395 0.0355 0.040 0.020 0.068 0.032 0.040 0.080...
    0.120 0.080 0.060 0.040 0.060 0.120 0.100 0.040 0.020 0.004 0.0081]; % 3+4+5 Uhr 0 - 0.0004 + 6 Uhr 0 - 0.00049 / 1 Uhr 0.001 - 0.00081 + 2 Uhr 0.002 - 0.0015 + 7 Uhr 0.04 - 0.0395 + 8 Uhr 0.036 - 0.0355 
handles.geschirr_sommer_werktag=bearbeitung_verteilung(geschirr_sommer_werktag);
%Sommer, Samstag
geschirr_sommer_samstag=[0.010 0 0 0 0 0 0 0 0.005 0.015 0.053 0.102 0.097 0.049 0.097 0.146 0.087 0.049 0.049 0.039...
    0.049 0.063 0.058 0.034 0.010 0];
handles.geschirr_sommer_samstag=bearbeitung_verteilung(geschirr_sommer_samstag);
%Sommer, Sonntag
geschirr_sommer_sonntag=[0.019 0.0135 0.0002 0.0002 0.0002 0.0002 0.0002 0.0135 0.005 0.030 0.041 0.082 0.068 0.055 0.082...
    0.110 0.055 0.055 0.082 0.088 0.041 0.049 0.068 0.041 0.019 0.011]; % 2+3+4+5+6 Uhr 0 - 0.0002 / 1+7 Uhr 0.014 - 0.0135
handles.geschirr_sommer_sonntag=bearbeitung_verteilung(geschirr_sommer_sonntag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Kochen                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
kochen_winter_werktag=[0.007 0 0 0 0 0 0.007 0.032 0.035 0.035 0.039 0.046 0.123 0.168 0.105 0.035 0.028 0.042 0.063...
    0.095 0.070 0.035 0.021 0.014 0.007 0];
handles.kochen_winter_werktag=bearbeitung_verteilung(kochen_winter_werktag);
%Winter, Samstag
kochen_winter_samstag=[0.006 0 0 0 0 0 0.003 0.009 0.021 0.036 0.053 0.065 0.131 0.172 0.128 0.047 0.045 0.045 0.047...
    0.071 0.059 0.033 0.018 0.012 0.006 0];
handles.kochen_winter_samstag=bearbeitung_verteilung(kochen_winter_samstag);
%Winter, Sonntag
kochen_winter_sonntag=[0.001 0 0 0 0 0 0 0.002 0.011 0.040 0.086 0.120 0.211 0.208 0.086 0.029 0.023 0.023 0.034...
    0.051 0.046 0.020 0.006 0.003 0.001 0];
handles.kochen_winter_sonntag=bearbeitung_verteilung(kochen_winter_sonntag);
%Sommer, Werktag
kochen_sommer_werktag=[0.013 0 0 0.001 0.001 0.001 0.021 0.035 0.026 0.031 0.031 0.044 0.096 0.148 0.096 0.078 0.074...
    0.070 0.052 0.044 0.052 0.044 0.026 0.017 0.013 0];
handles.kochen_sommer_werktag=bearbeitung_verteilung(kochen_sommer_werktag);
%Sommer, Samstag
kochen_sommer_samstag=[0.005 0 0 0 0 0 0 0.007 0.030 0.052 0.067 0.078 0.137 0.160 0.093 0.052 0.045 0.037 0.045...
    0.059 0.059 0.037 0.022 0.015 0.005 0];
handles.kochen_sommer_samstag=bearbeitung_verteilung(kochen_sommer_samstag);
%Sommer, Sonntag
kochen_sommer_sonntag=[0.001 0 0 0 0 0 0 0.004 0.029 0.066 0.088 0.088 0.195 0.195 0.074 0.033 0.029 0.022 0.022...
    0.055 0.048 0.029 0.015 0.004 0.001 0];
handles.kochen_sommer_sonntag=bearbeitung_verteilung(kochen_sommer_sonntag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Kühlschrank keine häufigkeit immer benutzt              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Warmwasser                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Werktag
warmwasser_werktag=[0.02 0.01 0.004 0.002 0.002 0.004 0.076 0.16 0.11 0.06 0.02 0.013 0.013 0.03 0.052 0.03 0.025 0.03...
    0.055 0.08 0.08 0.06 0.042 0.022 0.02 0.01];
handles.warmwasser_werktag=bearbeitung_verteilung(warmwasser_werktag);
%Samstag
warmwasser_samstag=[0.018 0.01 0.007 0.003 0.005 0.003 0.01 0.025 0.045 0.075 0.075 0.07 0.072 0.073 0.06 0.05 0.04 0.05...
    0.062 0.085 0.07 0.04 0.03 0.032 0.018 0.01];
handles.warmwasser_samstag=bearbeitung_verteilung(warmwasser_samstag);
%Sonntag
warmwasser_sonntag=[0.018 0.01 0.007 0.002 0.002 0.002 0.004 0.02 0.04 0.062 0.082 0.08 0.095 0.08 0.07 0.06 0.05 0.035 0.055...
    0.062 0.072 0.04 0.03 0.032 0.018 0.01];
handles.warmwasser_sonntag=bearbeitung_verteilung(warmwasser_sonntag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Elektroheizung keine häufigkeit                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Kreiselpumpe keine häufigke                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Entertainment                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fernseher %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
fernseher_winter_werktag=[0.032 0.011 0.005 0.002 0.001 0.00001 0.00099 0.002 0.004 0.005 0.006 0.006 0.008 0.009 0.012 0.016... 
    0.023 0.034 0.047 0.083 0.152 0.221 0.206 0.113 0.032 0.011];    % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.fernseher_winter_werktag=bearbeitung_verteilung(fernseher_winter_werktag);
%Winter, Samstag
fernseher_winter_samstag=[0.056 0.01 0.005 0.002 0.0009 0.0001 0.0001 0.0009 0.001 0.003 0.004 0.006 0.007 0.008 0.013 0.02...
    0.032 0.04 0.055 0.089 0.132 0.193 0.191 0.131 0.056 0.01];       % 5+6 Uhr 0 - 0.0001 / 4+7 Uhr 0.001 - 0.0009
handles.fernseher_winter_samstag=bearbeitung_verteilung(fernseher_winter_samstag);
%Winter, Sonntag
fernseher_winter_sonntag=[0.028 0.020 0.009 0.004 0.0019 0.0001 0.0001 0.0009 0.002 0.002 0.006 0.01 0.013 0.017 0.02 0.029...
    0.038 0.048 0.058 0.079 0.123 0.2 0.191 0.099 0.028 0.02];        % 5+6 Uhr 0 - 0.0001 / 4 Uhr 0.002 - 0.0019 +7 Uhr 0.001 - 0.0009
handles.fernseher_winter_sonntag=bearbeitung_verteilung(fernseher_winter_sonntag);
%Sommer, Werktag
fernseher_sommer_werktag=[0.032 0.011 0.005 0.002 0.001 0.00001 0.00099 0.002 0.004 0.005 0.006 0.006 0.008 0.009 0.012 0.016... 
    0.023 0.034 0.047 0.083 0.152 0.221 0.206 0.113 0.032 0.011];   % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.fernseher_sommer_werktag=bearbeitung_verteilung(fernseher_sommer_werktag);
%Sommer, Samstag
fernseher_sommer_samstag=[0.056 0.01 0.005 0.002 0.0009 0.0001 0.0001 0.0009 0.001 0.003 0.004 0.006 0.007 0.008 0.013 0.02...
    0.032 0.04 0.055 0.089 0.132 0.193 0.191 0.131 0.056 0.01];       % 5+6 Uhr 0 - 0.0001 / 4+7 Uhr 0.001 - 0.0009
handles.fernseher_sommer_samstag=bearbeitung_verteilung(fernseher_sommer_samstag);
%Sommer, Sonntag
fernseher_sommer_sonntag=[0.028 0.020 0.009 0.004 0.0019 0.0001 0.0001 0.0009 0.002 0.002 0.006 0.01 0.013 0.017 0.02 0.029...
    0.038 0.048 0.058 0.079 0.123 0.2 0.191 0.099 0.028 0.02];        % 5+6 Uhr 0 - 0.0001 / 4 Uhr 0.002 - 0.0019 +7 Uhr 0.001 - 0.0009
handles.fernseher_sommer_sonntag=bearbeitung_verteilung(fernseher_sommer_sonntag);

% Musik Anlagen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
musik_winter_werktag=[0.012 0.007 0.006 0.005 0.005 0.004 0.009 0.047 0.076 0.094 0.093 0.073 0.071 0.071 0.056 0.049... 
    0.047 0.050 0.056 0.050 0.037 0.029 0.030 0.024 0.012 0.007];
handles.musik_winter_werktag=bearbeitung_verteilung(musik_winter_werktag);
%Winter, Samstag
musik_winter_samstag=[0.022 0.005 0.004 0.003 0.003 0.003 0.004 0.013 0.04 0.085 0.104 0.091 0.084 0.082 0.068 0.059...
    0.055 0.053 0.052 0.041 0.034 0.033 0.033 0.03 0.022 0.005];
handles.musik_winter_samstag=bearbeitung_verteilung(musik_winter_samstag);
%Winter, Sonntag
musik_winter_sonntag=[0.015 0.012 0.006 0.003 0.002 0.001 0.002 0.008 0.026 0.074 0.109 0.122 0.116 0.099 0.065 0.052...
    0.048 0.044 0.045 0.043 0.034 0.026 0.026 0.021 0.015 0.012];
handles.musik_winter_sonntag=bearbeitung_verteilung(musik_winter_sonntag);
%Sommer, Werktag
musik_sommer_werktag=[0.012 0.007 0.006 0.005 0.005 0.004 0.009 0.047 0.076 0.094 0.093 0.073 0.071 0.071 0.056 0.049... 
    0.047 0.050 0.056 0.050 0.037 0.029 0.030 0.024 0.012 0.007];
handles.musik_sommer_werktag=bearbeitung_verteilung(musik_sommer_werktag);
%Sommer, Samstag
musik_sommer_samstag=[0.022 0.005 0.004 0.003 0.003 0.003 0.004 0.013 0.04 0.085 0.104 0.091 0.084 0.082 0.068 0.059...
    0.055 0.053 0.052 0.041 0.034 0.033 0.033 0.03 0.022 0.005];
handles.musik_sommer_samstag=bearbeitung_verteilung(musik_sommer_samstag);
%Sommer, Sonntag
musik_sommer_sonntag=[0.015 0.012 0.006 0.003 0.002 0.001 0.002 0.008 0.026 0.074 0.109 0.122 0.116 0.099 0.065 0.052...
    0.048 0.044 0.045 0.043 0.034 0.026 0.026 0.021 0.015 0.012];
handles.musik_sommer_sonntag=bearbeitung_verteilung(musik_sommer_sonntag);

% Standby %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% in Entertainment Funktion


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Informatik                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
computer_winter_werktag=[0.017 0.006 0.003 0.002 0.001 0.001 0.002 0.01 0.024 0.043 0.056 0.052 0.056 0.042 0.047 0.05... 
    0.052 0.062 0.076 0.076 0.086 0.094 0.089 0.053 0.017 0.006];
handles.computer_winter_werktag=bearbeitung_verteilung(computer_winter_werktag);
%Winter, Samstag
computer_winter_samstag=[0.024 0.005 0.003 0.001 0.001 0.00001 0.00099 0.004 0.013 0.038 0.063 0.065 0.07 0.054 0.061 0.065...
    0.063 0.065 0.071 0.064 0.068 0.074 0.073 0.053 0.024 0.005];       % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.computer_winter_samstag=bearbeitung_verteilung(computer_winter_samstag);
%Winter, Sonntag
computer_winter_sonntag=[0.013 0.008 0.004 0.002 0.001 0.00001 0.00099 0.003 0.011 0.034 0.067 0.088 0.096 0.066 0.064 0.053...
    0.047 0.051 0.063 0.065 0.07 0.075 0.073 0.044 0.013 0.008];        % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.computer_winter_sonntag=bearbeitung_verteilung(computer_winter_sonntag);
%Sommer, Werktag
computer_sommer_werktag=[0.017 0.006 0.003 0.002 0.001 0.001 0.002 0.01 0.024 0.043 0.056 0.052 0.056 0.042 0.047 0.05... 
    0.052 0.062 0.076 0.076 0.086 0.094 0.089 0.053 0.017 0.006];
handles.computer_sommer_werktag=bearbeitung_verteilung(computer_sommer_werktag);
%Sommer, Samstag
computer_sommer_samstag=[0.024 0.005 0.003 0.001 0.001 0.00001 0.00099 0.004 0.013 0.038 0.063 0.065 0.07 0.054 0.061 0.065...
    0.063 0.065 0.071 0.064 0.068 0.074 0.073 0.053 0.024 0.005];       % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.computer_sommer_samstag=bearbeitung_verteilung(computer_sommer_samstag);
%Sommer, Sonntag
computer_sommer_sonntag=[0.013 0.008 0.004 0.002 0.001 0.00001 0.00099 0.003 0.011 0.034 0.067 0.088 0.096 0.066 0.064 0.053...
    0.047 0.051 0.063 0.065 0.07 0.075 0.073 0.044 0.013 0.008];        % 5 Uhr 0 - 0.00001 / 6 Uhr 0 - 0.00099
handles.computer_sommer_sonntag=bearbeitung_verteilung(computer_sommer_sonntag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Licht                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Winter, Werktag
licht_winter_werktag=[0.021 0.014 0.008 0.005 0.004 0.003 0.007 0.034 0.048 0.054 0.044 0.027 0.026 0.031 0.030 0.035 0.048...
    0.057 0.073 0.088 0.095 0.094 0.090 0.061 0.021 0.014];
handles.licht_winter_werktag=bearbeitung_verteilung(licht_winter_werktag);
%Winter, Samstag
licht_winter_samstag=[0.029 0.019 0.010 0.006 0.004 0.002 0.002 0.012 0.035 0.062 0.056 0.036 0.033 0.038 0.039 0.045 0.060...
    0.063 0.071 0.079 0.081 0.080 0.078 0.061 0.029 0.019];
handles.licht_winter_samstag=bearbeitung_verteilung(licht_winter_samstag);
%Winter, Sonntag
licht_winter_sonntag=[0.020 0.012 0.007 0.004 0.002 0.001 0.002 0.007 0.024 0.057 0.064 0.048 0.045 0.046 0.041 0.041 0.053...
    0.056 0.067 0.079 0.087 0.090 0.088 0.060 0.020 0.012];
handles.licht_winter_sonntag=bearbeitung_verteilung(licht_winter_sonntag);
%Sommer, Werktag
licht_sommer_werktag=[0.028 0.018 0.011 0.007 0.005 0.005 0.010 0.045 0.053 0.038 0.026 0.019 0.018 0.021 0.019 0.019 0.022...
    0.031 0.053 0.101 0.126 0.125 0.120 0.082 0.028 0.018];
handles.licht_sommer_werktag=bearbeitung_verteilung(licht_sommer_werktag);
%Sommer, Samstag
licht_sommer_samstag=[0.041 0.027 0.014 0.008 0.005 0.003 0.003 0.016 0.040 0.046 0.035 0.026 0.024 0.027 0.026 0.025 0.028...
    0.036 0.054 0.095 0.114 0.112 0.109 0.085 0.041 0.027 ];
handles.licht_sommer_samstag=bearbeitung_verteilung(licht_sommer_samstag);
%Sommer, Sonntag
licht_sommer_sonntag=[0.028 0.017 0.009 0.005 0.003 0.002 0.002 0.010 0.028 0.043 0.040 0.035 0.033 0.033 0.027 0.023 0.025...
    0.032 0.051 0.096 0.122 0.127 0.124 0.084 0.028 0.017]; 
handles.licht_sommer_sonntag=bearbeitung_verteilung(licht_sommer_sonntag);

end

