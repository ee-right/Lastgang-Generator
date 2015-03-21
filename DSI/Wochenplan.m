%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Wochenplan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function varargout = Wochenplan(varargin)
% WOCHENPLAN MATLAB code for Wochenplan.fig
%      WOCHENPLAN, by itself, creates a new WOCHENPLAN or raises the existing
%      singleton*.
%
%      H = WOCHENPLAN returns the handle to a new WOCHENPLAN or the handle to
%      the existing singleton*.
%
%      WOCHENPLAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WOCHENPLAN.M with the given input arguments.
%
%      WOCHENPLAN('Property','Value',...) creates a new WOCHENPLAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Wochenplan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Wochenplan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Wochenplan

% Last Modified by GUIDE v2.5 19-Feb-2015 13:52:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Wochenplan_OpeningFcn, ...
                   'gui_OutputFcn',  @Wochenplan_OutputFcn, ...
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
% Wochenplan Opening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes just before Wochenplan is made visible.
function Wochenplan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Wochenplan (see VARARGIN)

% Choose default command line output for Wochenplan
handles.output = hObject;

handles.maindata=varargin{1};

if isfield(handles.maindata, 'struct_sgd') && isfield(handles.maindata.struct_sgd, 'winter_werktag_cost_1_min')
    set(handles.sommer_werktag_cost_1_min, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_1_min);
    set(handles.sommer_werktag_cost_1_max, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_1_max);
    set(handles.sommer_werktag_cost_2_min, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_2_min);
    set(handles.sommer_werktag_cost_2_max, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_2_max);
    set(handles.sommer_werktag_cost_3_min, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_3_min);
    set(handles.sommer_werktag_cost_3_max, 'Value',  handles.maindata.struct_sgd.sommer_werktag_cost_3_max);
    set(handles.sommer_wochenende_cost_1_min, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_1_min);
    set(handles.sommer_wochenende_cost_1_max, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_1_max);
    set(handles.sommer_wochenende_cost_2_min, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_2_min);
    set(handles.sommer_wochenende_cost_2_max, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_2_max);
    set(handles.sommer_wochenende_cost_3_min, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_3_min);
    set(handles.sommer_wochenende_cost_3_max, 'Value',  handles.maindata.struct_sgd.sommer_wochenende_cost_3_max);
    set(handles.winter_werktag_cost_1_min, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_1_min);
    set(handles.winter_werktag_cost_1_max, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_1_max);
    set(handles.winter_werktag_cost_2_min, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_2_min);
    set(handles.winter_werktag_cost_2_max, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_2_max);
    set(handles.winter_werktag_cost_3_min, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_3_min);
    set(handles.winter_werktag_cost_3_max, 'Value',  handles.maindata.struct_sgd.winter_werktag_cost_3_max);
    set(handles.winter_wochenende_cost_1_min, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_1_min);
    set(handles.winter_wochenende_cost_1_max, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_1_max);
    set(handles.winter_wochenende_cost_2_min, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_2_min);
    set(handles.winter_wochenende_cost_2_max, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_2_max);
    set(handles.winter_wochenende_cost_3_min, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_3_min);
    set(handles.winter_wochenende_cost_3_max, 'Value',  handles.maindata.struct_sgd.winter_wochenende_cost_3_max);    
    set(handles.cb_normal, 'Value', handles.maindata.struct_sgd.active_normal);
    set(handles.cb_ps, 'Value', handles.maindata.struct_sgd.active_ps);
    set(handles.cb_dlc, 'Value', handles.maindata.struct_sgd.active_dlc);
    set(handles.cb_rtp, 'Value', handles.maindata.struct_sgd.active_rtp);
    set(handles.ed_dlc_durchdringung, 'String',  handles.maindata.struct_sgd.dlc_durchdringung);
