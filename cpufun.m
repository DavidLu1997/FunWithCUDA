%Generates a Mandelbrot set using the CPU

%Max iterations
maxIter = 500;
%Grid size
gridSize = 1000;

%x limit
xLimit = [-2, 1];
%y limit
yLimit = [-sqrt(2), sqrt(2)];

%Initialization
t = tic();
x = linspace(xLimit(1), xLimit(2), gridSize);
y = linspace(yLimit(1), yLimit(2), gridSize);

[xGrid, yGrid] = meshgrid(x, y);
z0 = xGrid + 1i*yGrid;
count = ones(size(z0));

%Calculate
z = z0;
for n = 0:maxIter
   z = z.*z + z0;
   inside = abs( z )<=2;
   count = count + inside;
end
count = log(count);

%Display
cpuTime = toc(t);
fig = gcf;
fig.Position = [200 200 600 600];
imagesc(x ,y ,count);
axis image
colormap([jet(); flipud(jet()); 0 0 0]);
title(sprintf('%1.2fsecs (CPU)', cpuTime));