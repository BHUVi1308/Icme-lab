clear
clc

n = input('Enter the Grid Size: \n');    %Grid size
no_grain = input('Enter the Number of Grains: \n');    %Number of Grains
v_x = input('Enter velocity of growth in x direction: \n');    %Vx
v_y = input('Enter velocity of growth in y direction: \n'); %Vy
f = input('Enter frequency: \n');    %Frequency
t = 1/f ;
grid = zeros(n,n);    %
count = 0;

% allocating random grain nucleus accross grid
x_pos= randperm(n,no_grain);
y_pos= randperm(n,no_grain);

for i=1:no_grain
    grid(x_pos(i),y_pos(i))=i;
end

for i= 1:no_grain
    a = x_pos(i);
    b = y_pos(i);
    for k = 0:n
        for l = 0:n
            if x_pos(i) +k <= n && y_pos(i)+l <= n
                if (x_pos(i)+k-a)^2/(v_x*t)^2 + (y_pos(i)+l-b)^2/(v_y*t)^2 <1
                    if grid(x_pos(i)+k,y_pos(i)+l)==0
                        grid(x_pos(i)+k,y_pos(i)+l)=grid(x_pos(i),y_pos(i));
                    else
                        i1 =grid(x_pos(i)+k,y_pos(i)+l);
                        d1 = ((x_pos(i)+k-x_pos(i1))^2 + (y_pos(i)+l-y_pos(i1))^2)^(0.5);
                        d2 = ((x_pos(i)+k-x_pos(i))^2 + (y_pos(i)+l-y_pos(i))^2)^(0.5);
                        dmin = min([d1,d2]);
                        if dmin == d2 
                            grid(x_pos(i)+k,y_pos(i)+l)=grid(x_pos(i),y_pos(i));
                        end
                    end
                end
            end
            if x_pos(i) -k >= 1 && y_pos(i)-l >= 1
                if (x_pos(i)-k-a)^2/(v_x*t)^2 + (y_pos(i)-l-b)^2/(v_y*t)^2 <1
                    if grid(x_pos(i)-k,y_pos(i)-l)==0
                        grid(x_pos(i)-k,y_pos(i)-l)=grid(x_pos(i),y_pos(i));
                    else
                        i1 =grid(x_pos(i)-k,y_pos(i)-l);
                        d1 = ((x_pos(i)-k-x_pos(i1))^2 + (y_pos(i)-l-y_pos(i1))^2)^(0.5);
                        d2 = ((x_pos(i)-k-x_pos(i))^2 + (y_pos(i)-l-y_pos(i))^2)^(0.5);
                        dmin = min([d1,d2]);
                        if dmin == d2 
                            grid(x_pos(i)-k,y_pos(i)-l)=grid(x_pos(i),y_pos(i));
                        end
                    end
                end
            end
            if x_pos(i) -k >= 1 && y_pos(i)+l <= n
                if (x_pos(i)-k-a)^2/(v_x*t)^2 + (y_pos(i)+l-b)^2/(v_y*t)^2 <1
                    if grid(x_pos(i)-k,y_pos(i)+l)==0
                        grid(x_pos(i)-k,y_pos(i)+l)=grid(x_pos(i),y_pos(i));
                    else
                        i1 =grid(x_pos(i)-k,y_pos(i)+l);
                        d1 = ((x_pos(i)-k-x_pos(i1))^2 + (y_pos(i)+l-y_pos(i1))^2)^(0.5);
                        d2 = ((x_pos(i)-k-x_pos(i))^2 + (y_pos(i)+l-y_pos(i))^2)^(0.5);
                        dmin = min([d1,d2]);
                        if dmin == d2 
                            grid(x_pos(i)-k,y_pos(i)+l)=grid(x_pos(i),y_pos(i));
                        end
                    end
                end
            end
            if x_pos(i) +k <= n && y_pos(i)-l >= 1
                if (x_pos(i)+k-a)^2/(v_x*t)^2 + (y_pos(i)-l-b)^2/(v_y*t)^2 <1
                    if grid(x_pos(i)+k,y_pos(i)-l)==0
                        grid(x_pos(i)+k,y_pos(i)-l)=grid(x_pos(i),y_pos(i));
                    else
                        i1 =grid(x_pos(i)+k,y_pos(i)-l);
                        d1 = ((x_pos(i)+k-x_pos(i1))^2 + (y_pos(i)-l-y_pos(i1))^2)^(0.5);
                        d2 = ((x_pos(i)+k-x_pos(i))^2 + (y_pos(i)-l-y_pos(i))^2)^(0.5);
                        dmin = min([d1,d2]);
                        if dmin == d2 
                            grid(x_pos(i)+k,y_pos(i)-l)=grid(x_pos(i),y_pos(i));
                        end
                    end
                end
            end
        end
    end
        
    

