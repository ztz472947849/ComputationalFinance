
m=[0.10 0.20 0.15]';
C=[0.05 -0.01 0.004;-0.01 0.04 -0.002;0.004 -0.002 0.023];

%3 assets
p = Portfolio;
p = setAssetMoments(p, m, C);
p = setDefaultConstraints(p);
figure
plotFrontier(p, 10);
hold on
random_pro=rand(3,100);
random_pro=random_pro./sum(random_pro);
[an1,an2]=portstats(m', C,random_pro');
plot(an1,an2,'.')
%=====================================


%2 assets
%pairs=[1 2;1 3;2 3];    
new_m=[m(1) m(2)];
new_C=[C(1,1) C(1,2);C(2,1) C(2,2)];
p = Portfolio;
p = setAssetMoments(p, new_m, new_C);
p = setDefaultConstraints(p);
plotFrontier(p, 10);
random_pro=rand(2,100);
random_pro=random_pro./sum(random_pro);
[an1,an2]=portstats(new_m, new_C,random_pro');
plot(an1,an2,'.b')

new_m=[m(1) m(3)];
new_C=[C(1,1) C(1,3);C(3,1) C(3,3)];
p = Portfolio;
p = setAssetMoments(p, new_m, new_C);
p = setDefaultConstraints(p);
plotFrontier(p, 10);
random_pro=rand(2,100);
random_pro=random_pro./sum(random_pro);
[an1,an2]=portstats(new_m, new_C,random_pro');
plot(an1,an2,'.g')


new_m=[m(2) m(3)];
new_C=[C(2,2) C(2,3);C(3,2) C(3,3)];
p = Portfolio;
p = setAssetMoments(p, new_m, new_C);
p = setDefaultConstraints(p);
plotFrontier(p, 10);
random_pro=rand(2,100);
random_pro=random_pro./sum(random_pro);
[an1,an2]=portstats(new_m, new_C,random_pro');
plot(an1,an2,'.m')
hold off


%NumPorts = 10;

%p = Portfolio;
%p = setAssetMoments(p, ExpReturn, ExpCovariance);
%p = setDefaultConstraints(p);

%plotFrontier(p, NumPorts);