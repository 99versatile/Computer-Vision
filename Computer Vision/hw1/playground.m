A = [1, 2, 3; 4, 5, 6];
B = [7, 8; 9, 10; 11, 12];

C = matrix_product(A, B);
disp(C);

%%
C_matmul = A * B;
disp(C_matmul);

%%
A = [1, 2; 3, 4];
B = normalize_rows(A);
disp(B);

%%
A = [1, 2; 3, 4];
B = normalize_columns(A);
disp(B);

%% 
n = 7;
fibonacci_number = fib(n);
fprintf('The %d-th Fibonacci number is %d.\n', n, fibonacci_number);

%%
M1 = [1, 2; 3, 4; 3, 4];
N1 = my_unique(M1);
disp(N1);

%%
M2 = [1, 2; 3, 4; 3, 4; 5, 6; 1, 2];
N2 = my_unique(M2);
disp(N2);

%% 
lookfor isequal