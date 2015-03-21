%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% verbrauchoptimal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Effizienz Steigung Untersuchung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = verbrauchoptimal(varargin)
% VERBRAUCHOPTIMAL MATLAB code for verbrauchoptimal.fig
%      VERBRAUCHOPTIMAL, by itself, creates a new VERBRAUCHOPTIMAL or raises the existing
%      singleton*.
%
%      H = VERBRAUCHOPTIMAL returns the handle to a new VERBRAUCHOPTIMAL or the handle to
%      the existing singleton*.
%
%      VERBRAUCHOPTIMAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VERBRAUCHOPTIMAL.M with the given input arguments.
%
%      VERBRAUCHOPTIMAL('Property','Value',...) creates a new VERBRAUCHOPTIMAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before verbrauchoptimal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to verbrauchoptimal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help verbrauchoptimal

% Last Modified by GUIDE v2.5 26-Jul-2013 11:29:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @verbrauchoptimal_OpeningFcn, ...
                   'gui_OutputFcn',  @verbrauchoptimal_OutputFcn, ...
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
% verbrauchoptimal Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before verbrauchoptimal is made visible.
function verbrauchoptimal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to verbrauchoptimal (see VARARGIN)

% Choose default command line output for verbrauchoptimal
handles.output = hObject;

handles.maindata=varargin{1};

if isfield(handles.maindata, 'struct_eff') && isfield(handles.maindata.struct_eff, 'waschmaschine')
    set(handles.cb_active, 'Value', handles.maindata.struct_eff.active);
    set(handles.ed_durchdringung, 'String',  handles.maindata.struct_eff.durchdringung);
    set(handles.ed_waschmaschine, 'String',  handles.maindata.struct_eff.waschmaschine);
    set(handles.ed_waeschetrockner, 'String', handles.maindata.struct_eff.waeschetrockner);
    set(handles.ed_geschirr, 'String', handles.maindata.struct_eff.geschirr);
    set(handles.ed_warmwasser, 'String', handles.maindata.struct_eff.warmwasser);
    set(handles.ed_heizung, 'String', handles.maindata.struct_eff.heizung);
    set(handles.ed_licht, 'String', handles.maindata.struct_eff.licht);
    set(handles.cb_standby, 'Value', handles.maindata.struct_eff.standby);
    
    if get(handles.cb_active, 'Value')==1
            set(handles.ed_durchdringung, 'Enable', 'on');
            set(handles.ed_waschmaschine, 'Enable', 'on');
            set(handles.ed_waeschetrockner, 'Enable', 'on');
            set(handles.ed_geschirr, 'Enable', 'on');
            set(handles.ed_warmwasser, 'Enable', 'on');
            set(handles.ed_heizung, 'Enable', 'on');
            set(handles.ed_licht, 'Enable', 'on');
            set(handles.cb_standby, 'Enable', 'on');
    else
            set(handles.ed_durchdringung, 'Enable', 'off');
            set(handles.ed_waschmaschine, 'Enable', 'off');
            set(handles.ed_waeschetrockner, 'Enable', 'off');
            set(handles.ed_geschirr, 'Enable', 'off');
            set(handles.ed_warmwasser, 'Enable', 'off');
            set(handles.ed_heizung, 'Enable', 'off');
            set(handles.ed_licht, 'Enable', 'off');
            set(handles.cb_standby, 'Enable', 'off');
    end
    
else
    set(handles.ed_durchdringung, 'Enable', 'off');
    set(handles.ed_waschmaschine, 'Enable', 'off');
    set(handles.ed_waeschetrockner, 'Enable', 'off');
    set(handles.ed_geschirr, 'Enable', 'off');
    set(handles.ed_warmwasser, 'Enable', 'off');
    set(handles.ed_heizung, 'Enable', 'off');
    set(handles.ed_licht, 'Enable', 'off');
    set(handles.cb_standby, 'Enable', 'off');
end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes verbrauchoptimal wait for user response (see UIRESUME)
uiwait(handles.figure1);

%==========================================================================
% verbrauchoptimal Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = verbrauchoptimal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.maindata;

close();

