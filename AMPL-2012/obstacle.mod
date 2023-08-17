param nx;
param ny;

set Nx:={0..nx};
set Ny:={0..ny};

var v{Nx,Ny};

minimize z: (1/(4*nx*ny))*(
			sqrt(1. + ny^2*(-v[0, 0] + v[0, 1])^2 + nx^2*(-v[0, 0] + v[1, 0])^2) + 
			sqrt(1. + ny^2*(-v[0, -1 + ny] + v[0, ny])^2 + nx^2*(-v[0, ny] + v[1, ny])^2) + 
			sqrt(1 + nx^2*(-v[-1 + nx, 0] + v[nx, 0])^2 + ny^2*(-v[nx, 0] + v[nx, 1])^2 )+ 
			sqrt(1. + nx^2*(-v[-1 + nx, ny] + v[nx, ny])^2 + ny^2*(-v[nx, -1 + ny] + v[nx, ny])^2) +
     		2*sum{j in 1..(ny-1)} (sqrt(1. + (ny/2)^2*(-v[0, -1 + j] + v[0, 1 + j])^2 + nx^2*(-v[0, j] + v[1, j])^2)) +
    		2*sum{i in 1..(nx-1)} (sqrt(1. + ny^2*(-v[i, 0] + v[i, 1])^2 + (nx/2)^2*(-v[-1 + i, 0] + v[1 + i, 0])^2)) +
    		2*sum{i in 1..(nx-1)} (sqrt(1. + ny^2*(-v[i, -1 + ny] + v[i, ny])^2 + (nx/2)^2*(-v[-1 + i, ny] + v[1 + i, ny])^2)) +
    		2*sum{j in 1..(ny-1)} (sqrt(1. + nx^2*(-v[-1 + nx, j] + v[nx, j])^2 + (ny/2)^2*(-v[nx, -1 + j] + v[nx, 1 + j])^2)) + 
    		4*sum{i in 1..nx-1,j in 1..ny-1} (sqrt(1. + (ny/2)^2*(-v[i, -1 + j] + v[i, 1 + j])^2 + (nx/2)^2*(-v[-1 + i, j] + v[1 + i, j])^2))
    		);

subject to r1 {i in 0..nx}:
  v[i,0]=1-(2*(i/nx)-1)^2;
subject to r2 {i in 0..nx}:
  v[i,ny]=1-(2*(i/nx)-1)^2;
subject to r3 {j in 0..ny}:
  v[0,j]=0;
subject to r4 {j in 0..ny}:
  v[nx,j]=0;
  
subject to r5 {i in ceil(nx/4)..floor((3*nx)/4),j in ceil(ny/4)..floor((3*ny)/4)}:
  v[i,j]>=1;
  
subject to r6 {i in 1..floor(nx/4),j in 1..(ny - 1)}:
  v[i,j]>=0;
subject to r7 {i in 1..(nx-1),j in ceil((3*ny)/4)..(ny-1)}:
  v[i,j]>=0;
subject to r8 {i in 1..(nx-1),j in 1..floor(ny/4)}:
  v[i,j]>=0;
subject to r9 {i in ceil((3*nx)/4)..nx-1,j in 1..(ny-1)}:
  v[i,j]>=0;
  
subject to r10 {i in 0..nx-1,j in 0..ny}:
  (v[i+1,j]-v[i,j])^2 <= (1/(nx/4-1))^2;
subject to r11 {i in 0..nx,j in 0..ny-1}:
  (v[i,j+1]-v[i,j])^2 <= (1/(ny/4-1))^2;
