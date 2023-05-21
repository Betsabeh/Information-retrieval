function [Voc,Voc_Freq]=my_vocab(token)
%% set variables
num_doc=size(token,2);
voc_index=0;
Voc{1}=' ';
Voc_Freq{1}=0;
%% read from doc and save in Vocabulary
for i=1:num_doc
    doc=token{i};
    num_token=size(doc,2);
    for j=1:num_token
        tok=doc{j};
        flag=0;
        %% just for faster implimantation
        r=strfind(Voc,tok);
        s=sum(cell2mat(r));
        if s~=0
            for k=1:voc_index
                if strcmp(Voc{k},tok)==1
                    Voc_Freq{k}=Voc_Freq{k}+1;
                    flag=1;
                end
            end
        end
        if flag==0
            voc_index=voc_index+1;
            Voc{voc_index}=tok;
            Voc_Freq{voc_index}=1;
        end
    end
end



