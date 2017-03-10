rate=[];
for i=1:length(y)-1
rate=[rate;y(i,:)./y(i+1,:)];
end
figure
grid on
%axis([0 1100 300 600])
plot(x,sum(y'));
xlabel('days', 'FontSize', 14)
ylabel('price summary', 'FontSize', 14)
title('1/N portfolio', 'FontSize', 14)
axis([0 1100 300 600])
%hold on
%axis([200 205])
r_co=rate*weights;
r_co=[r_co;1];
new_y=sum(y');
new_y=new_y';
for i=1:length(r_co)
new_y(i,:)=new_y(i,:).*r_co(i,:);
end
figure
grid on
%axis([0 1100 300 600])
plot(x,new_y);
xlabel('days', 'FontSize', 14)
ylabel('price summary', 'FontSize', 14)
title('MV portfolio', 'FontSize', 14)
axis([0 1100 300 600])