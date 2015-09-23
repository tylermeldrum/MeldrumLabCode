clear
clc
close all

sampleCt = 5;

% 50 mM Gd
data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/50mMGd_noCHIRP.out');
lowlim = 1e-4;
hilim = 1e-2;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

h = figure('Units','centimeters','Position', [0 0 19 28])
subplot(sampleCt,2,1)
grid on
surf(xaxis,yaxis,data)
set(gca,'XScale','log','YScale','log','TickLabelInterpreter', 'latex','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('50 mM Gd, noCHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')


clear('data','xaxis','yaxis')

data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/50mMGd_CHIRP.out');
lowlim = 1e-4;
hilim = 1e-2;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,2)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('50 mM Gd, CHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')

% Glycerol
data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/Glycerol_noCHIRP.out');
lowlim = 1e-3;
hilim = 1e-1;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,3)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('Glycerol noCHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')


clear('data','xaxis','yaxis')

data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/Glycerol_CHIRP.out');
% lowlim = 1e-4;
% hilim = 1e-2;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,4)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('Glycerol CHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')

% Double
data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/DoubleSample_noCHIRP.out');
lowlim = 1e-4;
hilim = 1e0;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,5)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('Double noCHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')


clear('data','xaxis','yaxis')

data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/DoubleSample_CHIRP.out');
% lowlim = 1e-4;
% hilim = 1e-2;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,6)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('Double CHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')

% 15 mM Gd
data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/CHIRPExcelTableData/15mMGd_IRBURP.out');
lowlim = 1e-4;
hilim = 1e0;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,7)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('15 mM Gd, noCHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')


clear('data','xaxis','yaxis')

data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/CHIRPExcelTableData/15mM_GdH2O_CHIRP_22Sept2015.out');
% lowlim = 1e-4;
% hilim = 1e-2;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,8)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('15 mM Gd, CHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')

% new rubber
data = load('/Users/tyler/Dropbox/Manuscripts/CHIRP/CHIRPExcelTableData/newRubber_CHIRP.out');
lowlim = 1e-4;
hilim = 1e0;

xaxis = logspace(log10(lowlim), log10(hilim), size(data,1));
yaxis = logspace(log10(lowlim), log10(hilim), size(data,2));

figure(h)
subplot(sampleCt,2,10)
surf(xaxis,yaxis,data)
colormap('gray')
colormap(flipud(colormap))
shading flat
view([0 90])
set(gca,'XScale','log','YScale','log','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')
line([lowlim hilim],[lowlim hilim],[max(max(data)) max(max(data))],'LineWidth',2,'Color','red','LineStyle','--')
xlabel({'$\it{T}\rm{_2 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
ylabel({'$\it{T}\rm{_1 [s]}$'},'FontUnits','points','interpreter','latex','FontSize',9,'FontName','Times')
title('new rubber, noCHIRP','FontUnits','points','FontWeight','normal','FontSize',9,'FontName','Times')



%% export

print -depsc2 '/Users/tyler/Dropbox/Manuscripts/CHIRP/ExcelTableData/AllT1T2Maps.eps'