else
    set(handles.sommer_werktag_cost_1_min, 'Value', 97);
    set(handles.sommer_werktag_cost_1_max, 'Value', 97);
    set(handles.sommer_werktag_cost_2_min, 'Value', 97);
    set(handles.sommer_werktag_cost_2_max, 'Value', 97);
    set(handles.sommer_werktag_cost_3_min, 'Value', 97);
    set(handles.sommer_werktag_cost_3_max, 'Value', 97);
    set(handles.sommer_wochenende_cost_1_min, 'Value', 97);
    set(handles.sommer_wochenende_cost_1_max, 'Value', 97);
    set(handles.sommer_wochenende_cost_2_min, 'Value', 97);
    set(handles.sommer_wochenende_cost_2_max, 'Value', 97);
    set(handles.sommer_wochenende_cost_3_min, 'Value', 97);
    set(handles.sommer_wochenende_cost_3_max, 'Value', 97);
    set(handles.winter_werktag_cost_1_min, 'Value', 97);
    set(handles.winter_werktag_cost_1_max, 'Value', 97);
    set(handles.winter_werktag_cost_2_min, 'Value', 97);
    set(handles.winter_werktag_cost_2_max, 'Value', 97);
    set(handles.winter_werktag_cost_3_min, 'Value', 97);
    set(handles.winter_werktag_cost_3_max, 'Value', 97);
    set(handles.winter_wochenende_cost_1_min, 'Value',  97);
    set(handles.winter_wochenende_cost_1_max, 'Value',  97);
    set(handles.winter_wochenende_cost_2_min, 'Value',  97);
    set(handles.winter_wochenende_cost_2_max, 'Value',  97);
    set(handles.winter_wochenende_cost_3_min, 'Value',  97);
    set(handles.winter_wochenende_cost_3_max, 'Value',  97);        
    set(handles.ed_dlc_durchdringung, 'String', '0');
    set(handles.cb_normal, 'Value', 0);
    set(handles.cb_ps, 'Value', 0);
    set(handles.cb_dlc, 'Value', 0);
    set(handles.cb_rtp, 'Value', 0);
end

% Update handles structure
guidata(hObject, handles);

uiwait();


