function R = proximal_rotate(I, rotation_angle)
    % =========================================================================
    % Roteste imaginea alb-negru I de dimensiune m x n cu unghiul rotation_angle,
    % aplic�nd Interpolare Proximala.
    % rotation_angle este exprimat �n radiani.
    % =========================================================================
    [m n nr_colors] = size(I);
    I = double(I);
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    endif

    % Obs:
    % Atunci c�nd se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % �n Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza �n indici de la 1 la n si se inmultesc x si y cu s_x respectiv s_y,
    % atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici �n intervalul [0, n - 1].

    % TODO: Calculeaza cosinus si sinus de rotation_angle.
    c = cos(rotation_angle);
    s = sin(rotation_angle);
    % TODO: Initializeaza matricea finala.
    R = zeros(m, n);
    % TODO: Calculeaza matricea de transformare.
    T = [c, -s; s, c];
    % TODO: Inverseaza matricea de transformare, FOLOSIND doar functii predefinite!
    T_Inv = PR_Inv(T);
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : m - 1
        for x = 0 : n - 1
            % TODO: Aplica transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            Z = T_Inv * [x, y]';
            xp = Z(1);
            yp = Z(2);
            % TODO: Trece (xp, yp) din sistemul de coordonate [0, n - 1] �n
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            xp = xp + 1;
            yp = yp + 1;
            % TODO: Daca xp sau yp se afla �n exteriorul imaginii,
            % se pune un pixel negru si se trece mai departe.
            if xp < 1 || xp > n || yp < 1 || yp > m
              R(y + 1, x + 1) = 0;
              continue;
            endif
            % TODO: Afla punctele ce �nconjoara(xp, yp).
            x1 = floor(xp);
            x2 = floor(xp) + 1;
            
            y1 = floor(yp);
            y2 = floor(yp) + 1;
            
            if y1 == m
              y2 = y2 - 1;
            endif
            if x1 == n
              x2 = x2 - 1;
            endif
            
            % TODO: Calculeaza coeficientii de interpolare notati cu a
            % Obs: Se poate folosi o functie auxiliara �n care sau se calculeze coeficientii,
            % conform formulei.
            A = zeros(4, 4);
            A = [1, x1, y1, x1 * y1;
                 1, x1, y2, x1 * y2;
                 1, x2, y1, x2 * y1;
                 1, x2, y2, x2 * y2];
        
            b = zeros(4, 1);
            b = double(b);
            b = [I(y1, x1), I(y2, x1), I(y1, x2), I(y2, x2)]';
            
            a = A \ b;
            % TODO: Calculeaza valoarea interpolata a pixelului (x, y).
            R(y + 1, x + 1) = a(1) + a(2) * xp + a(3) * yp + a(4) * xp * yp;
        endfor
    endfor

    % TODO: Transforma matricea rezultata �n uint8 pentru a fi o imagine valida.
    R = uint8(R);
endfunction