% Copyright (c) 2018 Gopalakrishnan, Krishnakumar <krishnak@vt.edu>
% Author: Gopalakrishnan, Krishnakumar <krishnak@vt.edu>

clear;clc; format short g; format compact; close all;

%% Load user data, pre-process and run simulation loop
run('user_inputs_for_sim.m');
run('pre_process_script.m');
load('p2d_sim_Jul_09_2018_14_04_28');
run('quadratic_ce_model_loop.m');
run('postprocess_quadratic_results.m');

%% Obtain ce interpolated at the right location
z_neg_newconvention = linspace(param_p2d{1}.len_n/(2*param_p2d{1}.Nn),param_p2d{1}.len_n - (param_p2d{1}.len_n/(2*param_p2d{1}.Nn)),param_p2d{1}.Nn);
z_sep_newconvention = linspace(param_p2d{1}.len_s/(2*param_p2d{1}.Ns),param_p2d{1}.len_s - (param_p2d{1}.len_s/(2*param_p2d{1}.Ns)),param_p2d{1}.Ns);
z_pos_newconvention = linspace(param_p2d{1}.len_p/(2*param_p2d{1}.Np),param_p2d{1}.len_p - (param_p2d{1}.len_p/(2*param_p2d{1}.Np)),param_p2d{1}.Np);

z_neg_p2d_plot = linspace(0,param_p2d{1}.len_n,Nn);
z_sep_p2d_plot = linspace(0,param_p2d{1}.len_s,Ns);
z_pos_p2d_plot = linspace(0,param_p2d{1}.len_p,Np);

x_cell_p2d_plot_um = [z_neg_p2d_plot,param_p2d{1}.len_n + z_sep_p2d_plot, param_p2d{1}.len_n + param_p2d{1}.len_s + z_pos_p2d_plot]*1e6; % um
x_cell_newconvention = [z_neg_newconvention, param_p2d{1}.len_n+z_sep_newconvention, param_p2d{1}.len_n + param_p2d{1}.len_s + z_pos_newconvention];
x_cell_newconvention_um = x_cell_newconvention*1e6;

ce_pos_p2d = ce_results_p2d(:,1:param_p2d{1}.Np);
ce_sep_p2d = ce_results_p2d(:,param_p2d{1}.Np+1:param_p2d{1}.Np+param_p2d{1}.Ns);
ce_neg_p2d = ce_results_p2d(:,param_p2d{1}.Np+param_p2d{1}.Ns+1:end);

ce_neg_p2d_newconvention = fliplr(ce_neg_p2d);
ce_sep_p2d_newconvention = fliplr(ce_sep_p2d);
ce_pos_p2d_newconvention = fliplr(ce_pos_p2d);

% cep2d_newconvention = [ce_neg_p2d_newconvention,ce_sep_p2d_newconvention,ce_pos_p2d_newconvention];

%% Plot setup
golden_ratio = 1.618;
fig_width_factor = 1;
fig_ht_factor = 0.7;
ax_width_factor = 0.75;

figW_cm = 15.74776*fig_width_factor; % textwidth (cm) reported by thesis latex doc from layouts package. Additonally include a scaling factor
figH_cm = figW_cm*golden_ratio*fig_ht_factor;

n_axes_w = 2; % how many horizontal/width-wise axes?
n_axes_ht = 3;  % how many vertical axes?

marg_w_left = 1.25; % cm
marg_w_right = 0.5; % cm
marg_ht_top = 0.5; % cm
marg_ht_bottom = 1.25; %cm
gap_ht = 1; % cm
gap_w = 1.25; % cm

run('setup_line_colors.m'); % deletes axes/clears plots

%% Plot
set(0,'defaultaxesfontsize',12 ...
    ,'defaultaxeslinewidth',2 ...
    ,'defaultlinelinewidth',1 ...
    ,'defaultpatchlinewidth',1);

[ha, pos] = tight_subplot_cm(n_axes_ht, n_axes_w, [gap_ht gap_w],[marg_ht_bottom marg_ht_top],[marg_w_left marg_w_right],figH_cm,figW_cm);

axes(ha(1));
ce_neg_tplot1_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot1_idx,:)','smoothingspline');
ce_neg_p2d_tplot1 = feval(ce_neg_tplot1_fittedObj,z_neg_p2d_plot);

ce_sep_tplot1_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot1_idx,:)','smoothingspline');
ce_sep_p2d_tplot1 = feval(ce_sep_tplot1_fittedObj,z_sep_p2d_plot);

