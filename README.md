# FunWithCUDA
Computing Mandelbrot sets with CUDA in MATLAB, displays speed of CPU vs GPU

How to run:
- Open MATLAB 2013 or later (may work on earlier versions, not tested)
- Change directory to repository directory
- cudadiff(maxIterations, gridSize)

Notes:
- PNGs are automatically generated with results
- A GTX 970 runs out of memory at approximately 5000 x 5000
- gpuDevice() for gpuDevice information
- cpufun and cudafun can run individually using the same parameters
