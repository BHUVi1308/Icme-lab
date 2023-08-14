clear
clc
rng default;
i = input("Enter the Number of Grains: \n")
x = rand([1 i]);
y = rand([1 i]);
voronoi(x,y)
axis equal

