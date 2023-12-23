function [val] = fib(n)
    if n <= 0
        error('The number "n" should be greater than or equal to 1.');
    elseif n == 1 || n == 2
        val = 1;
    else
        val = fib(n - 1) + fib(n - 2);
    end
end
