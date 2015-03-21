%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% haushaltsgeaete %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function varargout = haushaltsgeraete(varargin)
% HAUSHALTSGERAETE MATLAB code for haushaltsgeraete.fig
%      HAUSHALTSGERAETE, by itself, creates a new HAUSHALTSGERAETE or raises the existing
%      singleton*.
%
%      H = HAUSHALTSGERAETE returns the handle to a new HAUSHALTSGERAETE or the handle to
%      the existing singleton*.
%
%      HAUSHALTSGERAETE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HAUSHALTSGERAETE.M with the given input arguments.
%
%      HAUSHALTSGERAETE('Property','Value',...) creates a new HAUSHALTSGERAETE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before haushaltsgeraete_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to haushaltsgeraete_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help haushaltsgeraete

% Last Modified by GUIDE v2.5 19-Feb-2015 14:52:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @haushaltsgeraete_OpeningFcn, ...
                   'gui_OutputFcn',  @haushaltsgeraete_OutputFcn, ...
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
% haushaltsgeraete Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before haushaltsgeraete is made visible.
function haushaltsgeraete_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to haushaltsgeraete (see VARARGIN)

% Choose default command line output for haushaltsgeraete
handles.output = hObject;

handles.maindata=varargin{1};

if isfield(handles.maindata, 'struct_sgd') && isfield(handles.maindata.struct_sgd, 'waschmaschine')
    set(handles.ed_waschmaschine, 'String',  handles.maindata.struct_sgd.waschmaschine);
    set(handles.ed_trockner, 'String', handles.maindata.struct_sgd.waeschetrockner);
    set(handles.ed_geschirr, 'String', handles.maindata.struct_sgd.geschirr);
    set(handles.ed_warmwasser, 'String', handles.maindata.struct_sgd.warmwasser);
    set(handles.ed_warmwasserspeicher, 'String', handles.maindata.struct_sgd.warmwasserspeicher);
    set(handles.ed_heizung, 'String', handles.maindata.struct_sgd.heizung);
    set(handles.ed_heatingpump, 'String', handles.maindata.struct_sgd.heatingpump);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes haushaltsgeraete wait for user response (see UIRESUME)
uiwait(handles.figure1);

%==========================================================================
% haushaltsgeraete Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = haushaltsgeraete_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.maindata;

close();

%==========================================================================
% Wash Machine - Waschmaschine(%) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
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

%==========================================================================
% Wash Dryer - Wäschetrockner(%) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_trockner_Callback(hObject, eventdata, handles)
% hObject    handle to ed_trockner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_trockner as text
%        str2double(get(hObject,'String')) returns contents of ed_trockner as a double


% --- Executes during object creation, after setting all properties.
function ed_trockner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_trockner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Dish Washer - Geschirrspüler(%) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
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

%==========================================================================
% Warm Water Generation - Wärmewassererzeugung(%) %%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
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

%==========================================================================
% Warm Water Storage - davon Wärmewasserspeicher(%) %%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_warmwasserspeicher_Callback(hObject, eventdata, handles)
% hObject    handle to ed_warmwasserspeicher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_warmwasserspeicher as text
%        str2double(get(hObject,'String')) returns contents of ed_warmwasserspeicher as a double


% --- Executes during object creation, after setting all properties.
function ed_warmwasserspeicher_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_warmwasserspeicher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Night Storage Heating - Nachtspeicherheizung(%) %%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
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

%==========================================================================
% Heat Pump with Buffer - Wärmepumpe mit Pufferspeicher(%) %%%%%%%%%%%%%%%%
%==========================================================================
function ed_heatingpump_Callback(hObject, eventdata, handles)
% hObject    handle to ed_heatingpump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_heatingpump as text
%        str2double(get(hObject,'String')) returns contents of ed_heatingpump as a double


% --- Executes during object creation, after setting all properties.
function ed_heatingpump_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_heatingpump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Warm Water - Warmwasserbereitung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on selection change in type_warmwasser.
function type_warmwasser_Callback(hObject, eventdata, handles)
% hObject    handle to type_warmwasser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns type_warmwasser contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_warmwasser


% --- Executes during object creation, after setting all properties.
function type_warmwasser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_warmwasser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% House Appliances Default - Default in haushaltsgeraete %%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_default.
function pb_default_Callback(hObject, eventdata, handles)
% hObject    handle to pb_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ed_waschmaschine, 'String', '100');
set(handles.ed_trockner, 'String', '40');
set(handles.ed_geschirr, 'String', '65');
set(handles.ed_warmwasser, 'String', '21');
set(handles.ed_warmwasserspeicher, 'String', '10');
set(handles.ed_heizung, 'String', '1');
set(handles.ed_heatingpump, 'String', '1');
set(handles.type_warmwasser, 'Value', 1);
% Update handles structure
guidata(hObject, handles);

%==========================================================================
% Save and Close - Sve & Close in haushaltsgeraete %%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.maindata.struct_sgd.waschmaschine=get(handles.ed_waschmaschine, 'String');
handles.maindata.struct_sgd.waeschetrockner=get(handles.ed_trockner, 'String');
handles.maindata.struct_sgd.geschirr=get(handles.ed_geschirr, 'String');
handles.maindata.struct_sgd.warmwasser=get(handles.ed_warmwasser, 'String');
handles.maindata.struct_sgd.warmwasserspeicher=get(handles.ed_warmwasserspeicher, 'String');
handles.maindata.struct_sgd.heizung=get(handles.ed_heizung, 'String');
handles.maindata.struct_sgd.heatingpump=get(handles.ed_heatingpump, 'String');
list=get(handles.type_warmwasser, 'String');
handles.maindata.struct_sgd.warmwasser_type=list{get(handles.type_warmwasser, 'Value')};
guidata(hObject, handles);
uiresume();

%==========================================================================
%==========================================================================