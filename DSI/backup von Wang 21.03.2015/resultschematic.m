%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record of revisions:                                                    % 
%     Date           Programmer     Decription of change                  %
%     ==========     ==========     ====================                  %
%     19.02.2015     Han Rui        Original code                         %
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

% Last Modified by GUIDE v2.5 19-Feb-2015 21:07:09

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

xlabel('Zeit (1/4h)');
ylabel('Leistung (W)');

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
% File Name %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
function ed_filename_Callback(hObject, eventdata, handles)
% hObject    handle to ed_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_filename as text
%        str2double(get(hObject,'String')) returns contents of ed_filename as a double
handles.result_file=get(handles.ed_filename, 'String');
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ed_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Result Path %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================

% --- Executes on button press in pb_path.
function pb_path_Callback(hObject, eventdata, handles)
% hObject    handle to pb_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.result_path= uigetdir;
set(handles.path_result, 'String',handles.result_path);
% Update handles structure
guidata(hObject, handles);

function path_result_Callback(hObject, eventdata, handles)
% hObject    handle to path_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path_result as text
%        str2double(get(hObject,'String')) returns contents of path_result as a double
dos('C:\Users\wang\Desktop\Arbeit\sincal.vbs');


% --- Executes during object creation, after setting all properties.
function path_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Sincal Path %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================

% --- Executes on button press in pb_sincal_path.
function pb_sincal_path_Callback(hObject, eventdata, handles)
% hObject    handle to pb_sincal_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.sincal_file, handles.sincal_path] = uigetfile('*.mdb','Select the Sincal database');
set(handles.ed_sincal, 'String',[handles.sincal_path, handles.sincal_file]);
% Update handles structure
guidata(hObject, handles);


function ed_sincal_Callback(hObject, eventdata, handles)
% hObject    handle to ed_sincal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_sincal as text
%        str2double(get(hObject,'String')) returns contents of ed_sincal as a double


% --- Executes during object creation, after setting all properties.
function ed_sincal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_sincal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%==========================================================================
% Caculation with Sincal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_cal_with_sincal.
function pb_cal_with_sincal_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cal_with_sincal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dos('sincal.vbs');

%==========================================================================
% Analyse the Results of Sincal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_analyse.
function pb_analyse_Callback(hObject, eventdata, handles)
% hObject    handle to pb_analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.result_file, handles.result_path] = uigetfile('*.xls','Select the Excel-File');

