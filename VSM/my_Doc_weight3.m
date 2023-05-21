function Doc_weights=my_Doc_weight3(TF,DF,total_num_doc,option)
%this function find the weight of each documents as a vector
% each vector element represent a weight it depends on being document or
% query
%for document  J weight of a term 
%i=(TF(i,Doc_J)*logN/n)/sqrt(sum(tfi(log(N/ni))^2)
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
        t1=TF(:,i)'.*log10(num_doc./DF);
        t2=sqrt(sum(t1.^2));
        if t2==0
            Doc_weights(i,:)=0;
        else
            Doc_weights(i,:)=t1./t2;
        end
  end
end
