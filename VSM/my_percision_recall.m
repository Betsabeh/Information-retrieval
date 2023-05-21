function [Precision,Recall]=my_percision_recall(top_list_doc,query_id,sim_value)
%calculate the precision and recall 
%top_list_doc=output of IR system (list of documents)
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
     rel(k)=s;
     k=k+1;
     j=j+1;
    end
 end
 
 %% find precision and recall
 total_num_Retrive=size(top_list_doc,2);
 num_Relevant_Ret=0;
 total_Relevant=k-1;
 Precision(1)=0;
 Recall(1)=0;
 disp(['retrive document for query=' q_id])
 for i=1: total_num_Retrive  
     doc_id=top_list_doc(i);
     disp('Doc_ID=         similarity=' )
     disp([doc_id sim_value(i)])
     if ~(isempty(find(rel==doc_id,1)) )
         num_Relevant_Ret=num_Relevant_Ret+1;
         disp ('Relevant documet')
     else
         disp ('Non Relevant document')
     end
     disp('******************************')
 end
 Precision=num_Relevant_Ret/total_num_Retrive;
 Recall=num_Relevant_Ret/total_Relevant;
 
         
         