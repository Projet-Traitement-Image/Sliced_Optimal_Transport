Im1 = imread("images_projet/simple1.png");
Im2 = imread("images_projet/simple2.png");
Im3 = imread("images_projet/simple3.png");
Im4 = imread("images_projet/simple4.png");
Im5 = imread("images_projet/simple5.png");
Im6 = imread("images_projet/painting-1.jpg");
Im7 = imread("images_projet/painting-2.jpg");
Im8 = imread("images_projet/simple6.png");
Im9 = imread("images_projet/simple7.png");
Im10 = imread("images_projet/simple8.png");
Im11 = imread("images_projet/simple_bleu.png");
Im12 = imread("images_projet/simple_rouge.png");

sliced_optimal_transport_RGB(Im12, Im11);
%sliced_optimal_transport_HSV(Im2, Im1);

function sliced_optimal_transport_HSV(Ix, Iz)

  %On convertit les deux images RGB en images HSV
  Ix_HSV = uint8(255.*rgb2hsv(Ix));
  Iz_HSV = uint8(255.*rgb2hsv(Iz));
  %On récupère les canaux hue, saturation et value des deux images
  H_Ix = Ix_HSV(:,:,1);
  S_Ix = Ix_HSV(:,:,2);
  V_Ix = Ix_HSV(:,:,3);
  
  %On transforme les matrices des canaux de l'image source en vecteurs
  %colonnes
  H_Ix_Column = reshape(H_Ix, [], 1);
  S_Ix_Column = reshape(S_Ix, [], 1);
  V_Ix_Column = reshape(V_Ix, [], 1);

  H_Iz = Iz_HSV(:,:,1);
  S_Iz = Iz_HSV(:,:,2);
  V_Iz = Iz_HSV(:,:,3);
  
  %On fait la spécification de chaques canaux
  H_Res = specification(H_Ix, H_Iz);
  S_Res = specification(S_Ix, S_Iz);
  V_Res = specification(V_Ix, V_Iz);
  
  %On transforme les matrices des canaux de l'image de référence en vecteurs
  %colonnes
  R_Iz_Column = reshape(H_Iz, [], 1);
  V_Iz_Column = reshape(S_Iz, [], 1);
  B_Iz_Column = reshape(V_Iz, [], 1);

  %Assemblage des trois canaux obtenus après spécification pour obtenir
  %l'image couleur résultante
  res = cat(3, H_Res, S_Res, V_Res);
  
  %On transforme les matrices des canaux résultants 
  %en vector colonnes pour afficher 
  %l'histogramme 3D
  H_Res_Column = reshape(H_Res, [], 1);
  S_Res_Column = reshape(S_Res, [], 1);
  V_Res_Column = reshape(V_Res, [], 1);
  
  Image_res = double(res)./255.;
  Image_res = hsv2rgb(Image_res);

  figure
  subplot(3,4,1);
  imagesc(Ix);
  title("Image source RGB");
  subplot(3,4,2);
  imagesc(Iz);
  title("Image de référence RGB");
  subplot(3,4,3); 
  imagesc(Image_res);
  title("Résultat de la spécification RGB");
  %{
  subplot(3,4,4);
  mymap = [1 1 0
    1 0.5 0
    1 0 0
    1 0 1];
  imagesc(label2rgb(Image_Diff, mymap, 'green'));
  title({'Différence de valeurs entre les pixels' 'de l''image de référence et ceux de l''image spécifiée'});
  %}
  subplot(3,4,5);
  imagesc(Ix_HSV);
  title("Image source HSV");
  subplot(3,4,6);
  imagesc(Iz_HSV);
  title("Image de référence HSV");
  subplot(3,4,7); 
  imagesc(res);
  title("Résultat de la spécification HSV");
  subplot(3,4,9);
  %[yRed_Source, ~] = imhist(H_Ix);
  %[yGreen_Source, ~] = imhist(S_Ix);
  %[yBlue_Source, x] = imhist(V_Ix);
  %plot(x, yRed_Source, "Red", x, yGreen_Source, "Green", x, yBlue_Source, "Blue");
  scatter3(H_Ix_Column, S_Ix_Column, V_Ix_Column, 2, 'magenta');
  xlim([0 255]);
  title("Histogramme de l'image source HSV");
  subplot(3,4,10);
  %[yRed_Ref, ~] = imhist(H_Iz);
  %[yGreen_Ref, ~] = imhist(S_Iz);
  %[yBlue_Ref, x] = imhist(V_Iz);
  %plot(x, yRed_Ref, "Red", x, yGreen_Ref, "Green", x, yBlue_Ref, "Blue");
  scatter3(R_Iz_Column, V_Iz_Column, B_Iz_Column, 2, 'magenta');
  %maximum = max([max(max(yRed_Ref(:))) max(max(yGreen_Ref(:))) max(max(yBlue_Ref(:)))]);
  xlim([0 255]);
  ylim([0 255]);
  title("Histogramme de l'image de référence HSV");
  subplot(3,4,11);
  %[yRed_Res, ~] = imhist(H_Res);
  %[yGreen_Res, ~] = imhist(S_Res);
  %[yBlue_Res, x] = imhist(V_Res);
  %plot(x, yRed_Res, "Red", x, yGreen_Res, "Green", x, yBlue_Res, "Blue");
  scatter3(H_Res_Column, S_Res_Column, V_Res_Column, 2, 'magenta');
  xlim([0 255]);
  ylim([0 255]);
  title("Histogramme du résultat de la spécification HSV");
