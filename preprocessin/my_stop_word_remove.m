function new_token=my_stop_word_remove(token)
[m,n]=size(token);
Stop_word_list=textread('D:\IR\IR_94\stopwords_me.txt','%s','delimiter','\n');
doc={};
for i=1:n
    l=1;
    t=token{i};
    t = lower(t);
    [r,c]=size(t);
    for j=1:c
        temp=t(j);
        fl=myfind(Stop_word_list,temp);
        if fl~=1
            doc{l}=temp;
            l=l+1;
        end
    end
    new_token{i}=doc;
    clear doc
end

%%%stop word %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%find 
function fl=myfind(Stop_word_list,word)
[m1,n1]=size(Stop_word_list);
fl=0;
for i1=1:m1
    te=Stop_word_list{i1};
    if strcmp(te,word)==1
        fl=1;
        return;
    end
end


end
end
