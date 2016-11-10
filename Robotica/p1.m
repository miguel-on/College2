# PRACTICA 1. 	CAMBIO DE COORDENADAS
# Alumno: 	MIGUEL POVEDANO GONZALEZ
# Fecha:	13/03/07


O00 = [0;0;1];


# Le pasamos por parámetro las longitudes l1,l2 y los ángulos en grados x1 y x2
function [res1 res2] = resultado (l1,l2,x1,x2)

   O00 = [0;0;1];

   rd1 = x1 * pi / 180; 
   rd2 = x2 * pi / 180;

   T10 = [cos(rd1) -sin(rd1) l1 * cos(rd1);
          sin(rd1)  cos(rd1) l1 * sin(rd1);
             0          0          1     ];

   T21 = [cos(rd2) -sin(rd2) l2 * cos(rd2);
          sin(rd2)  cos(rd2) l2 * sin(rd2);
              0         0          1     ];

   res1 = T10 * [0;0;1]; 
   res2 = T10 * T21 * [0;0;1];
   
   
   resx = [O00(1) res1(1) res2(1)];
   resy = [O00(2) res1(2) res2(2)];

   suma = l1+l2;
   title ('BRAZO');
   grid;
   axis ([-suma suma -suma suma], "square");
   hold off;
   plot(resx,resy,"-o");

endfunction



#funcion que muestra los ángulos que puede realizar el brazo
function bucle
   i = 0;
   j = 0;
   while (i <= 360)
      while (j <= 360)
         resultado(1,1,i,j);
         j = j + 45;
      endwhile
      j = 0;
      i = i + 45;
   endwhile
endfunction


