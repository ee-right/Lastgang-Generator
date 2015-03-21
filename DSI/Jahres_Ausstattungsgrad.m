%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     09.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Jahres_Ausstattungsgrad %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm bestimmt die Austattung der Elektrogeräten in allen
% Haushalten durch die eingegebenen Austattungsgrad in %. sehe Seite 13, Abbildung 4.2.
function handles = Jahres_Ausstattungsgrad(handles, Anzahl)
%AUSSTATTUNGSGRAD Summary of this function goes here
%   Detailed explanation goes here

% Waschmaschine
handles.ausstattung.waschmaschine_gesamt= zeros(1, Anzahl);
n=round(Anzahl*str2num(handles.struct_dd.waschmaschine)/100);
handles.ausstattung.waschmaschine_gesamt(randperm(Anzahl,n))=1;

% Wäschetrockner
handles.ausstattung.waeschetrockner_gesamt= zeros(1, Anzahl);
n=round(Anzahl*str2num(handles.struct_dd.waeschetrockner)/100);
handles.ausstattung.waeschetrockner_gesamt(randperm(Anzahl,n))=1;

% Geschirrspüler
handles.ausstattung.geschirr_gesamt= zeros(1, Anzahl);
n=round(Anzahl*str2num(handles.struct_dd.geschirr)/100);
handles.ausstattung.geschirr_gesamt(randperm(Anzahl,n))=1;

% Warmwasserbereitung
handles.ausstattung.warmwasserbereitstellung=zeros(1, Anzahl);
n=round(Anzahl*str2num(handles.struct_dd.warmwasser)/100);
handles.ausstattung.warmwasserbereitstellung(randperm(Anzahl,n))=1;
m=round(Anzahl*str2num(handles.struct_dd.warmwasserspeicher)/100);
index=find(handles.ausstattung.warmwasserbereitstellung==1);
index(randperm(n,n-m))=[];
handles.ausstattung.warmwasserbereitstellung(index)=2;

% Elektroheizung
handles.ausstattung.elektroheizung=zeros(1, Anzahl);
n=round(Anzahl*str2num(handles.struct_dd.heizung)/100)+round(Anzahl*str2num(handles.struct_dd.heatingpump)/100);
handles.ausstattung.elektroheizung(randperm(Anzahl,n))=1;   % "1" = Nachtspeicherheizung
m=round(Anzahl*str2num(handles.struct_dd.heatingpump)/100);
index=find(handles.ausstattung.elektroheizung==1);
index(randperm(n,n-m))=[];
handles.ausstattung.elektroheizung(index)=2;    % "2" = Wärmepumpe

end
