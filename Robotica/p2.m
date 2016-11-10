# PRACTICA 2. CINEMATICA EN 3D
# Alumno: MIGUEL POVEDANO GONZALEZ
# Asignatura: ROBOTICA
# Fecha: 30/03/07

O00 = [0;0;0;1];

function resultado(tita1,tita2,l1,l2,l3)
   O00 = [0;0;0;1];
   rad1 = (tita1 * pi) /180;
   rad2 = (tita2 * pi) /180;
   rad90 = 1.5708;

   O0 = [0;0;0;1];

   T10 = [cos(rad1)    -cos(rad90)*sin(rad1)     sin(rad90)*sin(rad1)      0;
          sin(rad1)    cos(rad90)*cos(rad1)     -sin(rad90)*cos(rad1)     0;
             0              sin(rad90)                 cos(rad90)         l1;
             0                  0                         0                1 ];

   T21 = [cos(rad2)    -cos(0)*sin(rad2)     sin(0)*sin(rad2)    l2*cos(rad2);
          sin(rad2)    cos(0)*cos(rad2)     -sin(0)*cos(rad2)   l2*sin(rad2);
             0              sin(0)                 cos(0)              0     ;
             0                  0                     0                1     ];

   T32 = [cos(0)    -cos(0)*sin(0)     sin(0)*sin(0)    l3*cos(0);
          sin(0)    cos(0)*cos(0)     -sin(0)*cos(0)   l3*sin(0);
             0           sin(0)            cos(0)          0     ;
             0                0              0             1     ];
 
   O1 = T10 * [0;0;0;1];
   O2 = T10 * T21 * [0;0;0;1];
   O3 = T10 * T21 * T32 * [0;0;0;1];

   x = [O0(1) O1(1) O2(1) O3(1)];
   y = [O0(2) O1(2) O2(2) O3(2)];
   z = [O0(3) O1(3) O2(3) O3(3)];
   

#  mostramos el brazo
   suma = l1+l2+l3;
   grid;
   axis ([-suma suma -suma suma], "square");
   title ('eje (x,y)');
   subplot(2,2,1);
   plot(x,y,"-o");
   title ('eje (x,z)');
   subplot(2,2,2); 
   plot(x,z,"-o");
   title ('eje (y,z)');
   subplot(2,2,3);
   plot(y,z,"-o");
   title ('3D');
   subplot(2,2,4);
   plot3(x,y,z,"-o");

endfunction
