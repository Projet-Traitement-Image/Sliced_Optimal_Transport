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
