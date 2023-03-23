Im1 = imread("images_projet/dawn.jpg");
Im2 = imread("images_projet/dawn3.jpg");
Im3 = imread("images_projet/simple_bleu.png");
Im4 = imread("images_projet/simple_rouge.png");
Im5 = imread("images_projet/simple_rouge2.png");
Im6 = imread("images_projet/painting-1.jpg");
Im7 = imread("images_projet/painting-2.jpg");

sliced_optimal_transport_RGB(Im7, Im6);
sliced_optimal_transport_HSV(Im7, Im6);

function sliced_optimal_transport_HSV(Ix, Iz)

  %On convertit les deux images RGB en images HSV
  Ix_HSV = uint8(255.*rgb2hsv(Ix));
  Iz_HSV = uint8(255.*rgb2hsv(Iz));
  %On récupère les canaux hue, saturation et value des deux images
  H_Ix = Ix_HSV(:,:,1);
  S_Ix = Ix_HSV(:,:,2);
  V_Ix = Ix_HSV(:,:,3);

  H_Iz = Iz_HSV(:,:,1);
  S_Iz = Iz_HSV(:,:,2);
  V_Iz = Iz_HSV(:,:,3);
  
  %On fait la spécification de chaques canaux
  H_Res = specification(H_Ix, H_Iz);
  S_Res = specification(S_Ix, S_Iz);
  V_Res = specification(V_Ix, V_Iz);

  %Assemblage des trois canaux obtenus après spécification pour obtenir
  %l'image couleur résultante
  res = cat(3, H_Res, S_Res, V_Res);
  Image_res = double(res)./255.;
  Image_res = hsv2rgb(Image_res);

  figure
  subplot(3,3,1);
  imagesc(Ix);
  title("Image source RGB");
  subplot(3,3,2);
  imagesc(Iz);
  title("Image de référence RGB");
  subplot(3,3,3); 
  imshow(Image_res);
  title("Résultat de la spécification RGB");
  subplot(3,3,4);
  imagesc(Ix_HSV);
  title("Image source HSV");
  subplot(3,3,5);
  imagesc(Iz_HSV);
  title("Image de référence HSV");
  subplot(3,3,6); 
  imagesc(res);
  title("Résultat de la spécification HSV");
  subplot(3,3,7);
  [yRed_Source, ~] = imhist(H_Ix);
  [yGreen_Source, ~] = imhist(S_Ix);
  [yBlue_Source, x] = imhist(V_Ix);
  plot(x, yRed_Source, "Red", x, yGreen_Source, "Green", x, yBlue_Source, "Blue");
  xlim([0 255]);
  title("Histogramme de l'image source HSV");
  subplot(3,3,8);
  [yRed_Ref, ~] = imhist(H_Iz);
  [yGreen_Ref, ~] = imhist(S_Iz);
  [yBlue_Ref, x] = imhist(V_Iz);
  plot(x, yRed_Ref, "Red", x, yGreen_Ref, "Green", x, yBlue_Ref, "Blue");
  %scatter3(yRed_Ref, yGreen_Ref, yBlue_Ref);
  maximum = max([max(max(yRed_Ref(:))) max(max(yGreen_Ref(:))) max(max(yBlue_Ref(:)))]);
  xlim([0 255]);
  ylim([0 maximum]);
  title("Histogramme de l'image de référence HSV");
  subplot(3,3,9);
  [yRed_Res, ~] = imhist(H_Res);
  [yGreen_Res, ~] = imhist(S_Res);
  [yBlue_Res, x] = imhist(V_Res);
  plot(x, yRed_Res, "Red", x, yGreen_Res, "Green", x, yBlue_Res, "Blue");
  xlim([0 255]);
  ylim([0 maximum]);
  title("Histogramme du résultat de la spécification HSV");
end

