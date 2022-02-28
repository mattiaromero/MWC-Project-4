function [erms]=root_mean_square_error(model,observations)
    n=length(observations);
    erms=0;
    for i=1:n
       erms=erms+((model(i)-observations(i)).^2);
    end 
    erms=sqrt((1/n)*erms);