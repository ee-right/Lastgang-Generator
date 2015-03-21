%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     23.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% wetterbedingung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
%Dieser Programm simuliert die Wetterbedingung jedes Tages stochastisch,
%unter Berücksichtigung der 5-jährigen Beobachtungen sehe meine Arbeit
%Seite 54.
function wetter_jahr = wetterbedingung()
%WETTERBEDINGUNG Summary of this function goes here
%   In this Programm the Weather Factor Kw will be calculate
%   Detailed explanation goes here

%% Erklärung:
% jan = 1   --> Sonne
% jan = 2   --> leicht bewölkt
% jan = 3   --> stark bewölkt

% Eingabe der Wetterbedingungen (stochastisch) für jeden Monat

wetter_jahr=[];
% Jan:1 11 19
jan=ones(1, 31);
jan(randperm(31,30))=2; % randperm(n,k) returns a row vector containing k unique integers selected randomly from 1 to n inclusive (n>=k)
index=find(jan==2);
index(randperm(30,11))=[];
jan(index)=3;

% Feb:3 10 15
feb=ones(1, 28);
feb(randperm(28,25))=2;
index=find(feb==2);
index(randperm(25,10))=[];
feb(index)=3;

% Mrz:2 15 14
mrz=ones(1, 31);
mrz(randperm(31,29))=2;
index=find(mrz==2);
index(randperm(29,15))=[];
mrz(index)=3;

% Apr:4 15 11
apr=ones(1, 30);
apr(randperm(30,26))=2;
index=find(apr==2);
index(randperm(26,15))=[];
apr(index)=3;

% Mai:4 17 10
mai=ones(1, 31);
mai(randperm(31,27))=2;
index=find(mai==2);
index(randperm(27,17))=[];
mai(index)=3;

% Jun:3 17 10
jun=ones(1, 30);
jun(randperm(30,27))=2;
index=find(jun==2);
index(randperm(27,17))=[];
jun(index)=3;

% Jul:3 16 12
jul=ones(1, 31);
jul(randperm(31,28))=2;
index=find(jul==2);
index(randperm(28,16))=[];
jul(index)=3;

% Aug:3 19 9
aug=ones(1, 31);
aug(randperm(31,28))=2;
index=find(aug==2);
index(randperm(28,19))=[];
aug(index)=3;

% Sep:3 17 10
sep=ones(1, 30);
sep(randperm(30,27))=2;
index=find(sep==2);
index(randperm(27,17))=[];
sep(index)=3;

% Okt:2 17 12
okt=ones(1, 31);
okt(randperm(31,29))=2;
index=find(okt==2);
index(randperm(29,17))=[];
okt(index)=3;

% Nov:1 11 18
nov=ones(1, 30);
nov(randperm(30,29))=2;
index=find(nov==2);
index(randperm(29,11))=[];
nov(index)=3;

% Dez:1 12 18
dez=ones(1, 31);
dez(randperm(31,30))=2;
index=find(dez==2);
index(randperm(30,12))=[];
dez(index)=3;

% Gesamte Wetterbedingungen (ein ganzes Jahr)
wetter_tag=[jan feb mrz apr mai jun jul aug sep okt nov dez];

for i=1:365
    % Unterscheidung der verschiedenen Tagestypen
    if wetter_tag(i)==1 % wenn sonnig
        Wetter=randi([81,100], [1, 96])/100; % [81,100] = Himmelklarheit (on the interval [imin,imax]);  [1, 96] = Zeit (return an 1-by-96 matrix of numbers)
        index=randi([1,20]); % mögliche Wetteränderung 2/20 = 10%
        if index==1 % mögliche Wetteränderung Vormittag
            Wetter(1:48)=randi([41,90], [1, 48])/100;
        elseif index==2 % mögliche Wetteränderung Nachmittag
            Wetter(49:96)=randi([41,90], [1, 48])/100;
        end
    elseif wetter_tag(i)==2 % wenn Bewölkte Tage
        Wetter=randi([41,80], [1, 96])/100;
        index=randi([1,20]); % mögliche Wetteränderung 6/20 = 30%
        if index<=2
            Wetter(1:48)=randi([71,100], [1, 48])/100;
        elseif index<=4
            Wetter(49:96)=randi([71,100], [1, 48])/100;
        elseif index<=5
            Wetter(1:48)=randi([5,30], [1, 48])/100;
        elseif index<=6
            Wetter(49:96)=randi([5,30], [1, 48])/100;            
        end        
    else % wenn Trübe Tage
        Wetter=randi([1,40], [1, 96])/100;
        index=randi([1,20]); % mögliche Wetteränderung 2/20 = 10%
        if index==1
            Wetter(1:48)=randi([21,80], [1, 48])/100;
        elseif index==2
            Wetter(49:96)=randi([21,80], [1, 48])/100;
        end        
    end
    
    wetter_jahr=[wetter_jahr; Wetter];
    
end
% save('wetter1.mat','wetter_jahr');
end

