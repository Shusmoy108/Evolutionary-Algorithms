function o = FitnessCSC742(a)

load MyData;

ym = a(1).*u + a(2)*u.^2 + a(3)*u.^3;

o = mse(y,ym);