function sliced_optimal_transport_RGB(Ix, Iz)
  %On récupère les canaux rouge, vert et bleu des deux images
  R_Ix = Ix(:,:,1);
  V_Ix = Ix(:,:,2);
  B_Ix = Ix(:,:,3);
  %On transforme les matrices des canaux de l'image source en vecteurs
  %colonnes
  R_Ix_Column = reshape(R_Ix, [], 1);
  V_Ix_Column = reshape(V_Ix, [], 1);
  B_Ix_Column = reshape(B_Ix, [], 1);

  R_Iz = Iz(:,:,1);
  V_Iz = Iz(:,:,2);
  B_Iz = Iz(:,:,3);
  %On transforme les matrices des canaux de l'image source en vecteurs
  %colonnes
  R_Iz_Column = reshape(R_Iz, [], 1);
  V_Iz_Column = reshape(V_Iz, [], 1);
  B_Iz_Column = reshape(B_Iz, [], 1);

  %On fait la spécification de chaques canaux
  R_Res = specification(R_Ix, R_Iz);
  V_Res = specification(V_Ix, V_Iz);
  B_Res = specification(B_Ix, B_Iz);

  %On transforme les matrices des canaux en vector colonnes pour afficher 
  %l'histogramme 3D
  R_Res_Column = reshape(R_Res, [], 1);
  V_Res_Column = reshape(V_Res, [], 1);
  B_Res_Column = reshape(B_Res, [], 1);

  %Assemblage des trois canaux obtenus après spécification pour obtenir
  %l'image couleur résultante
  Image_res = cat(3, R_Res, V_Res, B_Res);

  figure
  subplot(2,3,1);
  imagesc(Ix);
  title("Image source");
  subplot(2,3,2);
  imagesc(Iz);
  title("Image de référence");
  subplot(2,3,3); 
  imagesc(Image_res);
  title("Résultat de la spécification");
  subplot(2,3,4);
  %[yRed_Source, ~] = imhist(R_Ix);
  %[yGreen_Source, ~] = imhist(V_Ix);
  %[yBlue_Source, x] = imhist(B_Ix);
  %plot(x, yRed_Source, "Red", x, yGreen_Source, "Green", x, yBlue_Source, "Blue");
  scatter3(R_Ix_Column, V_Ix_Column, B_Ix_Column, 2, 'magenta');
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  title("Histogramme de l'image source");
  subplot(2,3,5);
  %[yRed_Ref, x] = imhist(R_Iz);
  %[yGreen_Ref, y] = imhist(V_Iz);
  %[yBlue_Ref, z] = imhist(B_Iz);
  %plot(x, yRed_Ref, "Red", x, yGreen_Ref, "Green", x, yBlue_Ref, "Blue");
  scatter3(R_Iz_Column, V_Iz_Column, B_Iz_Column, 2, 'magenta');
  %maximum = max([max(max(yRed_Ref(:))) max(max(yGreen_Ref(:))) max(max(yBlue_Ref(:)))]);
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  title("Histogramme de l'image de référence");
  subplot(2,3,6);
  %[yRed_Res, ~] = imhist(R_Res);
  %[yGreen_Res, ~] = imhist(V_Res);
  %[yBlue_Res, x] = imhist(B_Res);
  %plot(x, yRed_Res, "Red", x, yGreen_Res, "Green", x, yBlue_Res, "Blue");  
  scatter3(R_Res_Column, V_Res_Column, B_Res_Column, 2, 'magenta');
  xlim([0 255]);
  ylim([0 255]);
  zlim([0 255]);
  title("Histogramme du résultat de la spécification");
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

function Im_diff = pixels_diff(Im1, Im2)
    [m, n, ~] = size(Im1);
    Im_diff = zeros(m, n);
    
    Im1_d = double(Im1);
    Im2_d = double(Im2);
    
    for i = 1:m
        for j = 1:n
            if(abs(Im1_d(i,j) - Im2_d(i,j)) <= 25)
                Im_diff(i,j) = 0;
            elseif(abs(Im1_d(i,j) - Im2_d(i,j)) > 25 && abs(Im1_d(i,j) - Im2_d(i,j)) <= 50)
                Im_diff(i,j) = 1;
            elseif(abs(Im1_d(i,j) - Im2_d(i,j)) > 50 && abs(Im1_d(i,j) - Im2_d(i,j)) <= 75)
                Im_diff(i,j) = 2;
            elseif(abs(Im1_d(i,j) - Im2_d(i,j)) > 75 && abs(Im1_d(i,j) - Im2_d(i,j)) <= 100)
                Im_diff(i,j) = 3;
            else
                Im_diff(i,j) = 4;
            end
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

  Image_res = uint8(g_moins_un(Ix + 1) - 1);
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
  %{
  subplot(5,2,9);
    mymap = [1 1 0
    1 0.5 0
    1 0 0
    1 0 1];
  imshow(label2rgb(Image_diff, mymap, 'green'));
  title({'Différence de valeurs entre les pixels' 'de l''image de référence et ceux de l''image spécifiée'});
  %}
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
       %on actualise la valeur de l'intervalle
       min_intervalle = x - hist(i);
       i = i + 1;
     end
   end
end