%% Climate policy uncertainty model - Emanuele Campiglio, Francesco Lamperti, Roberta Terranova
 
function[output] = model_function(R,T,N,J,eta,beta,gamma,g_tax,a,c,delta,g_Y,initial_tax,g_sk,g_b,D,initial_kappa,initial_lc_cost)
 
%% Vectors
% Demand and supply
s                   =NaN(T,N);                % sectoral supply 
S                   =NaN(T,1);                % total supply

%Costs
theta               =NaN(T+1,N);             % cost of production of one unit of output with no carbon tax 
unit_cost           =NaN(T,N);               % unit cost of tehnology 
costs               =NaN(T,N);               % total costs of technology 

% Capital and investment
K                   =NaN(T,N);                 % capital stock
kappa               =NaN(T,N);                 % low- and high-carbon share of capital capital 
xi_k                =NaN(T+1,N);               % productivity of capital
I                   =NaN(T,N);                 % investment per technology 
totI                =NaN(T,1);                 % total investment
chi                 =NaN(T,J);                 % share of low-carbon investment for each expectation type               
chi_agg             =NaN(T,1);                 % overall share of low-carbon investment  

% Expectations
n                   =NaN(T,1);              % share of believers
n_s                 =NaN(T,1);              % share of sceptics
E_tax_b             =NaN(T,N);              % tax expected by believers updated in every t          
E_tax_s             =NaN(T,N);              % tax expected by skeptics updated in every t
E_tax               =NaN(T,N,J);            % matrix of expected tax
E_tax_allt_b        =NaN(T,T);              % schedule of expected tax believers
E_tax_allt_s        =NaN(T,T);              % schedule of expected tax sceptics
Ec_t                =NaN(T,J);              % schedule expected costs of high-carbon for both belief types
z1                  =NaN(T,J);              % investment choice logit numerator for both belief types - low-carbon
z2                  =NaN(T,J);              % investment choice logit numerator for both belief types - high-carbon 
sumz                =NaN(T,J);              % investment choice logit denominator for both belief types
U                   =NaN(T,J);              % fitness measure for belief choice
acc                 =NaN(T,J);              % squared prediction error 
z                   =NaN(T,1);              % belief choice logit numerator 
zz                  =NaN(T,1);              % belief choice logit denominator 

% Policy maker 
tax_target          =NaN(T,1);              % carbon tax target 
tax_target_t        =NaN(T,T);              % carbon tax target updated in every t
tax                 =NaN(T,N);              % carbon tax implemented
pi_pot              =NaN(T,1);              % potential transition risk index function
pi_actual           =NaN(T,1);              % actual transition risk index   
trans_rate          =NaN(T,1);              % speed of transition

%% Initial values
kappa(2,:)          =[initial_kappa, 1-initial_kappa]; 
K(2,:)              =155.2*[kappa(2,1),kappa(2,2)];
xi_k(:,:)           =0.3;
tax(1,2)            =initial_tax;   
tax(2,2)            =initial_tax;   
tax_target(2)       =initial_tax; 
E_tax_b(:,:)        =0;                     
E_tax_s(:,:)        =0;            
E_tax(:,:,:)        =0;   
E_tax(2,2,:)        =[tax_target(2),0];
U(1:3,:)            =[1,0.15;1,0.15;1,0.15]; 
n(1:3)              =0.3; 
n_s(1:3)            =0.7; 
theta(:,1)          =initial_lc_cost; 
theta(:,2)          =1;
    

%%  Carbon tax announcement 
    
    tax_targ_prev           =   tax_target(2);            
    for tt=3:T  
        tax_target(tt)  =   tax_targ_prev*(1 + g_tax);
        tax_targ_prev   =   tax_target(tt);
    end   

%% Tax expectations

    %Believers
    tax_targ_prev        = tax_target(2);                                          
    for tt=3:T  
        E_tax_b(tt,2)    = tax_targ_prev*(1+g_b);                                 % determine sceptics' expected tax schedule (if fixed)
        tax_targ_prev    = E_tax_b(tt,2);              
    end   
    
    %Sceptics
    tax_targ_prev        = tax_target(2);                                          
    for tt=3:T  
        E_tax_s(tt,2)    = tax_targ_prev*(1+g_sk);                                 % determine sceptics' expected tax schedule (if fixed)
        tax_targ_prev    = E_tax_s(tt,2);              
    end   
      
    E_tax            =  cat(3,E_tax_b,E_tax_s);
  
