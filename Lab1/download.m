company_list={'LLOY','VOD','BARC','BP','HSBA','BT-A','CNA','ITV','TSCO','RBS','LGEN','BA','KGF','EMG','BLT','SVT','UU','AZN','OML','CPG','SHP','REL','SKY','CCL','RB','BATS','PPB','EXPN','DLG','CCH'};
for company = company_list
    url=char(strcat('http://chart.finance.yahoo.com/table.csv?s=',company,'.L&a=2&b=2&c=2013&d=2&e=2&f=2017&g=d&ignore=.csv'));
    urlwrite(url,char(strcat(company,'.csv')));
end