%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     06.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Jahres_Ausstattung PV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm bestimmt die Austattung der PV-Anlage in allen
% Haushalten durch die eingegebenen Austattungsgrad in %.
function handles = Jahres_Ausstattung_PV(handles, Anzahl, i)
%JAHRES_AUSSTATTUNG_PV Summary of this function goes here
%   Detailed explanation goes here
%AUSSTATTUNGSGRAD Summary of this function goes here
%   Detailed explanation goes here
handles.ausstattung.solar=0;

% Photovoltaikanlage
switch Anzahl
     case 1     
         if ~isfield(handles, 'matrix_solar_1')
             handles.matrix_solar_1 = zeros(1,str2num(handles.anzahl_HH_1));
             n = round(str2num(handles.anzahl_HH_1)*str2num(handles.struct_dd.solar_1)/100);
             handles.matrix_solar_1(randperm(str2num(handles.anzahl_HH_1),n)) = 1;
         end   
         handles.ausstattung.solar = handles.matrix_solar_1(i);
     case 2
         if ~isfield(handles, 'matrix_solar_2_3')
             handles.matrix_solar_2_3 = zeros(1,str2num(handles.anzahl_HH_2_3));
             n = round(str2num(handles.anzahl_HH_2_3)*str2num(handles.struct_dd.solar_2)/100);
             handles.matrix_solar_2_3(randperm(str2num(handles.anzahl_HH_2_3),n)) = 1;
         end   
         handles.ausstattung.solar = handles.matrix_solar_2_3(i);          
     case 3
         if ~isfield(handles, 'matrix_solar_4')
             handles.matrix_solar_4 = zeros(1,str2num(handles.anzahl_HH_4));
             n = round(str2num(handles.anzahl_HH_4)*str2num(handles.struct_dd.solar_3)/100);
             handles.matrix_solar_4(randperm(str2num(handles.anzahl_HH_4),n)) = 1;
         end   
         handles.ausstattung.solar = handles.matrix_solar_4(i);  
end

end


