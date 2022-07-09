clear,clc,close all;
global R;
R = 0.5;
x = 0:0.01:R;
y = sqrt((R^2-x.^2));
color_type = {'r^','g^','rs','gs',...
              'r.','g.','r+','g+',...
              'rd','gd','rh','gh',...
              'ro','go','rp','gp',};
masz = [5,5,6,6,15,15,5,5,5,5,5,5,5,5,5,5];
fig = figure('Color','w');
ax=axes;

hold on;
grid off;
box off;
ax.TickLength =[0 0];
ax.FontName = 'Times New Roman';
set(gcf,'position',[200,100,400,250]);
% Part 1
plot(x, y,'k-','linewidth',0.5)

ifint = @(i)(i-floor(i))==0;
num2str_ = @(ele) [repmat(sprintf('%.1f',ele), 1, ifint(ele*10)) repmat(sprintf('%.2f',ele), 1, ~ifint(ele*10))];

xticks_ = 0:0.1:0.5;
xticks(xticks_);
t=0:0:0;
set(gca,'xtick',t);
%xticklabels_{6} = 'REF';
%xticklabels(xticklabels_);

yticks_ = 0:0.1:0.5;
yticks(yticks_);
yticklabels_ = cellfun(num2str_, num2cell(yticks_'), 'UniformOutput',0);
yticklabels(yticklabels_);

xlim([0 R]);
ylim([0 R]);

axis square;
% 制作圆弧刻度
tmp = [0 5 5 6 4 4.2 2 2.4 2.7 3 2.8];
tmp =tmp./sum(tmp);
tmp = cumsum(tmp);
cticks_ = tmp .* (pi/2);
yy = cticks_;
cticks_ = cticks_(1:end-1);
cticks(cticks_);
cticklabels_ = {'0','0.2','0.4','0.6','0.7','0.8','0.85','0.9','0.95','0.99'};
xx = [0,0.2,0.4,0.6,0.7,0.8,0.85,0.9,0.95,0.99,1];
cticklabels(cticks_, cticklabels_);
c = cticks_;
tmp1 = [4/5,3/5,2/5,1/5];
tmp2 = [1/5,2/5,3/5,4/5];
tmp3 = [3/4,2/4,1/4];
tmp4 = [1/4,2/4,3/4];
cminorticks_ = [(c(1)+c(2))/2,(c(2)+c(3))/2,(c(3)+c(4))/2,(c(4)+c(5))/2,(c(5)+c(6))/2,c(7).*tmp1+c(8).*tmp2, c(8).*tmp1+c(9).*tmp2,c(9).*tmp3+c(10).*tmp4];
cminorticks(cminorticks_);

[x0,y0] = getCirclePoint(pi/2-cticks_(5),0.5+0.08);
text(x0,y0, 'COR','rotation',-60,'FontName','Times New Roman');

% Part 2 画内部红色圆弧
c1x = linspace(0,0.5);
c1y = sqrt(0.5^2-c1x.^2);
plot(c1x, c1y,'k--','linewidth',0.5);

c2x = linspace(0,0.4);
c2y = sqrt(0.4^2-c2x.^2);
plot(c2x, c2y,'k--','linewidth',0.5);

c3x = linspace(0,0.3);
c3y = sqrt(0.3^2-c3x.^2);
plot(c3x, c3y,'k--','linewidth',0.5);

c4x = linspace(0,0.2);
c4y = sqrt(0.2^2-c4x.^2);
plot(c4x, c4y,'k--','linewidth',0.5);

c5x = linspace(0,0.1);
c5y = sqrt(0.1^2-c5x.^2);
plot(c5x, c5y,'k--','linewidth',0.5);

%c6x = linspace(0,1.00);
%c6y = sqrt(1.00^2-c6x.^2);
%plot(c6x, c6y,'k--','linewidth',0.5);

% Part 3 画内部蓝色圆弧

%c7x = linspace(0.00, 1.65);
% (x-r)^2 + y^2 = R^2
%c7y = sqrt(6.00^2 - (c7x - 3.30).^2);
%plot(c7x, c7y,'b--','linewidth',0.5);

c8x = linspace(0.00, 0.195);
% (x-r)^2 + y^2 = R^2
c8y = sqrt(0.5^2 - (c8x - 0.3916).^2);
plot(c8x, c8y,'b--','linewidth',0.5);

c9x = linspace(0.00, 0.31);
% (x-r)^2 + y^2 = R^2
c9y = sqrt(0.4^2 - (c9x - 0.3916).^2);
plot(c9x, c9y,'b--','linewidth',0.5);

c10x = linspace(0.03, 0.408);
% (x-r)^2 + y^2 = R^2
c10y = sqrt(0.3^2 - (c10x - 0.3916).^2);
plot(c10x, c10y,'b--','linewidth',0.5);

c11x = linspace(0.1916, 0.46);
% (x-r)^2 + y^2 = R^2
c11y = sqrt(0.2^2 - (c11x - 0.3916).^2);
plot(c11x, c11y,'b--','linewidth',0.5);

c12x = linspace(0.2916, 0.4916);
% (x-r)^2 + y^2 = R^2
c12y = sqrt(0.1^2 - (c12x - 0.3916).^2);
plot(c12x, c12y,'b--','linewidth',0.5);

% 画内部绿色直线段
l_alphas = cticks_([2 3 4 5 6 8 9 10]);
for alpha = l_alphas
    [x0,y0]=getCirclePoint(pi/2-alpha,0.5);
    line([0,x0], [0,y0],'LineStyle','--','Color',[0 0.5 0]);
end

% Part 3 画内部点
plot(0.3916, 0.000, '.','MarkerSize',12,'LineWidth',5.0,'Color','b');
text(0.37, -0.02,'REF','FontName','Times New Roman');

% plot(4.65, 0.84, '.','MarkerSize',16,'Color','r');
%text(4.80, 0.98,'B','FontName','Times New Roman');

% plot(4.65, 2.84, '*','MarkerSize',10,'LineWidth',0.5,'Color',[1 0.4 0]);
%text(4.80, 3.02,'C','FontName','Times New Roman');


%data=xlsread('D:\Taylordata.xlsx','sheet1','B2:D6');%文件路径
%x = [4.10,3.90,3.70,3.50,3.30,3.10,2.90,2.70,2.50,2.30,2.10,1.90,1.70,1.50,1.30,1.10];
%y = x*1/2+1;
%y = xlsread('D:\RF2_result.xlsx','sheet1','B11:B18');%文件路径
%x = y*3+1;
%y = [5.00,5.00,4.50,4.50,4.50,4.00,4.00,3.50,3.50,3.50,3.00,2.50,2.00,1.50,1.00,0.50];

% 数据导入
%data=readmatrix('trial_data.xlsx');
%data = [data(:,2:3);data(:,4:5)];
%x = data(:,1);
%r = data(:,2);
%x = [0.04,0.04,0.04,0.04,0.04,0,0,0,0,0,0,0,0,0,0,0];
%r = [0.2,0.75,0.85,0.95,0.995,0,0,0,0,0,0,0,0,0,0,0];
num = xlsread('D:\Taylor9_16_1.xlsx','sheet1','A1:A16');
r = xlsread('D:\Taylor9_16_1.xlsx','sheet1','B1:B16');
xxx = interp1(xx,yy,r,"spline");
y = change_cor(num,xxx);
alpha = atan(y./num);
x = num.* cos(alpha);
y = num.* sin(alpha);

character = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P'};
for i = 1:length(x)
    p(i) = plot(x(i),y(i),color_type{i},'MarkerSize',masz(i));
%     text(x(i)+0.1,y(i)+0.1,character{i},'FontName','Times New Roman');
end
L = legend(p,character,'Location','northeastoutside','Box','off','FontName','Times New Roman','FontSize',8);
% ah = axes('Position',get(ax,'Position'),'Visible','off');
% Position = get(L,'Position');
% Position(1) = Position(1)+0.12;
% legend(ah,p(9:16),character(9:16),'Position',Position,'Box','off','FontName','Times New Roman');
ylabel('Standard deviation','FontName','Times New Roman')

% subfunctions
% cticklabels将每个标签写在最外围1/4圆标签对应位置
function cticklabels(cticks_, cticklabels_)
global R
    ct = 0;
    for alpha = cticks_
        ct = ct+1;
        [x0,y0] = getCirclePoint(pi/2-alpha, R+0.018);
        text(x0-0.01,y0,cticklabels_{ct},'FontName','Times New Roman');
    end
end
% cticks在1/4圆弧外围绘制刻度线
function cticks(cticks_)
global R
    for alpha = cticks_
        CycleTickline(pi/2 - alpha, R, 0.008)
    end
end
% 在有标签的刻度线中间加入刻度线
function cminorticks(cminorticks_)
global R
    for alpha = cminorticks_
        CycleTickline(pi/2 - alpha, R, 0.004)
    end
end
% 指定角度，半径，线长，绘制圆弧线上的刻度线
function CycleTickline(alpha, r, linelength)
    [x1,y1] = getCirclePoint(alpha, r);
    [x2,y2] = getCirclePoint(alpha, r-linelength);
    line([x1,x2],[y1,y2],'LineStyle','-','Color','k')
end
% 坐标变换极坐标转直角坐标
function [x,y] = getCirclePoint(alpha, r)
    x = cos(alpha)*r;
    y = sin(alpha)*r;
end

function y=change_cor(x,alpha)
global R
n = length(alpha);
y = zeros(n,1);
for i = 1:n
    [x1,y1] = getCirclePoint(pi/2-alpha(i),R);
    y(i) = x(i)/x1*y1;
end
end
%set(gcf,'position',[200,100,330,150]);
%set(gcf,'position',[200,100,330,250]);
%set(gcf,'Color',[1 1 1]);
% legend('Thumb','Index (ring) finger','Middle finger','Little finger');
