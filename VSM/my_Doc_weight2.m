function Doc_weights=my_Doc_weight2(TF,DF,total_num_doc,option)
%this function find the weight of each documents as a vector
% each vector element represent a weight it depends on being document or
% query
%for document  J weight of a term i=TF(i,Doc_J)/sum(TF(:,Doc_J))
%for query weight of term i=(0.5+0.5*(TF(i,Q)/max(TF(:,Q))))* log(N/n)
% N is the total number of Documents
% n is the number of document a term is assigned

%% variables
  num_doc=size(TF,2);
  num_voc=size(TF,1);
  Doc=TF'; % invert TF= rows are DOC and columns are vocabulary
if strcmp(option, 'Query')==1
  for i=1:num_doc
    max_Freq=max(Doc(i,:));
    for j=1:num_voc
       t=0.5+0.5*(Doc(i,j)/max_Freq);
       Doc_weights(i,j)=t*log10(total_num_doc/DF(j));
    end
  end
else
  for i=1:num_doc
     S=sum(Doc(i,:));
     if S==0
         Doc_weights(i,:)=0;
         continue;
     end
    for j=1:num_voc 
        Doc_weights(i,j)=Doc(i,j)/S;
    end
  end
end
