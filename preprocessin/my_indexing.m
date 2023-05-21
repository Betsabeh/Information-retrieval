function [TF,DF]=my_indexing(Voc,token)
%this function create indexing 

%% finding tf  of each word in dictionary in documents
num_Doc=size(token,2);
num_Voc=size(Voc,2);
TF=zeros(num_Voc,num_Doc);
for i=1:num_Voc
    vocab=cell2mat(Voc(i));
    for j=1:num_Doc
        tok=token{j};
        num_tok=size(tok,2);
        for k=1:num_tok
            word=tok{k};
            if strcmp(vocab,word)==1
                TF(i,j)=TF(i,j)+1;
            end
        end
    end
end
%finding DF of each term
for i=1:num_Voc
    [x,y]=find(TF(i,:)~=0);
    s=sum(x);
    DF(i)=s;
% %     inverted_index_list{i,1}=DF(i);
% %     list=[y',TF(i,y)'];
% %     inverted_index_list{i,2}=list;
end
            
    