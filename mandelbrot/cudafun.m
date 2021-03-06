%Generates a Mandelbrot set using CUDA
function [gpuTime, count] = cudafun(maxIter, gridSize)
    %Check for GPU
    try
       gpuDevice();
    catch
        disp('No GPU detected');
        return;
    end
    
    %x limit
    xLimit = [-0.748766713922161, -0.748766707771757];
    %y limit
    yLimit = [0.123640844894862, 0.123640851045266];

    %Initialization
    t = tic();
    x = gpuArray.linspace(xLimit(1), xLimit(2), gridSize);
    y = gpuArray.linspace(yLimit(1), yLimit(2), gridSize);

    [xGrid, yGrid] = meshgrid(x, y);
    z0 = complex(xGrid, yGrid);
    count = ones(size(z0), 'gpuArray');

    %Calculate
    z = z0;
    for n = 0:maxIter
       z = z.*z + z0;
       inside = abs( z )<=2;
       count = count + inside;
    end
    count = log(count);

    %Display
    %Get data from GPU
    count = gather(count);
    gpuTime = toc(t);
    disp(gpuTime);
    fig = figure('position', [200, 200, 1000, 1000]);
    clf(fig, 'reset');
    imagesc(x, y, count);
    axis off
    colormap([jet(); flipud(jet()); 0 0 0]);
    title(sprintf('%1.2fs on GPU, %d Iterations, %dx%d', gpuTime, maxIter, gridSize, gridSize));
    saveas(gcf, 'cuda.png');
    saveas(gcf, 'cuda.fig');
end