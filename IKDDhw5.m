clc;
close;
clear;
fid = fopen('train.csv');
node = textscan(fid,'%d %d %d %s %s %s %d %d %d %s %n %s %s','HeaderLines',1,'Delimiter',',');
fclose(fid);

length = size(node{1},1);
table=zeros(5,length);
table(1,1:length)=node{1,2};
table(2,1:length)=node{1,3};
table(4,1:length)=node{1,11};
temp=node{1,6};
tempp=node{1,13};
for i = 1 : length
    if strcmp(temp(i), 'male')
        table(3,i)=1;
    end
    if table(4, i) > 20
        table(4, i) = 2;
    else if table(4, i) > 10 && table(4, i) <= 20
        table(4, i) = 1;
        else
            table(4, i) = 0;
        end
    end
    if strcmp(tempp(i), 'Q')
        table(5,i)=0;
    else if strcmp(tempp(i), 'C')
        table(5,i)=2;
        else
        table(5,i)=1;
        end
    end
end

fid2 = fopen('test.csv');
node2 = textscan(fid2,'%d %d %s %s %s %d %d %d %s %n %s %s','HeaderLines',1,'Delimiter',',');
fclose(fid2);

length2 = size(node2{1},1);
table2=zeros(5,length2);
table2(2,1:length2)=node2{1,2};
table2(4,1:length2)=node2{1,10};
temp2=node2{1,5};
tempp2=node2{1,12};
for i = 1 : length2
    if strcmp(temp2(i), 'male')
        table2(3,i)=1;
    end
    if table2(4, i) > 20
        table2(4, i) = 2;
    else if table2(4, i) > 10 && table2(4, i) <= 20
        table2(4, i) = 1;
        else
            table2(4, i) = 0;
        end
    end
    if strcmp(tempp2(i), 'Q')
        table2(5,i)=0;
    else if strcmp(tempp2(i), 'C')
        table2(5,i)=2;
        else
        table2(5,i)=1;
        end
    end
end

for i = 1 :length2
    der=zeros(1,length);
    for j = 1 :length
        der(j)=(table(2,j)-table2(2,i))*(table(2,j)-table2(2,i))+(table(3,j)-table2(3,i))*(table(3,j)-table2(3,i))+(table(4,j)-table2(4,i))*(table(4,j)-table2(4,i))+(table(5,j)-table2(5,i))*(table(5,j)-table2(5,i));
    end
    for j=1:15
        [a,b]=min(der);
        table2(1,i)=table2(1,i)+table(1,b);
        der(b)=100;
    end
    if (table2(1,i)/15)>0.5
        table2(1,i)=1;
    else
        table2(1,i)=0;
    end
end
fid3 = fopen('result.csv','w');
fprintf(fid3,'PassengerId,Survived\n');
temp3=node2{1,1};
for i=1:length2
fprintf(fid3,'%d,%d\n',temp3(i),table2(1,i));
end
fclose(fid3);