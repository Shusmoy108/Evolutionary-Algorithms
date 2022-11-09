    
function value=Rosenbrock(x)

    %%  Rosenbrock's function
    %   Minimum: f(1,1) = 0
    value  =  (1-x(1)).^2 + 100*(x(2)-x(1).^2).^2;
%     n_x    = 2;                           % 'n_x' states
%     limits = repmat([-5 5], n_x, 1);      % Boundaries
%     obj    = 0;                           % objective value (f(x_min) = obj)
    
    