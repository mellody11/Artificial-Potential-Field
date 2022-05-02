function [Frepx,Frepy] = Repulsive(x,y,ox,oy,k,P0)
% 先计算与障碍物的欧氏距离
Pobs = sqrt((x-ox)^2 + (y-oy)^2);
    if(Pobs>P0)
        Frepx = 0;
        Frepy = 0;
    else
        Frepx = k * (1/Pobs - 1/P0) * (1/Pobs^2) * ((x-ox)/Pobs);
        Frepy = k * (1/Pobs - 1/P0) * (1/Pobs^2) * ((y-oy)/Pobs);
    end
end