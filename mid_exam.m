theta = linspace(0, 2*pi, 50);

% 大圓
big_circle_x0y0 = [-5; 0];
big_circle_r = 6;
big_circle = [big_circle_r*cos(theta); big_circle_r*sin(theta)] + big_circle_x0y0;

% 小圓
small_circle_x0y0 = [10; 0];
small_circle_r = 3;
small_circle = [small_circle_r*cos(theta); small_circle_r*sin(theta);] + small_circle_x0y0;

a = big_circle_r;
b = 17; % 桿長
B_xy = big_circle_x0y0;

while 1
    for A_xy = small_circle
       c = norm(A_xy-B_xy);
       % 不可用acos((A_xy(1)-B_xy(1))/c)
       B_offest = asin((A_xy(2)-B_xy(2))/c);
       % 餘弦
       B = acos((a^2+c^2-b^2) / (2*a*c));
       
       % 畫大圓小圓
       plot(big_circle(1,:), big_circle(2,:));hold on;
       plot(small_circle(1,:), small_circle(2,:));hold on;
       % 畫A
       plot(A_xy(1), A_xy(2), 'o');hold on;
       % 畫第一個b
       C_xy = [a*cos(B+B_offest); a*sin(B+B_offest)] + big_circle_x0y0;
       plot(C_xy(1), C_xy(2), 'o');hold on;
       plot([C_xy(1) A_xy(1)], [C_xy(2) A_xy(2)]);hold on;
       % 畫第二個b
       C_xy = [a*cos(-B+B_offest); a*sin(-B+B_offest)] + big_circle_x0y0;
       plot(C_xy(1), C_xy(2), 'o');hold on;
       plot([C_xy(1) A_xy(1)], [C_xy(2) A_xy(2)]);hold off;
       
       axis([-15 15 -15 15]);
       
%        xxx = norm(C_xy-A_xy);
%        if round(xxx)~= 17
%            disp(xxx);
%            break;
%        end
       
       pause(0.01)
    end
end