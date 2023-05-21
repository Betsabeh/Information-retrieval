function [mean_voc,mean_freq]=List_meaningfull(Voc,Voc_Freq)
%% list 10 top meaningful word
Stop_word_list=textread('D:\IR\IR_94\stopwords_me.txt','%s','delimiter','\n');
n=size(Voc,2);
j=0;
for i=1:n
    f=myfind(Stop_word_list,Voc{i});
    if f==0
      j=j+1;
      mean_voc{j}=Voc{i};
      mean_freq{j}=Voc_Freq{i};
      if j==10
          break;
      end
    end
end
end

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