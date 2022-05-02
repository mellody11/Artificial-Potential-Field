function [Frepx,Frepy] = RepulsiveImprove(x,y,ox,oy,x0,y0,k,P0)
Pobs = sqrt((x-ox)^2 + (y-oy)^2);           % 障碍物离机器人距离
Pdes = sqrt((x-x0)^2 + (y-y0)^2);           % 目标点离机器人距离
    if(Pobs>P0)
        Frepx = 0;
        Frepy = 0;
    else
        Frepx = (k * (1/Pobs - 1/P0) * (Pdes^2)/(Pobs^2) * ((x-ox)/Pobs)) + (2/2 * k * (1/Pobs - 1/P0)^2 * Pdes * ((x0-x)/Pdes));
        Frepy = (k * (1/Pobs - 1/P0) * (Pdes^2)/(Pobs^2) * ((y-oy)/Pobs)) + (2/2 * k * (1/Pobs - 1/P0)^2 * Pdes * ((y0-y)/Pdes));  
    end
end