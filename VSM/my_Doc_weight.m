function Doc_weights=my_Doc_weight(TF,DF,total_num_doc)
%this function find the weight of each documents as a vector
% each vector element represent a weight according to TF_IDF
%TF is normlized TF(i,Doc)/max(TF(:,Doc))
%IDF is :log10(N/DF(i))
% N is the total number of Documents

%% variables
num_doc=size(TF,2);
num_voc=size(TF,1);
Doc=TF'; % invert TF= rows are DOC and columns are vocabulary
for i=1:num_doc
    max_Freq=max(Doc(i,:));
    if max_Freq==0
        Doc_weights(i,:)=0;
        continue;
    end
    for j=1:num_voc
        if DF(j)==0
            DF(j)=10^-6;
        end
        Doc_weights(i,j)=(Doc(i,j)/max_Freq)*log10(total_num_doc/DF(j));
    end
end
