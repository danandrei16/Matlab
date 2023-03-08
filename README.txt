Proximal:

proximal_2x2: Dupa ce aflu nr de puncte, parcurg fiecare pixel si aproximez pe cel mai apropia
si formez matricea.

proximal_resize: calculez factori de scalare, construiesc matricea si inversa ei cu Gram Schmidt,
Parcurg matricea, fac transformarea inversa, calculez xp, yp si retin valoarea pixelului.

proximal_rotate: calculez cos, sin si formez matricea si inversa ei. Trec (xp, yp) in sistemul
de coordonate. Daca ma aflu in afara imaginii, pixelul va fi negru, altfel aflu punctele, apoi
coeficientii de interpolare. La final calculez valoarea interpolata pixelului respectiv.

Bicubic:

fx, fy, fxy: am calculat derivatele functiei dupa formulele din pdf

precalc_d: pornesc cu o matrice de zero-uri si calculez derivatele pe care le retin in matrice
(termen cu termen; marginile au derivata 0)

bicubic_coef: inmultesc cele 3 matrici date in enunt pentru a obtine matricea A

bicubic_resize: proces similar cu resize-ul anterior, dar respect cerintele pentru bicubic

Functiile RGB: extrag canalele (1 - rosu, 2 - verde, 3 - albastru), aplic functia respectiva
cerintei si formez imaginea in 'out'