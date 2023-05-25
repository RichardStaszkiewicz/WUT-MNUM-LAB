function alpha = stepAlpha(x, epsilonW, epsilonB, delta)
    epsilon = abs(x) * epsilonW + epsilonB;
    alpha = min((epsilon ./ abs(delta)) .^ (1/5));
end
