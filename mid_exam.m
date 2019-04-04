theta = linspace(0, 2*pi, 100);

% 大圓
big_circle_x0y0 = [-5; 0];
big_circle_r = 5;
big_circle = [big_circle_r*cos(theta); big_circle_r*sin(theta)] + big_circle_x0y0;

% 小圓
small_circle_x0y0 = [5; 0];
small_circle_r = 3;
small_circle = [small_circle_r*cos(theta); small_circle_r*sin(theta);] + small_circle_x0y0;

a = big_circle_r;
b = 10; % 桿長
B_xy = big_circle_x0y0;

while 1
    for A_xy = small_circle
       c = norm(A_xy-B_xy);
       B = acos((a^2+c^2-b^2) / (2*a*c));
       
       % 畫大圓小圓
       plot(big_circle(1,:), big_circle(2,:));hold on;
       plot(small_circle(1,:), small_circle(2,:));hold on;
       % 畫第一個b
       C_xy = [a*cos(B); a*sin(B)] + big_circle_x0y0;
       plot([C_xy(1) A_xy(1)], [C_xy(2) A_xy(2)]);hold on;
       % 畫第二個b
       C_xy = [a*cos(-B); a*sin(-B)] + big_circle_x0y0;
       plot([C_xy(1) A_xy(1)], [C_xy(2) A_xy(2)]);hold off;
       
       axis([-10 10 -10 10]);
       
       pause(0.01)
    end
end