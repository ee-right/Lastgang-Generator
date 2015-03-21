%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% RTP_Struktur %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm berechnet die RTP-Tarifen nach dem simulierten Lastgang und 
%der simulierten Einspeisung. 
function Preisstruktur = RTP_Struktur(lastgang)
%RTP_STRUKTUR Summary of this function goes here
%   Detailed explanation goes here
lastgang24=[];
Preisstruktur=zeros([1,24]);

for i=1:24
    lastgang24=[lastgang24 sum(lastgang(4*i-3:4*i))];
end

[lastprofil_sort, Tarif] = sort(lastgang24);

Preisstruktur(Tarif(22:24))=0.4025;
Preisstruktur(Tarif(18:21))=0.3525;
Preisstruktur(Tarif(10:17))=0.2525;
Preisstruktur(Tarif(7:9))=0.20;
Preisstruktur(Tarif(1:6))=0.19;
Preisstruktur=kron(Preisstruktur, ones([1 4]));
end