%==========================================================================
% Activation the Plan - Aktivieren diesen Plan %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in cb_active.
function cb_active_Callback(hObject, eventdata, handles)
% hObject    handle to cb_active (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_active
if get(handles.cb_active, 'Value')==1
    set(handles.ed_durchdringung, 'Enable', 'on');
    set(handles.ed_waschmaschine, 'Enable', 'on');
    set(handles.ed_waeschetrockner, 'Enable', 'on');
    set(handles.ed_geschirr, 'Enable', 'on');
    set(handles.ed_warmwasser, 'Enable', 'on');
    set(handles.ed_heizung, 'Enable', 'on');
    set(handles.ed_licht, 'Enable', 'on');
    set(handles.cb_standby, 'Enable', 'on');
else
    set(handles.ed_durchdringung, 'Enable', 'off');
    set(handles.ed_waschmaschine, 'Enable', 'off');
    set(handles.ed_waeschetrockner, 'Enable', 'off');
    set(handles.ed_geschirr, 'Enable', 'off');
    set(handles.ed_warmwasser, 'Enable', 'off');
    set(handles.ed_heizung, 'Enable', 'off');
    set(handles.ed_licht, 'Enable', 'off');
    set(handles.cb_standby, 'Enable', 'off');
end

%==========================================================================
% Penentration - Durchdringung (%) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_durchdringung_Callback(hObject, eventdata, handles)
% hObject    handle to ed_durchdringung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_durchdringung as text
%        str2double(get(hObject,'String')) returns contents of ed_durchdringung as a double


% --- Executes during object creation, after setting all properties.
function ed_durchdringung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_durchdringung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Efficiency Improvement - Effizienz Steigung (%) %%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% Waschmaschine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_waschmaschine_Callback(hObject, eventdata, handles)
% hObject    handle to ed_waschmaschine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_waschmaschine as text
%        str2double(get(hObject,'String')) returns contents of ed_waschmaschine as a double


% --- Executes during object creation, after setting all properties.
function ed_waschmaschine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_waschmaschine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Wäschetrokner %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_waeschetrockner_Callback(hObject, eventdata, handles)
% hObject    handle to ed_waeschetrockner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_waeschetrockner as text
%        str2double(get(hObject,'String')) returns contents of ed_waeschetrockner as a double


% --- Executes during object creation, after setting all properties.
function ed_waeschetrockner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_waeschetrockner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Geschirrspülere %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_geschirr_Callback(hObject, eventdata, handles)
% hObject    handle to ed_geschirr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_geschirr as text
%        str2double(get(hObject,'String')) returns contents of ed_geschirr as a double


% --- Executes during object creation, after setting all properties.
function ed_geschirr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_geschirr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Warmwassererzeugung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_warmwasser_Callback(hObject, eventdata, handles)
% hObject    handle to ed_warmwasser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_warmwasser as text
%        str2double(get(hObject,'String')) returns contents of ed_warmwasser as a double


% --- Executes during object creation, after setting all properties.
function ed_warmwasser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_warmwasser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Elektroheizung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_heizung_Callback(hObject, eventdata, handles)
% hObject    handle to ed_heizung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_heizung as text
%        str2double(get(hObject,'String')) returns contents of ed_heizung as a double


% --- Executes during object creation, after setting all properties.
function ed_heizung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_heizung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Wohnbeleuchtung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ed_licht_Callback(hObject, eventdata, handles)
% hObject    handle to ed_licht (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_licht as text
%        str2double(get(hObject,'String')) returns contents of ed_licht as a double


% --- Executes during object creation, after setting all properties.
function ed_licht_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_licht (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Reduce Standby - Sparen Mode in verbrauchoptimal %%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in cb_standby.
function cb_standby_Callback(hObject, eventdata, handles)
% hObject    handle to cb_standby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_standby

%==========================================================================
% Default Consumption Optimization - Default in verbrauchoptimal %%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_default.
function pb_default_Callback(hObject, eventdata, handles)
% hObject    handle to pb_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ed_waschmaschine, 'String', '100');
set(handles.ed_waeschetrockner, 'String', '100');
set(handles.ed_geschirr, 'String', '100');
set(handles.ed_warmwasser, 'String', '100');
set(handles.ed_licht, 'String', '100');
set(handles.ed_heizung, 'String', '100');
set(handles.cb_standby, 'Value', 0);
% Update handles structure
guidata(hObject, handles);

%==========================================================================
% Save and Close - Save & Close in verbrauchoptimal %%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_close.
function pb_close_Callback(hObject, eventdata, handles)
% hObject    handle to pb_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.maindata.struct_eff.active=get(handles.cb_active, 'Value');
handles.maindata.struct_eff.durchdringung=get(handles.ed_durchdringung, 'String');
handles.maindata.struct_eff.waschmaschine=get(handles.ed_waschmaschine, 'String');
handles.maindata.struct_eff.waeschetrockner=get(handles.ed_waeschetrockner, 'String');
handles.maindata.struct_eff.geschirr=get(handles.ed_geschirr, 'String');
handles.maindata.struct_eff.warmwasser=get(handles.ed_warmwasser, 'String');
handles.maindata.struct_eff.licht=get(handles.ed_licht, 'String');
handles.maindata.struct_eff.heizung=get(handles.ed_heizung, 'String');
handles.maindata.struct_eff.standby=get(handles.cb_standby, 'Value');
guidata(hObject, handles);
uiresume();
%==========================================================================
%==========================================================================