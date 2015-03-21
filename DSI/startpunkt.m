%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     06.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% startpunkt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm bestimmt den Startzeitpunkt von Waschmaschinen und Geschirrspüler
%stochastisch, unter Berücksichtigung der normalen Häufigkeitsverteilung. 
%Dieser Programm bestimmt auch den Startzeitpunkt von Waschmaschinen und
%Geschirrspüler für TOU-Tarif stochastisch, unter Berücksichtigung der 
%TOU-Tarifen und normalen Häufigkeitsverteilung. 
function [start, handles] = startpunkt(handles)
%STARTPUNKT Summary of this function goes here
%   Detailed explanation goes here    

% Einschaltwahrscheinlichkeit von Waschmaschine pro Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    waschmaschine=handles.waschmaschine_winter_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    waschmaschine=handles.waschmaschine_winter_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    waschmaschine=handles.waschmaschine_winter_sonntag;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')    
    waschmaschine=handles.waschmaschine_sommer_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    waschmaschine=handles.waschmaschine_sommer_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    waschmaschine=handles.waschmaschine_sommer_sonntag;
end

% Einschaltwahrscheinlichkeit von Geschirrspülenmaschine pro Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    geschirrspueler=handles.geschirr_winter_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    geschirrspueler=handles.geschirr_winter_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    geschirrspueler=handles.geschirr_winter_sonntag;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer') 
    geschirrspueler=handles.geschirr_sommer_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    geschirrspueler=handles.geschirr_sommer_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    geschirrspueler=handles.geschirr_sommer_sonntag;
end        
        
switch handles.initiative
    case {'no', 'Load-Control'}    % Normal DLC hier ist gleich. DLC wird waschinemachine... in DLC Berechnen verändern!     
        handles.startpunkt=[];
        
        index_waschmaschine=randi([1,int32(max(waschmaschine))]);
        index_geschirrspueler=randi([1,int32(max(geschirrspueler))]);
        
        % Waschmaschine und Wäschetrockner
        [Asort,index]=sort(waschmaschine(:)-index_waschmaschine);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.waschmaschine=find(waschmaschine==waschmaschine(index(startpunkt)))-2;
        if start.waschmaschine<1
            start.waschmaschine=start.waschmaschine+96;
        end        
        start.waeschetrockner=start.waschmaschine+randi([7,8]);
        
        % Geschirrspüler
        [Asort,index]=sort(geschirrspueler(:)-index_geschirrspueler);
        startpunkt= Asort==min(Asort(Asort>=0));
        start.geschirrspueler=find(geschirrspueler==geschirrspueler(index(startpunkt)))-3;
        if start.geschirrspueler<1
            start.geschirrspueler=start.geschirrspueler+96;
        end
        
        % Warmwasserspeicher
        zeitachse_warmwasser=[1:16, 88:96];
        start.warmwasser=zeitachse_warmwasser(randi([1,numel(zeitachse_warmwasser)]));
        
        handles.startpunkt=start;
        
    case 'Price-Signals'
        start=handles.startpunkt;
        
        zeit_1=[];
        zeit_2=[];
        zeit_3=[];
        if handles.cost_1_min ~= 97 && handles.cost_1_max ~= 97
            zeit_1=[handles.cost_1_min : handles.cost_1_max-3];
        end
        
        if handles.cost_2_min ~= 97 && handles.cost_2_max ~= 97
            zeit_2=[handles.cost_2_min : handles.cost_2_max];
        end
        
        if handles.cost_3_min ~= 97 && handles.cost_3_max ~= 97
            zeit_3=[handles.cost_3_min : handles.cost_3_max];
        end
        zeit=[zeit_1 zeit_2 zeit_3];
        
        if isfield(handles, 'ps_active')==0
            kunden_index=randi([1,3000]);
            if kunden_index > 1000         
                while isempty(intersect(start.waschmaschine, zeit))
                    index_waschmaschine=randi([1,int32(max(waschmaschine))]);     
                    [Asort,index]=sort(waschmaschine(:)-index_waschmaschine);
                    startpunkt= Asort==min(Asort(Asort>=0));
                    start.waschmaschine=find(waschmaschine==waschmaschine(index(startpunkt)))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]); 
                end
                
                while isempty(intersect(start.geschirrspueler, zeit))
                    index_geschirrspueler=randi([1,int32(max(geschirrspueler))]);
                    [Asort,index]=sort(geschirrspueler(:)-index_geschirrspueler);
                    startpunkt= Asort==min(Asort(Asort>=0));
                    start.geschirrspueler=find(geschirrspueler==geschirrspueler(index(startpunkt)))-3;
                end                          
            end
        else
            if handles.ps_active==0
            else
                while isempty(intersect(start.waschmaschine, zeit))
                    index_waschmaschine=randi([1,int32(max(waschmaschine))]);     
                    [Asort,index]=sort(waschmaschine(:)-index_waschmaschine);
                    startpunkt= Asort==min(Asort(Asort>=0));
                    start.waschmaschine=find(waschmaschine==waschmaschine(index(startpunkt)))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]); 
                end
                
                while isempty(intersect(start.geschirrspueler, zeit))
                    index_geschirrspueler=randi([1,int32(max(geschirrspueler))]);
                    [Asort,index]=sort(geschirrspueler(:)-index_geschirrspueler);
                    startpunkt= Asort==min(Asort(Asort>=0));
                    start.geschirrspueler=find(geschirrspueler==geschirrspueler(index(startpunkt)))-3;
                end   
            end
        end
        
end
end
