%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     05.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Benutzungsfrequenz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm bestimmt, ob ein Haushalt am eingegebenen Tag
% Waschmaschine, Wäschetrockner und Geschirrspüler einschaltet. Die genaue
% Beschreibung liegt bei Seite 12.
function handles=Benutzungsfrequenz(handles, Anzahl)
%AUSSTATTUNG Summary of this function goes here
%   Detailed explanation goes here

 handles.benutzung.waschmaschine=1;
 handles.benutzung.waeschetrockner=1;
 handles.benutzung.geschirr=1;
 
 % Berücksichtigen die Benutzungsfrequenz von der Waschmaschine und dem
 % Wäschetrockner innerhalb eines Jahres
 switch Anzahl
     case 1     
         if strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,130]);
             if index > 39
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 7 && index <= 39
                 handles.benutzung.waeschetrockner=0;
             end
         elseif strcmp(handles.day_type, 'Samstag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,26]);
             if index > 8           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 3 && index <= 8
                 handles.benutzung.waeschetrockner=0;                 
             end
         elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,26]);
             if index > 7           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 3 && index <= 7
                 handles.benutzung.waeschetrockner=0; 
             end  
         elseif strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,130]);
             if index > 27
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 4 && index <= 27
                 handles.benutzung.waeschetrockner=0;
             end
         elseif strcmp(handles.day_type, 'Samstag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,26]);
             if index > 6           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 1 && index <= 6
                 handles.benutzung.waeschetrockner=0;                 
             end
         elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,26]);
             if index > 5           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;      
             elseif index > 2 && index <= 5
                 handles.benutzung.waeschetrockner=0;
             end
         end  
         
     case 2
         if strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,130]);
             if index > 81
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 31 && index <= 81
                 handles.benutzung.waeschetrockner=0;
             end
         elseif strcmp(handles.day_type, 'Samstag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,26]);
             if index > 16           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 14 && index <= 16
                 handles.benutzung.waeschetrockner=0;                
             end
         elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,26]);
             if index > 14           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 13 && index <= 14
                 handles.benutzung.waeschetrockner=0; 
             end  
         elseif strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,130]);
             if index > 56
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 18 && index <= 56
                 handles.benutzung.waeschetrockner=0;
             end
         elseif strcmp(handles.day_type, 'Samstag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,26]);
             if index > 13           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 5 && index <= 13
                 handles.benutzung.waeschetrockner=0;               
             end
         elseif strcmp(handles.day_type, 'Sonntag und Feiertag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,26]);
             if index > 9           
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;      
             end
         end           
     case 3
         if strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Winter')
             index=randi([1,130]);
             if index > 122
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 74 && index <= 122
                 handles.benutzung.waeschetrockner=0;
             end
         elseif strcmp(handles.day_type, 'Werktag')&& strcmp(handles.season_type, 'Sommer')
             index=randi([1,130]);
             if index > 71
                 handles.benutzung.waschmaschine=0;
                 handles.benutzung.waeschetrockner=0;
             elseif index > 36 && index <= 71
                 handles.benutzung.waeschetrockner=0;
             end
         end
 end
 
 % berücksichtigen die Benutzungsfrequenz vom Geschirrspüler innerhalb eines Jahres
 switch Anzahl
     case 1
     if strcmp(handles.season_type, 'Winter')
         index=randi([1,182]);
         if index > 33
             handles.benutzung.geschirr=0;
         end
     else
         index=randi([1,182]);
         if index > 11
             handles.benutzung.geschirr=0;
         end
     end
     
     case 2
     if strcmp(handles.season_type, 'Winter')
         index=randi([1,182]);
         if index > 95
             handles.benutzung.geschirr=0;
         end
     else
         index=randi([1,182]);
         if index > 62
             handles.benutzung.geschirr=0;
         end
     end   
     
     case 3
     if strcmp(handles.season_type, 'Sommer')
         index=randi([1,182]);
         if index > 129
             handles.benutzung.geschirr=0;
         end
     end 
 end

end

