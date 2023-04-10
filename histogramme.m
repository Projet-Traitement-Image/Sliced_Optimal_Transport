function H = histogramme (I) % fonction qui prend en paramètre une image I
    % et retourne une image res (négatif)
    [m, n, can] = size(I); % m=nb lignes, n=nb colonnes, can=nb canaux
    H = zeros (1, 256); % image résultante (de même taille que I) :
    % initialisée à 0 partout
    if(can > 1)
    I = rgb2gray(I); % si l’image est en couleur, la transformer en NG
    end
    for i=1:m
        for j=1:n
            H(1 + I(i,j)) = H(1 + I(i,j)) + 1;
        end
    end
end
