%% Cite This Article: N. B. Mohamadwasel and A. Ma'arif, "NB Theory with Bargaining Problem: A New Theory," Int. J. Robot. Control Syst., vol. 2, no. 3, pp. 606–609, Sep. 2022.

function plot_all_benchmarks()
    %% Settings
    funcs = {'sphere', 'rastrigin', 'rosenbrock', 'ackley', 'beale'};
    bounds = [-5, 5];

    for i = 1:length(funcs)
        name = funcs{i};
        f = benchmark_functions(name);

        [X, Y] = meshgrid(bounds(1):0.25:bounds(2));
        Z = arrayfun(@(x, y) f([x, y]), X, Y);

        figure;
        surf(X, Y, Z, 'EdgeColor', 'none');
        colormap turbo;
        title(['Surface Plot - ' upper(name)]);
        xlabel('x'); ylabel('y'); zlabel('f(x, y)');
        view(135, 35);
    end
end
