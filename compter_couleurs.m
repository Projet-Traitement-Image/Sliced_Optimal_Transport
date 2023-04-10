function [tab_couleurs, nombre] = compter_couleurs(I)
 % On récupère les dimensions de l'image
 [m, n, ~] = size(I);
 %On crée un tableau contenant les couleurs de l'image
 tab_couleurs = zeros(m*n, 3);
 tab_couleurs_temp = zeros(m*n, 3);
 %On sépare les différents canaux R, G et B de l'image
 Red_channel = I(:,:,1);
 Green_channel = I(:,:,2);
 Blue_channel = I(:,:,3);
 
 compteur = 1;
 %On parcours l'ensemble des pixels de l'image
 for i = 1:m
     for j = 1:n
         %On ajoute toutes les couleurs dans le tableau temporaire 
         tab_couleurs_temp(compteur, 1) = Red_channel(i,j);
         tab_couleurs_temp(compteur, 2) = Green_channel(i,j);
         tab_couleurs_temp(compteur, 3) = Blue_channel(i,j);
         compteur = compteur + 1;
     end
 end
 
 %On trie le tableau sur les trois colonnes
 tab_couleurs_trie = sortrows(tab_couleurs_temp, [1 2 3]);
 %On crée un compteur pour les couleurs uniques
 nombre = 1;
 %On ajoute la première couleur dans le tableau des couleurs uniques
 tab_couleurs(nombre, 1) = tab_couleurs_trie(nombre, 1);
 tab_couleurs(nombre, 2) = tab_couleurs_trie(nombre, 2);
 tab_couleurs(nombre, 3) = tab_couleurs_trie(nombre, 3);
 nombre = nombre + 1;
 
 %On parcours le tableau des couleurs triées
 for i = 2:m*n
     %Si la couleur n'est pas égale à la précédente, on l'ajoute dans le
     %tableau des couleurs
     if tab_couleurs_trie(i, 1) ~= tab_couleurs_trie(i-1, 1) || tab_couleurs_trie(i, 2) ~= tab_couleurs_trie(i-1, 2) || tab_couleurs_trie(i, 3) ~= tab_couleurs_trie(i-1, 3)
         tab_couleurs(nombre, 1) = tab_couleurs_trie(i, 1);
         tab_couleurs(nombre, 2) = tab_couleurs_trie(i, 2);
         tab_couleurs(nombre, 3) = tab_couleurs_trie(i, 3);
         nombre = nombre + 1;
     end
 end
end
