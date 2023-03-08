function x = Upper_System(N, A, b)
    % Rezolva Ax = b recursiv (formula din lab)
    x = zeros(N, 1);
    for i = N : -1 : 1
        %x(i) = zeros(1, N);
        s = 0;
        for j = i + 1 : N
            s = s + A(i, j) * x(j);
        endfor
        x(i) = (b(i) - s) / A(i, i);
    endfor
endfunction

