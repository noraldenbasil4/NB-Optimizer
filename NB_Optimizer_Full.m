%% Cite This Article: N. B. Mohamadwasel and A. Ma'arif, "NB Theory with Bargaining Problem: A New Theory," Int. J. Robot. Control Syst., vol. 2, no. 3, pp. 606–609, Sep. 2022.

function NB_Optimizer_Full()
    %% -----------------------------
    % Example: Minimize Sphere Function
    % f(x) = sum(x.^2)
    % -----------------------------
    objective_func = @(x) sum(x.^2);
    n_vars = 5;
    lb = -10 * ones(1, n_vars);
    ub = 10 * ones(1, n_vars);
    max_iter = 100;

    % Call NB Optimizer
    [best_solution, best_fitness] = NB_Optimizer(objective_func, n_vars, lb, ub, max_iter);
    
    fprintf('Best Solution: %s\n', mat2str(best_solution, 4));
    fprintf('Best Fitness: %.4f\n', best_fitness);
end

%% ------------------------------------
% Core NB Optimizer: Chooses Best Algorithm
% ------------------------------------
function [best_solution, best_fitness] = NB_Optimizer(fobj, nvar, lb, ub, max_iter)
    algorithms = {@GA_Optimizer, @PSO_Optimizer, @DE_Optimizer};
    algo_names = {'Genetic Algorithm', 'Particle Swarm Optimization', 'Differential Evolution'};
    scores = zeros(length(algorithms), 1);
    test_iter = round(0.2 * max_iter);

    % Test each algorithm briefly
    for i = 1:length(algorithms)
        fprintf('Testing %s...\n', algo_names{i});
        [~, fit] = algorithms{i}(fobj, nvar, lb, ub, test_iter);
        scores(i) = fit(1);  % Ensure it's a scalar
    end

    % Select the best-performing algorithm
    [~, best_idx] = min(scores);
    fprintf('\n Selected Optimizer: %s\n', algo_names{best_idx});
    [best_solution, best_fitness] = algorithms{best_idx}(fobj, nvar, lb, ub, max_iter);
end

%% -------------------
% Genetic Algorithm
% -------------------
function [best_sol, best_fit] = GA_Optimizer(fobj, nvar, lb, ub, max_iter)
    options = optimoptions('ga', ...
        'Display', 'off', ...
        'MaxGenerations', max_iter, ...
        'PopulationSize', 30);
    [best_sol, best_fit] = ga(fobj, nvar, [], [], [], [], lb, ub, [], options);
end

%% -------------------
% Particle Swarm Optimization
% -------------------
function [best_sol, best_fit] = PSO_Optimizer(fobj, nvar, lb, ub, max_iter)
    options = optimoptions('particleswarm', ...
        'Display', 'off', ...
        'MaxIterations', max_iter, ...
        'SwarmSize', 30);
    [best_sol, best_fit] = particleswarm(fobj, nvar, lb, ub, options);
end

%% -------------------
% Differential Evolution (Basic Implementation)
% -------------------
function [best_sol, best_fit] = DE_Optimizer(fobj, nvar, lb, ub, max_iter)
    pop_size = 30;
    F = 0.8; Cr = 0.9;
    pop = rand(pop_size, nvar) .* (ub - lb) + lb;
    fitness = zeros(pop_size, 1);
    for i = 1:pop_size
        fitness(i) = fobj(pop(i, :));
    end

    for iter = 1:max_iter
        for i = 1:pop_size
            idxs = randperm(pop_size, 3);
            x1 = pop(idxs(1), :);
            x2 = pop(idxs(2), :);
            x3 = pop(idxs(3), :);
            v = x1 + F * (x2 - x3);
            jrand = randi(nvar);
            u = pop(i, :);
            for j = 1:nvar
                if rand < Cr || j == jrand
                    u(j) = v(j);
                end
            end
            u = max(min(u, ub), lb);
            fit_u = fobj(u);
            if fit_u < fitness(i)
                pop(i, :) = u;
                fitness(i) = fit_u;
            end
        end
    end
    [best_fit, idx] = min(fitness);
    best_sol = pop(idx, :);
end
