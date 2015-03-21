function [ output_args ] = Nach( input_args )
%NACH Summary of this function goes here
%   Detailed explanation goes here

[handles.result_file, handles.result_path] = uigetfile('*.xlsx','Select the Excel-File');

result_i_normal=xlsread([handles.result_path,'\', handles.result_file], 'I Normal', 'C2:FH35041');
nach=zeros(size(result_i_normal));
nach(result_i_normal>100)=1;
result_i_normal=[];

result_i_ps=xlsread([handles.result_path,'\', handles.result_file], 'I Price Signal', 'C2:FH35041');
nach(result_i_ps>100)=1;
result_i_ps=[];

result_i_dlc=xlsread([handles.result_path,'\', handles.result_file], 'I Direct Load Control', 'C2:FH35041');
nach(result_i_dlc>100)=1;
result_i_dlc=[];

result_i_rtp=xlsread([handles.result_path,'\', handles.result_file], 'I Real Time Pricing', 'C2:FH35041');
nach(result_i_rtp>100)=1;
result_i_rtp=[];

pv_start=zeros([35040,1]);
pv_start(sum(nach,2)>0)=1;

xlswrite([handles.result_path,'\', handles.result_file], pv_start, 'Nach');

end

