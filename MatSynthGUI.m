function varargout = MatSynthGUI(varargin)
% MATSYNTHGUI MATLAB code for MatSynthGUI.fig
%      MATSYNTHGUI, by itself, creates a new MATSYNTHGUI or raises the existing
%      singleton*.
%
%      H = MATSYNTHGUI returns the handle to a new MATSYNTHGUI or the handle to
%      the existing singleton*.
%
%      MATSYNTHGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATSYNTHGUI.M with the given input arguments.
%
%      MATSYNTHGUI('Property','Value',...) creates a new MATSYNTHGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MatSynthGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MatSynthGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MatSynthGUI

% Last Modified by GUIDE v2.5 20-Apr-2015 21:18:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MatSynthGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MatSynthGUI_OutputFcn, ...
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


% --- Executes just before MatSynthGUI is made visible.
function MatSynthGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MatSynthGUI (see VARARGIN)
handles.attackmin=0.001;
handles.attackmax=1;

handles.decaymin=0.001;
handles.decaymax=1;

handles.sustainmin=0;
handles.sustainmax=1;

handles.releasemin=0.001;
handles.releasemax=5;

handles.durationmin=0.01;
handles.durationmax=4;

handles.volumemin=0;
handles.volumemax=1;

handles.frequencymin=0;
handles.frequencymax=5000;

handles.shapes=char(['sin     ';'square  ';'saw     ';'triangle']);

