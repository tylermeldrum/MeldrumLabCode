function varargout = T2D_DataSim(varargin)
% T2D_DATASIM MATLAB code for T2D_DataSim.fig
%      T2D_DATASIM, by itself, creates a new T2D_DATASIM or raises the existing
%      singleton*.
%
%      H = T2D_DATASIM returns the handle to a new T2D_DATASIM or the handle to
%      the existing singleton*.
%
%      T2D_DATASIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in T2D_DATASIM.M with the given input arguments.
%
%      T2D_DATASIM('Property','Value',...) creates a new T2D_DATASIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before T2D_DataSim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to T2D_DataSim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help T2D_DataSim

% Last Modified by GUIDE v2.5 26-Jul-2017 16:44:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @T2D_DataSim_OpeningFcn, ...
                   'gui_OutputFcn',  @T2D_DataSim_OutputFcn, ...
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


% --- Executes just before T2D_DataSim is made visible.
function T2D_DataSim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to T2D_DataSim (see VARARGIN)

clc

% global RC_on Reg_on AmpA AmpB T1A T1B T2A T2B DA DB delta DELTA tE nEchoes G n SNR;
% Create the data to plot.
handles.peaks=peaks(35);
axes(handles.axes1);
surf(handles.peaks)

% Choose default command line output for T2D_DataSim
handles.output = hObject;


steps = min(15,str2double(get(handles.n, 'string')));
    set(handles.nSteps, 'string', steps);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes T2D_DataSim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = T2D_DataSim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function T1B_Callback(hObject, eventdata, handles)
% hObject    handle to T1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1B as text
%        str2double(get(hObject,'String')) returns contents of T1B as a double


% --- Executes during object creation, after setting all properties.
function T1B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2B_Callback(hObject, eventdata, handles)
% hObject    handle to T2B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2B as text
%        str2double(get(hObject,'String')) returns contents of T2B as a double


% --- Executes during object creation, after setting all properties.
function T2B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DB_Callback(hObject, eventdata, handles)
% hObject    handle to DB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DB as text
%        str2double(get(hObject,'String')) returns contents of DB as a double


% --- Executes during object creation, after setting all properties.
function DB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1A_Callback(hObject, eventdata, handles)
% hObject    handle to T1A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1A as text
%        str2double(get(hObject,'String')) returns contents of T1A as a double


% --- Executes during object creation, after setting all properties.
function T1A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2A_Callback(hObject, eventdata, handles)
% hObject    handle to T2A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2A as text
%        str2double(get(hObject,'String')) returns contents of T2A as a double


% --- Executes during object creation, after setting all properties.
function T2A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DA_Callback(hObject, eventdata, handles)
% hObject    handle to DA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DA as text
%        str2double(get(hObject,'String')) returns contents of DA as a double


% --- Executes during object creation, after setting all properties.
function DA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to AmpB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpB as text
%        str2double(get(hObject,'String')) returns contents of AmpB as a double


% --- Executes during object creation, after setting all properties.
function AmpB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AmpA_Callback(hObject, eventdata, handles)
% hObject    handle to AmpA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AmpA as text
%        str2double(get(hObject,'String')) returns contents of AmpA as a double
   
% Updates the amplitude of component B automatically; sum equals 1
%     data = guidata(hObject);    
    AmpB = 1 - str2double(get(handles.AmpA, 'string'));
    set(handles.AmpB, 'string', AmpB);
%     guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function AmpA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AmpA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DELTA_Callback(hObject, eventdata, handles)
% hObject    handle to DELTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DELTA as text
%        str2double(get(hObject,'String')) returns contents of DELTA as a double


% --- Executes during object creation, after setting all properties.
function DELTA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DELTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tE_Callback(hObject, eventdata, handles)
% hObject    handle to tE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tE as text
%        str2double(get(hObject,'String')) returns contents of tE as a double


% --- Executes during object creation, after setting all properties.
function tE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nEchoes_Callback(hObject, eventdata, handles)
% hObject    handle to nEchoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nEchoes as text
%        str2double(get(hObject,'String')) returns contents of nEchoes as a double


