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
%sliced_optimal_transport_RGB_simplifie(Im13, Im14);
%sliced_optimal_transport_HSV_detaillee(Im3, Im4);
sliced_optimal_transport_HSV_simplifie(Im7, Im6);