function Im_diff = evaluation_distance(tab_distances, tab_couleurs, I_spe)
    %On récupère la taille de l'image
    [m,n,~] = size(I_spe);
    %tab_distances
    %On récupère la taille du tableau
    tab_size = size(tab_distances, 2);
    Im_diff = zeros(m,n);

    for i = 1:tab_size
        if tab_distances(1,i) == 0.0
           %On récupère tous les pixels dont la couleur est située au même indice
           Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 0;
        elseif tab_distances(1,i) > 0.0 && tab_distances(1,i) < 3.0
           Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 1;
        elseif tab_distances(1,i) >= 3.0 && tab_distances(1,i) < 10.0
           Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 2;
        elseif tab_distances(1,i) >= 10.0 && tab_distances(1,i) < 17.5
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 3;
        elseif tab_distances(1,i) >= 17.5 && tab_distances(1,i) < 25.0
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 4;
        else
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 5;
        end
    end
end