% --- Executes during object creation, after setting all properties.
function nEchoes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nEchoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delta_Callback(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delta as text
%        str2double(get(hObject,'String')) returns contents of delta as a double


% --- Executes during object creation, after setting all properties.
function delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SNR_Callback(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNR as text
%        str2double(get(hObject,'String')) returns contents of SNR as a double


% --- Executes during object creation, after setting all properties.
function SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate.
function generate_Callback(hObject, eventdata, handles)
% hObject    handle to generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles= guidata(hObject);  

AmpA = str2double(get(handles.AmpA, 'string'));
AmpB = str2double(get(handles.AmpB, 'string'));

T1A = 1e-3* str2double(get(handles.T1A, 'string'));
T1B = 1e-3* str2double(get(handles.T1B, 'string'));

T2A = 1e-3* str2double(get(handles.T2A, 'string'));
T2B = 1e-3* str2double(get(handles.T2B, 'string'));

DA = str2double(get(handles.DA, 'string'));
DB = str2double(get(handles.DB, 'string'));

delta = 1e-3* str2double(get(handles.delta, 'string'));
DELTA = 1e-3* str2double(get(handles.DELTA, 'string'));
tE = 1e-6* str2double(get(handles.tE, 'string'));
nEchoes = str2double(get(handles.nEchoes, 'string'));
G = str2double(get(handles.G, 'string'));
n = str2double(get(handles.n, 'string'));
SNR = str2double(get(handles.SNR, 'string'));

RC_on = get(handles.RC, 'value');
Reg_on = get(handles.Reg, 'value');

if RC_on == 1 && Reg_on == 0
    [echoVec,v,T2Ddata] = RC_T2Dsim(AmpA, T1A, T2A, DA, AmpB, T1B, T2B, DB, delta, DELTA, tE, nEchoes, n, G, SNR);
elseif RC_on == 0 && Reg_on == 1
    [echoVec,v,T2Ddata] = Reg_T2Dsim(AmpA, T2A, DA, AmpB, T2B, DB, delta, DELTA, tE, nEchoes, n, G, SNR);
end

handles.echoVec= echoVec;
handles.v= v;
handles.T2Ddata= T2Ddata;

guidata(hObject, handles);

surf(1000*echoVec,v,T2Ddata)
xlim([0 1000*max(echoVec)]);
ylim([min(v) max(v)]);
shading flat
view([0 90])
xlabel('echoVec/ms')
ylabel('v/[s m-2]')


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% data = guidata(hObject);
folder_name = uigetdir;

T2Ddata = handles.T2Ddata;
v = handles.v;
echoVec = handles.echoVec;

if ismac
    save(strcat(folder_name,'/T2Ddata.dat'), 'T2Ddata', '-ascii');
    save(strcat(folder_name,'/T2_axis.dat'), 'echoVec', '-ascii');
    save(strcat(folder_name,'/vaxis.dat'), 'v', '-ascii');
elseif ispc
    save(strcat(folder_name,'\T2Ddata.dat'), 'T2Ddata', '-ascii');
    save(strcat(folder_name,'\T2_axis.dat'), 'echoVec', '-ascii');
    save(strcat(folder_name,'\vaxis.dat'), 'v', '-ascii');
end


% --- Executes on selection change in G.
function G_Callback(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns G contents as cell array
%        contents{get(hObject,'Value')} returns selected item from G


% --- Executes during object creation, after setting all properties.
function G_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ILTGo.
function ILTGo_Callback(hObject, eventdata, handles)
% hObject    handle to ILTGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2lowlim_Callback(hObject, eventdata, handles)
% hObject    handle to T2lowlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2lowlim as text
%        str2double(get(hObject,'String')) returns contents of T2lowlim as a double


% --- Executes during object creation, after setting all properties.
function T2lowlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2lowlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2highlim_Callback(hObject, eventdata, handles)
% hObject    handle to T2highlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2highlim as text
%        str2double(get(hObject,'String')) returns contents of T2highlim as a double


% --- Executes during object creation, after setting all properties.
function T2highlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2highlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nSteps_Callback(hObject, eventdata, handles)
% hObject    handle to nSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nSteps as text
%        str2double(get(hObject,'String')) returns contents of nSteps as a double


% --- Executes during object creation, after setting all properties.
function nSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dlowlim_Callback(hObject, eventdata, handles)
% hObject    handle to Dlowlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dlowlim as text
%        str2double(get(hObject,'String')) returns contents of Dlowlim as a double


% --- Executes during object creation, after setting all properties.
function Dlowlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dlowlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dhighlim_Callback(hObject, eventdata, handles)
% hObject    handle to Dhighlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dhighlim as text
%        str2double(get(hObject,'String')) returns contents of Dhighlim as a double


% --- Executes during object creation, after setting all properties.
function Dhighlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dhighlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in redraw.
function redraw_Callback(hObject, eventdata, handles)
% hObject    handle to redraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in GetT2D.
function GetT2D_Callback(hObject, eventdata, handles)
% hObject    handle to GetT2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function T2value_Callback(hObject, eventdata, handles)
% hObject    handle to T2value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2value as text
%        str2double(get(hObject,'String')) returns contents of T2value as a double


% --- Executes during object creation, after setting all properties.
function T2value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dvalue_Callback(hObject, eventdata, handles)
% hObject    handle to Dvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dvalue as text
%        str2double(get(hObject,'String')) returns contents of Dvalue as a double


% --- Executes during object creation, after setting all properties.
function Dvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
