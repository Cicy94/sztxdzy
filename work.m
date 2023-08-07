function varargout = work(varargin)
% WORK MATLAB code for work.fig
%      WORK, by itself, creates a new WORK or raises the existing
%      singleton*.
%
%      H = WORK returns the handle to a new WORK or the handle to
%      the existing singleton*.
%
%      WORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORK.M with the given input arguments.
%
%      WORK('Property','Value',...) creates a new WORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before work_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to work_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help work

% Last Modified by GUIDE v2.5 04-Dec-2022 09:37:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @work_OpeningFcn, ...
                   'gui_OutputFcn',  @work_OutputFcn, ...
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


% --- Executes just before work is made visible.
function work_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to work (see VARARGIN)

% Choose default command line output for work
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes work wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = work_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示灰度图
if ~isempty(handles.imgfilename)
    %将彩色图片变成灰色
    imgoutput=rgb2gray(handles.imgdata);
    %绘制灰度图
    %image(handles.axes2,imgoutput)
    axes(handles.axes2);imshow(imgoutput)
    %选择颜色映射
    colormap(handles.axes2,gray(256))
    %全局变量：原始图转换为的灰度图
    handles.imggray=imgoutput;

end
guidata(hObject,handles)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示灰度图的直方图	
axes(handles.axes4)
[nk,rk]=imhist(handles.imggray);
bar(rk,nk,0.3);%0.3是柱子的宽度
%以下写法是显示指定区间的
%histogram(handles.imggray,100:125); 

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

th = get(handles.slider1,'Value')%0~1之间的一个数值
%滑动条最大值为1.0，最小值为0.0是因为im2bw函数的阈值输入在0~1之间
%所以在文本框中显示的时候*255
set(handles.edit1,'String',num2str(round(th*255)));

%全局变量 二值化时自定义拖动选择的阈值
handles.binary_thresh = th;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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


% --- Executes on button press in pushbutton6.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示二值化图片


a=im2double(handles.imggray);
binary_img = im2bw(a,handles.binary_thresh);
%显示二值化后的图片
axes(handles.axes3)
imshow(binary_img)

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

img= handles.imgdata;
val = round(get(handles.slider2,'Value'))
[w,h,c]=size(img)
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

n1=ones(w,h)*val;
r1=imadd(r,uint8(n1));
r2=imadd(g,uint8(n1));
r3=imadd(b,uint8(n1));
new(:,:,1) = r1;
new(:,:,2) = r2;
new(:,:,3) = r3;
axes(handles.axes3);imshow(new);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, ~)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%对截取区域图像几何变换

%判断是否存在截取区域，如果不存在就==0，弹出提示框
if exist('handles.roi') ==0
   disp('请先截取感兴趣的区域!');
end
var = get(handles.listbox1,'Value');
axes(handles.axes3);
figure(1);
subplot(121);imshow(handles.roi);title('原图');
switch var
    case 1    %按比例放大2倍
        a = imresize(handles.roi,2);subplot(122);
        imshow(a);colormap(handles.axes3,gray(256));title('变换后');
    case 2      %按比例缩小0.5倍
        a = imresize(handles.roi,0.5);subplot(122);
        imshow(a);colormap(handles.axes3,gray(256));title('变换后');
    case 3     %非比例放大
        a = imresize(handles.roi,[420,348],'nearest');subplot(122);
       imshow(a);colormap(handles.axes3,gray(256));title('变换后');
    case 4     %非比例缩小
        a = imresize(handles.roi,[150,180],'nearest');subplot(122);
       imshow(a); colormap(handles.axes3,gray(256));title('变换后');
    case 5      %双线性放大2
        a = imresize(handles.roi,2,'bilinear');subplot(122);
       imshow(a); colormap(handles.axes3,gray(256));title('变换后');
     case 6      %双线性缩小0.5 
        a = imresize(handles.roi,0.5,'bilinear');subplot(122);
        imshow(a); colormap(handles.axes3,gray(256));title('变换后');
    case 7      %逆时针旋转45度
        a = imrotate(handles.roi,45);
        subplot(122);imshow(a);title('变换后');
    case 8      %顺时针旋转90度
        a = imrotate(handles.roi,-90);subplot(122);imshow(a);title('变换后');
    case 9      %上下翻转
        a = flipud(handles.roi);subplot(122);imshow(a);title('变换后');
    case 10      %顺时针旋转90度
        a = fliplr(handles.roi);subplot(122);imshow(a);title('变换后');
