function [ output_args ] = analyse( input_args )
%ANALYSE Summary of this function goes here
%   Detailed explanation goes here
[handles.result_file, handles.result_path] = uigetfile('*.xls','Select the Excel-File');

result_i_normal=xlsread([handles.result_path,'\', handles.result_file], 'I Normal');
result_i_normal( : , 1)=[];
result_u_normal=xlsread([handles.result_path,'\', handles.result_file], 'U Normal');
result_u_normal( : , 1)=[];

result_i_ps=xlsread([handles.result_path,'\', handles.result_file], 'I Price Signal');
result_i_ps( : , 1)=[];
result_u_ps=xlsread([handles.result_path,'\', handles.result_file], 'U Price Signal');
result_u_ps( : , 1)=[];

result_i_dlc=xlsread([handles.result_path,'\', handles.result_file], 'I Direct Load Control');
result_i_dlc( : , 1)=[];
result_u_dlc=xlsread([handles.result_path,'\', handles.result_file], 'U Direct Load Control');
result_u_dlc( : , 1)=[];

result_i_rtp=xlsread([handles.result_path,'\', handles.result_file], 'I Real Time Pricing');
result_i_rtp( : , 1)=[];
result_u_rtp=xlsread([handles.result_path,'\', handles.result_file], 'U Real Time Pricing');
result_u_rtp( : , 1)=[];

ort_overload_i_normal=zeros(size(result_i_normal));
ort_overload_u_normal=zeros(size(result_u_normal));
ort_overload_i_ps=zeros(size(result_i_ps));
ort_overload_u_ps=zeros(size(result_u_ps));
ort_overload_i_dlc=zeros(size(result_i_dlc));
ort_overload_u_dlc=zeros(size(result_u_dlc));
ort_overload_i_rtp=zeros(size(result_i_rtp));
ort_overload_u_rtp=zeros(size(result_u_rtp));

ort_overload_i_normal(result_i_normal>100)=1;
ort_overload_u_normal(result_u_normal>110)=1;
ort_overload_i_ps(result_i_ps>100)=1;
ort_overload_u_ps(result_u_ps>110)=1;
ort_overload_i_dlc(result_i_dlc>100)=1;
ort_overload_u_dlc(result_u_dlc>110)=1;
ort_overload_i_rtp(result_i_rtp>100)=1;
ort_overload_u_rtp(result_u_rtp>110)=1;
% %3a
% ort_overload_u_normal(:,[30:3:54, 56:3:81, 109:3:133, 163:3:187])=[];
% ort_overload_u_ps(:,[30:3:54, 56:3:81, 109:3:133, 163:3:187])=[];
% ort_overload_u_dlc(:,[30:3:54, 56:3:81, 109:3:133, 163:3:187])=[];
% ort_overload_u_rtp(:,[30:3:54, 56:3:81, 109:3:133, 163:3:187])=[];
% %1a
% ort_overload_u_normal(:,[1:3:22])=[];
% ort_overload_u_ps(:,[1:3:22])=[];
% ort_overload_u_dlc(:,[1:3:22])=[];
% ort_overload_u_rtp(:,[1:3:22])=[];
%2a
ort_overload_u_normal(:,[3:3:120])=[];
ort_overload_u_ps(:,[3:3:120])=[];
ort_overload_u_dlc(:,[3:3:120])=[];
ort_overload_u_rtp(:,[3:3:120])=[];

ort_overload_i_normal=sum(ort_overload_i_normal,2);
ort_overload_u_normal=sum(ort_overload_u_normal,2);
ort_overload_i_ps=sum(ort_overload_i_ps,2);
ort_overload_u_ps=sum(ort_overload_u_ps,2);
ort_overload_i_dlc=sum(ort_overload_i_dlc,2);
ort_overload_u_dlc=sum(ort_overload_u_dlc,2);
ort_overload_i_rtp=sum(ort_overload_i_rtp,2);
ort_overload_u_rtp=sum(ort_overload_u_rtp,2);

ort_overload_i_normal(ort_overload_i_normal==0)=[];
ort_overload_u_normal(ort_overload_u_normal==0)=[];
ort_overload_i_ps(ort_overload_i_ps==0)=[];
ort_overload_u_ps(ort_overload_u_ps==0)=[];
ort_overload_i_dlc(ort_overload_i_dlc==0)=[];
ort_overload_u_dlc(ort_overload_u_dlc==0)=[];
ort_overload_i_rtp(ort_overload_i_rtp==0)=[];
ort_overload_u_rtp(ort_overload_u_rtp==0)=[];

darstellung(1,1)=numel(ort_overload_i_normal)/4;
darstellung(1,2)=numel(ort_overload_i_ps)/4;
darstellung(1,3)=numel(ort_overload_i_rtp)/4;
darstellung(1,4)=numel(ort_overload_i_dlc)/4;
darstellung(2,1)=sum(ort_overload_i_normal)/numel(ort_overload_i_normal);
darstellung(2,2)=sum(ort_overload_i_ps)/numel(ort_overload_i_ps);
darstellung(2,3)=sum(ort_overload_i_rtp)/numel(ort_overload_i_rtp);
darstellung(2,4)=sum(ort_overload_i_dlc)/numel(ort_overload_i_dlc);

darstellung(3,1)=numel(ort_overload_u_normal)/4;
darstellung(3,2)=numel(ort_overload_u_ps)/4;
darstellung(3,3)=numel(ort_overload_u_rtp)/4;
darstellung(3,4)=numel(ort_overload_u_dlc)/4;
darstellung(4,1)=sum(ort_overload_u_normal)/numel(ort_overload_u_normal);
darstellung(4,2)=sum(ort_overload_u_ps)/numel(ort_overload_u_ps);
darstellung(4,3)=sum(ort_overload_u_rtp)/numel(ort_overload_u_rtp);
darstellung(4,4)=sum(ort_overload_u_dlc)/numel(ort_overload_u_dlc);


% xlswrite([handles.result_path,'\', handles.result_file], number_overload_u, 'Zusammenfassung', 'B2');
% xlswrite([handles.result_path,'\', handles.result_file], number_overload_s, 'Zusammenfassung', 'B9');
% xlswrite([handles.result_path,'\', handles.result_file], number_overload_i, 'Zusammenfassung', 'B16');
% xlswrite([handles.result_path,'\', handles.result_file], lost_pv, 'Zusammenfassung', 'B23');
xlswrite([handles.result_path,'\', handles.result_file], darstellung, 'Zusammenfassung', 'B37');


msgbox('Analyse is completed, The result is saved in Sheet "Zusammenfassung".','Message');

end

