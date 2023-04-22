using WGLMakie, SplitApplyCombine

function parametric_grid(us, vs, r)
n,m = length(us), length(vs)
xs, ys, zs = zeros(n,m), zeros(n,m), zeros(n,m)
for (i, u) in pairs(us)
for (j, v) in pairs(vs)
x,y,z = r(u, v)
xs[i,j] = x
ys[i,j] = y
zs[i,j] = z
end
end
(xs, ys, zs)
end

r1, r2 = 2, 1/2
r(u,v) = ((r1 + r2*cos(v))*cos(u), (r1 + r2*cos(v))*sin(u), r2*sin(v))
us = vs = range(0, 2pi, length=25)
s1, s2 = 2, 0.45
s(u,v) = ((s1 + s2*cos(v))*cos(u), (s1 + s2*cos(v))*sin(u), s2*sin(v))
us = vs = range(0, 2pi, length=25)
x, y, z = parametric_grid(us, vs, s)
surface(x, y, z)

using CSV, DataFrames
d = CSV.read("CAL1HAL13.csv", DataFrame)
t1, t2 = d[:,1], d[:,2]
xs, ys, zs = invert(r.(t1, t2))
surface(x, y, z)
plot!(xs,ys,zs, markersize=5)
current_figure()

surface(x, y, z)
plot!(xs,ys,zs, markersize=5)
for i in 1:length(t1) - 1
t10, t11 = t1[i:i+1]
t20, t21 = t2[i:i+1]
    
    if abs(t11-t10)>3.14
        t10,t11=max(t11, t10), max(t11, t10)+ (2*pi -abs(t11-t10))
end
    if abs(t21-t20)>3.14
        t20,t21=max(t21, t20), max(t21, t20)+ (2*pi-abs(t21-t20))
end     

pts1 = range(t10, t11, length= 100)
pts2 = range(t20, t21, length= 100)
x,y,z = invert(r.(pts1, pts2))
lines!(x,y,z, color=:blue)
end
current_figure()
