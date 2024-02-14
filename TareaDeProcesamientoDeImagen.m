% Alejandro Palacios 

clc
clear all


f=imread('radiograph1.jpg');
imshow(f);
%%
f=f(:,:,1);
%%
%evita errores numericos y degradación de imagen
f=double(f)/255; 
%%
% vemos la imagen de rayos x en una ventana de 4
f=imresize(f,0.25);
figure(1);
subplot(2,2,1); 
imshow(f,[]);
%%
% vemos la grafica en 3 dimensiones, la cual se asemeja a la imagen
% original
subplot(2,2,2)
mesh(f) 

%%

%funcion gaussiana, vemos una grafica con una cuadricula donde sale hasta
%casi 2.5
h=10*fspecial('gaussian',10 ); 
subplot(2,2,3);
mesh(h);


%%
% vemos un disco en la imagen y al mismo tiempo se hace borrosa
g=conv2(f,h, "same"); 
subplot(2,2,4)
%mesh(g);
imshow(g,[]);

sz=size(f);
F=fft2(f,sz(1),sz(2));

subplot(2,2,4);
imshow(fftshift(log(abs(F))),[]);

%%

% en la figura de abajo a la derecha vemos 
% podemos ver tres puntos en diferentes partes de la imagen
sz=size(f);
f=zeros(sz(1));
f(int16(sz(1)/2),int16(sz(2)/2))=1;
f(int16(sz(1)/3),int16(sz(2)/2))=1;
f(int16(sz(1)/2),int16(sz(2)/3))=1;
subplot(2,2,2)
imshow(f,[])

% volvemos a usar la funcion gaussiana y nuestra grafica cambia en la parte
% inferior izquierda
h = fspecial("gaussian",7,2);
subplot(2,2,3);
mesh(h)

% por ultimo tenemos una grafica donde aparecen los picos, en el mismo
% lugar en el cual vemos en la imgagen superior derecha
g = conv2(f,h,"same");
subplot(2,2,4);
imshow(g,[])
mesh(g)



%%

% vemos una imagen con un patron de cuadrados  en la parte superior
% izquierda
for (x=1:sz(1))
    for (y=1:sz(2))
        f(y,x)=sin(y*0.07)*sin(x*0.05);
    end
end

subplot(2,2,1)
imshow(f,[])


%%

% volvemos a mostrar nuestra imagen
f=imread('radiograph1.jpg');
imshow(f);

f=f(:,:,1);

f=double(f)/255; %para evitar problemas numericos y evitar la degradacion de imagen

f=imresize(f,0.25); % muestreo en factor de 4

h=fspecial('disk',10);
H=fft2(h,sz(1),sz(2));
G=F.*H;
g=abs(ifft2(G));
% vemos 3 puntos en una imagen
subplot(2,2,2);
imshow(g,[]);

% vemos una imagen con los puntos mas borrosos y mas pequeños
G=F.*abs(H);
g=abs(ifft2(G));
subplot(2,2,3);
imshow(g,[]);

%finalemnte tenemos la imagen inicial pero ahora borrosa 
g2 = conv2(f,h,'same');
subplot(2,2,4);
imshow(g2,[]);