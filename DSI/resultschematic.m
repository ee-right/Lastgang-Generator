%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%   Date            Programmer      Decription of change                  %
%   ==========      ==========      ====================                  %
%   19.02.2015      Han Rui         Original code                         %
%   05.03.2015      Norbert Ba?     Added button to save data to .mat file%
%                                   Added popupmenu to select which type  %
%                                   to save                               %
%   10.03.2015      Norbert Ba?     Removed option to save as Excel files %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% resultschematic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function varargout = resultschematic(varargin)
% RESULTSCHEMATIC MATLAB code for resultschematic.fig
%      RESULTSCHEMATIC, by itself, creates a new RESULTSCHEMATIC or raises the existing
%      singleton*.
%
%      H = RESULTSCHEMATIC returns the handle to a new RESULTSCHEMATIC or the handle to
%      the existing singleton*.
%
%      RESULTSCHEMATIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTSCHEMATIC.M with the given input arguments.
%
%      RESULTSCHEMATIC('Property','Value',...) creates a new RESULTSCHEMATIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resultschematic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resultschematic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resultschematic

% Last Modified by GUIDE v2.5 10-Mar-2015 16:19:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resultschematic_OpeningFcn, ...
                   'gui_OutputFcn',  @resultschematic_OutputFcn, ...
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
% resultschematic Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before resultschematic is made visible.
function resultschematic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resultschematic (see VARARGIN)

% Choose default command line output for resultschematic
handles.output = hObject;
% Caculation Ausgabe resultschematic(lastprofil.all, initiative, lastprofil_singal.normal, lastprofil_singal.normal_blind);
handles.lastprofil=varargin{1, 1};
handles.initiative=varargin{1, 2};

% Diagram Display %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normal Line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.initiative.cb_normal==1
    plot(handles.axes, handles.lastprofil, 'r');
    hold on;
    grid on;
    set(handles.ed_max_normal, 'String', max(handles.lastprofil));
    set(handles.ed_min_normal, 'String', min(handles.lastprofil));
    handles.signal_normal=varargin{1, 3};
    handles.signal_normal_blind=varargin{1, 4};
    handles.excel_normal=1;
end

xlabel('Zeit (1/4h)');
ylabel('Leistung (W)');

% Solar Line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.initiative.solar==1
    handles.solar=varargin{1, 3};
    handles.cosphi=varargin{1, 4};
    handles.excel_solar=1;
end

% TOU Line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.initiative.cb_ps==1
    plot(handles.axes, handles.lastprofil, 'b');
    hold on;
    grid on;
    set(handles.ed_max_ps, 'String', max(handles.lastprofil));
    set(handles.ed_min_ps, 'String', min(handles.lastprofil));
    handles.signal_ps=varargin{1, 3};
    handles.signal_ps_blind=varargin{1, 4};
    handles.excel_ps=1;
end

% DLC Line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.initiative.cb_dlc==1
    plot(handles.axes, handles.lastprofil, 'g');
    hold on;
    grid on;
    set(handles.ed_max_dlc, 'String', max(handles.lastprofil));
    set(handles.ed_min_dlc, 'String', min(handles.lastprofil));
    handles.signal_dlc=varargin{1, 3};
    handles.signal_dlc_blind=varargin{1, 4};
    handles.excel_dlc=1;
end

% RTP Line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if handles.initiative.cb_rtp==1
    plot(handles.axes, handles.lastprofil, 'k');
    hold on;
    grid on;
    set(handles.ed_max_rtp, 'String', max(handles.lastprofil));
    set(handles.ed_min_rtp, 'String', min(handles.lastprofil));
    handles.signal_rtp=varargin{1, 3};
    handles.signal_rtp_blind=varargin{1, 4};
    handles.excel_rtp=1;
end

% sets string values of the popupmenu popupmenu_SaveAsMat_SelectType %%%%%%
normal_string =     'Normal';            % hier k?nnen wir die Namen ?ndern
ps_string =         'ps / TOU-Tarife';
rtp_string =        'RTP-Tarife';
dlc_string =        'Direct-Load-Control';

