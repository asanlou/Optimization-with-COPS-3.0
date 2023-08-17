param NODES;
param npasos;
param n1=(npasos*(NODES  - 1) + 1);

set N :={0..NODES-1};
set N1 :={0..(n1 - 1)};

param z1{j in N};
param z2{j in N};
param insts{j in 0..NODES-1} = j/(NODES - 1);
param insts2{j in 0..(n1-1)};

var y1{j in N1};
var y2{j in N1};
var theta{j in 1..3};

minimize z: sum {i in N} ((y1[npasos*i] - z1[i])^2 + (y2[npasos*i] - z2[i])^2);

subject to valor_ini_y1:
  y1[0] = 1;
subject to valor_ini_y2:
  y2[0] = 0;

subject to y1_modelo {i in 0..(n1 - 2)}:
  y1[i+1] = y1[i] + (insts2[i + 1] - insts2[i])*(-(theta[1] + theta[3])*y1[i]*y1[i] -(theta[1] + theta[3])*y1[i+1]*y1[i+1])/2;

subject to y2_modelo {i in 0..(n1 - 2)}:
  y2[i+1] = y2[i] + (insts2[i + 1] - insts2[i])*(theta[1]*y1[i]*y1[i] - theta[2]*y2[i] + theta[1]*y1[i+1]*y1[i+1] - theta[2]*y2[i+1])/2;