end

function sliced_optimal_transport_RGB(Ix, Iz)
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
  [tab_distances, Im_corrigee, nombre_correction] = analyse_couleurs(tab_couleurs_Iz, nombre_Iz, tab_couleurs_Res, nombre_Res, Image_res);
  
  %Puis, on évalue les différences de distance afin de créer un code
  %couleur
  Image_diff = evaluation_distance(tab_distances, tab_couleurs_Res, Image_res);
  
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
  mymap = [1 1 0
    1 0.5 0
    1 0 0
    1 0 1];
  imagesc(label2rgb(Image_diff, mymap, 'green'));
  title({'Différence de valeurs entre les pixels' 'de l''image de référence et ceux de l''image spécifiée'});
  
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
  
  figure
  subplot(3,2,1);
  imagesc(Image_res);
  title({'Résultat de la spécification' strcat(num2str(nombre_Res - 1), ' couleurs')});
  
  subplot(3,2,2);
  imagesc(Im_corrigee);
  title({'Résultat de la spécification corrigé' strcat(num2str(nombre_coul_correction - 1), ' couleurs') strcat(num2str(nombre_correction), ' couleurs corrigées')});
  
  subplot(3,2,3);
  h_spe_bis = scatter3(x_spe, y_spe, z_spe, 30, 'filled');
  h_spe_bis.CData = couleurs_spe./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title("Histogramme du résultat de la spécification");
  
  subplot(3,2,4);
  h_corr = scatter3(x_corrigee, y_corrigee, z_corrigee, 30, 'filled');
  h_corr.CData = couleurs_correction./255;
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  xlabel('Rouge');
  ylabel('Vert');
  zlabel('Bleu');
  title("Histogramme du résultat de la spécification corrigé");
  
  subplot(3,2,5);
  imagesc(label2rgb(Image_diff, mymap, 'green'));
  title({'Différence de valeurs entre les pixels' 'de l''image de référence et ceux de l''image spécifiée'});  
end

function HCN = histogramme_cumule (I, histogramme_I, type)
  [~,n] = size(histogramme_I);
  [x,y] = size(I);
  HCN=zeros(1,256);
  sum = 0;
  if type == "normalise"
    for i = 1:n
        HCN(i) = (histogramme_I(i) + sum)/(x*y);
        sum = sum + histogramme_I(i);
    end
   else
    for i = 1:n
        HCN(i) = (histogramme_I(i) + sum);
        sum = sum + histogramme_I(i);
    end
   end
