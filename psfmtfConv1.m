% Emilio Arturo Vidal de la Cruz A00833430
%% Cargar la imagen

f=imread('radiograph1.jpg');
imshow(f);

%% 
f=f(:,:,1);
imshow(f);

%% 
f=double(f)/255;
imshow(f);

%% Se reduce el tamaño de la imagen 
f=imresize(f,0.25); 

figure(1);
subplot(2,2,1); %Ubicar en posición 1
imshow(f,[]); 
subplot(2,2,2); 
mesh(f) %mapa de color y densidad

%% Usamos la función gaussiana
h=10*fspecial('gaussian',10);

subplot(2,2,3);
%imshow(h,[]);
mesh(h)

sum(sum(h)) %se busca que sea igual a 1 pero como se multiplicó por 10 será 10

g=conv2(f,h,'same'); %convolución
subplot(2,2,4);
imshow(g,[]);
%mesh(g)

%% Se ponen 3 puntos 
sz=size(f);
f=zeros(sz(1));
f(int16(sz(1)/2), int16(sz(2)/2)) = 1;
f(int16(sz(1)/3), int16(sz(2)/2)) = 1;
f(int16(sz(1)/2), int16(sz(2)/3)) = 1;
subplot(2,2,2);
imshow(f,[]);
mesh(f)

h=fspecial('gaussian',7,2);
subplot(2,2,3);
mesh(h)

imshow(f,[]);
g=conv2(f,h,'same');
subplot(2,2,4);
imshow(g,[]);
%mesh(g)

%%
for (x=1:sz(1))
    for(y=1: sz(2))
        f(y,x)=sin(y*0.7)*sin(x*0.5); 
    
    end
end

    subplot(2,2,1);
      imshow(f,[]);
%%
%Usamos fourier 
F=fft2(f,sz(1),sz(2));

subplot(2,2,2);
imshow(fftshift(log(abs(F))),[]);
subplot(2,2,3);
imshow(fftshift(abs(F)),[]);

%%
f=imread('radiograph1.jpg');
imshow(f);

f=f(:,:,1);

f=double(f)/255; 

% Filtro de disco
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

% Convolución para hacer borrosa la imagen 
g2 = conv2(f,h,'same');
subplot(2,2,4);
imshow(g2,[]);