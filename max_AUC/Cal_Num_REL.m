function [num_Rel,Num_NRel,Rel_list]=Cal_Num_REL(query_id,total_num_Doc)
%% read relevant file
 relevant_Doc=textread('D:\IR\IR_94\cran.tar\relevant.txt','%s','delimiter','\n');
%% change query id to char
a1=query_id;
count=1;
 while (a1>0)
         r(count)=mod(a1,10);
         a1=floor(a1/10);
         count=count+1;
 end
 q_id='';
 for g=count-1:-1:1
     v=r(g);
     q_id=strcat(q_id, char(v+48));
 end
 %% number of total relevant documents and searching for the query
ALL_relevant_num=size(relevant_Doc,1);
for i=1:ALL_relevant_num
    string=relevant_Doc{i};
    [id,string]=strtok(string);
    if strcmp(q_id,id)==1
        break;
    end
end
j=i;
k=1;
 while (j)
     string=relevant_Doc{j};
    [id,string]=strtok(string);
    if strcmp(id,q_id)~=1
        break;
    else
     [r_id,string]=strtok(string); 
     n=size(r_id,2);
     s=0;
     for i=1:n
         s=s*10+(r_id(i)-'0');
     end
     Rel_list(k)=s;
     k=k+1;
     j=j+1;
    end
 end
 %% find num_REL and num_NON_REL
 num_Rel=k-1;
 Num_NRel=total_num_Doc-num_Rel;