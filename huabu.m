function varargout = huabu(varargin)
% HUABU MATLAB code for huabu.fig
%      HUABU, by itself, creates a new HUABU or raises the existing
%      singleton*.
%
%      H = HUABU returns the handle to a new HUABU or the handle to
%      the existing singleton*.
%
%      HUABU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUABU.M with the given input arguments.
%
%      HUABU('Property','Value',...) creates a new HUABU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before huabu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to huabu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help huabu

% Last Modified by GUIDE v2.5 01-Dec-2022 16:02:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @huabu_OpeningFcn, ...
                   'gui_OutputFcn',  @huabu_OutputFcn, ...
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


% --- Executes just before huabu is made visible.
function huabu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to huabu (see VARARGIN)

% Choose default command line output for huabu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes huabu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = huabu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 最近要做一些模式识别的课程作业，设计一个手写输入板来实现测试样本的识别，好吧，废话不多说，干货来了。
% 要实现的目标：
% 1.实现手写
% 2.手写的图像能够保存
% 大概就是下面这个样子
% ![界面](https://img-blog.csdn.net/20151018102952336)
% 实现步骤：
% 1.添加控件，有点类似VB那种，先创建新的GUI界面，然后把控件拖里面去就行。
% ![创建界面](https://img-blog.csdn.net/20151018103234403)
% 2.创建一些回调函数
% ![回调函数](https://img-blog.csdn.net/20151018103457787)
% 每个回调函数下面可以写函数，用到的回调函数也就那么几个，下面一一介绍
% No.1 获取鼠标位置（鼠标按下）
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x;
global y;
draw_enable=1;
if draw_enable
    position=get(gca,'currentpoint');
    x(1)=position(1);
    y(1)=position(3);
end
% No.2更新鼠标位置并画线（鼠标在按下的情况下运动）
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable;
global x;
global y;
if draw_enable
    position=get(gca,'currentpoint');
    x(2)=position(1);
    y(2)=position(3);
    line(x,y,'LineWidth',1,'color','k');
    x(1)=x(2);
    y(1)=y(2);
end
% No.3鼠标放开后停止画线
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global draw_enable
draw_enable=0;
% No.4清除图像（按下清除按键，这里要说明一下创建回调函数的时候要在清除按钮上右键，比较快）
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
% NO.5保存图像（按下保存按键）
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
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
    h=getframe(handles.axes1);

    imwrite(h.cdata,[PathName,FileName]);

end;
% 将上述函数都一一调用后就可以实现手写输入了，这里要感谢MATLAB中文论坛的大神，上面的源代码基本上是他们原创的，我只是整理，稍微改写添加了一下。
