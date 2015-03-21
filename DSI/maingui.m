%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     21.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function varargout = maingui(varargin)
% MAINGUI MATLAB code for maingui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maingui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maingui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maingui

% Last Modified by GUIDE v2.5 19-Feb-2015 13:42:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maingui_OpeningFcn, ...
                   'gui_OutputFcn',  @maingui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%==========================================================================
% maingui Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before maingui is made visible.
function maingui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maingui (see VARARGIN)

% Choose default command line output for maingui
handles.output = hObject;

% default value
if ~isfield(handles, 'cost_1_min')
    handles.cost_1_min=1;
    handles.cost_2_min=1;
    handles.cost_3_min=1;
    handles.cost_1_max=1;
    handles.cost_2_max=1;
    handles.cost_3_max=1;
    handles.anzahl_DLC='0';
    handles.day_type='Werktag';
    handles.season_type='Winter';
    handles.cb_ps=0;
    handles.cb_dlc=0;
    handles.cb_normal=0;
    handles.cb_rtp=0;
    handles.warmwasser='night heating';
    handles.calculation_mode='Normal';
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maingui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%==========================================================================
% maingui Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = maingui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%==========================================================================
% Day and Season Types - Tagestyp und Jahreszeit in maingui %%%%%%%%%%%%%%%
%==========================================================================

