monster = Monster();

while 1 
    for A = monster.body
       monster.update(monster.pos_of_knee1, A);
       monster.update(monster.pos_of_knee2, A);
       % [cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)]
%        A = [0.5 -0.866; 0.866 0.5] * A;
A = [0 -1; 1 0] * A;
       monster.update(monster.pos_of_knee3, A);
       monster.update(monster.pos_of_knee4, A);
       
       hold off;
       axis([-15 15 -15 15]);
       pause(0.1);
    end
end
