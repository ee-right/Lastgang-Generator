function [ output_args ] = Geld( input_args )
%GELD Summary of this function goes here
%   Detailed explanation goes here
a=[];

[handles.result_file, handles.result_path] = uigetfile('*.xls','Select the Excel-File');
geld_ps=0;
geld_rtp=0;

result_normal=xlsread([handles.result_path,'\', handles.result_file], 'Normal');
result_normal=sum(result_normal,2)/4000;

result_solar=xlsread([handles.result_path,'\', handles.result_file], 'Solar');
result_solar=sum(result_solar,2)/4000;

result_ps=xlsread([handles.result_path,'\', handles.result_file], 'Price Signal');
result_ps=sum(result_ps,2)/4000;

preis_ps_werktag=[0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 ...
    0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 ...
    0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 ...
    0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.249 0.249 0.249 0.249 ...
    0.249 0.249 0.249 0.249];

preis_ps_wochenende=[0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 ...
    0.249 0.249 0.249 0.249 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.249 0.249 0.249 0.249 ...
    0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 0.249 ...
    0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.353 0.249 0.249 0.249 0.249 ...
    0.249 0.249 0.249 0.249];

result_rtp=xlsread([handles.result_path,'\', handles.result_file], 'Real Time Pricing');
result_rtp=sum(result_rtp,2)/4000;

for tag=1:365
    
    if mod(tag, 7)==5
        geld_ps=sum(preis_ps_wochenende'.*result_ps(96*tag-95:96*tag))+geld_ps;
    elseif mod(tag, 7)==6
        geld_ps=sum(preis_ps_wochenende'.*result_ps(96*tag-95:96*tag))+geld_ps;
    else
        geld_ps=sum(preis_ps_werktag'.*result_ps(96*tag-95:96*tag))+geld_ps;
    end 
    
    lastgang=result_normal(96*tag-95:96*tag)-result_solar(96*tag-95:96*tag);
    lastgang24=[];
    for i=1:24
        lastgang24=[lastgang24 sum(lastgang(4*i-3:4*i))];
    end
    
    [lastprofil_sort, Tarif] = sort(lastgang24);
    Preisstruktur=[];
    Preisstruktur(Tarif(22:24))=0.4025;
    Preisstruktur(Tarif(18:21))=0.3525;
    Preisstruktur(Tarif(10:17))=0.2495;
    Preisstruktur(Tarif(7:9))=0.20;
    Preisstruktur(Tarif(1:6))=0.19;
    
    Preisstruktur=kron(Preisstruktur, ones([1 4]));    
    geld_rtp=sum(Preisstruktur'.*result_rtp(96*tag-95:96*tag))+geld_rtp;

end

geld_normal=sum(result_normal*0.288);
geld_normal
geld_ps
geld_rtp
