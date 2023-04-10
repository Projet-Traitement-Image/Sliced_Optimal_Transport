function sliced_optimal_transport_RGB_brute(Ix, Iz)
  %On récupère les canaux rouge, vert et bleu des deux images
  R_Ix = Ix(:,:,1);
  V_Ix = Ix(:,:,2);
  B_Ix = Ix(:,:,3);

  R_Iz = Iz(:,:,1);
  V_Iz = Iz(:,:,2);
  B_Iz = Iz(:,:,3);

  %On fait la spécification de chaques canaux
  R_Res = specification(R_Ix, R_Iz);
  V_Res = specification(V_Ix, V_Iz);
  B_Res = specification(B_Ix, B_Iz);

  %Assemblage des trois canaux obtenus après spécification pour obtenir
  %l'image couleur résultante
  Image_res = cat(3, R_Res, V_Res, B_Res);
  
  %On récupère les couleurs de l'image source ainsi que leur nombre
  [tab_couleurs_Ix, nombre_Ix] = compter_couleurs(Ix);
  disp(strcat('L''image source possède ', num2str(nombre_Ix - 1), ' couleurs'));
  
  %On récupère les différentes couleurs ainsi que leur nombre
  %de l'image de référence
  [tab_couleurs_Iz, nombre_Iz] = compter_couleurs(Iz);
  disp(strcat('L''image de référence possède ', num2str(nombre_Iz - 1), ' couleurs'));
  
  %On fait de même pour l'image obtenue après la spécification
  [tab_couleurs_Res, nombre_Res] = compter_couleurs(Image_res);
  disp(strcat('L''image obtenue après la spécification possède ', num2str(nombre_Res - 1), ' couleurs'));
  
  %Puis on analyse les différences de couleurs entre l'image de référence
  % et celle obtenue après la spécification
  %On récupère également une image corrigée avec le nombre de couleurs qui
  %ont été corrigées dans l'image obtenue dans l'image obtenue après la
  %spécification
  %Pour ce faire, on définit un seuil de correction de couleurs
  %cad, si la distance euclidienne entre une couleur obtenue après
  %spécification et la couleur dans l'image de référence la plus proche
  %dépasse cette valeur, elle est corrigée
  seuil = 5.0;
  [Im_corrigee, nombre_correction] = analyse_couleurs_brute(tab_couleurs_Iz, nombre_Iz, tab_couleurs_Res, nombre_Res, Image_res, seuil);
  
  %On calcule le nombre de couleurs dans l'image corrigée
  [tab_couleurs_correction, nombre_coul_correction] = compter_couleurs(Im_corrigee);
  
  %On transforme la matrice des couleurs de l'image de référence
  %en vecteurs colonnes pour afficher
  %l'histogramme 3D avec scatter3
  couleurs_ref = tab_couleurs_Iz(1:nombre_Iz-1,:);
  x_ref = couleurs_ref(:,1);
  y_ref = couleurs_ref(:,2);
  z_ref = couleurs_ref(:,3);
  
  %On fait de même pour l'image obtenue après la spécification
  couleurs_spe = tab_couleurs_Res(1:nombre_Res-1,:);
  x_spe = couleurs_spe(:,1);
  y_spe = couleurs_spe(:,2);
  z_spe = couleurs_spe(:,3);
  
  %Et pour l'image source
  couleurs_source = tab_couleurs_Ix(1:nombre_Ix-1,:);
  x_source = couleurs_source(:,1);
  y_source = couleurs_source(:,2);
  z_source = couleurs_source(:,3);
  
  %Et on pour l'image corrigée
  couleurs_correction = tab_couleurs_correction(1:nombre_coul_correction-1,:);
  x_corrigee = couleurs_correction(:,1);
  y_corrigee = couleurs_correction(:,2);
  z_corrigee = couleurs_correction(:,3);
      
  figure
  subplot(2,4,1);
  imagesc(Ix);
  title({'Image source' strcat(num2str(nombre_Ix - 1), ' couleurs')});
  
  subplot(2,4,2);
  imagesc(Iz);
  title({'Image de référence' strcat(num2str(nombre_Iz - 1), ' couleurs')});
  
  subplot(2,4,3); 
  imagesc(Image_res);
  title({'Résultat de la spécification' strcat(num2str(nombre_Res - 1), ' couleurs')});
  
  subplot(2,4,4);
  imagesc(Im_corrigee);
  title({'Résultat de la spécification corrigé' strcat(num2str(nombre_coul_correction - 1), ' couleurs')});
  
  subplot(2,4,5);
  h_source = scatter3(x_source, y_source, z_source, 30, 'filled');
  h_source.CData = couleurs_source./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title("Histogramme de l'image source");
  
  subplot(2,4,6);
  h_ref = scatter3(x_ref, y_ref, z_ref, 30, 'filled');
  h_ref.CData = couleurs_ref./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title("Histogramme de l'image de référence");
  
  subplot(2,4,7);
  h_spe = scatter3(x_spe, y_spe, z_spe, 30, 'filled');
  h_spe.CData = couleurs_spe./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title("Histogramme du résultat de la spécification");
  
  subplot(2,4,8);
  h_corr = scatter3(x_corrigee, y_corrigee, z_corrigee, 30, 'filled');
  h_corr.CData = couleurs_correction./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title({'Histogramme du résultat de la spécification corrigé' strcat('seuil de correction= ', num2str( seuil)) strcat(num2str(nombre_correction), ' couleurs corrigées')});
end
