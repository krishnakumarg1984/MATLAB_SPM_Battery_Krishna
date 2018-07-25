% Copyright (c) 2018 Gopalakrishnan, Krishnakumar <krishnak@vt.edu>
% Author: Gopalakrishnan, Krishnakumar <krishnak@vt.edu>

% clear;clc; format short g; format compact; close all;
golden_ratio = 1.618;

fig_width_factor = 1;
ax_width_factor = 0.8;
fig_ht_factor = 1.1;

figW_cm = 15.74776*fig_width_factor;     % textwidth (cm) reported by LaTeX doc with a scaling factor
figH_cm = figW_cm*fig_ht_factor/golden_ratio;

n_axes_w = 3; % how many horizontal/width-wise axes?
n_axes_ht = 3;  % how many vertical axes?

ax_width = (figW_cm/n_axes_w)*ax_width_factor;
ax_height = ax_width/golden_ratio;

% decision
% left_margin : gap_w : right_margin
gap_w_scale = 1.7;         % wrt to marg_w_left
marg_w_right_scale = 0.3;   % wrt to marg_w_left

% bottom_margin : gap_ht : top_margin
gap_ht_scale = 1.1;        % wrt to marg_ht_bottom
% gap_ht_scale = 2.5;        % wrt to marg_ht_bottom
% marg_ht_top_scale = 1.45;     % wrt to marg_ht_bottom
marg_ht_top_scale = 1;     % wrt to marg_ht_bottom

%%
marg_w_left = (figW_cm - n_axes_w*ax_width)/(1 + gap_w_scale + marg_w_right_scale);
gap_w = marg_w_left*gap_w_scale;
marg_w_right = marg_w_left*marg_w_right_scale;

marg_ht_bottom = (figH_cm - n_axes_ht*ax_height)/(1 + gap_ht_scale + marg_ht_top_scale);
gap_ht = marg_ht_bottom*gap_ht_scale;
marg_ht_top = marg_ht_bottom*marg_ht_top_scale;

run('setup_line_colors.m'); % deletes axes/clears plots
cbrewerintergray = [189,189,189]/255;
cbrewerdarkgray = [99,99,99]/255;
[ha, pos] = tight_subplot_cm(n_axes_ht, n_axes_w, [gap_ht gap_w],[marg_ht_bottom marg_ht_top],[marg_w_left marg_w_right],figH_cm,figW_cm);
movegui('center');
% return;
%% Post-process and plot
no_of_x_tick_points = 5;
no_of_y_tick_points = 5;

load('time_invariance.mat');
set(0,'defaultaxesfontsize',8,'defaultaxeslinewidth',0.5,'defaultlinelinewidth',0.5,'defaultpatchlinewidth',0.5);

clc;

axes(ha(2));
plot(u_1,'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$u_1(t)$');
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(1));
plot(Qen_P2d_y1,'color',line_colors(1,:)); 
title('$Q_{\mathrm{e,n}_1}(t)$');
xlim([0 tf+Ts]);
ax_handle = gca;
% ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(3));
plot(Qep_P2d_y1,'color',line_colors(1,:)); 
title('$Q_{\mathrm{e,p}_1}(t)$');
xlim([0 tf+Ts]);
ax_handle = gca;
% ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(5));
plot(u_2,'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$u_2(t)=u_1(t-\tau)$');
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(4));
plot(Qen_P2d_y2,'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$Q_{\mathrm{e,n}_2}(t)$');
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(6));
plot(Qep_P2d_y2,'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$Q_{\mathrm{e,p}_2}(t)$');
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
% return;

axes(ha(7));
plot(Qen_P2d_y2 - Qen_P2d_y1_delayed(1:end-delay_samples),'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$\qquad \qquad Q_{\mathrm{e,n}_2}(t) - Q_{\mathrm{e,n}_1}(t\!-\!\tau)$','FontSize',8);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
xlabel('time (s)');
% return;

axes(ha(9));
plot(Qep_P2d_y2 - Qep_P2d_y1_delayed(1:end-delay_samples),'color',line_colors(1,:));
xlim([0 tf+Ts]);
% ylabel('$u_1(t)\  (\mathrm{A})$');
% ha(2).YLabel.Units = 'normalized';
% ha(2).YLabel.Position(1) = -0.2;
title('$\qquad \qquad Q_{\mathrm{e,p}_2}(t) - Q_{\mathrm{e,p}_1}(t\!-\!\tau)$','FontSize',8);
ax_handle = gca;
ax_handle.YAxis.TickValues = linspace(ax_handle.YAxis.Limits(1),ax_handle.YAxis.Limits(2),no_of_y_tick_points); % not for voltage
ax_handle.XAxis.TickValues = linspace(ax_handle.XAxis.Limits(1),ax_handle.XAxis.Limits(2),no_of_x_tick_points);
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:)))); % remove scientific multipliers in x-axis format
xlabel('time (s)');
% return;

ha(8).Visible = 'off';
txtbox_str = {'The systems on the','left and right are','both time-invariant'};
txtbox_dim = [0.4 0.005 0.3 0.25];
txtbox = annotation('textbox',txtbox_dim,'String',txtbox_str,'FitBoxToText','on');
txtbox.EdgeColor = [1 1 1];
annotation('arrow',[.37 .325],[.81 .81]);
annotation('arrow',[.645 .69],[.81 .81]);
annotation('arrow',[.37 .325],[.5 .5]);
annotation('arrow',[.645 .69],[.5 .5]);
% txtbox.FontName = 'times';
return;
export_fig time_invariance.pdf -q101
%% 
return;
extra_axis_options = 'xticklabel style={/pgf/number format/1000 sep=, /pgf/number format/precision=0,/pgf/number format/fixed,/pgf/number format/fixed zerofill,},yticklabel style={/pgf/number format/1000 sep=, /pgf/number format/precision=2, /pgf/number format/fixed, }, ylabel absolute,';
extra_axis_options = [];
custom_m2t_fcn('time_invariance',[figW_cm,figH_cm]*10,[],false,extra_axis_options);
close;

return;