end

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

function Im_diff = evaluation_distance(tab_distances, tab_couleurs, I_spe)
    %On récupère la taille de l'image
    [m,n,~] = size(I_spe);
    %tab_distances
    %On récupère la taille du tableau
    tab_size = size(tab_distances, 2);
    Im_diff = zeros(m,n);
    
    for i = 1:tab_size
        if tab_distances(1,i) >= 0.0 && tab_distances(1,i) < 3.0
           %On récupère tous les pixels dont la couleur est située au même indice
           Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 0;
        elseif tab_distances(1,i) >= 3.0 && tab_distances(1,i) < 5.0
           Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 1;
        elseif tab_distances(1,i) >= 5.0 && tab_distances(1,i) < 7.5
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 2;
        elseif tab_distances(1,i) >= 7.5 && tab_distances(1,i) < 10.0
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 3;
        else
            Im_diff(I_spe(:,:,1) == tab_couleurs(i, 1) & I_spe(:,:,2) == tab_couleurs(i, 2) & I_spe(:,:,3) == tab_couleurs(i, 3)) = 4;
        end
    end
end

function Image_res = specification (Ix, Iz)
  %On récupère les dimensions des deux images et on teste si elles sont
  %en niveaux de gris
  [m, n, nbCanauxIx] = size(Ix);
  [k, l, nbCanauxIz] = size(Iz);

  if nbCanauxIx > 1
      Ix = rgb2gray(Ix);
  end
  if nbCanauxIz > 1
      Iz = rgb2gray(Iz);
  end

  %On récupère l'histogramme de l'image Ix
  Hist_Ix = histogramme(Ix);
  %Hist_Ix
  %ainsi que celui de l'image Iz
  Hist_Iz = histogramme(Iz);
  %on récupère l'histogramme cumulé de l'image Ix
  HC_Ix = histogramme_cumule(Ix, Hist_Ix, 'classique');
  %HC_Ix
  %ainsi que celui de l'image Iz
  HC_Iz = histogramme_cumule(Iz, Hist_Iz, 'classique');
  %ainsi que les histogrammes cumulés normalisés
  HCN_Ix = histogramme_cumule(Ix, Hist_Ix, 'normalise');
  HCN_Iz = histogramme_cumule(Iz, Hist_Iz, 'normalise');
  %HC_Iz
  %On crée le tableau des g-1(f(x))
  g_moins_un = zeros(1,256);

  for i = 1:256
    g_moins_un(i) = indice_plus_proche(HCN_Ix(i), HCN_Iz);
  end

  %On crée l'image résultante de la spécification
  Image_res = uint8(g_moins_un(Ix + 1) - 1);
  %Ainsi que la matrice des différences de distances
  %Image_diff = pixels_diff(Iz, Image_res);
  %Image_diff

  figure
  %affichage de l'image source
  subplot(4,2,1);
  imshow(Ix);
  title('Image source');
  %affichage de l'image de référence
  subplot(4,2,2);
  imshow(Iz);
  title('Image de référence');
  %affichage de l'histogramme de l'image source
  subplot(4,2,3);
  imhist(Ix);
  ylim([0 max(imhist(Ix))]);
  title('Histogramme de l''image source');
  %affichage de l'histogramme de l'image de référence
  subplot(4,2,4);
  imhist(Iz);
  xlim([0 255]);
  ylim([0 max(imhist(Iz))]);
  title('Histogramme de l''image de référence');
  %affichage de l'histogramme cumulé de l'image source
  subplot(4,2,5);
  bar(HC_Ix);
  xlim([0 255]);
  ylim([0 m*n]);
  title('Histogramme cumulé de l''image source');
  %affichage de l'histogramme cumulé de l'image de référence
  subplot(4,2,6);
  bar(HC_Iz);
  xlim([0 255]);
  ylim([0 k*l]);
  title('Histogramme cumulé de l''image de référence');
  %affichage de l'image résultant de la spécification
  subplot(4,2,7);
  imshow(Image_res);
  title('Image du résultat de la spécification');
  %affichage de l'histogramme du résultat de la spécification
  subplot(4,2,8);
  imhist(Image_res);
  xlim([0 255]);
  ylim([0 max(imhist(Iz))]);
  title('Histogramme du résultat de la spécification');