end
% [r,c] = size(a)
% set(handles.edit9,'String',num2str(r));
% set(handles.edit10,'String',num2str(c));        

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ha=axes('units','normalized','pos',[0 0 1 1]);
uistack(ha,'bottom');
ii=imread('back6.jpg');
image(ii);
colormap gray
set(ha,'handlevisibility','off','visible','on');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fushi_Callback(hObject, eventdata, handles)
% hObject    handle to fushi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想带通滤波器的低半径' '请设置理想带通滤波器的高半径'};
name='理想带通滤波器的带宽设置';
numlines=1;
defaultanswer={'5' '15'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
D1=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D>=D0&D<=D1);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想带阻滤波器的低半径' '请设置理想带阻滤波器的高半径'};
name='理想带阻滤波器的带宽设置';
numlines=1;
defaultanswer={'5' '15'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
D1=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-double(D>=D0&D<=D1);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pegnzhang_Callback(hObject, eventdata, handles)
% hObject    handle to pegnzhang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function junhenghua_Callback(hObject, eventdata, handles)
% hObject    handle to junhenghua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%直方图均衡化操作

after_img = histeq(handles.imggray);  %均衡化操作

%显示均衡化后的图片
axes(handles.axes3);
imshow(after_img)
% image(handles.axes3,after_img)
%选择颜色映射
% colormap(handles.axes3,gray(256))
%保存为全局变量:直方图均衡化后的图像
handles.after_img = after_img
guidata(hObject,handles)

% --------------------------------------------------------------------
function junhenghuahouzhifnagtu_Callback(hObject, eventdata, handles)
% hObject    handle to junhenghuahouzhifnagtu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示均衡化后的直方图
axes(handles.axes4)
[new0,x0]=imhist(handles.after_img); 
bar(x0,new0,0.3);%0.3是柱子的宽度

% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想高通滤波器的半径' };
name='理想高通滤波器的半径';
numlines=1;
defaultanswer={'10'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D>=D0);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置巴特沃斯高通滤波器的截止频率半径' '请设置巴特沃斯高通滤波器的阶数'};
name='巴特沃斯高通滤波器的截止频率半径和阶数';
numlines=1;
defaultanswer={'10' '1'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
n=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-1./(1+(D./D0).^(2*n));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_50_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_fly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt={'请设置高斯高通滤波器的截止频率（方差）' };
name='高斯高通滤波器的截止频率（方差）';
numlines=1;
defaultanswer={'10'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-exp(-(D.^2)./(2*(D0^2)));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想低通滤波器的半径' };
name='理想低通滤波器的半径';
numlines=1;
defaultanswer={'300'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});

r=handles.imggray; %对灰度图进行滤波
% r=handles.imggray_add_noise;  %对添加了噪声的图片进行滤波


[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D<=D0);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
% handles.imdata=g;
% guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置巴特沃斯低通滤波器的截止频率半径' '请设置巴特沃斯低通滤波器的阶数'};
name='巴特沃斯低通滤波器的截止频率半径和阶数';
numlines=1;
defaultanswer={'300' '1'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
n=str2num(anss{2});

r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1./(1+(D./D0).^(2*n));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置高斯低通滤波器的截止频率（方差）' };
name='高斯低通滤波器的截止频率（方差）';
numlines=1;
defaultanswer={'300'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});

r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=exp(-(D.^2)./(2*(D0^2)));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);


% --------------------------------------------------------------------
function dakai_Callback(hObject, eventdata, handles)
% hObject    handle to dakai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%获取图片的名称和路径
[imgfilename imgpathname]=uigetfile({'*.jpg;*.png'},'Select a RGB image');
if imgfilename
    %读取图片
    imgdata=imread([imgpathname '\' imgfilename]); 
    %显示图片
    %大小为原图的大小
    axes(handles.axes1)
    imshow(imgdata)
    %以下的写法显示的图片被限制在axes框的大小中了
   %image(handles.axes1,imgdata);
    %设置全局变量：打开的图片名称
    handles.imgfilename=imgfilename;
    %设置全局变量：打开的图片路径
    handles.imgdata=imgdata;    

end
temp=imread('back4.jpg');
axes(handles.axes2); imshow(temp);
axes(handles.axes3); imshow(temp);
axes(handles.axes4); imshow(temp)
%更新全局变量
% [r,c] = size(imgdata)
% set(handles.edit7,'String',num2str(r));
% set(handles.edit8,'String',num2str(c));
guidata(hObject,handles)

% --------------------------------------------------------------------
function saveGray_Callback(hObject, eventdata, handles)
% hObject    handle to saveGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%保存灰度图

%获取保存图片的名称和路径
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';
                                 '*.bmp','Bitmap(*.bmp)';
                                 '*.gif','GIF(*.gif)';
                                 '*.*',  'All Files (*.*)'},'Save Picture','Untitled');

if FileName==0
    return;

else
    %这么写保存的图像的大小与打开的原图像的大小相同
    imwrite(handles.imggray,[PathName,FileName]);

%     这种写法是保存axes2的内容，图像的大小和axes2的大小一致
%     h=getframe(handles.axes2);
% 
%     imwrite(h.cdata,[PathName,FileName]);

end;

% --------------------------------------------------------------------
function saveTrans_Callback(hObject, eventdata, handles)
% hObject    handle to saveTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%保存变换后的图片

%获取保存图片的名称和路径
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';
                                 '*.bmp','Bitmap(*.bmp)';
                                 '*.gif','GIF(*.gif)';
                                 '*.*',  'All Files (*.*)'},'Save Picture','Untitled');

