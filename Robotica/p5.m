% Practica 5. robotica
% bordes
  matriz = zeros(26,26);
  matriz(1,1:21)= ones(1,21);
  matriz(1:21,1)= ones(21,1);
  matriz(21,1:21)= ones(1,21);
  matriz(1:21,21)= ones(21,1);

% obstaculos
  matriz(15:16,5:7) = ones(2,3);
  matriz(17,6:7) = ones(1,2);
  matriz(4:7,11:13) =ones(4,3);
  matriz(6:7,14:16) =ones(2,3);
  matriz(12:13,14:18) = ones(2,5);
  matriz(7:8,4:5) = ones(2,2);
  matriz(4:7,7:8) = ones(4,2);
  matriz(10:14,3) = ones(5,1);
  matriz(10:12,9:10) = ones(3,2);
  matriz(10:11,7:8) = ones(2,2);
  matriz(18:20,10) = ones(3,1);
  matriz(7,19:20) = ones(1,2);
  matriz(2:4,18) = ones(3,1);
  matriz(19,16:20) = ones(1,5);
  matriz(16:17,13:14) = ones(2,2);
  matriz(16,11:12) = ones(1,2);
  matriz(15,9:10) = ones(1,2);
  matriz(5,2:4) = ones(1,3);
  matriz(11:12,5) = ones(2,1);
  clearplot;
  hold off;

function aux = sensor(matriz,x,y)
   if (floor(x + 1) < 21)&& (floor(x + 1) > 1)
      if (floor(y + 1) < 21) && (floor(y + 1) > 1)
         aux = matriz(floor(x + 1),floor(y+1));
       else
          aux = 1;
      endif
   else
      aux = 1;
   endif
   
endfunction


function bucle(matriz,x,y)
  aux(x,y) = 1;
  [x1,y1]=find(aux);
  hold on;
  plot(x1,y1,"@6");
  [x,y] = find(matriz);
  plot(x,y,'x');
  hold off;
endfunction

grid("on");
axis([0.5 21.5 0.5 21.5],"square");
x = 20;
y =11;
bucle(matriz,x,y);

hold on;
  tita = 0;
  tic();
  ent = false;
  ent1 = false;
  giro = (10 * pi)/180

  while (toc() < 150)
     ent = false;
     obstaculo_f = 5.1;
     obstaculo_d = 5.1;
     obstaculo_i = 5.1;
     sent = 1;
     for i = 5:-1:0
        if ((sensor(matriz, x+i*cos(tita), y+i * sin(tita))) == 1)
           obstaculo_f = i;
	endif;
        if ((sensor(matriz, x+i*cos(tita+(pi/4)), y+i* sin(tita+(pi/4)))) == 1)
           obstaculo_i = i;
        endif;
        if ((sensor(matriz, x+i*cos(tita-(pi/4)), y+i * sin(tita-(pi/4)))) == 1)
           obstaculo_d = i;
        endif;

     endfor;
     if (obstaculo_f > 5)
       giro_final = giro/4; 
     else
        if(obstaculo_f > 3)
           giro_final = giro/1.8;
        else
           if (obstaculo_f > 1)
              giro_final = giro * 2;
           else
              giro_final = pi + giro;
           endif;
        endif;
     endif;


     if (obstaculo_d < 5.1) || (obstaculo_i < 5.1) 
        if (obstaculo_d == obstaculo_i)
           if (rand(1) > 0.5)
              sent = 1;
           else
              sent =-1;
           endif;
        else
           if (obstaculo_d > obstaculo_i)
	      sent = -1;
	   else
	      sent = 1;
	   endif
       endif;
     endif
     tita = tita + giro_final * sent;
     x = ((0.1 * cos(tita)) + x);
     y = ((0.1 * sin(tita)) + y); 
     plot(x,y,'@4')
  endwhile
