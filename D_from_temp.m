function D = D_from_temp(T,D0,Q)

%Some initializations
R=2;
%

%Find diffusion coefficient
D=(D0)*exp(-Q/(R*T));
%

end

