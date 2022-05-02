function [Fattx,Fatty] = AttractiveImprove(x0,x1,y0,y1,k,d)
    Distence = sqrt((x0-x1)^2 + (y0-y1)^2);
    if(Distence <= d)
        Fattx = -k*(x0-x1);
        Fatty = -k*(y0-y1);
    else
        Fattx = -d*k*((x0-x1) / Distence);
        Fatty = -d*k*((y0-y1) / Distence);
    end
end