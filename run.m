%% Run file for the code of 'Believe me when I say green'

% this file runs the model for given parameters and initial conditions

% it allows to run the model for a single configuration of for multiple
% configurations (changing two inputs at the time). Multiple configurations
% testing is instrumental to the sensitivity analysis perfomed in the paper.


clear

%% Set configurations

% To run a SINGLE configuration: input values at line 36

% To run MULTIPLE configurations: three steps required

% i. Define the two inputs on which sensitivity analysis should be run
sens_par_name_1 = "$\bar g_\tau$";
sens_par_name_2 = "$c$";
% ii. Define the range of the sensitivity analysis 
sens_par_range_1=0:0.0002:0.02; 
sens_par_range_2=0:0.01:1; %0.5; 
% iii. Change the assigned value at line 36 and below to "sens_par_1" and "sens_par_2"
% e.g. to run multiple commitments values (c) as indicated in the range of line 22, at line 50 write:
% c=sens_par_1;

%% Start loops over configurations  
% Initialize the second scenario count parameter
sens_run_2=  0;
% Start of the second sensitivity analysis loop
for sens_par_2 = sens_par_range_2    
    sens_run_2 = sens_run_2+1;
    % Initialize the first scenario count parameter
    sens_run_1 = 0;
    % Start of the first sensitivity analysis loop
    for sens_par_1=sens_par_range_1
        sens_run_1 = sens_run_1+1;

%% Parameter setting
        % NB. If sensitivity analysis is run, the chosen parameters must be assigned the ranges specified above
        R               = 120;                                  %planning horizon
        T               = 320+R;                                %time
        N               = 2;                                    %set of technologies
        J               = 2;                                    %set of expectation rules                                                                      
        eta             = 0.5;                                  %memory parameter
        beta            = 1;                                    %belief responsiveness
        gamma           = 1;                                  %investment responsiveness
        g_tax           = sens_par_1; %0.016; %0.02;                                 %tax target growth rate 
        a               = 1;                                    %vulnerability to transition risks
        c               = sens_par_2; %1;                                  %commitment
        delta           = 0.018;                                %capital depreciation rate 
        g_Y             = 0.005;                                %exogenous expansion of productive capacity 
        initial_tax     = 0.15; %0.21; %0.1;                                  %initial tax target
        epsilon         = 0;                                    %sceptics' discount of announced tax growth rate
        g_sk            = epsilon*g_tax;                        %tax growth rate expected by skeptics
        g_b             = g_tax;                                %tax gowth rate expected by believers
        rho             = 0.017;                                %discount rate 
        D               = 1/(1+rho);                            %discount factor 
        initial_kappa   = 0.2;                                  %initial clean capital share 
        initial_lc_cost = 1.36;                                 %initial ratio of low-carbon to high-carbon costs 
        g_thetal        = 0;                                %growth rate of cost efficiency of low-carbon technology 
        
        %% Run model
        % Model equations are called as a function file
        output = model_function(R,T,N,J,eta,beta,gamma,g_tax,a,c,delta,g_Y,initial_tax,g_sk,g_b,D,initial_kappa,initial_lc_cost,g_thetal);
        load(output)
       
        %% Store results
        % Results are stored into a structure with specific fields for most relevant variables
        sens_res(sens_run_1,sens_run_2).name            =   "SensitivityRun_for_"+sens_par_name_1+"="+sens_par_1+"_and_"+sens_par_name_2+"="+sens_par_2+"";
        sens_res(sens_run_1,sens_run_2).D               =   D;
        sens_res(sens_run_1,sens_run_2).tax             =   tax(:,2);
        sens_res(sens_run_1,sens_run_2).tax_target      =   tax_target;
        sens_res(sens_run_1,sens_run_2).K               =   K(:,1);
        sens_res(sens_run_1,sens_run_2).chi_agg         =   chi_agg;
        sens_res(sens_run_1,sens_run_2).theta           =   theta(:,1);
        sens_res(sens_run_1,sens_run_2).diff_Ec_t       =   Ec_t(:,1);
        sens_res(sens_run_1,sens_run_2).n               =   n;
        sens_res(sens_run_1,sens_run_2).totI            =   totI;
        sens_res(sens_run_1,sens_run_2).pi_pot          =   pi_pot;
        sens_res(sens_run_1,sens_run_2).pi_actual       =   pi_actual;
        sens_res(sens_run_1,sens_run_2).kappa           =   kappa(:,1);
        sens_res(sens_run_1,sens_run_2).trans_rate      =   trans_rate;
        sens_res(sens_run_1,sens_run_2).tax_target_t    =   tax_target_t;
        sens_res(sens_run_1,sens_run_2).U_b             =   U(:,1);
        sens_res(sens_run_1,sens_run_2).U_s             =   U(:,2);
        sens_res(sens_run_1,sens_run_2).chi_b           =   chi(:,1);
        sens_res(sens_run_1,sens_run_2).chi_s           =   chi(:,2);
             
    end 
end 



