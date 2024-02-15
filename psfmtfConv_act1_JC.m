% Juan Carlos Ibarra A00831834
clc
clear all

%% Leer la imagen

f=imread('radiograph1.jpg');
imshow(f);

%% Conversión a escala de grises
f=f(:,:,1);
imshow(f);

%% Se busca dejar valores de 1 a 0 para evitar errores y mala calidad de imagen
f=double(f)/255;
imshow(f);

%% Imagen de rayos x con sus respectivas coordenadas
f=imresize(f,0.25); % reduce la imagen una cuarta parte de su tamaño original

figure(1);
subplot(2,2,1);
imshow(f,[]); 
subplot(2,2,2);
mesh(f)

%% Usamos la función gaussiana
h=10*fspecial('gaussian',10);

subplot(2,2,3);
%imshow(h,[]);
mesh(h)

sum(sum(h)) %se busca que sea igual a 1 pero como se multiplicó por 10 será 10

g=conv2(f,h,'same'); % realización de la convolución
subplot(2,2,4);
imshow(g,[]);
%mesh(g)

%% Realización de 3 puntos
sz=size(f);
f=zeros(sz(1));
f(int16(sz(1)/2), int16(sz(2)/2)) = 1;
f(int16(sz(1)/3), int16(sz(2)/2)) = 1;
f(int16(sz(1)/2), int16(sz(2)/3)) = 1;
subplot(2,2,2);
imshow(f,[]);
mesh(f)

h=fspecial('gaussian',7,2); %con esta función y el mesh podemos ver la gráfica de los puntos
subplot(2,2,3);
mesh(h)

imshow(f,[]);
g=conv2(f,h,'same'); % se muestran los puntos de manera mas grande y borrosos
subplot(2,2,4);
imshow(g,[]);
%mesh(g)

%%
% Uso de ciclo for para usar senos para ver la calidad de imagen con su
% respectiva frecuencia en x y y
for (x=1:sz(1))
    for(y=1: sz(2))
        f(y,x)=sin(y*0.7)*sin(x*0.5); 
    
    end
end

    subplot(2,2,1);
      imshow(f,[]);
%% 
% Usamos furier para ver como las lineas se cruzan, estas indican que entre
% mayor separación haya entre ellas mejor es la calidad de la imagen, ya
% que la frecuencia del apartado anterior es mayor
F=fft2(f,sz(1),sz(2));

subplot(2,2,2);
imshow(fftshift(log(abs(F))),[]);
subplot(2,2,3);
imshow(fftshift(abs(F)),[]);

%%
% Se vuelve a hacer las primeras tres secciones de este código para
% facilitar el resultado
f=imread('radiograph1.jpg');
imshow(f);

f=f(:,:,1);

f=double(f)/255; 

% Uso de filtro de disco para filtrar en el dominio de la frecuencia
f=imresize(f,0.25);
h=fspecial('disk',10);
H=fft2(h,sz(1),sz(2));
G=F.*H;
g=abs(ifft2(G));
subplot(2,2,2);
imshow(g,[]);

G=F.*abs(H);
g=abs(ifft2(G));
subplot(2,2,3);
imshow(g,[]);

% Usar convolución se puede observar la imagen de la radiografía mas
% borrosa que la inicial
g2 = conv2(f,h,'same');
subplot(2,2,4);
imshow(g2,[]);