end

function res = indice_plus_proche(x, hist)
   %On récupère les dimensions du vecteur contenant l'histogramme dans lequel
   %chercher l'indice à retourner
   [~,n] = size(hist);
   %un booléen indiquant si on a trouvé la valeur la plus proche de x
   trouve = false;
   %ainsi qu'un compteur sur la seconde position du vecteur contenant
   %l'histogramme
   i = 2;
   %initialisation de la valeur de l'indice à retourner
   res = 1;
   %ainsi qu'un intervalle afin de trouver la valeur la plus proche de x
   min_intervalle = x - hist(1);

   while ~trouve && i <= n
     if hist(i) >= x
       trouve = true;
       %On regarde si x est plus proche de la valeur de cet indice ou du
       %précédent
       if min_intervalle >= (x - hist(i))
        res = i;      
       else
        res = i - 1;
       end
     else
       min_intervalle = x - hist(i);
       i = i + 1;
     end
   end    
end

function [tab_couleurs, nombre] = compter_couleurs(I)
 % On récupère les dimensions de l'image
 [m, n, ~] = size(I);
 %On crée un tableau contenant les couleurs de l'image
 tab_couleurs = zeros(m*n, 3);
 %On initialise le compteur sur la nombre de couleurs
 nombre = 1;
 %On sépare les différents canaux R, G et B de l'image
 Red_channel = I(:,:,1);
 Green_channel = I(:,:,2);
 Blue_channel = I(:,:,3);
 
 %On parcours l'ensemble des pixels de l'image
 for i = 1:m
     for j = 1:n
         %On récupère les trois valeurs du pixels
         Red = Red_channel(i,j);
         Green = Green_channel(i,j);
         Blue = Blue_channel(i,j);
         %puis on regarde si cette couleur est déjà présente dans le
         %tableau des couleurs
         estPresente = false;
         l = 1;
         while ~estPresente && l < nombre
             if(tab_couleurs(l, 1) == Red && tab_couleurs(l, 2) == Green && tab_couleurs(l, 3) == Blue)
                 estPresente = true;
             else
                 l = l + 1;
             end
         end
         %Si la couleur n'est pas présente dans le tableau, on l'ajoute
         if ~estPresente
             tab_couleurs(nombre, 1) = Red;
             tab_couleurs(nombre, 2) = Green;
             tab_couleurs(nombre, 3) = Blue;
             nombre = nombre + 1;
         end
     end
 end
end

function [tab_distances, Im_corrigee, compteur_correction] = analyse_couleurs(tab_couleurs_Ref, nb_couleurs_Ref, tab_couleurs_Spe, nb_couleurs_Spe, Im_Spe)
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
        else
            %sinon on met la valeur de la plus petite distance obtenue
            tab_distances(1, i) = distance;
            %Et on met à jour les valeurs des canaux RGB de l'image obtenue
            %après spécification avec la couleur de l'image de référence la
            %plus proche
            Red_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Red_temp;
            Green_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Green_temp;
            Blue_channel_spe(Im_Spe(:,:,1) == Red_spe & Im_Spe(:,:,2) == Green_spe & Im_Spe(:,:,3) == Blue_spe) = Blue_temp;
            %On incrémente le compteur de couleurs corrigées
            compteur_correction = compteur_correction + 1;
        end
    end
    %On refusionne les 3 canaux de l'image obtenue après la spécification
    %pour former l'image corrigée
    Im_corrigee = cat(3, Red_channel_spe, Green_channel_spe, Blue_channel_spe);
end