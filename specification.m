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
