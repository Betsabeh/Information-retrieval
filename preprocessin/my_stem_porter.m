function [stem,num_token]=my_stem_porter(token)
[m,n]=size(token);
num_token=0;
for i=1:n
    l=1;
    t=token{1,i};
    [r,c]=size(t);
    for j=1:c
        temp=t{j};
        if strcmp(temp,'ied')~=1
          st{l} = porterStemmer(cell2mat(temp));
          l=l+1;
          num_token=num_token+1;
        end
    end
    stem{i}=st;
    clear st;
end
