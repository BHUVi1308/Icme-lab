clear
clc

n = input('Enter the Grid Size: \n');    %Grid size
no_grain = input('Enter the Number of Grains: \n');    %Number of Grains
v_x = input('Enter velocity of growth in x direction: \n');    % Vx
v_y = input('Enter velocity of growth in y direction: \n');  % Vy
f = input('Enter frequency: \n');    %Frequency
t = 1/f ;
grid = zeros(n,n);   
count = 0;

% allocating random grain nucleus accross grid
x_pos= randperm(n,no_grain);
y_pos= randperm(n,no_grain);

for i=1:no_grain
    grid(x_pos(i),y_pos(i))=i;
end

for k = 0:n
    for l = 0:n
        for i = 1:no_grain
            a = x_pos(i);
            b = y_pos(i);
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
    count = count + 1;
    
    if mod(count, t) == 0
        set(pcolor(grid), 'EdgeColor', 'none');
        f = getframe
        [im, map] = rgb2ind(f.cdata, 256, 'nodither')
       
        %To Generate gif
        
        imwrite(im, map, 'Question1.gif', 'gif', 'Loopcount', inf) 
        imwrite(im, map, 'Question1.gif', 'gif', 'WriteMode', 'append')  
    end    
    

end