function [exp_return_mean] = cal_cov(price)
%price=price_data;
exp_return=[];
for i =1:length(price)-1
exp_return=[exp_return;(price(i,:)-price(i+1,:))./price(i+1,:)];
end
%log=ln in matlab!
%log(x)/log(exp(1))
exp_return_mean=mean(exp_return);
%exss_return=exp_return-exp_return_mean;
%C=exss_return'*exss_return;
%eret=mean()