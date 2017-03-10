%Generate 100 random portfolios and plot a scatter diagram in the E ? V space as shown in Fig. 1 of [1].
m=[0.10 0.20 0.15]';
C=[0.005 -0.01 0.004;-0.01 0.04 -0.002;0.004 -0.002 0.023];
V=zeros(100,1);
E=zeros(100,1);
for loop=1:100
    X=rand(3,1);
    X=X./sum(X);
    %so that the sum of X is one
    E(loop)=sum(X.*m);
    size=length(X);
    for i=1:size
        for j=1:size
            V(loop)=V(loop)+C(i,j)*X(i)*X(j);
        end
    end
end   
V=sqrt(V);
%standard deviation
figure
plot(V,E,'r.')
hold on
xlabel('standard deviation', 'FontSize', 14)
ylabel('expectation', 'FontSize', 14)
title('E-V space', 'FontSize', 14)
[an1,an2,~]=navim(m,C,10);
%figure
plot(an1,an2,'linewidth',2)
%random_pro=rand(3,100);
%random_pro=random_pro./sum(random_pro);
%[risk,ret]=portstats(m', C,random_pro');
%plot(risk,ret,'g.')
hold off

