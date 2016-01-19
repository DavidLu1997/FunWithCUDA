%Difference between CPU and GPU
function [diff, err] = cudadiff(maxIter, gridSize)
    %Get count
    [cpuTime, cpuCount] = cpufun(maxIter, gridSize);
    [gpuTime, gpuCount] = cudafun(maxIter, gridSize);
    err = abs(cpuCount - gpuCount);
    count = (cpuCount + gpuCount) / 2;
    diff = abs(cpuTime - gpuTime);
    
    %Grid size
    gridSize = 1000;
    
    %x limit
    xLimit = [-0.748766713922161, -0.748766707771757];
    %y limit
    yLimit = [0.123640844894862, 0.123640851045266];

    %Initialization
    x = linspace(xLimit(1), xLimit(2), gridSize);
    y = linspace(yLimit(1), yLimit(2), gridSize);
    
    %Display error
    fig = figure('position', [200, 200, 1000, 1000]);
    clf(fig, 'reset');
    imagesc(x, y, count);
    axis off
    colormap([jet(); flipud(jet()); 0 0 0]);
    title(sprintf('%d Iterations, %dx%d\nCPU Time: %1.2fs\nGPU Time: %1.2fs\nTime Difference: %1.2fs\nGPU is %1.2fx faster\nTotal error: %1.12E', maxIter, gridSize, gridSize, cpuTime, gpuTime, diff, cpuTime / gpuTime, sum(sum(err))));
    saveas(gcf, 'result.png');
    saveas(gcf, 'result.fig');
end

