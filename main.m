monster = Monster();

while 1 
    for A = monster.body
       monster.update(monster.pos_of_knee1, A);
       monster.update(monster.pos_of_knee2, A);
       % [cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)]
       monster.update(monster.pos_of_knee3, [cos()] * A);
       monster.update(monster.pos_of_knee4, [] * A);
       
       hold off;
       axis([-15 15 -15 15]);
       pause(0.01);
    end
end