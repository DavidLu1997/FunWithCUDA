%Error checking between CPU and GPU
function err = cudaerror()
    %Get count
    cpuCount = cpufun();
    gpuCount = cudafun();
    err = abs(cpuCount - gpuCount);
    
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
    fig = figure(3);
    fig.Position = [200 200 600 600];
    imagesc(x, y, err);
    axis image
    colormap([jet(); flipud(jet()); 0 0 0]);
    title(sprintf('Total error: %1.12E', sum(sum(err))));
    saveas(figure(3), 'error.png');
end

