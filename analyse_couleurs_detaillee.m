function [tab_distances, tab_distances_corr, Im_corrigee, compteur_correction] = analyse_couleurs_detaillee(tab_couleurs_Ref, nb_couleurs_Ref, tab_couleurs_Spe, nb_couleurs_Spe, Im_Spe, seuil)
    %On commence par passer les deux tableaux de couleurs en double
    %pour faciliter les calculs
    tab_couleurs_Ref = double(tab_couleurs_Ref);
    tab_couleurs_Spe = double(tab_couleurs_Spe);
    
    %On récupère les 3 canaux de l'image obtenue après spécification
    Red_channel_spe = Im_Spe(:,:,1);
    Green_channel_spe = Im_Spe(:,:,2);
    Blue_channel_spe = Im_Spe(:,:,3);
    
    %On crée le tableau des différences de couleurs
    %égal au nombre de couleurs dans l'image obtenue après la spécification
    tab_distances = zeros(1, nb_couleurs_Spe - 1);
    %On fait de même pour le tableau de l'image corrigée
    tab_distances_corr = zeros(1, nb_couleurs_Spe - 1);
    
    %On crée un compteur sur les couleurs qui seront corrigées par la
    %fonction
    compteur_correction = 0;
    
    %On parcourt ensuite le tableau de couleurs de l'image obtenues après
    %spécification
    for i = 1:nb_couleurs_Spe-1
        %On récupère les différentes valeurs de canal RGB
        Red_spe = tab_couleurs_Spe(i, 1);
        Green_spe = tab_couleurs_Spe(i, 2);
        Blue_spe = tab_couleurs_Spe(i, 3);
        %puis on regarde si cette couleur se retrouve dans l'image de
        %référence
        estIdentique = false;
        j = 1;
        distance = 10000.0;
        %On définit des variables pour stocker les valeurs des canaux
        %RGB de la couleur la plus proche de la couleur
        %de l'image obtenue après spécification
        Red_temp = 0;
        Green_temp = 0;
        Blue_temp = 0;
        while ~estIdentique && j < nb_couleurs_Ref
            %On compare les deux couleurs
            %On récupère les valeurs de la couleur de l'image de référence
            Red_ref = tab_couleurs_Ref(j, 1);
            Green_ref = tab_couleurs_Ref(j, 2);
            Blue_ref = tab_couleurs_Ref(j, 3);
            %si elles sont identiques
            if Red_spe == Red_ref && Green_spe == Green_ref && Blue_spe == Blue_ref
               estIdentique = true;
            else
                %Sinon on calcule la distance euclidienne entre ces deux couleurs
                distance_coul = sqrt((Red_spe - Red_ref)^2 + (Green_spe - Green_ref)^2 + (Blue_spe - Blue_ref)^2);
                if distance_coul < distance
                    distance = distance_coul;
                    %On conserve les valeurs des canaux RGB de cette
                    %couleur de référence
                    Red_temp = Red_ref;
                    Green_temp = Green_ref;
                    Blue_temp = Blue_ref;
                end
                j = j + 1;
            end
        end
        %Si les deux couleurs sont identiques, on met 0.0 dans le tableau
        %des distances
        if estIdentique
            tab_distances(1, i) = 0.0;
            tab_distances_corr(1, i) = 0.0;
        else
            %sinon on met la valeur de la plus petite distance obtenue
            tab_distances(1, i) = distance;
            %Et on met à jour les valeurs des canaux RGB de l'image obtenue
            %après spécification avec la couleur de l'image de référence la
            %plus proche
            %Si la distance dépasse la valeur de seuil fixé, alors on
            %modifie la couleur dans l'image corrigée
            if distance > seuil
                Red_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Red_temp;
                Green_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Green_temp;
                Blue_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Blue_temp;
                %On incrémente le compteur de couleurs corrigées
                compteur_correction = compteur_correction + 1;
                %On met la valeur de la distance pour la couleur corrigée à
                %0.0
                tab_distances_corr(1, i) = 0.0;
            else
                tab_distances_corr(1, i) = distance;
            end
        end
        disp(strcat('Nombre de couleurs restantes à analyser:', num2str(nb_couleurs_Spe - 1 - i))); 
    end
    %On refusionne les 3 canaux de l'image obtenue après la spécification
    %pour former l'image corrigée
    Im_corrigee = cat(3, Red_channel_spe, Green_channel_spe, Blue_channel_spe);
end


