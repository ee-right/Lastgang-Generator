%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     05.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Jahres_Benutzungsfrequenz %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Dieser Programm bestimmt, ob ein Haushalt am eingegebenen Tag
% Waschmaschine, Wäschetrockner und Geschirrspüler einschaltet.
function jahres_benutzung = Jahres_Benutzungsfrequenz(handles, Anzahl)
%JAHRES_BENUTZUNGSFREQUENZ Summary of this function goes here
%   Detailed explanation goes here

jahres_benutzung.waschmaschine=zeros([1,365]);
jahres_benutzung.waeschetrockner=zeros([1,365]);
jahres_benutzung.geschirr=zeros([1,365]);

%Berücksichtigen die Benutzungsfrequenz von der Waschmaschine und dem
%Waschmaschine
 switch Anzahl
     case 1              
         while sum(jahres_benutzung.waschmaschine)<86        
             index_waschmaschine=randi([1,int32(max(handles.waschmaschine_verteilung))]);
             [Asort,index]=sort(handles.waschmaschine_verteilung(:)-index_waschmaschine);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.waschmaschine_verteilung==handles.waschmaschine_verteilung(index(startpunkt)));
             jahres_benutzung.waschmaschine(start)=1;
             
             if start>105 && start<281        
                 if mod(start, 7)==5
                     index=randi([1,26]);
                     if index < 2
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 elseif mod(start, 7)==6
                     index=randi([1,26]);
                     if index < 3
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 else
                     index=randi([1,130]);
                     if index < 5
                         jahres_benutzung.waeschetrockner(start)=1;
                     end
                 end
             else     
                 if mod(start, 7)==5
                     index=randi([1,26]);
                     if index < 4
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 elseif mod(start, 7)==6
                     index=randi([1,26]);
                     if index < 4
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 else
                     index=randi([1,130]);
                     if index < 8
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 end
             end
         end  
         
         while sum(jahres_benutzung.geschirr)<42        
             index_geschirr=randi([1,int32(max(handles.geschirr_verteilung))]);
             [Asort,index]=sort(handles.geschirr_verteilung(:)-index_geschirr);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.geschirr_verteilung==handles.geschirr_verteilung(index(startpunkt)));
             jahres_benutzung.geschirr(start)=1;
         end  
     case 2
         while sum(jahres_benutzung.waschmaschine)<183        
             index_waschmaschine=randi([1,int32(max(handles.waschmaschine_verteilung))]);
             [Asort,index]=sort(handles.waschmaschine_verteilung(:)-index_waschmaschine);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.waschmaschine_verteilung==handles.waschmaschine_verteilung(index(startpunkt)));
             jahres_benutzung.waschmaschine(start)=1;
             
             if start>105 && start<281        
                 if mod(start, 7)==5
                     index=randi([1,26]);
                     if index < 6 
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 elseif mod(start, 7)==6
                     index=randi([1,26]);
                     if index < 10
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 else
                     index=randi([1,130]);
                     if index < 19
                         jahres_benutzung.waeschetrockner(start)=1;
                     end
                 end
             else     
                 if mod(start, 7)==5
                     index=randi([1,26]);
                     if index < 15
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 elseif mod(start, 7)==6
                     index=randi([1,26]);
                     if index < 14
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 else
                     index=randi([1,130]);
                     if index < 32
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 end
             end             
         end   
         
         while sum(jahres_benutzung.geschirr)<155        
             index_geschirr=randi([1,int32(max(handles.geschirr_verteilung))]);
             [Asort,index]=sort(handles.geschirr_verteilung(:)-index_geschirr);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.geschirr_verteilung==handles.geschirr_verteilung(index(startpunkt)));
             jahres_benutzung.geschirr(start)=1;
         end           
     case 3
         while sum(jahres_benutzung.waschmaschine)<300        
             index_waschmaschine=randi([1,int32(max(handles.waschmaschine_verteilung))]);
             [Asort,index]=sort(handles.waschmaschine_verteilung(:)-index_waschmaschine);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.waschmaschine_verteilung==handles.waschmaschine_verteilung(index(startpunkt)));
             jahres_benutzung.waschmaschine(start)=1;
             
             if start>105 && start<281        
                 if mod(start, 7)==5
                     jahres_benutzung.waeschetrockner(start)=1;            
                 elseif mod(start, 7)==6
                     jahres_benutzung.waeschetrockner(start)=1;             
                 else
                     index=randi([1,130]);
                     if index < 37
                         jahres_benutzung.waeschetrockner(start)=1;
                     end
                 end
             else     
                 if mod(start, 7)==5
                     jahres_benutzung.waeschetrockner(start)=1;             
                 elseif mod(start, 7)==6
                     jahres_benutzung.waeschetrockner(start)=1;             
                 else
                     index=randi([1,130]);
                     if index <75
                         jahres_benutzung.waeschetrockner(start)=1;
                     end             
                 end
             end             
         end
 
         while sum(jahres_benutzung.geschirr)<310       
             index_geschirr=randi([1,int32(max(handles.geschirr_verteilung))]);
             [Asort,index]=sort(handles.geschirr_verteilung(:)-index_geschirr);
             startpunkt= Asort==min(Asort(Asort>=0));
             start= find(handles.geschirr_verteilung==handles.geschirr_verteilung(index(startpunkt)));
             jahres_benutzung.geschirr(start)=1;
         end           
end 
end
