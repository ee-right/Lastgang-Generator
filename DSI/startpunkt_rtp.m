%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     22.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% startpunkt_rtp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm bestimmt  den Startzeitpunkt von Waschmaschinen und
%Geschirrspüler für TOU-Tarif stochastisch, unter Berücksichtigung der 
%RTP-Tarifen und normalen Häufigkeitsverteilung. 
function start=startpunkt_rtp(Preisstruktur, lastgang_normal, handles)
%STARTPUNKT_RTP Summary of this function goes here

% Einschaltwahrscheinlichkeit von Waschmaschine pro Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    start_waschmaschine=handles.waschmaschine_winter_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    start_waschmaschine=handles.waschmaschine_winter_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    start_waschmaschine=handles.waschmaschine_winter_sonntag;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer')    
    start_waschmaschine=handles.waschmaschine_sommer_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    start_waschmaschine=handles.waschmaschine_sommer_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    start_waschmaschine=handles.waschmaschine_sommer_sonntag;
end

% Einschaltwahrscheinlichkeit von Geschirrspülenmaschine pro Tag
if strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Winter')
    start_geschirrspueler=handles.geschirr_winter_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Winter')
    start_geschirrspueler=handles.geschirr_winter_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Winter')
    start_geschirrspueler=handles.geschirr_winter_sonntag;
elseif strcmp(handles.day_type, 'Werktag')&&strcmp(handles.season_type, 'Sommer') 
    start_geschirrspueler=handles.geschirr_sommer_werktag;
elseif strcmp(handles.day_type, 'Samstag')&&strcmp(handles.season_type, 'Sommer')
    start_geschirrspueler=handles.geschirr_sommer_samstag;
elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&&strcmp(handles.season_type, 'Sommer')
    start_geschirrspueler=handles.geschirr_sommer_sonntag;
end    

%abstimmen RTP-Tarife je nach dem aktuellen Verbrauch 
[preis_sort, Tarif] = sort(Preisstruktur);

%abstimmen RTP-Tarife je nach dem aktuellen Verbrauch 
waschmaschine = find(lastgang_normal.waschmaschine~=0);
%abstimmen RTP-Tarife je nach dem aktuellen Verbrauch 
geschirrspueler = find(lastgang_normal.geschirrspueler~=0);


%   Detailed explanation goes here        
i=0;
j=0;
if isempty(waschmaschine)
    start.waschmaschine=0;     
    start.waeschetrockner=0; 
else
    if ~isempty(intersect(waschmaschine(1:3), Tarif(81:96)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(1:24)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([1,24]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        elseif index > 433 && index <= 636 
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(25:36)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([25,36]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        elseif index > 637 && index <= 924 
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(37:68)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([37,68]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        elseif index > 925 && index <= 960   
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(69:80)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([69,80]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        else
            start.waschmaschine=waschmaschine(1);     
            start.waeschetrockner=start.waschmaschine+9;
        end        
    elseif ~isempty(intersect(waschmaschine(1:3), Tarif(69:80)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(1:24)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([1,24]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        elseif index > 433 && index <= 636 
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(25:36)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([25,36]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        elseif index > 637 && index <= 924 
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(37:68)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([37,68]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end
        else
            start.waschmaschine=waschmaschine(1);     
            start.waeschetrockner=start.waschmaschine+9;
        end  
    elseif ~isempty(intersect(waschmaschine(1:3), Tarif(37:68)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(1:24)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([1,24]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end                
            end 
        elseif index > 433 && index <= 636 
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(25:36)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([25,36]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end
            end
        else
            start.waschmaschine=waschmaschine(1);     
            start.waeschetrockner=start.waschmaschine+9;
        end  
    elseif ~isempty(intersect(waschmaschine(1:3), Tarif(25:36)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_waschmaschine=randi([1,int32(max(start_waschmaschine))]);     
                [Asort,index]=sort(start_waschmaschine(:)-index_waschmaschine);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.waschmaschine=find(start_waschmaschine==start_waschmaschine(index(startpunkt)))-2;
                if ~isempty(intersect(start.waschmaschine, Tarif(1:24)))
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;
                end
                i=i+1;
                if i>200
                    start.waschmaschine=Tarif(randi([1,24]))-2;
                    start.waeschetrockner=start.waschmaschine+randi([7,8]);                     
                    break;        
                end
            end 
        else
            start.waschmaschine=waschmaschine(1);     
            start.waeschetrockner=start.waschmaschine+9;
        end 
    else
        start.waschmaschine=waschmaschine(1);     
        start.waeschetrockner=start.waschmaschine+9;
    end
    
    if start.waschmaschine<1
        start.waschmaschine=start.waschmaschine+96;
        start.waeschetrockner=start.waschmaschine+9;
    end
end


if isempty(geschirrspueler)
    start.geschirrspueler=0;     
else
    if ~isempty(intersect(geschirrspueler(1:3), Tarif(81:96)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(1:24)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([1,24]))-2;                   
                    break;        
                end                
            end
        elseif index > 433 && index <= 636 
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(25:36)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([25,36]))-3;                   
                    break;        
                end                  
            end
        elseif index > 637 && index <= 924 
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(37:68)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([37,68]))-3;                   
                    break;        
                end                    
            end
        elseif index > 925 && index <= 960   
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(69:80)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([69,80]))-3;                   
                    break;        
                end                    
            end     
        else
            start.geschirrspueler=geschirrspueler(1);     
        end        
    elseif ~isempty(intersect(geschirrspueler(1:3), Tarif(69:80)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(1:24)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([1,24]))-3;                   
                    break;        
                end                    
            end  
        elseif index > 433 && index <= 636 
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(25:36)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([25,36]))-3;                   
                    break;        
                end                    
            end   
        elseif index > 637 && index <= 924 
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(37:68)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([37,68]))-3;                   
                    break;        
                end                    
            end  
        else
            start.geschirrspueler=geschirrspueler(1);     
        end  
    elseif ~isempty(intersect(geschirrspueler(1:3), Tarif(37:68)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(1:24)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([1,24]))-3;                   
                    break;        
                end                 
            end    
        elseif index > 433 && index <= 636 
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(25:36)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([25,36]))-3;                   
                    break;        
                end                 
            end   
        else
            start.geschirrspueler=geschirrspueler(1);     
        end  
    elseif ~isempty(intersect(geschirrspueler(1:3), Tarif(25:36)))
        index=randi([1,976]);
        if index <= 432       
            while 1
                index_geschirrspueler=randi([1,int32(max(start_geschirrspueler))]);     
                [Asort,index]=sort(start_geschirrspueler(:)-index_geschirrspueler);
                startpunkt= Asort==min(Asort(Asort>=0));
                start.geschirrspueler=find(start_geschirrspueler==start_geschirrspueler(index(startpunkt)))-3;
                if ~isempty(intersect(start.geschirrspueler, Tarif(1:24)))                     
                    break;
                end
                j=j+1;
                if j>200
                    start.geschirrspueler=Tarif(randi([1,24]))-3;                   
                    break;        
                end                 
            end  
        else
            start.geschirrspueler=geschirrspueler(1);     
        end 
    else
         start.geschirrspueler=geschirrspueler(1);     
    end
    
    if start.geschirrspueler<1
        start.geschirrspueler=start.geschirrspueler+96;
    end
end
end