ce_pos_tplot1_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot1_idx,:)','smoothingspline');
ce_pos_p2d_tplot1 = feval(ce_pos_tplot1_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot1 = [ce_neg_p2d_tplot1;ce_sep_p2d_tplot1;ce_pos_p2d_tplot1];

plot(x_cell_p2d_plot_um,ce_p2d_tplot1,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot1,'color',line_colors(1,:));
hold off;


axes(ha(2));
ce_neg_tplot2_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot2_idx,:)','smoothingspline');
ce_neg_p2d_tplot2 = feval(ce_neg_tplot2_fittedObj,z_neg_p2d_plot);

ce_sep_tplot2_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot2_idx,:)','smoothingspline');
ce_sep_p2d_tplot2 = feval(ce_sep_tplot2_fittedObj,z_sep_p2d_plot);

ce_pos_tplot2_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot2_idx,:)','smoothingspline');
ce_pos_p2d_tplot2 = feval(ce_pos_tplot2_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot2 = [ce_neg_p2d_tplot2;ce_sep_p2d_tplot2;ce_pos_p2d_tplot2];

plot(x_cell_p2d_plot_um,ce_p2d_tplot2,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot2,'color',line_colors(1,:));
hold off;


axes(ha(3));
ce_neg_tplot3_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot3_idx,:)','smoothingspline');
ce_neg_p2d_tplot3 = feval(ce_neg_tplot3_fittedObj,z_neg_p2d_plot);

ce_sep_tplot3_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot3_idx,:)','smoothingspline');
ce_sep_p2d_tplot3 = feval(ce_sep_tplot3_fittedObj,z_sep_p2d_plot);

ce_pos_tplot3_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot3_idx,:)','smoothingspline');
ce_pos_p2d_tplot3 = feval(ce_pos_tplot3_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot3 = [ce_neg_p2d_tplot3;ce_sep_p2d_tplot3;ce_pos_p2d_tplot3];

plot(x_cell_p2d_plot_um,ce_p2d_tplot3,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot3,'color',line_colors(1,:));
hold off;


axes(ha(4));
ce_neg_tplot4_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot4_idx,:)','smoothingspline');
ce_neg_p2d_tplot4 = feval(ce_neg_tplot4_fittedObj,z_neg_p2d_plot);

ce_sep_tplot4_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot4_idx,:)','smoothingspline');
ce_sep_p2d_tplot4 = feval(ce_sep_tplot4_fittedObj,z_sep_p2d_plot);

ce_pos_tplot4_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot4_idx,:)','smoothingspline');
ce_pos_p2d_tplot4 = feval(ce_pos_tplot4_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot4 = [ce_neg_p2d_tplot4;ce_sep_p2d_tplot4;ce_pos_p2d_tplot4];

plot(x_cell_p2d_plot_um,ce_p2d_tplot4,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot4,'color',line_colors(1,:));
hold off;


axes(ha(5));
ce_neg_tplot5_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot5_idx,:)','smoothingspline');
ce_neg_p2d_tplot5 = feval(ce_neg_tplot5_fittedObj,z_neg_p2d_plot);

ce_sep_tplot5_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot5_idx,:)','smoothingspline');
ce_sep_p2d_tplot5 = feval(ce_sep_tplot5_fittedObj,z_sep_p2d_plot);

ce_pos_tplot5_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot5_idx,:)','smoothingspline');
ce_pos_p2d_tplot5 = feval(ce_pos_tplot5_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot5 = [ce_neg_p2d_tplot5;ce_sep_p2d_tplot5;ce_pos_p2d_tplot5];

plot(x_cell_p2d_plot_um,ce_p2d_tplot5,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot5,'color',line_colors(1,:));
hold off;


axes(ha(6));
ce_neg_tplot6_fittedObj = fit(z_neg_newconvention',ce_neg_p2d_newconvention(tplot6_idx,:)','smoothingspline');
ce_neg_p2d_tplot6 = feval(ce_neg_tplot6_fittedObj,z_neg_p2d_plot);

ce_sep_tplot6_fittedObj = fit(z_sep_newconvention',ce_sep_p2d_newconvention(tplot6_idx,:)','smoothingspline');
ce_sep_p2d_tplot6 = feval(ce_sep_tplot6_fittedObj,z_sep_p2d_plot);

ce_pos_tplot6_fittedObj = fit(z_pos_newconvention',ce_pos_p2d_newconvention(tplot6_idx,:)','smoothingspline');
ce_pos_p2d_tplot6 = feval(ce_pos_tplot6_fittedObj,z_pos_p2d_plot);
ce_p2d_tplot6 = [ce_neg_p2d_tplot6;ce_sep_p2d_tplot6;ce_pos_p2d_tplot6];

plot(x_cell_p2d_plot_um,ce_p2d_tplot6,'color',line_colors(2,:));
hold on;
plot(x_cell_p2d_plot_um,ce_quadratic_tplot6,'color',line_colors(1,:));
hold off;