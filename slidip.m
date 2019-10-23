function varargout = slidip(varargin)
% SLIDIP MATLAB code for slidip.fig
%      SLIDIP, by itself, creates a new SLIDIP or raises the existing
%      singleton*.
%
%      H = SLIDIP returns the handle to a new SLIDIP or the handle to
%      the existing singleton*.
%
%      SLIDIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDIP.M with the given input arguments.
%
%      SLIDIP('Property','Value',...) creates a new SLIDIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slidip_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slidip_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slidip

% Last Modified by GUIDE v2.5 18-Oct-2019 19:16:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slidip_OpeningFcn, ...
                   'gui_OutputFcn',  @slidip_OutputFcn, ...
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


% --- Executes just before slidip is made visible.
function slidip_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slidip (see VARARGIN)

% Choose default command line output for slidip
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes slidip wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slidip_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadImage.
function LoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear
clc
[filename1,filepath1]=uigetfile({'*.jpg; *.JPG; *.jpeg; *.JPEG; *.png; *.PNG','All Files'},'Choose a file');
inputpic=imread([filepath1 filename1]);
bwpic = rgb2bw(inputpic);
picsize = size(bwpic);
assignin('base','picsize',picsize);
assignin('base','bwpic',bwpic);
assignin('base','inputpic',inputpic);


% --- Executes on button press in sobelfilter.
function sobelfilter_Callback(hObject, eventdata, handles)
% hObject    handle to sobelfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bwpic = evalin('base','bwpic');

sobelpic = sobeloperator(bwpic);
assignin('base','sobelpic',sobelpic);

thresholdsobel = str2num(get(handles.thresholdsobel,'String'))*0.01;
sobelpicthreshold = threshold(sobelpic,thresholdsobel);
assignin('base','sobelpicthreshold',sobelpic);

figure('units','normalized','outerposition',[0 0 1 1])
colormap gray;

subplot(1,2,1)
imagesc(sobelpic); 
title('\fontsize{15}Sobelfilter');
set(gca,'xtick',[]);
set(gca,'ytick',[]);

subplot(1,2,2), imagesc(sobelpicthreshold);
title(['\fontsize{15}Sobelfilter with Threshold of ', num2str(thresholdsobel*100), '%']);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
saveas(gcf,'result/sobel.jpg');



% --- Executes on button press in houghtransformation.
function houghtransformation_Callback(hObject, eventdata, handles)
% hObject    handle to houghtransformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pic = evalin('base','sobelpicthreshold');
pistep = str2double(get(handles.pistep,'String'));
assignin('base','pistep',pistep);
dstep = str2double(get(handles.dstep,'String'));
assignin('base','dstep',dstep);
houghthreshold = str2double(get(handles.houghthreshold,'String'))*0.01;

[houghpic,alpha,dist] = houghtransformation(pic,pistep,dstep); 
assignin('base','alpha',alpha);
assignin('base','dist',dist);
houghpicthreshold = threshold(houghpic,houghthreshold);
assignin('base','houghpicthreshold',houghpicthreshold);

figure('units','normalized','outerposition',[0 0 1 1])
colormap gray;

subplot(1,2,1)
imagesc(houghpic); 
title('\fontsize{15}Houghtransformation');
set(gca,'xtick',[]);
set(gca,'ytick',[]);

subplot(1,2,2), imagesc(houghpicthreshold);
title(['\fontsize{15}Houghtransformation with Threshold of ', num2str(houghthreshold*100), '%']);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
saveas(gcf,'result/hough.jpg');


% --- Executes on button press in hough2lines.
function hough2lines_Callback(hObject, eventdata, handles)
% hObject    handle to hough2lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
houghpicthreshold = evalin('base','houghpicthreshold');
pistep = evalin('base','pistep');
dstep = evalin('base','dstep');
alpha = evalin('base','alpha');
d = evalin('base','dist');
sobelpicthreshold = evalin('base','sobelpicthreshold');
picsize = evalin('base','picsize');
hough2linespic = hough2lines(houghpicthreshold,pistep,dstep,alpha,d,picsize);
hough2linessobel = hough2linespic.*sobelpicthreshold;
assignin('base','hough2lines',hough2linessobel);

figure('units','normalized','outerposition',[0 0 1 1])
colormap gray;

subplot(1,2,1)
imagesc(hough2linespic); 
title('\fontsize{15}Houghtransformation to Lines');
set(gca,'xtick',[]);
set(gca,'ytick',[]);

subplot(1,2,2), imagesc(hough2linessobel);
title(['\fontsize{15}Houghtransformation to Lines with Sobeledges']);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
saveas(gcf,'result/hough2lines.jpg');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresholdsobel_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdsobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresholdsobel as text
%        str2double(get(hObject,'String')) returns contents of thresholdsobel as a double


% --- Executes during object creation, after setting all properties.
function thresholdsobel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdsobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function houghthreshold_Callback(hObject, eventdata, handles)
% hObject    handle to houghthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of houghthreshold as text
%        str2double(get(hObject,'String')) returns contents of houghthreshold as a double


% --- Executes during object creation, after setting all properties.
function houghthreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to houghthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pistep_Callback(hObject, eventdata, handles)
% hObject    handle to pistep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pistep as text
%        str2double(get(hObject,'String')) returns contents of pistep as a double


% --- Executes during object creation, after setting all properties.
function pistep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pistep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dstep_Callback(hObject, eventdata, handles)
% hObject    handle to dstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dstep as text
%        str2double(get(hObject,'String')) returns contents of dstep as a double


% --- Executes during object creation, after setting all properties.
function dstep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dstep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in overlay.
function overlay_Callback(hObject, eventdata, handles)
% hObject    handle to overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputpic = evalin('base','inputpic');
resultpic = evalin('base','hough2lines');
outputpic = inputpic;
[row,col] = find(resultpic ~= 0);
for index = 1:size(row,1)
    outputpic(row(index),col(index),1) = 255;
    outputpic(row(index),col(index),3) = 255;
end

figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
imshow(inputpic)
title('\fontsize{15}Input Picture')
subplot(1,2,2)
imshow(outputpic)
title('\fontsize{15}Output Picture')
% A = imfuse(inputpic,outputpic);
% imagesc(A);



