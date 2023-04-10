Im1 = imread("images_projet/dawn.jpg");
Im2 = imread("images_projet/dawn_mist.jpg");
Im3 = imread("images_projet/simple1.png");
Im4 = imread("images_projet/simple2.png");
Im5 = imread("images_projet/simple5.png");
Im6 = imread("images_projet/painting-1.jpg");
Im7 = imread("images_projet/painting-2.jpg");
Im8 = imread("images_projet/simple6.png");
Im9 = imread("images_projet/simple7.png");
Im10 = imread("images_projet/simple8.png");
Im11 = imread("images_projet/simple_bleu.png");
Im12 = imread("images_projet/simple_rouge.png");
Im13 = imread("images_projet/cold_colors_small.jpg");
Im14 = imread("images_projet/warm_colors_small.jpg");

%sliced_optimal_transport_RGB_detaillee(Im13, Im14);
sliced_optimal_transport_RGB_brute(Im13, Im14);
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