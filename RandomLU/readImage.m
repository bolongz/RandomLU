%% read image
imname= 'image1.jpg';
XX= imread(imname);
X= double(XX)/255;
if ndims(X) == 3
   image(X)
   [m,n,p]= size(X);
   if m>n,
       size(X(:,:,1))
       A= [X(:,:,1), X(:,:,2), X(:,:,3)]; 
   else
       size(X(:,:,1))
       A= [X(:,:,1); X(:,:,2); X(:,:,3)]; 
   end
else
   image(255*X);
   colormap(gray(256));
   A= X;
end
axis image
axis off
drawnow
clear X;



