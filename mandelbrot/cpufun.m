%Generates a Mandelbrot set using the CPU
function [cpuTime, count] = cpufun(maxIter, gridSize)
    %x limit
    xLimit = [-0.748766713922161, -0.748766707771757];
    %y limit
    yLimit = [0.123640844894862, 0.123640851045266];

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
    fig = figure('position', [200, 200, 1000, 1000]);
    clf(fig, 'reset');
    imagesc(x, y, count);
    axis off
    colormap([jet(); flipud(jet()); 0 0 0]);
    title(sprintf('%1.2fs on CPU, %d Iterations, %dx%d', cpuTime, maxIter, gridSize, gridSize));
    saveas(gcf, 'cpu.png');
    saveas(gcf, 'cpu.fig');
end