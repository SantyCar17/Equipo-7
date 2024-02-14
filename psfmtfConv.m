% Se abre el archivo de imagen y se muestra
f=imread('radiograph1.jpg');
imshow(f);
%%
f=f(:,:,1); 
imshow(f);
%%
%Para poner el index de 0 a 1, se trabaja con flotantes reales
f=double(f)/255;
imshow(f, []);

%%
%Se hace una imagen chiquita para sus posterior procesamiento
f=imresize(f,0.25); %muestreo en factor de 4

figure(1);
subplot(2,2,1);% Mostrarla en la posicion 1
imshow(f,[]);

subplot(2,2,2)
mesh(f) %mapa de color por int
% densidad, similar a un mapa topografico


h=fspecial('gaussian',7,2);
subplot(2,2,3);
%imshow(h,[]);

mesh(h)

sum(sum(h)); %tiene que ser igual a 1

subplot(2,2,4);
g = conv2(f,h,'same'); %Proceso de convolucion 
%mesh(g)
imshow(g,[]);

%%
sz = size (f);
f = zeros(sz(1));
f(int16(sz(1)/2), int16(sz(2)/2)) = 1;
f(int16(sz(1)/3), int16(sz(2)/2)) = 1;
f(int16(sz(1)/2), int16(sz(2)/3)) = 1;
subplot(2,2,2);
imshow(f,[]);

h = fspecial('gaussian',7,2);
subplot(2,2,3);
mesh(h)

subplot(2,2,4);
g = conv2(f,h,'same');
imshow(g,[]);
%%
%Senos para intercalado
for (x=1:sz(1))
    for(y=1: sz(2))
        f(y,x)=sin(y*0.8)*sin(x*0.8); %Se generan lineas con diferente frecuencai
    
    end
end

    subplot(2,2,1);
      imshow(f,[]);
%%
F = fft2(f,sz(1),sz(2));
subplot(2,2,2);
imshow(fftshift(log(abs(F))),[]);

subplot(2,2,3);
imshow(fftshift(abs(F)),[]);

%%
F=imresize(f,0.25);

subplot(2,2,1);% Mostrarla en la posicion 1
imshow(f,[]);

F=fft2(f,sz(1),sz(2));
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
g2 = conv2(f,h,'same');

subplot(2,2,4);
imshow(g2,[]);