if FileName==0
    return;

else
%     %这么写保存的图像的大小与打开的原图像的大小相同
%     imwrite(handles.imggray,[PathName,FileName]);

   % 这种写法是保存axes2的内容，图像的大小和axes3的大小一致
    h=getframe(handles.axes3);

    imwrite(h.cdata,[PathName,FileName]);

end;


% 窗体打开前，先执行该函数
function UI_tupian_OpeningFcn(hObject, eventdata, handles, varargin)
% handles.output = hObject;
% 
% A=imread('back2.jpg');   %读取图片
% set(handles.pushbutton1,'CData',A);  %将按钮的背景图片设置成A，美化按钮
% 
% guidata(hObject, handles);


% --- Executes on button press in radiobutton_ruili.
function radiobutton_ruili_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_ruili (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_ruili


% --- Executes on button press in radiobutton_jiaoyan.
function radiobutton_jiaoyan_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_jiaoyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton_chengxin.
function radiobutton_chengxin_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_chengxin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_chengxin



% --- Executes on button press in radiobutton_zhishu.
function radiobutton_zhishu_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_zhishu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_zhishu


% --------------------------------------------------------------------
function pengzhang5_Callback(hObject, eventdata, handles)
% hObject    handle to pengzhang3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(5,5); 
a = imdilate(handles.imggray,mask);
axes(handles.axes3);imshow(a);

% --------------------------------------------------------------------
function fushi5_Callback(hObject, eventdata, handles)
% hObject    handle to fushi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(5,5); 
a = imerode(handles.imggray,mask);
axes(handles.axes3);imshow(a);

% --------------------------------------------------------------------
function fushi3_Callback(hObject, eventdata, handles)
% hObject    handle to fushi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(3,3); 
a = imerode(handles.imggray,mask);
axes(handles.axes3);imshow(a);
% --- Executes on button press in radiobutton_gaosi.

function zhongzhi3_Callback(hObject, eventdata, handles)
% hObject    handle to zhongzhi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
e=medfilt2(handles.imggray_add_noise,[3,3]);  
axes(handles.axes3);imshow(e)

% --------------------------------------------------------------------
function zhongzhi5_Callback(hObject, eventdata, handles)
% hObject    handle to zhongzhi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%中值滤波

prompt={'请设置卷积核的大小,建议输入以下几种大小，3或5，输入一个数字即可'};%对话框的提示内容
%另外弹出一个提示框
%msgbox('建议输入以下几种大小，3或5，输入一个数字即可');
name='设置卷积核大小'; %对话框的名称
numlines=1;
defaultanswer={'3'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

e=medfilt2(handles.imggray_add_noise,[x1,x1]);  
axes(handles.axes3);imshow(e);

% --------------------------------------------------------------------
function junzhi3_Callback(hObject, eventdata, handles)
% hObject    handle to junzhi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%先创建一个均值mask  
average_mask=fspecial('average',[3,3]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3junzhizidingyi);imshow(f)

% --------------------------------------------------------------------
function junzhi5_Callback(hObject, eventdata, handles)
% hObject    handle to junzhi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
average_mask=fspecial('average',[5,5]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)

function pengzhang3_Callback(hObject, eventdata, handles)
% hObject    handle to pengzhang3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(3,3); 
a = imdilate(handles.imggray,mask);
axes(handles.axes3);imshow(a);

% --------------------------------------------------------------------


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%边缘检测按钮组

%获取当前选中的按钮的tag（是字符串哦）
current_obj = get(eventdata.NewValue,'Tag');
switch current_obj
    case 'radiobutton_Canny'
        a = edge(handles.imggray,'canny'); 
        image(handles.axes3,a);
        colormap(handles.axes2,gray(100));
%         axes(handles.axes3);imshow(a);
    case 'radiobutton_Roberts'
        a = edge(handles.imggray,'Roberts'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_Sobel'
        a = edge(handles.imggray,'Sobel'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_Prewitt'
        a = edge(handles.imggray,'Prewitt'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_LoG'
        a = edge(handles.imggray,'LoG'); 
        axes(handles.axes3);imshow(a);
end


% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'均值滤波，请设置卷积核的大小,建议输入以下几种大小，3或5，输入一个数字即可'};%对话框的提示内容
%另外弹出一个提示框
%msgbox('建议输入以下几种大小，3或5，输入一个数字即可');
name='设置卷积核大小'; %对话框的名称
numlines=1;
defaultanswer={'3'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

average_mask=fspecial('average',[x1,x1]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)

% --- Executes during object creation, after setting all properties.
function uibuttongroup3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.imggray_add_noise;
[M,N]=size(f);
y=fft2(f);
g=log(abs(fftshift(y))+1);
axes(handles.axes3);
imshow(g,[8,12]);
handles.ft=y;
handles.ftimg=log(abs(fftshift(y))+1);
guidata(hObject, handles);

% --------------------------------------------------------------------
function ifft_Callback(hObject, eventdata, handles)
% hObject    handle to ifft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.ft;
[M,N]=size(f);
y=ifft2(f);
axes(handles.axes3);
imshow(y,[min(min(abs(y))),max(max(abs(y)))]);

% handles.imdata=abs(y);
% guidata(hObject, handles);


% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup3 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%添加噪声按钮组

%获取当前选中的按钮的tag（是字符串哦）
current_obj = get(eventdata.NewValue,'Tag');
switch current_obj
    case 'radiobutton_gaosi'
        %添加高斯噪声
        prompt={'请设置高斯噪声的均值' '请设置高斯噪声的方差' };
        name='设置高斯噪声';
        numlines=1;
        defaultanswer={'0.04' '0.01'};
        anss=inputdlg(prompt,name,numlines,defaultanswer);
        x1=str2num(anss{1});
        x2=str2num(anss{2});

        gaussi=imnoise(handles.imggray,'gaussian',x1,x2);
        axes(handles.axes3)
        imshow(gaussi)

        % %保存全局变量：添加了高斯噪声的灰度图
        % handles.imggray_add_gaus = gaussi
        %保存全局变量：添加了噪声的灰度图
        handles.imggray_add_noise = gaussi
        guidata(hObject,handles)
    case 'radiobutton_jiaoyan'
       %添加椒盐噪声

        prompt={'请设置椒盐噪声的密度'};
        name='设置椒盐噪声';
        numlines=1;
        defaultanswer={'0.04'};
        anss=inputdlg(prompt,name,numlines,defaultanswer);
        x1=str2num(anss{1});

        saltpepper=imnoise(handles.imggray,'salt & pepper',x1);
        axes(handles.axes3)
        imshow(saltpepper)

        %保存全局变量：添加了椒盐噪声的灰度图
        %handles.imggray_add_saltpepper = saltpepper
        %   保存全局变量：添加了噪声的灰度图
        handles.imggray_add_noise = saltpepper
        guidata(hObject,handles)

    case 'radiobutton_chengxin'
       %添加乘性噪声

        prompt={'请设置乘性噪声的密度'};
        name='设置乘性噪声';
        numlines=1;
        defaultanswer={'0.04'};
        anss=inputdlg(prompt,name,numlines,defaultanswer);
        x1=str2num(anss{1});

        speckle=imnoise(handles.imggray,'speckle',x1);
        axes(handles.axes3)
        imshow(speckle)

        % %保存全局变量：添加了乘性噪声的灰度图
        % handles.imggray_add_speckle = speckle
        %保存全局变量：添加了噪声的灰度图
        handles.imggray_add_noise = speckle
        guidata(hObject,handles)
    case 'radiobutton_ruili'
       %添加泊松噪声
        bosong=imnoise(handles.imggray,'poisson');
        axes(handles.axes3)
        imshow(bosong)

        % %保存全局变量：添加了高斯噪声的灰度图
        % handles.imggray_add_gaus = gaussi
        %保存全局变量：添加了噪声的灰度图
        handles.imggray_add_noise = bosong
        guidata(hObject,handles)
end


% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video=VideoReader('helpvideo.avi');
	nFrames=video.NumberOfFrames;  %得到帧数
	H=video.Height;  %得到高度
	W=video.Width;  %得到宽度
	Rate=video.FrameRate;  %重新分配视频结构
	mov(1:nFrames)=struct('cdata',zeros(H,W,3,'uint8'),'colormap',[]);
	%每次读取一帧
    figure(1);
	for i=1:nFrames
		 mov(i).cdata=read(video,i);
   		P=mov(i).cdata;
    		disp('当前播帧数：');disp(i);
    		imshow(P),title('原始图片');
    		%P2=rgb2gray(P);
	end

% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function Untitled_fly_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_41_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close(); %想关闭的matlab界面名称——对应gui.m和gui.fig
set(huabu,'Visible','on');  %想打开的界面名称——gui.m和gui.fig


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

close(); %想关闭的matlab界面名称——对应gui.m和gui.fig
set(work,'Visible','on');  %想打开的界面名称——gui.m和gui.fig

% --------------------------------------------------------------------
function Untitled_42_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(); %想关闭的matlab界面名称——对应gui.m和gui.fig
% --------------------------------------------------------------------
function Untitled_43_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%获取图片的名称和路径
[imgfilename imgpathname]=uigetfile({'*.jpg;*.png'},'Select a RGB image');
if imgfilename
    %读取图片
    imgdata=imread([imgpathname '\' imgfilename]); 
    %显示图片
    %大小为原图的大小
    axes(handles.axes4)
    imshow(imgdata)
    %以下的写法显示的图片被限制在axes框的大小中了
   %image(handles.axes1,imgdata);
    %设置全局变量：打开的图片名称
    handles.imgfilename1=imgfilename;
    %设置全局变量：打开的图片路径
    handles.imgdata1=imgdata;    

end
guidata(hObject,handles)

% --- Executes when selected object is changed in uibuttongroup4.
function uibuttongroup4_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup4 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.imggray;
%img_gray=rgb2gray(img);
img_gray=img;
img_filter=double(img_gray);
%% 设置金字塔层数：p，高斯金字塔元胞数组为gausPyramid，拉普拉斯金字塔元胞数组为LaplPyramid
p=4;
gausPyramid=cell(1,p);
LaplPyramid=gausPyramid;

%% 5*5高斯核，sigma=1
kernel=fspecial('gaussian',5,1);
% 高斯核乘以4（亮度守恒）
kernel1=4.*kernel;

%% 计算gausPyramid和LaplPyramid
[m,n]=size(img_filter);
gausPyramid(1)=mat2cell(img_filter,m,n);
for i=2:p        
    %% 高斯金字塔
    % 滤波
    img_filter1=filter2(kernel,img_filter,'same');
    % 下采样：去掉偶数行、列
    img_filter1(2:2:end,:)=[];
    img_filter1(:,2:2:end)=[];    
    [m,n]=size(img_filter1);
    gausPyramid(i)=mat2cell(img_filter1,m,n);

    %% 拉普拉斯金字塔
    % 上采样：新增全零行、列
    img_filter2=zeros(2*m,2*n);
    img_filter2(1:2:2*m,1:2:2*n)=img_filter1(1:m,1:n);
    % 滤波
    img_filter2=filter2(kernel1,img_filter2,'same');
    img_filter2=img_filter-img_filter2;
    LaplPyramid(i-1)=mat2cell(img_filter2,2*m,2*n);
    
    img_filter=img_filter1;
end
LaplPyramid(p)=gausPyramid(p);

%% 显示金字塔，把元胞金字塔统计到一个数组中
img_gaus=cell2mat(gausPyramid(1));
[r,~]=size(img_gaus);
img_lapl=cell2mat(LaplPyramid(1));
[r1,~]=size(img_lapl);
for i=2:p
    %% 高斯金字塔
    img_filter=cell2mat(gausPyramid(i));
    [m,~]=size(img_filter);
    % 在第一行前面补(r-m)行全255行,10列全255列，与最大的图像行对齐
    img_filter=padarray(img_filter,[r-m 10],255,'pre');
    img_gaus=[img_gaus img_filter];

    %% 拉普拉斯金字塔
    img_filter=cell2mat(LaplPyramid(i));
    [m,~]=size(img_filter);
     % 在第一行前面补(r-m)行全255行,10列全255列，与最大的图像行对齐
    img_filter=padarray(img_filter,[r1-m 10],255,'pre');
    img_lapl=[img_lapl img_filter];
end
%figure('Name','gausPyramid');
current_obj = get(eventdata.NewValue,'Tag');
switch current_obj
    case 'radiobutton15'
        axes(handles.axes3);
        imshow(uint8(img_gaus));
        figure('Name','高斯图像金字塔');
imshow(uint8(img_gaus));
    case 'radiobutton_muban3'
        axes(handles.axes3);
        imshow(uint8(abs(img_lapl)));
figure('Name','LaplPyramid');
imshow(uint8(abs(img_lapl)));
end



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%原图的路径
f = handles.imgdata;
figure(1);
imshow(f);
t=imrect;
pos=getPosition(t);
a=int16(pos(1,1));
b=int16(pos(1,2));
c=int16(pos(1,3));
d=int16(pos(1,4));
g=imcrop(f,pos);
gr = g(:,:,1);
[h w] = size(gr);
imgn = g;
%设置马赛克区域n*n像素块大小
n = 20;
nh = floor(h/n)*n;%将不一定是n的整数倍的图像大小化为整数倍
nw = floor(w/n)*n;
%对三个通道进行循环处理
for t = 1:3
    for j = 1:n:nh
        for i = 1:n:nw
            imgn(j:j+n-1, i:i+n-1, t) =mean(mean(g(j:j+n-1, i:i+n-1, t)));%对列进行取均值处理
        end
        imgn(j:j+n-1,nw:w , t ) = mean(mean(g(j:j+n-1,nw:w , t)));%处理最后的列
    end
    for i = 1:n:nw
        imgn(nh:h, i:i+n-1, t) = mean(mean(g(nh:h, i:i+n-1, t)));%处理最后的行
    end
    imgn(nh:h, nw:w, t) = mean(mean(g(nh:h, nw:w , t)));%处理最后的角
end
%imshow(imgn);%图片显示

f(b:b+d,a:a+c,1:3)=imgn(:,:,1:3); 
axes(handles.axes3);imshow(f);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%截图操作,完成截取操作后双击鼠标即确定截取

x= imcrop(handles.imgdata);
disp('截图完成！')
[r,c] = size(x)
handles.roi = x;
guidata(hObject, handles);
%显示截图

axes(handles.axes3);imshow(handles.roi);
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% %添加模板按钮组
% leftImage = handles.imgdata;
% rightImage = handles.imgdata1;
leftImage = double(imread('apple.png'));
rightImage = double(imread('orange.png'));
iternum = 5;

if (size(leftImage) ~= size(rightImage))
    error('Input images are not the same size!')
end

% Ô¤´¦Àí£¬Ê¹Í¼Æ¬height,widthÎªÅ¼Êý
[rows, cols, channels] = size(leftImage);

% mask gaussian
mask = double(zeros(rows, cols, channels));
mask(:, 1:floor(cols/2), :) = ones(rows, floor(cols/2), channels);
mask_pyramid = GaussianPyramid(mask, iternum);


% leftImage pyramid and rightImage pyramid
left_pyramid = LaplacianPyramid(leftImage, iternum);
right_pyramid = LaplacianPyramid(rightImage, iternum);

% TODO: get blend laplacian pyramid
blend_pyramid = cell(iternum, 1);
for i = 1:iternum
    blend_pyramid{i} = left_pyramid{i} .* mask_pyramid{i} + right_pyramid{i} .* (1 - mask_pyramid{i});
end

% reconstruct the blend image
blendImage = LaplacianReconstruct(blend_pyramid);
imwrite(uint8(blendImage), 'blendImage.png');
axes(handles.axes3);
imshow('blendImage.png');

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on slider1 and none of its controls.
function slider1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uibuttongroup4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
function gaussi_Callback(hObject, eventdata, handles)
% hObject    handle to gaussi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