end

grid


set(pcolor(grid), 'EdgeColor', 'none');


% COUNTING GB, TP AND INTERIOR POINTS
    var1=1;
    var2=1;
    grid_scan=0;
    grainboundary_count=0;
    triplepoint_count=0;
    interiorpoints=0;
    while var1<=n
        while var2<=n
            grid_scan=grid(var1,var2);
            if var1<=n-1 && var2<=n-1 && var1>=2 && var2>=2
                if grid(var1,var2+1)==grid_scan && grid(var1,var2-1)==grid_scan && grid(var1+1,var2)==grid_scan && grid(var1-1,var2)==grid_scan
                interiorpoints=interiorpoints+1 ;                           
                end 
                a=[grid(var1,var2+1),grid(var1+1,var2),grid(var1,var2-1),grid(var1-1,var2)];
                if length(unique(a))>=3
                    triplepoint_count=triplepoint_count+1;
                end

            end
            if var1==1 && var2~=1 && var2~=n
                    if grid(var1,var2-1)==grid_scan && grid(var1+1,var2)==grid_scan && grid(var1,var2+1)==grid_scan
                        interiorpoints=interiorpoints+1;
                    end
                    a=[grid(var1,var2+1),grid(var1+1,var2),grid(var1,var2-1)];
                if length(unique(a))>=3
                    triplepoint_count=triplepoint_count+1;
                end
            end
            if var2==1 && var1~=n && var1~=1
                if grid(var1-1,var2)==grid_scan && grid(var1+1,var2)==grid_scan && grid(var1,var2+1)==grid_scan
                   interiorpoints=interiorpoints+1;
                end
                a=[Grid(var1,var2+1),grid(var1+1,var2),grid(var1-1,var2)];
                if length(unique(a))>=3
                    triplepoint_count=triplepoint_count+1;
                end
            end
            if var2==n && var1~=1 && var1~=n
                if grid(var1,var2-1)==grid_scan && grid(var1+1,var2)==grid_scan && grid(var1-1,var2)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
                a=[grid(var1+1,var2),grid(var1,var2-1),grid(var1-1,var2)];
                if length(unique(a))>=3
                    triplepoint_count=triplepoint_count+1;
                end
            end
            if var1==n && var2~=1 && var2~=n
                if grid(var1,var2-1)==grid_scan && grid(var1,var2+1)==grid_scan && grid(var1-1,var2)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
                a=[grid(var1,var2+1),grid(var1,var2-1),grid(var1-1,var2)];
                if length(unique(a))>=3
                    triplepoint_count=triplepoint_count+1;
                end
            end
            if var1==1 && var2==1
                if grid(1,2)==grid_scan && grid(2,1)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
            end
            if var1==n && var2==1
                if grid(n-1,1)==grid_scan && grid(n,2)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
            end
            if var1==1 && var2==n
                if grid(1,n-1)==grid_scan && grid(2,n)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
            end
            if var1==n && var2==n
                if grid(n-1,n)==grid_scan && grid(n,n-1)==grid_scan
                    interiorpoints=interiorpoints+1;
                end
            end
           var2=var2+1;
          end
         var1=var1+1;
         var2=2;
    end
interiorpoints
grainboundary_count= (n)^2 - interiorpoints
triplepoint_count

fraction_GB = grainboundary_count/(n^2)
fraction_interior = interiorpoints/(n^2)
fraction_TP = triplepoint_count/(n^2)