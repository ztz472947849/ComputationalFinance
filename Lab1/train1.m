company_list={'LLOY','VOD','BARC','BP','HSBA','BT-A','CNA','ITV','TSCO','RBS','LGEN','BA','KGF','EMG','BLT','SVT','UU','AZN','OML','CPG','SHP','REL','SKY','CCL','RB','BATS','PPB','EXPN','DLG','CCH'};
price_data=[];
k=1;l=1;
%price_sum=0;
for i=company_list(1:3)
%pick first 3 companies
pre_read=csvread(char(strcat(i,'.csv')),1,6);
%figure
%plot(linspace(length(pre_read)-1,1,length(pre_read))-2,pre_read);
%title(char(strcat(i,'''s stock price in 3 years')));
%xlabel('days');
%ylabel('price');
read=pre_read(520:length(pre_read));
read1=pre_read(1:519);
%display(i);
%display(k);
for j=1:length(read)
    price_data(j,k)=read(j,:);
end
k=k+1;
for j=1:length(read1)
    price_data1(j,l)=read1(j,:);
end
l=l+1;
end
%500+ days by 3 companies matrix
while find(~price_data)
for i = find(~price_data)
price_data(i)=price_data(i-1);
end
end
while find(~price_data1)
for i = find(~price_data1)
price_data1(i)=price_data1(i-1);
end
end
%padding with same values
%m=[(price_data(1,1)-price_data(length(price_data),1))/price_data(1,1);(price_data(1,2)-price_data(length(price_data),2))/price_data(1,2);(price_data(1,3)-price_data(length(price_data),3))/price_data(1,3)];
C=cov(price_data)/100;
m=cal_cov(price_data);
[an1,an2,~]=navim(m,C,10);
figure
grid on
plot(an1,an2,'linewidth',2)
xlabel('standard deviation', 'FontSize', 14)
ylabel('expectation', 'FontSize', 14)
title('Efficient frontier', 'FontSize', 14)
%hold on
%%m=[m;0.1];
%C=[C [0;0;0]];
%C=[C;0 0 0 0];
%[an1,an2,~]=navim(m,C,10);
%plot(an1,an2,'linewidth',2)
%hold off
C_new=cov(price_data1)/100;
m_new=cal_cov(price_data1);
%m_new=[(price_data1(1,1)-price_data1(length(price_data1),1))/price_data1(1,1);(price_data1(1,2)-price_data1(length(price_data1),2))/price_data1(1,2);(price_data1(1,3)-price_data1(length(price_data1),3))/price_data1(1,3)];

p = Portfolio('AssetMean',m, 'AssetCovar',C);
p = setDefaultConstraints(p);
figure
plotFrontier(p, 20);
weights = estimateMaxSharpeRatio(p);
[risk, ret] = estimatePortMoments(p, weights);
[risk_even,ret_even]=estimatePortMoments(p,[1/3;1/3;1/3]);
hold on
plot(risk,ret,'*r');
plot(risk_even,ret_even,'*g')
hold off
%rest half of data
p1 = Portfolio('AssetMean',m_new, 'AssetCovar',C_new);
p1 = setDefaultConstraints(p1);
figure
plotFrontier(p1, 20);
%weights = estimateMaxSharpeRatio(p);
[risk, ret] = estimatePortMoments(p1, weights);
[risk_even,ret_even]=estimatePortMoments(p1,[1/3;1/3;1/3]);
hold on
plot(risk,ret,'*r');
plot(risk_even,ret_even,'*g')
hold off
%figure
%plot(linspace(length(pre_read)-1,1,length(pre_read))-2,pre_read);
display(m_new*weights)
display(m_new*[1/3;1/3;1/3])