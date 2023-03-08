function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
    [N, M] = size(A); % dim lui A
    Q = zeros(N);
    R = zeros(N);
    for i = 1:N
        R(i, i) = norm(A(:, i));
        Q(:, i) = A(:, i) / R(i, i);
        for j = i + 1 : N
            R(i, j) = Q(:, i)' * A(:, j);
            A(:, j) = A(:, j) - R(i, j) * Q(:, i);
        endfor
    endfor
    % Deci am Q * R = A => R * (A)^(-1) = Q'
    
    B = zeros(N);
    Q = Q';
    for i = 1 : N % rezolv cele N sisteme 
        B(:, i) = Upper_System(N, R, Q(:, i));
    endfor
endfunction