SaveAsMat_Array    = java_array('java.lang.String', 4);
SaveAsMat_Array(1) = java.lang.String(normal_string);
SaveAsMat_Array(2) = java.lang.String(ps_string);
SaveAsMat_Array(3) = java.lang.String(rtp_string);
SaveAsMat_Array(4) = java.lang.String(dlc_string);

SaveAsMat_Cell = cell(SaveAsMat_Array);
set(handles.popupmenu_SaveAsMat_SelectType, 'String', SaveAsMat_Cell);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resultschematic wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%==========================================================================
% resultschematic Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = resultschematic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%==========================================================================
% Reset %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_reset.
function pb_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pb_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes,'reset');
set(handles.ed_max_normal, 'String', '0');
set(handles.ed_min_normal, 'String', '0');
set(handles.ed_max_ps, 'String', '0');
set(handles.ed_min_ps, 'String', '0');

%==========================================================================
% Normal (Red Line) Max and Min Value %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_max_normal_Callback(hObject, eventdata, handles)
% hObject    handle to ed_max_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_max_normal as text
%        str2double(get(hObject,'String')) returns contents of ed_max_normal as a double


% --- Executes during object creation, after setting all properties.
function ed_max_normal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_max_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_min_normal_Callback(hObject, eventdata, handles)
% hObject    handle to ed_min_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_min_normal as text
%        str2double(get(hObject,'String')) returns contents of ed_min_normal as a double


% --- Executes during object creation, after setting all properties.
function ed_min_normal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_min_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Time of Use (Blue Line) Max and Min Value %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_max_ps_Callback(hObject, eventdata, handles)
% hObject    handle to ed_max_ps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_max_ps as text
%        str2double(get(hObject,'String')) returns contents of ed_max_ps as a double


% --- Executes during object creation, after setting all properties.
function ed_max_ps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_max_ps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_min_ps_Callback(hObject, eventdata, handles)
% hObject    handle to ed_min_ps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_min_ps as text
%        str2double(get(hObject,'String')) returns contents of ed_min_ps as a double


% --- Executes during object creation, after setting all properties.
function ed_min_ps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_min_ps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Direct Load Control (Green Line) Max and Min Value %%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_max_dlc_Callback(hObject, eventdata, handles)
% hObject    handle to ed_max_dlc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_max_dlc as text
%        str2double(get(hObject,'String')) returns contents of ed_max_dlc as a double


% --- Executes during object creation, after setting all properties.
function ed_max_dlc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_max_dlc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_min_dlc_Callback(hObject, eventdata, handles)
% hObject    handle to ed_min_dlc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_min_dlc as text
%        str2double(get(hObject,'String')) returns contents of ed_min_dlc as a double


% --- Executes during object creation, after setting all properties.
function ed_min_dlc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_min_dlc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Real Time Pricing (Black Line) Max and Min Value %%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_max_rtp_Callback(hObject, eventdata, handles)
% hObject    handle to ed_max_rtp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_max_rtp as text
%        str2double(get(hObject,'String')) returns contents of ed_max_rtp as a double


% --- Executes during object creation, after setting all properties.
function ed_max_rtp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_max_rtp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ed_min_rtp_Callback(hObject, eventdata, handles)
% hObject    handle to ed_min_rtp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_min_rtp as text
%        str2double(get(hObject,'String')) returns contents of ed_min_rtp as a double


% --- Executes during object creation, after setting all properties.
function ed_min_rtp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_min_rtp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%==========================================================================
% "Normal" will be used by default
%==========================================================================
% --- Executes during object creation, after setting all properties.
function popupmenu_SaveAsMat_SelectType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_SaveAsMat_SelectType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Load variables that were saved in Jahresverlauf.m beforehand 

load lastprofil_singal lastprofil_singal

% load default data

