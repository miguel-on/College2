# PRACTICA 3. CINEMATICA EN 3D
# Alumno: MIGUEL POVEDANO GONZALEZ
# Asignatura: ROBOTICA
# Fecha: 14/05/07

O00 = [0;0;0;1];

function resultado(tita1,tita3,tita4,l1,l2,l3,l4 )
   O00 = [0;0;0;1];
   rad1 = (tita1 * pi) /180;
   rad3 = (tita3 * pi) /180;
   rad4 = (tita4 * pi) /180;
   rad90 = 1.5708;

   O0 = [0;0;0;1];

   T10 = [cos(rad1)    -cos(0)*sin(rad1)     sin(0)*sin(rad1)      0*cos(rad1);
          sin(rad1)    cos(0)*cos(rad1)     -sin(0)*cos(rad1)      0*sin(rad1);
             0              sin(0)                 cos(0)              l1     ;
             0                  0                      0                1     ];

   T21 = [cos(0)    -cos(rad90)*sin(0)     sin(rad90)*sin(0)    0*cos(0);
          sin(0)    cos(rad90)*cos(0)     -sin(rad90)*cos(0)    0*sin(0);
             0        sin(rad90)              cos(rad90)          l2    ;
             0              0                     0              1     ];

   T32 = [cos(rad3)   -cos(-rad90)*sin(rad3)     sin(-rad90)*sin(rad3)   l3*cos(rad3);
          sin(rad3)    cos(-rad90)*cos(rad3)    -sin(-rad90)*cos(rad3)   l3*sin(rad3);
             0            sin(-rad90)                  cos(-rad90)           0       ;
             0                0                             0                1      ];

   T43 = [cos(rad4)   -cos(0)*sin(rad4)     sin(0)*sin(rad4)   l4*cos(rad4);
          sin(rad4)    cos(0)*cos(rad4)    -sin(0)*cos(rad4)   l4*sin(rad4);
             0             sin(0)                cos(0)             0      ;
             0                0                    0                1     ];
 
   O1 = T10 * [0;0;0;1];
   O2 = T10 * T21 * [0;0;0;1];
   O3 = T10 * T21 * T32 * [0;0;0;1];
   O4 = T10 * T21 * T32 * T43 * [0;0;0;1];

   x = [O0(1) O1(1) O2(1) O3(1) O4(1)];
   y = [O0(2) O1(2) O2(2) O3(2) O4(2)];
   z = [O0(3) O1(3) O2(3) O3(3) O4(3)];
   

#  mostramos el brazo
   suma = l1+l2+l3+l4;
   grid;
   axis ([-suma suma -suma suma], "square");
   title ('eje (x,y) Arriba');
   subplot(2,2,1);
   plot(x,y,"-o");
   title ('eje (x,z) Lateral');
   subplot(2,2,2); 
   plot(x,z,"-o");
   title ('eje (y,z) Frente');
   subplot(2,2,3);
   plot(y,z,"-o");
   title ('3D');
   subplot(2,2,4);
   plot3(x,y,z,"-o");

endfunction
