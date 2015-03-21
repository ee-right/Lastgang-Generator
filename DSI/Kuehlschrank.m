%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Kühlschrank %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert den Lastgang vom Bereich Kühlschrank. Für Detail
%bitte sehen die Bilder auf Seite 33.
function  [lastgang, blind]=Kuehlschrank(handles, Anzahl)
%KUEHLSCHRANK Summary of this function goes here
%   Detailed explanation goes here

lastgang=[];
switch Anzahl
    case 1
        if strcmp(handles.season_type, 'Winter')
            P=14*0.0669*4*388000/(365*36);
        else
            P=14*0.0760*4*388000/(365*36);
        end
        lastgang=[P 0 0];
        order = randperm(numel(lastgang));
        lastgang=lastgang(order);
    case 2
        if strcmp(handles.season_type, 'Winter')
            P=14*0.0669*4*596000/(365*36);
        else
            P=14*0.0760*4*596000/(365*36);
        end
        lastgang=[P 0 0];
        order = randperm(numel(lastgang));
        lastgang=lastgang(order);
    case 3
        if strcmp(handles.season_type, 'Winter')
            P=14*0.0669*4*783000/(365*36);
        else
            P=14*0.0760*4*783000/(365*36);
        end
        lastgang=[P 0 0];
        order = randperm(numel(lastgang));
        lastgang=lastgang(order);
end

lastgang=kron(ones(1,32), lastgang);

while sum(lastgang)<=36*P        
    zusatz=randi([29,88]);
    if zusatz>84
        index=randi([1,2]);
        if index==1
            zusatz=zusatz-60;
        end
    end
    lastgang(zusatz)=P;
end

blind=lastgang*tan(acos(0.9));
end

