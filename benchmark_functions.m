%% Cite This Article: N. B. Mohamadwasel and A. Ma'arif, "NB Theory with Bargaining Problem: A New Theory," Int. J. Robot. Control Syst., vol. 2, no. 3, pp. 606–609, Sep. 2022.

function f = benchmark_functions(name)
    switch lower(name)
        case 'sphere'
            f = @(x) sum(x.^2);
        case 'rastrigin'
            f = @(x) 10 * numel(x) + sum(x.^2 - 10 * cos(2 * pi * x));
        case 'rosenbrock'
            f = @(x) sum(100*(x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2);
        case 'ackley'
            f = @(x) -20 * exp(-0.2 * sqrt(mean(x.^2))) - exp(mean(cos(2*pi*x))) + 20 + exp(1);
        case 'beale'
            f = @(x) (1.5 - x(1) + x(1)*x(2))^2 + ...
                     (2.25 - x(1) + x(1)*x(2)^2)^2 + ...
                     (2.625 - x(1) + x(1)*x(2)^3)^2;
        otherwise
            error('Unknown benchmark function');
    end
end
