company_list={'LLOY','VOD','BARC','BP','HSBA','BT-A','CNA','ITV','TSCO','RBS','LGEN','BA','KGF','EMG','BLT','SVT','UU','AZN','OML','CPG','SHP','REL','SKY','CCL','RB','BATS','PPB','EXPN','DLG','CCH'};
price_data=[];
k=1;
for i=company_list
read=csvread(char(strcat(i,'.csv')),1,6);
for j=1:length(read)
    price_data(j,k)=read(j,:);
end
k=k+1;
end
while find(~price_data)
for i = find(~price_data)
price_data(i)=price_data(i-1);
end
end

read=csvread('download.csv',1,3);
read=read(:,1);
read=flipud(read);
read=[read;zeros(31,1)];
ftse=read;
while find(~ftse)
    for i=find(~ftse)
        ftse(i)=ftse(i-1);
    end
end
expftse=[];
for i=1:length(ftse(1:520,:))-1
expftse=[expftse;(ftse(i,:)-ftse(i+1,:))./ftse(i+1,:)];

end
trainset=price_data(1:520,:);
compareset=price_data(521:1040,:);
exptrain=[];
input_assets=trainset(2:520,:);
for i=1:length(trainset)-1
exptrain=[exptrain;(trainset(i,:)-trainset(i+1,:))./trainset(i+1,:)];

end
%w=ones(30,1);
error=sqrt(mean(exptrain-expftse).^2);
index=[];
for i=1:6
[~,I] = min(error(:));
index=[index;I];
error(1,I)=10;
end
w=[1/6;1/6;1/6;1/6;1/6;1/6];
%Sparse
%gamma = 8.0;
gamma=0.2;
w2=w;
while length(find(w2<10e-4))<30-6
    %trick part
gamma = gamma+0.1;

    cvx_begin quiet
    variable w2( 30,1 );
    minimize( norm(ftse(1:519,:)-exptrain*w2,2) + norm(gamma*w2,1) )
    subject to
        ones(1,30)*w2 == 1,
        w2>=0;
    cvx_end
end
%pick the largest 6 among them.! TODO
% and compare 2 performance.
%it is actually C(6,30)
 sorted=sort(w2,'descend');
 w2=sorted(1:6);
w2=w2.*(1/sum(w2));
%scale to one



