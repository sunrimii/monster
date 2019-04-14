classdef Monster
    properties
        body
        pos_of_body
        r_of_body
        num_of_bodypnts

        knee1
        knee2
        knee3
        knee4
        pos_of_knee1
        pos_of_knee2
        pos_of_knee3
        pos_of_knee4
        r_of_knee
        color_of_knee1
        color_of_knee2
        color_of_knee3
        color_of_knee4

        len_of_leg

        zero_to_2pi
    end
    
    methods
        % 建構子
        function monster = Monster()
            % 此段為可調整的參數
            monster.r_of_body = 3;
            monster.pos_of_body = [0; 0];
            monster.pos_of_knee1 = [8; 0];
            monster.pos_of_knee2 = [-8; 0];
            monster.pos_of_knee3 = [8; 0];
            monster.pos_of_knee4 = [-8; 0];
            monster.r_of_knee = 6;
            monster.len_of_leg = 8;
            monster.color_of_knee1 = rand(1, 3);
            monster.color_of_knee2 = rand(1, 3);
            monster.color_of_knee3 = rand(1, 3);
            monster.color_of_knee4 = rand(1, 3);

            monster.zero_to_2pi = linspace(0, 2*pi, 50);

            monster.body = [cos(monster.zero_to_2pi); sin(monster.zero_to_2pi)] .* monster.r_of_body + monster.pos_of_body;
            monster.knee1 = [cos(monster.zero_to_2pi); sin(monster.zero_to_2pi)] .* monster.r_of_knee + monster.pos_of_knee1;
            monster.knee2 = [cos(monster.zero_to_2pi); sin(monster.zero_to_2pi)] .* monster.r_of_knee + monster.pos_of_knee2;
            monster.knee3 = [cos(monster.zero_to_2pi); sin(monster.zero_to_2pi)] .* monster.r_of_knee + monster.pos_of_knee3;
            monster.knee4 = [cos(monster.zero_to_2pi); sin(monster.zero_to_2pi)] .* monster.r_of_knee + monster.pos_of_knee4;
        end

        function plot_body(monster)
            fill(monster.body(1, :), monster.body(2, :), [0.3,0.6,0.3], 'edgealpha', 0.6, 'facealpha', 0.6);hold on;
        end

        function plot_knee(monster)
            plot(monster.knee1(1, :), monster.knee1(2, :), '--');hold on;
            plot(monster.knee2(1, :), monster.knee2(2, :), '--');hold on;
            plot(monster.knee3(1, :), monster.knee3(2, :), '--');hold on;
            plot(monster.knee4(1, :), monster.knee4(2, :), '--');hold on;
        end
        
        function plot_leg(monster, moving_pnt, pos_of_knee, color)
            % 變數命名風格
            % A代表A點座標
            % AB代表A點到B點的長度
            % ABC代表3點在B點所夾的角度

            A = moving_pnt;
            B = pos_of_knee;
            C2G = monster.len_of_leg;
            BC1 = monster.r_of_knee;
            
            % 計算各點座標
            AB = norm(A - B);
            AC = norm(monster.pos_of_body - B) * 1.3;
            ABC1 = acos((BC1^2 + AB^2 - AC^2) / (2 * BC1 * AB)); % B角由已知的三邊長度運用餘弦定理求得
            ABC1_offest = asin((A(2) - B(2)) / AB); % 偏移角度由圓的參數式求得 假想A點為以B點為圓心所作的圓上一點
            if B(1) < monster.pos_of_body % 若膝在身的左方
                C1 = [cos(ABC1 + ABC1_offest); sin(ABC1 + ABC1_offest)] * BC1 + B; % C1點在圓上的角度為B角角度加上偏移角度
                C2 = [cos(-ABC1 + ABC1_offest); sin(-ABC1 + ABC1_offest)] * BC1 + B; % C2點在圓上的角度為B角角度加上偏移角度
                D = [0 -1; 1 0] * (C1 - B) + B; % D點為向量BC1旋轉90度求得 化簡 D = [0 -1; 1 0] * ((C1 - B) - (B - B)) + B;
            else % 若膝在身的右方
                C1 = [cos(pi - (ABC1 + ABC1_offest)); sin(pi - (ABC1 + ABC1_offest))] * BC1 + B;
                C2 = [cos(pi - (-ABC1 + ABC1_offest)); sin(pi - (-ABC1 + ABC1_offest))] * BC1 + B;
                D = [0 1; -1 0] * (C1 - B) + B; % D點為向量BC1旋轉-90度求得 化簡 D = [0 1; -1 0] * ((C1 - B) - (B - B)) + B;
            end
            E = (D + C2) / 2; % E點為D和C2的中點
            F = (E - B) * 2 + B; % F點為向量BE的2倍
            if B(1) < monster.pos_of_body % 若膝在身的左方
                G = ([0 -1; 1 0] * (F - C2)) / norm(F - C2) * C2G  + C2; % D點為向量C2F旋轉90度再伸縮至腿長求得 化簡 G = [0 -1; 1 0] * ((F - B) - (C2 - B)) / norm(F - C2) * C2G + C2;
            else % 若膝在身的右方
                G = ([0 1; -1 0] * (F - C2)) / norm(F - C2) * C2G  + C2; % D點為向量C2F旋轉-90度再伸縮至腿長求得 化簡 G = [0 -1; 1 0] * ((F - B) - (C2 - B)) / norm(F - C2) * C2G + C2;
            end

            % 填充色塊
            fill([A(1) C1(1) B(1) C2(1)], [A(2) C1(2) B(2) C2(2)], color, 'edgealpha', 0.6, 'facealpha', 0.6);hold on;
            fill([B(1) C1(1) C1(1)], [B(2) C1(2) C1(2)], color, 'edgealpha', 0.6, 'facealpha', 0.6);hold on;
            fill([B(1) C2(1) F(1) D(1)], [B(2) C2(2) F(2) D(2)], color, 'edgealpha', 0.6, 'facealpha', 0.6);hold on;
            fill([C2(1) F(1) G(1)], [C2(2) F(2) G(2)], color, 'edgealpha', 0.6, 'facealpha', 0.6);hold on;

            % 畫點
            % plot(A(1), A(2), 'o');hold on;
            % plot(B(1), B(2), 'o');hold on;
            % plot(C1(1), C1(2), 'o');hold on;
            % plot(C2(1), C2(2), 'o');hold on;
            % plot(D(1), D(2), 'o');hold on;
            % plot(E(1), E(2), 'o');hold on;
            % plot(F(1), F(2), 'o');hold on;
            % plot(G(1), G(2), 'o');hold on;
            
            % 顯示文字
            % text(A(1), A(2), 'A');hold on;
            % text(B(1), B(2), 'B');hold on;
            % text(C1(1), C1(2), 'C1');hold on;
            % text(C2(1), C2(2), 'C2');hold on;
            % text(D(1), D(2), 'D');hold on;
            % text(E(1), E(2), 'E');hold on;
            % text(F(1), F(2), 'F');hold on;
            % text(G(1), G(2), 'G');hold on;
        end
    end 
end