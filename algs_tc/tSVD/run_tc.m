function T_hat = run_tc(params)
  T = params.T;
  Omega = params.Idx;
  
  %Omega = find(Idx);
  %Ak = T(Omega);
  
  %% ====================== Load data ==============================
  normalize              =        max(T(:))                     ;
  Xn                     =        T/normalize                   ;
  [n1,n2,n3]             =        size(Xn)                      ;

  %p                      =        0.5                           ;
  %Omega                  =        zeros(size(Xn))               ;
  %chosen                 =        randperm(n1*n2*n3,...
  %                                       round(p*n1*n2*n3))     ;
  %Omega(chosen)          =        1                             ;

  alpha                  =        1                             ;
  maxItr                 =        100                          ; % maximum iteration
  rho                    =        0.01                          ;
  myNorm                 =        'tSVD_1'                      ; % dont change for now

  A                      =        diag(sparse(double(Omega(:)))); % sampling operator
  b                      =        A * Xn(:)                     ; % available data
  bb                     =        reshape(b,[n1,n2,n3]);

  %% ================ main process of completion =======================
  X   =    tensor_cpl_admm( A , b , rho , alpha , ...
                       [n1,n2,n3] , maxItr , myNorm , 0 );
  X                      =        X * normalize                 ;
  T_hat                  =        reshape(X,[n1,n2,n3])         ;

  %X_dif                  =        T-X                           ;
  %RSE                    =        norm(X_dif(:))/norm(T(:))     ;
end