% UIWAIT makes Wochenplan wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%==========================================================================
% Wochenplan Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Outputs from this function are returned to the command line.
function varargout = Wochenplan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.maindata.struct_sgd.sommer_werktag_cost_1_min=get(handles.sommer_werktag_cost_1_min, 'Value');
handles.maindata.struct_sgd.sommer_werktag_cost_1_max=get(handles.sommer_werktag_cost_1_max, 'Value');
handles.maindata.struct_sgd.sommer_werktag_cost_2_min=get(handles.sommer_werktag_cost_2_min, 'Value');
handles.maindata.struct_sgd.sommer_werktag_cost_2_max=get(handles.sommer_werktag_cost_2_max, 'Value');
handles.maindata.struct_sgd.sommer_werktag_cost_3_min=get(handles.sommer_werktag_cost_3_min, 'Value');
handles.maindata.struct_sgd.sommer_werktag_cost_3_max=get(handles.sommer_werktag_cost_3_max, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_1_min=get(handles.sommer_wochenende_cost_1_min, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_1_max=get(handles.sommer_wochenende_cost_1_max, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_2_min=get(handles.sommer_wochenende_cost_2_min, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_2_max=get(handles.sommer_wochenende_cost_2_max, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_3_min=get(handles.sommer_wochenende_cost_3_min, 'Value');
handles.maindata.struct_sgd.sommer_wochenende_cost_3_max=get(handles.sommer_wochenende_cost_3_max, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_1_min=get(handles.winter_werktag_cost_1_min, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_1_max=get(handles.winter_werktag_cost_1_max, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_2_min=get(handles.winter_werktag_cost_2_min, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_2_max=get(handles.winter_werktag_cost_2_max, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_3_min=get(handles.winter_werktag_cost_3_min, 'Value');
handles.maindata.struct_sgd.winter_werktag_cost_3_max=get(handles.winter_werktag_cost_3_max, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_1_min=get(handles.winter_wochenende_cost_1_min, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_1_max=get(handles.winter_wochenende_cost_1_max, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_2_min=get(handles.winter_wochenende_cost_2_min, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_2_max=get(handles.winter_wochenende_cost_2_max, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_3_min=get(handles.winter_wochenende_cost_3_min, 'Value');
handles.maindata.struct_sgd.winter_wochenende_cost_3_max=get(handles.winter_wochenende_cost_3_max, 'Value');
handles.maindata.struct_sgd.active_normal=get(handles.cb_normal, 'Value');
handles.maindata.struct_sgd.active_ps=get(handles.cb_ps, 'Value');
handles.maindata.struct_sgd.active_dlc=get(handles.cb_dlc, 'Value');
handles.maindata.struct_sgd.active_rtp=get(handles.cb_rtp, 'Value');
handles.maindata.struct_sgd.dlc_durchdringung=get(handles.ed_dlc_durchdringung, 'String');

varargout{1} = handles.maindata;
close();

%==========================================================================
% Price Signal for Sommer Work Day %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on selection change in sommer_werktag_cost_1_min.
function sommer_werktag_cost_1_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_1_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_1_min


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_1_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_werktag_cost_2_min.
function sommer_werktag_cost_2_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_2_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_2_min


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_werktag_cost_3_min.
function sommer_werktag_cost_3_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_3_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_3_min


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_3_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_werktag_cost_1_max.
function sommer_werktag_cost_1_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_1_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_1_max


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_werktag_cost_2_max.
function sommer_werktag_cost_2_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_2_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_2_max


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_werktag_cost_3_max.
function sommer_werktag_cost_3_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_werktag_cost_3_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_werktag_cost_3_max


% --- Executes during object creation, after setting all properties.
function sommer_werktag_cost_3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_werktag_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Price Signal for Sommer Weekend %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on selection change in sommer_wochenende_cost_1_min.
function sommer_wochenende_cost_1_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_1_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_1_min


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_1_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_wochenende_cost_2_min.
function sommer_wochenende_cost_2_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_2_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_2_min


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_wochenende_cost_3_min.
function sommer_wochenende_cost_3_min_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_3_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_3_min


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_3_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_wochenende_cost_1_max.
function sommer_wochenende_cost_1_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_1_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_1_max


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_wochenende_cost_2_max.
function sommer_wochenende_cost_2_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_2_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_2_max


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sommer_wochenende_cost_3_max.
function sommer_wochenende_cost_3_max_Callback(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sommer_wochenende_cost_3_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sommer_wochenende_cost_3_max


% --- Executes during object creation, after setting all properties.
function sommer_wochenende_cost_3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sommer_wochenende_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Price Signal for Winter Work Day %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on selection change in winter_werktag_cost_1_min.
function winter_werktag_cost_1_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_1_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_1_min


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_1_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in winter_werktag_cost_2_min.
function winter_werktag_cost_2_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_2_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_2_min


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in winter_werktag_cost_3_min.
function winter_werktag_cost_3_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_3_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_3_min


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_3_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in winter_werktag_cost_1_max.
function winter_werktag_cost_1_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_1_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_1_max


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in winter_werktag_cost_2_max.
function winter_werktag_cost_2_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_2_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_2_max


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in winter_werktag_cost_3_max.
function winter_werktag_cost_3_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_werktag_cost_3_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_werktag_cost_3_max


% --- Executes during object creation, after setting all properties.
function winter_werktag_cost_3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_werktag_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Price Signal for Winter Weekend %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on selection change in winter_wochenende_cost_1_min.
function winter_wochenende_cost_1_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_1_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_1_min


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_1_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in winter_wochenende_cost_2_min.
function winter_wochenende_cost_2_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_2_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_2_min


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_2_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in winter_wochenende_cost_3_min.
function winter_wochenende_cost_3_min_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_3_min contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_3_min


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_3_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in winter_wochenende_cost_1_max.
function winter_wochenende_cost_1_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_1_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_1_max


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_1_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_1_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in winter_wochenende_cost_2_max.
function winter_wochenende_cost_2_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_2_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_2_max


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_2_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_2_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in winter_wochenende_cost_3_max.
function winter_wochenende_cost_3_max_Callback(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winter_wochenende_cost_3_max contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winter_wochenende_cost_3_max


% --- Executes during object creation, after setting all properties.
function winter_wochenende_cost_3_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winter_wochenende_cost_3_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Direct Load Control Prozent - Anzahl der Teilnehmer(%) in Wochenplan %%%%
%==========================================================================
function ed_dlc_durchdringung_Callback(hObject, eventdata, handles)
% hObject    handle to ed_dlc_durchdringung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_dlc_durchdringung as text
%        str2double(get(hObject,'String')) returns contents of ed_dlc_durchdringung as a double


% --- Executes during object creation, after setting all properties.
function ed_dlc_durchdringung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_dlc_durchdringung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Demand Side Management Options - Aktivität in Wochenplan %%%%%%%%%%%%%%%%
%==========================================================================
% Normal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_normal.
function cb_normal_Callback(hObject, eventdata, handles)
% hObject    handle to cb_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_normal

% Price-Signals %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_ps.
function cb_ps_Callback(hObject, eventdata, handles)
% hObject    handle to cb_ps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_ps

% Direct Load Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_dlc.
function cb_dlc_Callback(hObject, eventdata, handles)
% hObject    handle to cb_dlc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_dlc

% Real Time Pricing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in cb_rtp.
function cb_rtp_Callback(hObject, eventdata, handles)
% hObject    handle to cb_rtp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_rtp

%==========================================================================
% Default Parameters - Default in Wochenplan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_default.
function pb_default_Callback(hObject, eventdata, handles)
% hObject    handle to pb_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ed_dlc_durchdringung, 'String', '100');
set(handles.sommer_werktag_cost_1_min, 'Value', 1);
set(handles.sommer_werktag_cost_1_max, 'Value', 24);
set(handles.sommer_werktag_cost_2_min, 'Value', 41);
set(handles.sommer_werktag_cost_2_max, 'Value', 68);
set(handles.sommer_werktag_cost_3_min, 'Value', 89);
set(handles.sommer_werktag_cost_3_max, 'Value', 96);
set(handles.sommer_wochenende_cost_1_min, 'Value', 1);
set(handles.sommer_wochenende_cost_1_max, 'Value', 28);
set(handles.sommer_wochenende_cost_2_min, 'Value', 45);
set(handles.sommer_wochenende_cost_2_max, 'Value', 68);
set(handles.sommer_wochenende_cost_3_min, 'Value', 89);
set(handles.sommer_wochenende_cost_3_max, 'Value', 96);
set(handles.winter_werktag_cost_1_min, 'Value', 1);
set(handles.winter_werktag_cost_1_max, 'Value', 48);
set(handles.winter_werktag_cost_2_min, 'Value', 89);
set(handles.winter_werktag_cost_2_max, 'Value', 96);
set(handles.winter_werktag_cost_3_min, 'Value', 97);
set(handles.winter_werktag_cost_3_max, 'Value', 97);
set(handles.winter_wochenende_cost_1_min, 'Value', 1);
set(handles.winter_wochenende_cost_1_max, 'Value', 36);
set(handles.winter_wochenende_cost_2_min, 'Value', 89);
set(handles.winter_wochenende_cost_2_max, 'Value', 96);
set(handles.winter_wochenende_cost_3_min, 'Value', 97);
set(handles.winter_wochenende_cost_3_max, 'Value', 97);
set(handles.cb_normal, 'Value', 1);
set(handles.cb_ps, 'Value', 1);
set(handles.cb_dlc, 'Value', 1);
set(handles.cb_rtp, 'Value', 1);

%==========================================================================
% Save and Close - Save & Close in Wochenplan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
uiresume();

%==========================================================================
%==========================================================================
