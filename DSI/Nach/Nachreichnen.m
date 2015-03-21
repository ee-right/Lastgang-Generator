function [ output_args ] = Nachreichnen( input_args )
%NACHREICHNEN Summary of this function goes here
%   Detailed explanation goes here
[handles.result_file_orignal, handles.result_path_orignal] = uigetfile('*.xlsx','Select the old Excel-File');
[handles.result_file_new, handles.result_path_new] = uigetfile('*.xlsx','Select the new Excel-File');

h = waitbar(0,'Please wait...');
nach=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'Nach');

% u normal
result_u_normal_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'U Normal');
result_u_normal_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'U Normal');
result_u_normal_old(find(nach==1),:)=result_u_normal_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_u_normal_old, 'U Normal', 'C2');
result_u_normal_old=[];
result_u_normal_new=[];
waitbar(1/16,h,sprintf('%s %12.1f %s','Calculating...',100*1/16, '%'));

% u tou
result_u_ps_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'U Price Signal');
result_u_ps_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'U Price Signal');
result_u_ps_old(find(nach==1),:)=result_u_ps_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_u_ps_old, 'U Price Signal', 'C2');
result_u_ps_old=[];
result_u_ps_new=[];
waitbar(2/16,h,sprintf('%s %12.1f %s','Calculating...',100*2/16, '%'));

% u rtp
result_u_rtp_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'U Real Time Pricing');
result_u_rtp_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'U Real Time Pricing');
result_u_rtp_old(find(nach==1),:)=result_u_rtp_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_u_rtp_old, 'U Real Time Pricing', 'C2');
result_u_rtp_old=[];
result_u_rtp_new=[];
waitbar(3/16,h,sprintf('%s %12.1f %s','Calculating...',100*3/16, '%'));

% u dlc
result_u_dlc_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'U Direct Load Control');
result_u_dlc_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'U Direct Load Control');
result_u_dlc_old(find(nach==1),:)=result_u_dlc_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_u_dlc_old, 'U Direct Load Control', 'C2');
result_u_dlc_old=[];
result_u_dlc_new=[];
waitbar(4/16,h,sprintf('%s %12.1f %s','Calculating...',100*4/16, '%'));

% i normal
result_i_normal_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'I Normal');
result_i_normal_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'I Normal');
result_i_normal_old(find(nach==1),:)=result_i_normal_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_i_normal_old, 'I Normal', 'C2');
result_i_normal_old=[];
result_i_normal_new=[];
waitbar(5/16,h,sprintf('%s %12.1f %s','Calculating...',100*5/16, '%'));

% i tou
result_i_ps_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'I Price Signal');
result_i_ps_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'I Price Signal');
result_i_ps_old(find(nach==1),:)=result_i_ps_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_i_ps_old, 'I Price Signal', 'C2');
result_i_ps_old=[];
result_i_ps_new=[];
waitbar(6/16,h,sprintf('%s %12.1f %s','Calculating...',100*6/16, '%'));

% i rtp
result_i_rtp_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'I Real Time Pricing');
result_i_rtp_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'I Real Time Pricing');
result_i_rtp_old(find(nach==1),:)=result_i_rtp_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_i_rtp_old, 'I Real Time Pricing', 'C2');
result_i_rtp_old=[];
result_i_rtp_new=[];
waitbar(7/16,h,sprintf('%s %12.1f %s','Calculating...',100*7/16, '%'));

% i dlc
result_i_dlc_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'I Direct Load Control');
result_i_dlc_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'I Direct Load Control');
result_i_dlc_old(find(nach==1),:)=result_i_dlc_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_i_dlc_old, 'I Direct Load Control', 'C2');
result_i_dlc_old=[];
result_i_dlc_new=[];
waitbar(8/16,h,sprintf('%s %12.1f %s','Calculating...',100*8/16, '%'));

% S normal
result_s_normal_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'S Normal');
result_s_normal_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'S Normal');
result_s_normal_old(find(nach==1),:)=result_s_normal_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_s_normal_old, 'S Normal', 'C2');
result_s_normal_old=[];
result_s_normal_new=[];
waitbar(9/16,h,sprintf('%s %12.1f %s','Calculating...',100*9/16, '%'));

% S tou
result_s_ps_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'S Price Signal');
result_s_ps_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'S Price Signal');
result_s_ps_old(find(nach==1),:)=result_s_ps_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_s_ps_old, 'S Price Signal', 'C2');
result_s_ps_old=[];
result_s_ps_new=[];
waitbar(10/16,h,sprintf('%s %12.1f %s','Calculating...',100*10/16, '%'));

% S rtp
result_s_rtp_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'S Real Time Pricing');
result_s_rtp_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'S Real Time Pricing');
result_s_rtp_old(find(nach==1),:)=result_s_rtp_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_s_rtp_old, 'S Real Time Pricing', 'C2');
result_s_rtp_old=[];
result_s_rtp_new=[];
waitbar(11/16,h,sprintf('%s %12.1f %s','Calculating...',100*11/16, '%'));

% S dlc
result_s_dlc_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'S Direct Load Control');
result_s_dlc_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'S Direct Load Control');
result_s_dlc_old(find(nach==1),:)=result_s_dlc_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_s_dlc_old, 'S Direct Load Control', 'C2');
result_s_dlc_old=[];
result_s_dlc_new=[];
waitbar(12/16,h,sprintf('%s %12.1f %s','Calculating...',100*12/16, '%'));

% PV normal
result_pv_normal_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'PV Normal');
result_pv_normal_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'PV Normal');
result_pv_normal_old(find(nach==1),:)=result_pv_normal_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_pv_normal_old, 'PV Normal', 'C2');
result_pv_normal_old=[];
result_pv_normal_new=[];
waitbar(13/16,h,sprintf('%s %12.1f %s','Calculating...',100*13/16, '%'));

% PV tou
result_pv_ps_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'PV Price Signal');
result_pv_ps_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'PV Price Signal');
result_pv_ps_old(find(nach==1),:)=result_pv_ps_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_pv_ps_old, 'PV Price Signal', 'C2');
result_pv_ps_old=[];
result_pv_ps_new=[];
waitbar(14/16,h,sprintf('%s %12.1f %s','Calculating...',100*14/16, '%'));

% PV rtp
result_pv_rtp_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'PV Real Time Pricing');
result_pv_rtp_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'PV Real Time Pricing');
result_pv_rtp_old(find(nach==1),:)=result_pv_rtp_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_pv_rtp_old, 'PV Real Time Pricing', 'C2');
result_pv_rtp_old=[];
result_pv_rtp_new=[];
waitbar(15/16,h,sprintf('%s %12.1f %s','Calculating...',100*15/16, '%'));

% PV dlc
result_pv_dlc_old=xlsread([handles.result_path_orignal,'\', handles.result_file_orignal], 'PV Direct Load Control');
result_pv_dlc_new=xlsread([handles.result_path_new,'\', handles.result_file_new], 'PV Direct Load Control');
result_pv_dlc_old(find(nach==1),:)=result_pv_dlc_new(find(nach==1),:);
xlswrite([handles.result_path_new,'\', handles.result_file_new], result_pv_dlc_old, 'PV Direct Load Control', 'C2');
result_pv_dlc_old=[];
result_pv_dlc_new=[];
waitbar(16/16,h,sprintf('%s %12.1f %s','Calculating...',100*16/16, '%'));
delete(h);

end