%% T-loop starts
for t=3:T
 
%% Expected costs and choice of technology 
    % Find the last t of firms' planning horizon
    if T-t>R 
       end_time=t+R;
    else 
       end_time=T;
    end 
    
    % Find net present value of expected production cost including carbon
    % tax
    Ec_lt   = (theta(t:end_time,:).*(1 + (E_tax(t:end_time,:,:))));            % schedule of expected production costs from t to end of planning horizon
    tt=t:end_time; 
    depr=D.^(tt-t);                                                            % discounting of future periods                                   
    Ec_lt_disc      =   sum(Ec_lt.*depr',1);                                   % net present value
    Ec_lt_disc      =   reshape(Ec_lt_disc,[],N);                              % obtain matrix of net present values at t      
    Ec_t(t,:)       =   [Ec_lt_disc(2,1),Ec_lt_disc(2,2)];                     
    
    z1(t,:)         =   exp(-gamma * Ec_lt_disc(1,:));                         % investment choice logit numerator - low-carbon capital for believers and sceptics      
    z2(t,:)         =   exp(-gamma * Ec_lt_disc(2,:));                         % investment choice logit numerator - high-carbon capital for believers and sceptics 
    sumz(t,:)       =   z1(t,:)+z2(t,:);                                       % sum of the two previous terms
    chi(t,:)        =   z1(t,:)./sumz(t,:);                                    % low-carbon investment share for both belief types
    chi_agg(t)      =   n(t-1).*chi(t,1) + n_s(t-1).*chi(t,2);                 % share of aggregate low-carbon investment in t
    
    totI(t)         =   sum(K(t-1,:))*(g_Y + delta);                           % total investment
    I(t,:)          =   [chi_agg(t)*totI(t),(1-chi_agg(t))*totI(t)];           % sectoral investments      
    K(t,:)          =   K(t-1,:)*(1 - delta) + I(t,:);                         % sectoral capital stock                                 
    kappa(t,:)      =   K(t,:)./sum(K(t,:));                                   % sectoral capital share
 
%% Carbon tax implemented      
    pi_pot(t)       =  1 - 1/(1 + a*(1-kappa(t,1))*tax_target(t));                 % compute potential transition risk index             
    tax(t,2)            =   c*tax_target(t) + (1-c)*tax_target(t)*(1-pi_pot(t));   % set actual tax 
    pi_actual(t)    = 1 - 1/(1 + a*(1-kappa(t,1))*tax(t,2));                       % compute actual transition risk index depending on actual tax 
          
%% Production 
    s(t,:)  =   K(t,:).*xi_k(t);                                                   % sectoral supply
    S(t)    =   sum(s(t,:));                                                       % total supply
       
%% Final good costs 
    unit_cost(t,:)  =   (theta(t,:).*(1 + tax(t,:)));                              % unit cost of production including tax 
    costs(t,:)      =   s(t,:).*unit_cost(t,:);                                    % sectoal costs
       
%% Belief switching  
    E_tax_t         =   reshape(E_tax(t,:,:),[N,J]);                               % expected tax in previous period by both belief types
    acc(t-1,:)      =   abs(tax(t,2) - E_tax_t(2,:));                              % absolute value of prediction errors
    U(t-1,:)        =   eta*acc(t-1,:) + (1-eta)*U(t-2,:);                         % fitness measure of expectation rules 
    z(t)            =   exp(-beta.*U(t-1,1));                                      % logit numerator 
    zz(t)           =   sum(exp(-beta*U(t-1,:)));                                  % logit denominator 
    n(t)            =   z(t)/zz(t);                                                % share of believers
    n_s(t)          =   1-n(t);                                                    % share of sceptics    
    
end 


%% Results
res=table(chi_agg, theta(1:T,1), K(:,1), Ec_t(:,1), n);
 
save('Results')
output='Results';
end
 
 
 
 


