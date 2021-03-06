# PRACTICA 4. 	PROYECCIÓN
# Alumno: 	MIGUEL POVEDANO GONZALEZ
# Asignatura: 	ROBOTICA
# Fecha: 14/05/07

O00 = [0;0;0;1];

function resultado(tita2,tita3,l1,l2,l3,l4 )
   O00 = [0;0;0;1];
   rad2 = (tita2 * pi) /180;
   rad3 = (tita3 * pi) /180;
   rad90 = 1.5708;

   O0 = [0;0;0;1];

   T10 = [cos(rad90)    -cos(0)*sin(rad90)     sin(0)*sin(rad90)      0*cos(rad90);
          sin(rad90)    cos(0)*cos(rad90)     -sin(0)*cos(rad90)      0*sin(rad90);
             0              sin(0)                 cos(0)              l1         ;
             0                  0                      0                1        ];

   T21 = [cos(rad2)    -cos(0)*sin(rad2)     sin(0)*sin(rad2)    l2*cos(rad2);
          sin(rad2)    cos(0)*cos(rad2)     -sin(0)*cos(rad2)    l2*sin(rad2);
             0            sin(0)                cos(0)               0       ;
             0              0                     0                  1      ];

   T32 = [cos(rad3)   -cos(0)*sin(rad3)     sin(0)*sin(rad3)   l3*cos(rad3);
          sin(rad3)    cos(0)*cos(rad3)    -sin(0)*cos(rad3)   l3*sin(rad3);
             0            sin(0)                  cos(0)           0       ;
             0                0                    0                1     ];

   T43 = [cos(0)       -cos(0)*sin(0)       sin(0)*sin(0)        0*cos(0);
          sin(0)        cos(0)*cos(0)      -sin(0)*cos(0)        0*sin(0);
             0             sin(0)                cos(0)             -l4  ;
             0                0                    0                1   ];

 
   f = 50;

   Proyeccion = [ 1   0   0   0
                  0   1   0   0
                  0   0   1   0
                  0  1/f  0   1 ];

   O1 = T10 * [0;0;0;1];
   O1 = Proyeccion * O1;
   O1 = O1 / O1(4);
   O2 = T10 * T21 * [0;0;0;1];
   O2 = Proyeccion * O2;
   O2 = O2 / O2(4);
   O3 = T10 * T21 * T32 * [0;0;0;1]; 
   O3 = Proyeccion * O3;
   O3 = O3 / O3(4);
   O4 = T10 * T21 * T32 * T43 * [0;0;0;1];
   O4 = Proyeccion * O4;
   O4 = O4 / O4(4);

   x = [O0(1) O1(1) O2(1) O3(1) O4(1)];
   y = [O0(2) O1(2) O2(2) O3(2) O4(2)];
   z = [O0(3) O1(3) O2(3) O3(3) O4(3)];                                                  
   

#  mostramos el brazo
   suma = l1+l2+l3+l4;
   grid;
   axis ([-suma suma -suma suma], "square");
   title ('eje (x,z) Lateral');
   plot(x,z,"-o");

endfunction
