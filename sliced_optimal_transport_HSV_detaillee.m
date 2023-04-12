function sliced_optimal_transport_HSV_detaillee(Ix, Iz)

  %On convertit les deux images RGB en images HSV
  Ix_HSV = uint8(255.*rgb2hsv(Ix));
  Iz_HSV = uint8(255.*rgb2hsv(Iz));
  %On récupère les canaux hue, saturation et value des deux images
  %Image source
  H_Ix = Ix_HSV(:,:,1);
  S_Ix = Ix_HSV(:,:,2);
  V_Ix = Ix_HSV(:,:,3);
  
  %Image de référence
  H_Iz = Iz_HSV(:,:,1);
  S_Iz = Iz_HSV(:,:,2);
  V_Iz = Iz_HSV(:,:,3);
  
  %On fait la spécification de chaque canal
  H_Res = specification(H_Ix, H_Iz);
  S_Res = specification(S_Ix, S_Iz);
  V_Res = specification(V_Ix, V_Iz);
  
  %Assemblage des trois canaux obtenus après spécification pour obtenir
  %l'image HSV résultante
  HSV_res = cat(3, H_Res, S_Res, V_Res);
  
  %On crée une version RGB de l'image HSV obtenue après la spécification
  RGB_res = double(HSV_res)./255.;
  RGB_res = hsv2rgb(RGB_res);
  
  %On récupère les couleurs de l'image source en RGB
  [~, nombre_Ix_RGB] = compter_couleurs(Ix);
  disp(strcat('L''image source RGB possède ', num2str(nombre_Ix_RGB - 1), ' couleurs'));
  
  %On récupère les couleurs de l'image source en HSV ainsi que leur nombre
  [tab_couleurs_Ix_HSV, nombre_Ix_HSV] = compter_couleurs(Ix_HSV);
  disp(strcat('L''image source HSV possède ', num2str(nombre_Ix_HSV - 1), ' couleurs'));
  
  %On récupère les différentes couleurs ainsi que leur nombre
  %de l'image de référence HSV
  [tab_couleurs_Iz_HSV, nombre_Iz_HSV] = compter_couleurs(Iz_HSV);
  disp(strcat('L''image de référence HSV possède ', num2str(nombre_Iz_HSV - 1), ' couleurs'));
  
  %On récupère les couleurs de l'image de référence en RGB
  [~, nombre_Iz_RGB] = compter_couleurs(Iz);
  disp(strcat('L''image de référence RGB possède ', num2str(nombre_Iz_RGB - 1), ' couleurs'));
  
  %On fait de même pour l'image obtenue après la spécification HSV
  [tab_couleurs_Res_HSV, nombre_Res_HSV] = compter_couleurs(HSV_res);
  disp(strcat('L''image HSV obtenue après la spécification possède ', num2str(nombre_Res_HSV - 1), ' couleurs'));
  
  %Ainsi que la version RGB
  [~, nombre_Res_RGB] = compter_couleurs(RGB_res);
  disp(strcat('L''image RGB obtenue après la spécification possède ', num2str(nombre_Res_RGB - 1), ' couleurs'));
  
  %Puis on analyse les différences de couleurs entre l'image de référence
  % et celle obtenue après la spécification
  %On récupère également une image corrigée avec le nombre de couleurs qui
  %ont été corrigées dans l'image obtenue après la spécification
  %Pour ce faire, on définit un seuil de correction de couleurs
  %cad, si la distance euclidienne entre une couleur obtenue après
  %spécification et la couleur dans l'image de référence la plus proche
  %dépasse cette valeur, elle est corrigée
  seuil = 10.0;
  [tab_distances, tab_distances_corrigees, Im_corrigee_HSV, nombre_correction] = analyse_couleurs_detaillee(tab_couleurs_Iz_HSV, nombre_Iz_HSV, tab_couleurs_Res_HSV, nombre_Res_HSV, HSV_res, seuil);
  
  %On crée une version HSV de l'image HSV en RGB
  Im_corrigee_RGB = double(Im_corrigee_HSV)./255.;
  Im_corrigee_RGB = hsv2rgb(Im_corrigee_RGB);
  
  %Puis, on évalue les différences de distance afin de créer un code
  %couleur
  Image_diff_HSV = evaluation_distance(tab_distances, tab_couleurs_Res_HSV, HSV_res);  
  
  %On fait de même pour l'image corrigée
  Image_diff_corrigee_HSV = evaluation_distance(tab_distances_corrigees, tab_couleurs_Res_HSV, HSV_res);
  
  %On calcule le nombre de couleurs dans l'image corrigée RGB
  [~, nombre_coul_correction_RGB] = compter_couleurs(Im_corrigee_RGB);
  
  %On calcule le nombre de couleurs dans l'image corrigée HSV
  [tab_couleurs_correction_HSV, nombre_coul_correction_HSV] = compter_couleurs(Im_corrigee_HSV);
  
  %On transforme la matrice des couleurs de l'image de référence
  %en vecteurs colonnes pour afficher
  %l'histogramme 3D avec scatter3
  couleurs_ref = tab_couleurs_Iz_HSV(1:nombre_Iz_HSV-1,:);
  x_ref = couleurs_ref(:,1);
  y_ref = couleurs_ref(:,2);
  z_ref = couleurs_ref(:,3);
  
  %On fait de même pour l'image obtenue après la spécification
  couleurs_spe = tab_couleurs_Res_HSV(1:nombre_Res_HSV-1,:);
  x_spe = couleurs_spe(:,1);
  y_spe = couleurs_spe(:,2);
  z_spe = couleurs_spe(:,3);
  
  %Et pour l'image source
  couleurs_source = tab_couleurs_Ix_HSV(1:nombre_Ix_HSV-1,:);
  x_source = couleurs_source(:,1);
  y_source = couleurs_source(:,2);
  z_source = couleurs_source(:,3);
  
  %Et on pour l'image corrigée
  couleurs_correction = tab_couleurs_correction_HSV(1:nombre_coul_correction_HSV-1,:);
  x_corrigee = couleurs_correction(:,1);
  y_corrigee = couleurs_correction(:,2);
  z_corrigee = couleurs_correction(:,3);
    
  figure
  subplot(3,4,1);
  imagesc(Ix);
  title({'Image source RGB' strcat(num2str(nombre_Ix_RGB - 1), ' couleurs')});
  
  subplot(3,4,2);
  imagesc(Iz);
  title({'Image de référence RGB' strcat(num2str(nombre_Iz_RGB - 1), ' couleurs')});
  
  subplot(3,4,3); 
  imagesc(RGB_res);
  title({'Résultat de la spécification RGB' strcat(num2str(nombre_Res_RGB - 1), ' couleurs')});
  
  subplot(3,4,5);
  imagesc(Ix_HSV);
  title("Image source HSV");
  
  subplot(3,4,6);
  imagesc(Iz_HSV);
  title("Image de référence HSV");
  
  subplot(3,4,7); 
  imagesc(HSV_res);
  title("Résultat de la spécification HSV");
  
  subplot(3,4,8);
  mymap = [0.7 0.95 0.7
    1 1 0
    1 0.5 0
    1 0 0
    1 0 1];
  imagesc(label2rgb(Image_diff_HSV, mymap, 'green'));
  title({'Différence de valeurs entre les pixels de l''image' 'de référence HSV et ceux du résultat de la spécification HSV'});
  
  subplot(3,4,9);
  h_source = scatter3(x_source, y_source, z_source, 30, 'filled');
  h_source.CData = couleurs_source./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Hue');
  ylabel('Saturation');
  zlabel('Value');
  title("Histogramme de l'image source HSV");
  
  subplot(3,4,10);
  h_ref = scatter3(x_ref, y_ref, z_ref, 30, 'filled');
  h_ref.CData = couleurs_ref./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Hue');
  ylabel('Saturation');
  zlabel('Value');
  title("Histogramme de l'image de référence HSV");
  
  subplot(3,4,11);
  h_spe = scatter3(x_spe, y_spe, z_spe, 30, 'filled');
  h_spe.CData = couleurs_spe./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Hue');
  ylabel('Saturation');
  zlabel('Value');
  title("Histogramme du résultat de la spécification HSV");
  
  figure
  subplot(4,2,1);
  imagesc(RGB_res);
  title({'Résultat de la spécification RGB' strcat(num2str(nombre_Res_RGB - 1), ' couleurs')});
  
  subplot(4,2,2);
  imagesc(Im_corrigee_RGB);
  title({'Résultat de la spécification RGB corrigé' strcat(num2str(nombre_coul_correction_RGB - 1), ' couleurs')});
  
  subplot(4,2,3);
  imagesc(HSV_res);
  title({'Résultat de la spécification HSV' strcat(num2str(nombre_Res_HSV - 1), ' couleurs')});
  
  subplot(4,2,4);
  imagesc(Im_corrigee_HSV);
  title({'Résultat de la spécification HSV corrigé' strcat(num2str(nombre_coul_correction_HSV - 1), ' couleurs')});
  
  subplot(4,2,5);
  h_spe_bis = scatter3(x_spe, y_spe, z_spe, 30, 'filled');
  h_spe_bis.CData = couleurs_spe./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Hue');
  ylabel('Saturation');
  zlabel('Value');
  title("Histogramme du résultat de la spécification HSV");
  
  subplot(4,2,6);
  h_corr = scatter3(x_corrigee, y_corrigee, z_corrigee, 30, 'filled');
  h_corr.CData = couleurs_correction./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Hue');
  ylabel('Saturation');
  zlabel('Value');
  title({'Histogramme du résultat de la spécification HSV corrigé' strcat('seuil de correction= ', num2str( seuil)) strcat(num2str(nombre_correction), ' couleurs corrigées')});
  
  subplot(4,2,7);
  imagesc(label2rgb(Image_diff_HSV, mymap, 'green'));
  title({'Différence de valeurs entre les pixels de l''image' 'de référence et ceux du résultat de la spécification'});
  
  subplot(4,2,8);
  imagesc(label2rgb(Image_diff_corrigee_HSV, mymap, 'green'));
  title({'Différence de valeurs entre les pixels de l''image' 'de référence et ceux du résultat de la spécification après correction'});
end
