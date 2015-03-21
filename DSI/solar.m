%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     06.03.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function varargout = solar(varargin)
% SOLAR MATLAB code for solar.fig
%      SOLAR, by itself, creates a new SOLAR or raises the existing
%      singleton*.
%
%      H = SOLAR returns the handle to a new SOLAR or the handle to
%      the existing singleton*.
%
%      SOLAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOLAR.M with the given input arguments.
%
%      SOLAR('Property','Value',...) creates a new SOLAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before solar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to solar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help solar

% Last Modified by GUIDE v2.5 11-Dec-2013 16:07:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @solar_OpeningFcn, ...
                   'gui_OutputFcn',  @solar_OutputFcn, ...
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
% solar Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before solar is made visible.
function solar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to solar (see VARARGIN)

% Choose default command line output for solar
handles.output = hObject;

handles.maindata=varargin{1};

if isfield(handles.maindata, 'struct_sgd') && isfield(handles.maindata.struct_sgd, 'solar_1')
    set(handles.ed_solar_1, 'String', handles.maindata.struct_sgd.solar_1);
    set(handles.ed_solar_2, 'String', handles.maindata.struct_sgd.solar_2);
    set(handles.ed_solar_3, 'String', handles.maindata.struct_sgd.solar_3);
    set(handles.ed_neigung, 'String', handles.maindata.struct_sgd.solar_neigung);
    set(handles.ed_size, 'String', handles.maindata.struct_sgd.solar_size);
    set(handles.ed_orient, 'String', handles.maindata.struct_sgd.solar_orient);
    set(handles.ed_k_T, 'String', handles.maindata.struct_sgd.solar_k_T);
    set(handles.ed_solar_day, 'String', handles.maindata.struct_sgd.solar_day);
    set(handles.ed_geo_breite, 'String', handles.maindata.struct_sgd.ort_breite);
    set(handles.ed_geo_lange, 'String', handles.maindata.struct_sgd.ort_lange);   
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes solar wait for user response (see UIRESUME)
 uiwait(handles.figure1);

%==========================================================================
% solar Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = solar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.maindata;

close(); % GUI close

%==========================================================================
% Solar Penetration - Ausstattungsgrad in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% 1 Person Haushalt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_solar_1_Callback(hObject, eventdata, handles)
% hObject    handle to ed_solar_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_solar_1 as text
%        str2double(get(hObject,'String')) returns contents of ed_solar_1 as a double


% --- Executes during object creation, after setting all properties.
function ed_solar_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_solar_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% 2-3 Personen Haushalt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_solar_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_solar_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_solar_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_solar_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_solar_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_solar_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% 4+ Personen Haushalt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_solar_3_Callback(hObject, eventdata, handles)
% hObject    handle to ed_solar_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_solar_3 as text
%        str2double(get(hObject,'String')) returns contents of ed_solar_3 as a double


% --- Executes during object creation, after setting all properties.
function ed_solar_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_solar_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Floor Inclination - Dachneigung in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_neigung_Callback(hObject, eventdata, handles)
% hObject    handle to ed_neigung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_neigung as text
%        str2double(get(hObject,'String')) returns contents of ed_neigung as a double


% --- Executes during object creation, after setting all properties.
function ed_neigung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_neigung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Floor Area - Fläche in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_size_Callback(hObject, eventdata, handles)
% hObject    handle to ed_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_size as text
%        str2double(get(hObject,'String')) returns contents of ed_size as a double


% --- Executes during object creation, after setting all properties.
function ed_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Orientation - Ausrichtung nach süd in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_orient_Callback(hObject, eventdata, handles)
% hObject    handle to ed_orient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_orient as text
%        str2double(get(hObject,'String')) returns contents of ed_orient as a double


% --- Executes during object creation, after setting all properties.
function ed_orient_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_orient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Sky index - Himmelklarheit in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_k_T_Callback(hObject, eventdata, handles)
% hObject    handle to ed_k_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_k_T as text
%        str2double(get(hObject,'String')) returns contents of ed_k_T as a double


% --- Executes during object creation, after setting all properties.
function ed_k_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_k_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Weahter Day - Tag des Jahres in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_solar_day_Callback(hObject, eventdata, handles)
% hObject    handle to ed_solar_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_solar_day as text
%        str2double(get(hObject,'String')) returns contents of ed_solar_day as a double


% --- Executes during object creation, after setting all properties.
function ed_solar_day_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_solar_day (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Latitude - Die geografische Breite in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_geo_breite_Callback(hObject, eventdata, handles)
% hObject    handle to ed_geo_breite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_geo_breite as text
%        str2double(get(hObject,'String')) returns contents of ed_geo_breite as a double


% --- Executes during object creation, after setting all properties.
function ed_geo_breite_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_geo_breite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Longitude - Die geografische Länge in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_geo_lange_Callback(hObject, eventdata, handles)
% hObject    handle to ed_geo_lange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_geo_lange as text
%        str2double(get(hObject,'String')) returns contents of ed_geo_lange as a double


% --- Executes during object creation, after setting all properties.
function ed_geo_lange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_geo_lange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Solar Deufault - Default in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_default.
function pb_default_Callback(hObject, eventdata, handles)
% hObject    handle to pb_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ed_solar_1, 'String', '0');
set(handles.ed_solar_2, 'String', '5');
set(handles.ed_solar_3, 'String', '25');
set(handles.ed_neigung, 'String', '35');
set(handles.ed_size, 'String', '50');
set(handles.ed_orient, 'String', '0');
set(handles.ed_k_T, 'String', '1');
set(handles.ed_solar_day, 'String', '1');
set(handles.ed_geo_breite, 'String','51');
set(handles.ed_geo_lange, 'String','10');

%==========================================================================
% Save and Close - Save & Close in solar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.maindata.struct_sgd.solar_1=get(handles.ed_solar_1, 'String');
handles.maindata.struct_sgd.solar_2=get(handles.ed_solar_2, 'String');
handles.maindata.struct_sgd.solar_3=get(handles.ed_solar_3, 'String');
handles.maindata.struct_sgd.solar_neigung=get(handles.ed_neigung, 'String');
handles.maindata.struct_sgd.solar_size=get(handles.ed_size, 'String');
handles.maindata.struct_sgd.solar_orient=get(handles.ed_orient, 'String');
handles.maindata.struct_sgd.solar_k_T=get(handles.ed_k_T, 'String');
handles.maindata.struct_sgd.solar_day=get(handles.ed_solar_day, 'String');
handles.maindata.struct_sgd.ort_breite=get(handles.ed_geo_breite, 'String');
handles.maindata.struct_sgd.ort_lange=get(handles.ed_geo_lange, 'String');
guidata(hObject, handles);
uiresume();

%==========================================================================
%==========================================================================