handles.WirkLeistung_data =     lastprofil_singal.normal;
handles.BlindLeistung_data =    lastprofil_singal.normal_blind;

handles.Solar_data =            lastprofil_singal.solar;
handles.CosPhi_data =           lastprofil_singal.cosphi;

guidata(hObject, handles);

clear lastprofil_singal;


%==========================================================================
% Popup Menu to select which data should be saved as a .mat file
% "Normal" will be used by default
%==========================================================================

% --- Executes on selection change in popupmenu_SaveAsMat_SelectType.
function popupmenu_SaveAsMat_SelectType_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_SaveAsMat_SelectType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_SaveAsMat_SelectType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_SaveAsMat_SelectType

% Load variables that were saved in Jahresverlauf.m beforehand 

load lastprofil_singal lastprofil_singal

% Select data depending on selection

SaveAsMat_Value = get(handles.popupmenu_SaveAsMat_SelectType, 'Value'); 

switch SaveAsMat_Value
    case 1
        handles.WirkLeistung_data =     lastprofil_singal.normal;
        handles.BlindLeistung_data =    lastprofil_singal.normal_blind;

        handles.Solar_data =            lastprofil_singal.solar;
        handles.CosPhi_data =           lastprofil_singal.cosphi;
        
    case 2
        handles.WirkLeistung_data =     lastprofil_singal.ps;
        handles.BlindLeistung_data =    lastprofil_singal.ps_blind;

        handles.Solar_data =            lastprofil_singal.solar;
        handles.CosPhi_data =           lastprofil_singal.cosphi;
        
    case 3
        handles.WirkLeistung_data =     lastprofil_singal.rtp;
        handles.BlindLeistung_data =    lastprofil_singal.rtp_blind;

        handles.Solar_data =            lastprofil_singal.solar;
        handles.CosPhi_data =           lastprofil_singal.cosphi;
        
    case 4
        handles.WirkLeistung_data =     lastprofil_singal.dlc;
        handles.BlindLeistung_data =    lastprofil_singal.dlc_blind;

        handles.Solar_data =            lastprofil_singal.solar;
        handles.CosPhi_data =           lastprofil_singal.cosphi;
end

guidata(hObject, handles);

clear lastprofil_singal;

%==========================================================================
% Button to save data as a .mat file
% "Normal" will be used by default
%==========================================================================

% --- Executes on button press in pushbutton_SaveAsMat.
function pushbutton_SaveAsMat_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SaveAsMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
% Select data
% Select data depending on selection
%

WirkLeistung_data =     handles.WirkLeistung_data;
BlindLeistung_data =    handles.BlindLeistung_data;

Solar_data =            handles.Solar_data;
CosPhi_data =           handles.CosPhi_data;

% Define variable names
%
% Structure of structure variable
% Do not change the variables names itselves, change the strings!

JahresLastProfile_string =         'Jahreslastprofile';
JahresEinspeiseProfile_string =    'Jahreseinspeiseprofile';

% Create output 

Jahreslastprofile(:,:,1) = WirkLeistung_data; % Saves the data of the Wirk-Leistung in the first dimension
Jahreslastprofile(:,:,2) = BlindLeistung_data; % Saves the data of the Blind-Leistung in the second dimension

Jahreseinspeiseprofile(:,:,1) = Solar_data; % Saves the data of the Solar in the first dimension
Jahreseinspeiseprofile(:,:,2) = CosPhi_data; % Saves the data of the CosPhi in the second dimension

% "In" can be changed if so desired; DO NOT FORGET IT TO CHANGE IT BELOW, TOO!
In = struct(JahresLastProfile_string, Jahreslastprofile, JahresEinspeiseProfile_string, Jahreseinspeiseprofile);

% Select save location
[fileName_SaveOutput, filePath_SaveOutput] = uiputfile('*.*','Select the Output file');
save([filePath_SaveOutput, fileName_SaveOutput], 'In'); % Change the variable name here too if you have changed in above!
