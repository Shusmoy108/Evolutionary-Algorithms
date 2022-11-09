  function value=Ackley(x)

    %%  Ackley's function
    %   Minimum:  f(0,0) = 0
    value = -20*exp(-0.2*sqrt(0.5*(x(1).^2 + x(2).^2)))...
          - exp(0.5*(cos(2*pi*x(1)) + cos(2*pi*x(2)))) + 20 + exp(1);
      
%     n_x    = 2;                           % 'n_x' states
%     limits = repmat([-5 5], n_x, 1);      % Boundaries
%     obj    = 0;                           % objective value (f(x_min) = obj)