global monster
monster = Monster();

slider = uicontrol('style', 'slider', 'position', [20 10 500 20], 'min', 0, 'max', 2*pi);
slider.Callback = @plot_monster;

function plot_monster(slider, ~)
   global monster

   % for moving_pnt = monster.body
      theta = slider.Value;
      moving_pnt = [cos(theta); sin(theta)] .* monster.r_of_body + monster.pos_of_body;

      monster.plot_body();
      % monster.plot_knee();
      monster.plot_leg(moving_pnt, monster.pos_of_knee1, monster.color_of_knee1);
      monster.plot_leg(moving_pnt, monster.pos_of_knee2, monster.color_of_knee2);
      moving_pnt = [0 -1; 1 0] * moving_pnt; % 旋轉90度
      monster.plot_leg(moving_pnt, monster.pos_of_knee3, monster.color_of_knee3);
      monster.plot_leg(moving_pnt, monster.pos_of_knee4, monster.color_of_knee4);
         
      hold off;
      axis([-15 15 -15 15]);
      pause(0.001);
   % end
end