% --- Executes on selection change in day.
function day_Callback(hObject, eventdata, handles)
% hObject    handle to day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns day contents as cell array
%        contents{get(hObject,'Value')} returns selected item from day
list=get(handles.day, 'String');
handles.day_list=get(handles.day, 'Value');
handles.day_type=list{get(handles.day, 'Value')};
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function day_CreateFcn(hObject, eventdata, handles)
% hObject    handle to day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in season.
function season_Callback(hObject, eventdata, handles)
% hObject    handle to season (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns season contents as cell array
%        contents{get(hObject,'Value')} returns selected item from season
list=get(handles.season, 'String');
handles.season_list=get(handles.season, 'Value');
handles.season_type=list{get(handles.season, 'Value')};
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function season_CreateFcn(hObject, eventdata, handles)
% hObject    handle to season (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% House Types - Haushaltsinformation in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================

function ed_anzahl_HH_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_anzahl_HH_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_anzahl_HH_1 as a double
handles.anzahl_HH_1=get(handles.ed_anzahl_HH_1, 'String');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ed_anzahl_HH_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_anzahl_HH_2_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_2_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_anzahl_HH_2_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_anzahl_HH_2_3 as a double
handles.anzahl_HH_2_3=get(handles.ed_anzahl_HH_2_3, 'String');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ed_anzahl_HH_2_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_2_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_anzahl_HH_4_Callback(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_anzahl_HH_4 as text
%        str2double(get(hObject,'String')) returns contents of ed_anzahl_HH_4 as a double
handles.anzahl_HH_4=get(handles.ed_anzahl_HH_4, 'String');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ed_anzahl_HH_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_anzahl_HH_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% House Appliances - Haushaltsgeräte in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_geraete.
function pb_geraete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_geraete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=haushaltsgeraete(handles);
guidata(hObject, handles);


%==========================================================================
% Photovoltaic - Solarenergie in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_solar.
function pb_solar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_solar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=solar(handles);
guidata(hObject, handles);


%==========================================================================
% Consumption Optimization - Sparenderer und Effizienterer Verbrauch %%%%%%
%==========================================================================
% --- Executes on button press in pb_spar.
function pb_spar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_spar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=verbrauchoptimal(handles);
guidata(hObject, handles);


%==========================================================================
% DSM for TOU - Detaillierte DSM-Maßnahme für TOU-Tarife in maingui %%%%%%%
%==========================================================================
function pd_cost_1_min_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pd_cost_1_min as text
%        str2double(get(hObject,'String')) returns contents of pd_cost_1_min as a double
handles.cost_1_min=get(handles.pd_cost_1_min, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_1_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pd_cost_2_min_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pd_cost_2_min as text
%        str2double(get(hObject,'String')) returns contents of pd_cost_2_min as a double
handles.cost_2_min=get(handles.pd_cost_2_min, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pd_cost_3_min_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pd_cost_3_min as text
%        str2double(get(hObject,'String')) returns contents of pd_cost_3_min as a double
handles.cost_3_min=get(handles.pd_cost_3_min, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_3_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pd_cost_1_max.
function pd_cost_1_max_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pd_cost_1_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pd_cost_1_max
handles.cost_1_max=get(handles.pd_cost_1_max, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pd_cost_2_max.
function pd_cost_2_max_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pd_cost_2_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pd_cost_2_max
handles.cost_2_max=get(handles.pd_cost_2_max, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pd_cost_3_max.
function pd_cost_3_max_Callback(hObject, eventdata, handles)
% hObject    handle to pd_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pd_cost_3_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pd_cost_3_max
handles.cost_3_max=get(handles.pd_cost_3_max, 'Value');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_cost_3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% DLC Customer Prozent - Anzahl der Teilnehmer (%) in maingui %%%%%%%%%%%%%
%========================================================================== 
function ed_dlc_kunden_Callback(hObject, eventdata, handles)
% hObject    handle to ed_dlc_kunden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_dlc_kunden as text
%        str2double(get(hObject,'String')) returns contents of ed_dlc_kunden as a double
handles.anzahl_DLC=get(handles.ed_dlc_kunden, 'String');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ed_dlc_kunden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_dlc_kunden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% Demand Side Management Options - DSM-Maßnahme in maingui %%%%%%%%%%%%%%%%
%========================================================================== 
% Normal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_normal_price.
function cb_normal_price_Callback(hObject, eventdata, handles)
% hObject    handle to cb_normal_price (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_normal_price
handles.cb_normal=get(handles.cb_normal_price, 'Value');
guidata(hObject, handles);

% TOU-Tarife %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_price_signal.
function cb_price_signal_Callback(hObject, eventdata, handles)
% hObject    handle to cb_price_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_price_signal
handles.cb_ps=get(handles.cb_price_signal, 'Value');
guidata(hObject, handles);

% Direct-Load-Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_load_control.
function cb_load_control_Callback(hObject, eventdata, handles)
% hObject    handle to cb_load_control (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_load_control
handles.cb_dlc=get(handles.cb_load_control, 'Value');
guidata(hObject, handles);

% RTP-Tarife %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_real_time_pricing.
function cb_real_time_pricing_Callback(hObject, eventdata, handles)
% hObject    handle to cb_real_time_pricing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_real_time_pricing
handles.cb_rtp=get(handles.cb_real_time_pricing, 'Value');
guidata(hObject, handles);


%==========================================================================
% Calculation Mode - Brechnungsmethode in maingui %%%%%%%%%%%%%%%%%%%%%%%%%
%========================================================================== 
% --- Executes on selection change in pd_mode.
function pd_mode_Callback(hObject, eventdata, handles)
% hObject    handle to pd_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pd_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pd_mode
list=get(handles.pd_mode, 'String');
handles.calculation_mode=list{get(handles.pd_mode, 'Value')};
if strcmp(handles.calculation_mode, 'Halbjahr-Verlauf')
    handles=Wochenplan(handles); 
end
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pd_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pd_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% Caculation - Starten in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%========================================================================== 
% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(handles.calculation_mode, 'Normal')    
    lastprofil=Calculation(handles);
else
    Jahresverlauf(handles);
end

% --- Executes during object creation, after setting all properties.
function calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%==========================================================================
% Open File - Open File in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================

function load_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Select the text file');
startpunkt=textread([PathName,FileName], '%s');
set(handles.pd_cost_1_min, 'Value', str2num(startpunkt{1})); 
set(handles.pd_cost_2_min, 'Value', str2num(startpunkt{2}));
set(handles.pd_cost_3_min, 'Value', str2num(startpunkt{3}));
set(handles.pd_cost_1_max, 'Value', str2num(startpunkt{4}));
set(handles.pd_cost_2_max, 'Value', str2num(startpunkt{5}));
set(handles.pd_cost_3_max, 'Value', str2num(startpunkt{6}));
set(handles.pd_waschmaschine_min, 'Value', str2num(startpunkt{7}));
set(handles.pd_waeschetrockner_min, 'Value', str2num(startpunkt{8}));
set(handles.pd_geschirrspueler_min, 'Value', str2num(startpunkt{9}));
set(handles.pd_waschmaschine_max, 'Value', str2num(startpunkt{10}));
set(handles.pd_waeschetrockner_max, 'Value', str2num(startpunkt{11}));
set(handles.pd_geschirrspueler_max, 'Value', str2num(startpunkt{12}));
set(handles.day, 'Value', str2num(startpunkt{13}));
set(handles.season, 'Value', str2num(startpunkt{15}));
set(handles.pd_initiative, 'Value', str2num(startpunkt{17}));
handles.cost_1_min=str2num(startpunkt{1});
handles.cost_2_min=str2num(startpunkt{2});
handles.cost_3_min=str2num(startpunkt{3});
handles.cost_1_max=str2num(startpunkt{4});
handles.cost_2_max=str2num(startpunkt{5});
handles.cost_3_max=str2num(startpunkt{6});
handles.start_waschmaschine_min=str2num(startpunkt{7});
handles.start_waeschetrockner_min=str2num(startpunkt{8});
handles.start_geschirrspueler_min=str2num(startpunkt{9});
handles.start_waschmaschine_max=str2num(startpunkt{10});
handles.start_waeschetrockner_max=str2num(startpunkt{11});
handles.start_geschirrspueler_max=str2num(startpunkt{12});
handles.day_list=startpunkt{13};
handles.day_type=startpunkt{14};
handles.season_list=startpunkt{15};
handles.season_type=startpunkt{16};
handles.initiative_list=startpunkt{17};
handles.initiative=startpunkt{18};

% Update handles structure
guidata(hObject, handles);

%==========================================================================
% Save File - Save File in maingui %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================

function save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fid = fopen(['DSI_', datestr(clock, 'yyyymmddHHMMSS'), '.txt'], 'w'); %open the file
%write your data to the file
fprintf(fid,'%s\n', num2str(handles.cost_1_min)); 
fprintf(fid,'%s\n', num2str(handles.cost_2_min));
fprintf(fid,'%s\n', num2str(handles.cost_3_min));
fprintf(fid,'%s\n', num2str(handles.cost_1_max));
fprintf(fid,'%s\n', num2str(handles.cost_2_max));
fprintf(fid,'%s\n', num2str(handles.cost_3_max));
fprintf(fid,'%s\n', num2str(handles.start_waschmaschine_min));
fprintf(fid,'%s\n', num2str(handles.start_waeschetrockner_min));
fprintf(fid,'%s\n', num2str(handles.start_geschirrspueler_min));
fprintf(fid,'%s\n', num2str(handles.start_waschmaschine_max));
fprintf(fid,'%s\n', num2str(handles.start_waeschetrockner_max));
fprintf(fid,'%s\n', num2str(handles.start_geschirrspueler_max));
fprintf(fid,'%s\n', num2str(handles.day_list));
fprintf(fid,'%s\n', handles.day_type);
fprintf(fid,'%s\n', num2str(handles.season_list));
fprintf(fid,'%s\n', handles.season_type);
fprintf(fid,'%s\n', num2str(handles.initiative_list));
fprintf(fid,'%s\n', handles.initiative);
fclose(fid); %close the file 

%==========================================================================
%==========================================================================