handles.duration = 3.0;
handles.volume = 1.0;
handles.shape = 'sin';
handles.frequency = 440;
handles.previous_wave = [];
handles.attack=0.5;
handles.decay=0.5;
handles.sustain=0.5;
handles.release=0.5;
handles.ADSR=ADSR(0.5,0.5,0.5,0.5,handles.duration);
% Choose default command line output for MatSynthGUI
handles.output = hObject;
Y=waveform(handles.ADSR, handles.shape, handles.frequency, handles.volume);
axes(handles.axes1);
plot(1:floor((44100*4/handles.frequency)), (Y(1:(floor(44100*4/handles.frequency)))));
axes(handles.axes2);
plot(1:length(handles.ADSR), handles.ADSR);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MatSynthGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MatSynthGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function attackslider_Callback(hObject, eventdata, handles)
% hObject    handle to attackslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.attack=get(hObject, 'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.attackdisplay,'String',handles.attack)
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function attackslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attackslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function decayslider_Callback(hObject, eventdata, handles)
% hObject    handle to decayslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.decay=get(hObject, 'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.decaydisplay,'String',handles.decay)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function decayslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to decayslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function releaseslider_Callback(hObject, eventdata, handles)
% hObject    handle to releaseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.release=get(hObject, 'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.releasedisplay,'String',handles.release)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function releaseslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to releaseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sustainslider_Callback(hObject, eventdata, handles)
% hObject    handle to sustainslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.sustain=get(hObject, 'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.sustaindisplay,'String',handles.sustain)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sustainslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sustainslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ADSR=ADSR(handles.attack, handles.decay, handles.sustain, handles.release, handles.duration);
Y=[handles.previous_wave waveform(handles.ADSR, handles.shape, handles.frequency, handles.volume)];
axes(handles.axes1);
plot(1:floor((44100*4/handles.frequency)), (Y(1:floor((44100*4/handles.frequency)))));
axes(handles.axes2);
plot(1:length(handles.ADSR), handles.ADSR);
sound(Y,44100)


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear playsnd

% --- Executes on selection change in waveforms.
function waveforms_Callback(hObject, eventdata, handles)
% hObject    handle to waveforms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject, 'Value')
str = get(hObject, 'String')

if val > 0
    handles.shape = strtrim(str(val,:))
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns waveforms contents as cell array
%        contents{get(hObject,'Value')} returns selected item from waveforms


% --- Executes during object creation, after setting all properties.
function waveforms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waveforms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on slider movement.
function durationslider_Callback(hObject, eventdata, handles)
% hObject    handle to durationslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.duration=get(hObject, 'Value');
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.durationdisplay,'String',handles.duration)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function durationslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to durationslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function volumeslider_Callback(hObject, eventdata, handles)
% hObject    handle to volumeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.volume=get(hObject, 'Value')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.volumedisplay,'String',handles.volume)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function volumeslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volumeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end






% --- Executes on slider movement.
function freq_Callback(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.frequency = get(hObject, 'Value');
set(handles.frequencydisplay,'String',handles.frequency)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ADSR=ADSR(handles.attack, handles.decay, handles.sustain, handles.release, handles.duration);
handles.previous_wave=[handles.previous_wave waveform(handles.ADSR, handles.shape, handles.frequency, handles.volume)];
guidata(hObject, handles);



% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.previous_wave=[];
guidata(hObject, handles);



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
audiowrite('output.wav', handles.previous_wave,44100);


% --- Executes on button press in random.
function random_Callback(hObject, eventdata, handles)
% hObject    handle to random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.frequency=handles.frequencymin+(handles.frequencymax-handles.frequencymin)*rand(1,1);
set(handles.freq, 'Value', handles.frequency);
set(handles.frequencydisplay,'String',handles.frequency)

r=randi(4);
handles.shape=strtrim(handles.shapes(r,:));
set(handles.waveforms, 'Value', r+1);


handles.attack=handles.attackmin+(handles.attackmax-handles.attackmin)*rand(1,1);
set(handles.attackslider, 'Value', handles.attack);

handles.decay=handles.decaymin+(handles.decaymax-handles.decaymin)*rand(1,1);
set(handles.decayslider, 'Value', handles.decay);
handles.sustain=handles.sustainmin+(handles.sustainmax-handles.sustainmin)*rand(1,1);
set(handles.sustainslider, 'Value', handles.sustain);
handles.release=handles.releasemin+(handles.releasemax-handles.releasemin)*rand(1,1);
set(handles.releaseslider, 'Value', handles.release);

handles.duration=handles.durationmin+(handles.durationmax-handles.durationmin)*rand(1,1);
set(handles.durationslider, 'Value', handles.duration);
set(handles.durationdisplay,'String',handles.duration)

handles.volume=handles.volumemin+(handles.volumemax-handles.volumemin)*rand(1,1);
set(handles.volumeslider, 'Value', handles.volume);
set(handles.volumedisplay,'String',handles.volume);



%handles.ADSR=ADSR(handles.attack,handles.decay,handles.sustain,handles.release,handles.duration);
set(handles.sustaindisplay,'String',handles.sustain)
set(handles.releasedisplay,'String',handles.release)
set(handles.decaydisplay,'String',handles.decay)
set(handles.attackdisplay,'String',handles.attack)
guidata(hObject, handles);



% --- Executes on selection change in presets.
function presets_Callback(hObject, eventdata, handles)
% hObject    handle to presets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns presets contents as cell array
%        contents{get(hObject,'Value')} returns selected item from presets
val = get(hObject, 'Value')


switch val
    case 2
        handles.shape ='sin';
        handles.frequency=1000;
        handles.volume=0.9;
        handles.attack=0.001;
        handles.decay=0.5;
        handles.release=5;
        handles.sustain=0.5;
        handles.duration=0.15;
        r=2;
    case 3
        handles.shape ='sin';
        handles.frequency=160;
        handles.volume=0.9;
        handles.attack=1;
        handles.decay=0.001;
        handles.release=0.2;
        handles.sustain=0.5;
        handles.duration=0.15;
        r=2;
    otherwise
end
set(handles.durationslider, 'Value', handles.duration);
set(handles.durationdisplay,'String',handles.duration);
set(handles.volumedisplay,'String',handles.volume);
set(handles.frequencydisplay,'String',handles.frequency)
set(handles.waveforms, 'Value', r);

set(handles.volumeslider, 'Value', handles.volume);
set(handles.sustainslider, 'Value', handles.sustain);
set(handles.releaseslider, 'Value', handles.release);
set(handles.decayslider, 'Value', handles.decay);
set(handles.attackslider, 'Value', handles.attack);
set(handles.sustaindisplay,'String',handles.sustain)
set(handles.releasedisplay,'String',handles.release)
set(handles.decaydisplay,'String',handles.decay)
set(handles.attackdisplay,'String',handles.attack)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function presets_CreateFcn(hObject, eventdata, handles)
% hObject    handle to presets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