result_i_normal=xlsread([handles.result_path,'\', handles.result_file], 'I Normal');
result_i_normal( : , 1)=[];
result_u_normal=xlsread([handles.result_path,'\', handles.result_file], 'U Normal');
result_u_normal( : , 1)=[];
result_s_normal=xlsread([handles.result_path,'\', handles.result_file], 'S Normal');
result_s_normal( : , 1)=[];
result_pv_normal=xlsread([handles.result_path,'\', handles.result_file], 'PV Normal');
result_pv_normal( : , 1)=[];

result_i_ps=xlsread([handles.result_path,'\', handles.result_file], 'I Price Signal');
result_i_ps( : , 1)=[];
result_u_ps=xlsread([handles.result_path,'\', handles.result_file], 'U Price Signal');
result_u_ps( : , 1)=[];
result_s_ps=xlsread([handles.result_path,'\', handles.result_file], 'S Price Signal');
result_s_ps( : , 1)=[];
result_pv_ps=xlsread([handles.result_path,'\', handles.result_file], 'PV Price Signal');
result_pv_ps( : , 1)=[];

result_i_dlc=xlsread([handles.result_path,'\', handles.result_file], 'I Direct Load Control');
result_i_dlc( : , 1)=[];
result_u_dlc=xlsread([handles.result_path,'\', handles.result_file], 'U Direct Load Control');
result_u_dlc( : , 1)=[];
result_s_dlc=xlsread([handles.result_path,'\', handles.result_file], 'S Direct Load Control');
result_s_dlc( : , 1)=[];
result_pv_dlc=xlsread([handles.result_path,'\', handles.result_file], 'PV Direct Load Control');
result_pv_dlc( : , 1)=[];

result_i_rtp=xlsread([handles.result_path,'\', handles.result_file], 'I Real Time Pricing');
result_i_rtp( : , 1)=[];
result_u_rtp=xlsread([handles.result_path,'\', handles.result_file], 'U Real Time Pricing');
result_u_rtp( : , 1)=[];
result_s_rtp=xlsread([handles.result_path,'\', handles.result_file], 'S Real Time Pricing');
result_s_rtp( : , 1)=[];
result_pv_rtp=xlsread([handles.result_path,'\', handles.result_file], 'PV Real Time Pricing');
result_pv_rtp( : , 1)=[];

number_overload_i_normal=[];
number_overload_u_normal=[];
number_overload_s_normal=[];
number_overload_i_ps=[];
number_overload_u_ps=[];
number_overload_s_ps=[];
number_overload_i_dlc=[];
number_overload_u_dlc=[];
number_overload_s_dlc=[];
number_overload_i_rtp=[];
number_overload_u_rtp=[];
number_overload_s_rtp=[];

number_note=size(result_u_normal,2);
number_line=size(result_i_normal,2);
number_trafo=size(result_s_normal,2);
number_pv=size(result_pv_normal,2);

for i = 1:number_note
    number_overload_u_normal=[number_overload_u_normal, numel(find(result_u_normal(:, i)>110 | result_u_normal(:, i)<90))];
    number_overload_u_ps=[number_overload_u_ps, numel(find(result_u_ps(:, i)>110 | result_u_ps(:, i)<90))];
    number_overload_u_rtp=[number_overload_u_rtp, numel(find(result_u_rtp(:, i)>110 | result_u_rtp(:, i)<90))];
    number_overload_u_dlc=[number_overload_u_dlc, numel(find(result_u_dlc(:, i)>110 | result_u_dlc(:, i)<90))];
end

for i = 1:number_trafo
    number_overload_s_normal=[number_overload_s_normal, numel(find(result_s_normal(:, i)>120))];
    number_overload_s_ps=[number_overload_s_ps, numel(find(result_s_ps(:, i)>120))];
    number_overload_s_rtp=[number_overload_s_rtp, numel(find(result_s_rtp(:, i)>120))];
    number_overload_s_dlc=[number_overload_s_dlc, numel(find(result_s_dlc(:, i)>120))];
end

for i = 1:number_line
    number_overload_i_normal=[number_overload_i_normal, numel(find(result_i_normal(:, i)>100))];
    number_overload_i_ps=[number_overload_i_ps, numel(find(result_i_ps(:, i)>100))];
    number_overload_i_rtp=[number_overload_i_rtp, numel(find(result_i_rtp(:, i)>100))];
    number_overload_i_dlc=[number_overload_i_dlc, numel(find(result_i_dlc(:, i)>100))];
end

ort_overload_i_normal=zeros(size(result_i_normal));
ort_overload_u_normal=zeros(size(result_u_normal));
ort_overload_i_ps=zeros(size(result_i_ps));
ort_overload_u_ps=zeros(size(result_u_ps));
ort_overload_i_dlc=zeros(size(result_i_dlc));
ort_overload_u_dlc=zeros(size(result_u_dlc));
ort_overload_i_rtp=zeros(size(result_i_rtp));
ort_overload_u_rtp=zeros(size(result_u_rtp));
ort_overload_i_normal(find(result_i_normal)>0)=1;
ort_overload_u_normal(find(result_u_normal)>0)=1;
ort_overload_i_ps(find(result_i_ps)>0)=1;
ort_overload_u_ps(find(result_u_ps)>0)=1;
ort_overload_i_dlc(find(result_i_dlc)>0)=1;
ort_overload_u_dlc(find(result_u_dlc)>0)=1;
ort_overload_i_rtp(find(result_i_rtp)>0)=1;
ort_overload_u_rtp(find(result_i_rtp)>0)=1;
ort_overload_i_normal=sum(ort_overload_i_normal,2);
ort_overload_u_normal=sum(ort_overload_u_normal,2);
ort_overload_i_ps=sum(ort_overload_i_ps,2);
ort_overload_u_ps=sum(ort_overload_u_ps,2);
ort_overload_i_dlc=sum(ort_overload_i_dlc,2);
ort_overload_u_dlc=sum(ort_overload_u_dlc,2);
ort_overload_i_rtp=sum(ort_overload_i_rtp,2);
ort_overload_u_rtp=sum(ort_overload_u_rtp,2);
ort_overload_i_normal(ort_overload_i_normal==0)=[];
ort_overload_u_normal(ort_overload_u_normal==0)=[];
ort_overload_i_ps(ort_overload_i_ps==0)=[];
ort_overload_u_ps(ort_overload_u_ps==0)=[];
ort_overload_i_dlc(ort_overload_i_dlc==0)=[];
ort_overload_u_dlc(ort_overload_u_dlc==0)=[];
ort_overload_i_rtp(ort_overload_i_rtp==0)=[];
ort_overload_u_rtp(ort_overload_u_rtp==0)=[];
darstellung(1,1)=numel(ort_overload_i_normal);
darstellung(1,2)=numel(ort_overload_i_ps);
darstellung(1,3)=numel(ort_overload_i_rtp);
darstellung(1,4)=numel(ort_overload_i_dlc);
darstellung(2,1)=sum(ort_overload_i_normal)/numel(ort_overload_i_normal);
darstellung(2,2)=sum(ort_overload_i_ps)/numel(ort_overload_i_ps);
darstellung(2,3)=sum(ort_overload_i_rtp)/numel(ort_overload_i_rtp);
darstellung(2,4)=sum(ort_overload_i_dlc)/numel(ort_overload_i_dlc);


number_overload_u=[number_overload_u_normal; number_overload_u_ps; number_overload_u_rtp; number_overload_u_dlc]/4;
number_overload_s=[number_overload_s_normal; number_overload_s_ps; number_overload_s_rtp; number_overload_s_dlc]/4;
number_overload_i=[number_overload_i_normal; number_overload_i_ps; number_overload_i_rtp; number_overload_i_dlc]/4;

msgbox('Analyse is completed, The result is saved in Sheet "Zusammenfassung".','Message');

%==========================================================================
% Save in a new Excel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save.
function pb_save_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% for i=1:6
%     signal_normal(:,i)=sum(handles.signal_normal(:,48*(i-1)+1:48*i),2);
%     signal_normal_blind(:,i)=sum(handles.signal_normal_blind(:,48*(i-1)+1:48*i),2);
%     solar(:,i)=sum(handles.solar(:,48*(i-1)+1:48*i),2);
%     cosphi(:,i)=sum(handles.cosphi(:,48*(i-1)+1:48*i),2);
%     signal_ps(:,i)=sum(handles.signal_ps(:,48*(i-1)+1:48*i),2);
%     signal_ps_blind(:,i)=sum(handles.signal_ps_blind(:,48*(i-1)+1:48*i),2);
%     signal_dlc(:,i)=sum(handles.signal_dlc(:,48*(i-1)+1:48*i),2);
%     signal_dlc_blind(:,i)=sum(handles.signal_dlc_blind(:,48*(i-1)+1:48*i),2);
%     signal_rtp(:,i)=sum(handles.signal_rtp(:,48*(i-1)+1:48*i),2);
%     signal_rtp_blind(:,i)=sum(handles.signal_rtp_blind(:,48*(i-1)+1:48*i),2);
% end
% 
%     handles.signal_normal=signal_normal;
%     handles.signal_normal_blind=signal_normal_blind;
%     handles.solar=solar;
%     handles.cosphi=cosphi;
%     handles.signal_ps=signal_ps;
%     handles.signal_ps_blind=signal_ps_blind;
%     handles.signal_dlc=signal_dlc;
%     handles.signal_dlc_blind=signal_dlc_blind;
%     handles.signal_rtp=signal_rtp;
%     handles.signal_rtp_blind=signal_rtp_blind;

if isfield(handles, 'result_file')==0 
    msgbox('Please write a filename for the excel','Message','error');
else
    if isfield(handles, 'result_path')==0  
        msgbox('Please select a path for the excel','Message','error');
    else
        if isfield(handles, 'sincal_path')==0  
            msgbox('Please select a Sincal database','Message','error');
        else            
            copyfile('muster.xls', [handles.result_path,'\', handles.result_file,'.xls'], 'f');
            xlswrite([handles.result_path,'\', handles.result_file], {[handles.sincal_path, handles.sincal_file ]}, 'Sincal Database', 'A1');
            
            %Information
            info={['Der Verbrauch beträgt c.a ', num2str((sum(handles.lastprofil)+sum(sum(handles.solar)))/4000), 'kWh.'];
                ['Die Einspeisung beträgt c.a ', num2str(sum(sum(handles.solar))/4000), 'kWh.'];
                ['Die Spitzelast beträgt c.a ', num2str(max(sum(handles.signal_normal,2))/1000), 'kW.'];
                ['Die Spitzelast mit TOU beträgt c.a ', num2str(max(sum(handles.signal_ps,2))/1000), 'kW.'];
                ['Die Spitzelast mit RTP beträgt c.a ', num2str(max(sum(handles.signal_rtp,2))/1000), 'kW.'];
                ['Die Spitzelast mit DLC beträgt c.a ', num2str(max(sum(handles.signal_dlc,2))/1000), 'kW.'];
                ['Die Spitze der Einspeisung beträgt c.a ', num2str(max(sum(handles.solar,2))/1000), 'kW.']};
            xlswrite([handles.result_path,'\', handles.result_file], info, 'Infomation', 'A1');
            
            if isfield(handles, 'excel_normal') && handles.excel_normal==1
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_normal, 'Normal', 'A2');    
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_normal_blind, 'Q Normal', 'A2'); 
            end
            
            if isfield(handles, 'excel_solar') && handles.excel_solar==1
                xlswrite([handles.result_path,'\', handles.result_file], handles.solar, 'Solar', 'A2');  
                xlswrite([handles.result_path,'\', handles.result_file], handles.cosphi, 'cosphi', 'A2');
            end

            if isfield(handles, 'excel_ps') && handles.excel_ps==1
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_ps, 'Price Signal', 'A2'); 
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_ps_blind, 'Q Price Signal', 'A2'); 
            end

            if isfield(handles, 'excel_dlc') && handles.excel_dlc==1
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_dlc, 'Direct Load Control', 'A2');  
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_dlc_blind, 'Q Direct Load Control', 'A2'); 
            end
                   
            if isfield(handles, 'excel_rtp') && handles.excel_rtp==1
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_rtp, 'Real Time Pricing', 'A2');   
                xlswrite([handles.result_path,'\', handles.result_file], handles.signal_rtp_blind, 'Q Real Time Pricing', 'A2'); 
            end
            
            msgbox('Save is completed','Message');
        end
    end
end

%==========================================================================
% Save the sum in a new Excel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save_new_sum.
function pb_save_new_sum_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save_new_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'result_file')==0 
    msgbox('Please write a filename for the excel','Message','error');
else
    if isfield(handles, 'result_path')==0  
        msgbox('Please select a path for the excel','Message','error');
    else
        if isfield(handles, 'sincal_path')==0  
            msgbox('Please select a Sincal database','Message','error');
        else            
            copyfile('muster.xls', [handles.result_path,'\', handles.result_file,'.xls'], 'f');
            xlswrite([handles.result_path,'\', handles.result_file], {[handles.sincal_path, handles.sincal_file ]}, 'Sincal Database', 'A1');

            if isfield(handles, 'excel_normal') && handles.excel_normal==1
                xlswrite([handles.result_path,'\', handles.result_file], round(sum(handles.signal_normal,2)), 'Normal', 'A2');
            end
            
            if isfield(handles, 'excel_solar') && handles.excel_solar==1
                xlswrite([handles.result_path,'\', handles.result_file], round(sum(handles.solar,2)), 'Solar', 'A2');
            end

            if isfield(handles, 'excel_ps') && handles.excel_ps==1
                xlswrite([handles.result_path,'\', handles.result_file], round(sum(handles.signal_ps,2)), 'Price Signal', 'A2');
            end

            if isfield(handles, 'excel_dlc') && handles.excel_dlc==1
                xlswrite([handles.result_path,'\', handles.result_file], round(sum(handles.signal_dlc,2)), 'Direct Load Control', 'A2');
            end
            
            if isfield(handles, 'excel_rtp') && handles.excel_rtp==1
                xlswrite([handles.result_path,'\', handles.result_file], round(sum(handles.signal_rtp,2)), 'Real Time Pricing', 'A2');
            end
            msgbox('Save is completed','Message');
        end
    end
end

%==========================================================================
% Save in an old Excel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save_old.
function pb_save_old_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.result_file, handles.result_path] = uigetfile('*.xls','Select the Excel-File');

if isfield(handles, 'excel_normal') && handles.excel_normal==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Normal');
    result=[result round(handles.signal_normal)];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Normal', 'A2');
end

if isfield(handles, 'excel_solar') && handles.excel_solar==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Solar');
    result=[result round(handles.solar)];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Solar', 'A2');
end

if isfield(handles, 'excel_ps') && handles.excel_ps==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Price Signal');
    result=[result round(handles.signal_ps)];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Price Signal', 'A2');
end

if isfield(handles, 'excel_dlc') && handles.excel_dlc==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Direct Load Control');
    result=[result round(handles.signal_dlc)];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Direct Load Control', 'A2');
end

if isfield(handles, 'excel_dlc') && handles.excel_dlc==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Real Time Pricing');
    result=[result round(handles.signal_rtp)];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Real Time Pricing', 'A2');
end

msgbox('Save is completed','Message');

%==========================================================================
% Save the sum in an old Excel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% --- Executes on button press in pb_save_old_sum.
function pb_save_old_sum_Callback(hObject, eventdata, handles)
% hObject    handle to pb_save_old_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.result_file, handles.result_path] = uigetfile('*.xls','Select the Excel-File');

if isfield(handles, 'excel_normal') && handles.excel_normal==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Normal');
    result=[result round(sum(handles.signal_normal,2))];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Normal', 'A2');
end

if isfield(handles, 'excel_solar') && handles.excel_solar==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Solar');
    result=[result round(sum(handles.solar,2))];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Solar', 'A2');
end

if isfield(handles, 'excel_ps') && handles.excel_ps==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Price Signal');
    result=[result round(sum(handles.signal_ps,2))];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Price Signal', 'A2');
end

if isfield(handles, 'excel_dlc') && handles.excel_dlc==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Direct Load Control');
    result=[result round(sum(handles.signal_dlc,2))];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Direct Load Control', 'A2');
end

if isfield(handles, 'excel_rtp') && handles.excel_rtp==1
    result=xlsread([handles.result_path,'\', handles.result_file], 'Real Time Pricing');
    result=[result round(sum(handles.signal_rtp,2))];
    xlswrite([handles.result_path,'\', handles.result_file], result, 'Real Time Pricing', 'A2');
end
msgbox('Save is completed','Message');

%==========================================================================
%==========================================================================
