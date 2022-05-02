function [Fattx,Fatty] = Attractive(x0,x1,y0,y1,k)
    Fattx = -k*(x0-x1);
    Fatty = -k*(y0-y1);
end