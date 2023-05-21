%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Assignment 1
clc
clear all
%% 1.a (remove tags)
corpus_name='D:\IR\IR_94\cran.tar\cran_all.txt';
%%%%%Remove_tags(corpus_name);
load('remove_xml_Doc.mat')
%% 1.b (tokenization)
[num_token,token]=my_tokenization(Doc);
save('token.mat','token')
%% 2.a (vocabulary size)
% % % [Voc,Voc_Freq]=my_vocab(token);
% % % save('Voc.mat','Voc')
% % % save('Voc_Freq.mat','Voc_Freq')
load('Voc.mat')
load('Voc_Freq.mat')
Voc_Size=size(Voc,2);
disp('Vocabulary Size=')
disp(Voc_Size)
%% 2.b (10 top words)
% % [Voc,Voc_Freq] = sort_Freq( Voc,Voc_Freq );
% % save('Sort_Voc.mat','Voc')
% % save('Sort_Freq_Voc.mat','Voc_Freq')
load('Sort_Voc')
load('Sort_Freq_Voc.mat')
disp('WORD   WORD FREQUENCY')
disp('----   --------------')
for i=1:10
    disp([Voc{i},'         ' , num2str(Voc_Freq{i})])
    
end
%% 2.c (10 top minigful words)
[mean_voc,mean_freq]=List_meaningfull(Voc,Voc_Freq);
disp('WORD   WORD FREQUENCY')
disp('----   --------------')
for i=1:10
    disp([mean_voc{i},'         ' , num2str(mean_freq{i})])
    
end
%% 2.d minimum number of unique words counting
s=0;
for i=1:Voc_Size
    s=s+Voc_Freq{i};
    if s>=(num_token/2)
        disp(' minimum number of unique words counting for half of total number of words:')
        disp(i)
        break;
    end
end
%% 3.Apply porter Stemmer and stop word elimnator 
 new_token=my_stop_word_remove(token);
 [stem_token,num_S_token]=my_stem_porter(new_token);
save('Stem_token.mat','stem_token')
load('Stem_token.mat')
disp('After Stemming result')
%% 3.a (vocabulary size)
[S_Voc,S_Voc_Freq]=my_vocab(stem_token);
save('Stem_Voc.mat','S_Voc')
save('Stem_Voc_Freq.mat','S_Voc_Freq')
load('Stem_Voc.mat')
load('Stem_Voc_Freq.mat')
S_Voc_Size=size(S_Voc,2);
disp('Vocabulary Size after steming=')
disp(S_Voc_Size)
%% 3.b (10 top words)
[S_Voc,S_Voc_Freq] = sort_Freq( S_Voc,S_Voc_Freq );
save('Sort_Stem_Voc_Freq','S_Voc_Freq')
save('Sort_Stem_Voc.mat','S_Voc')
load('Sort_Stem_Voc.mat')
disp('WORD   WORD FREQUENCY')
disp('----   --------------')
for i=1:10
    disp([S_Voc{i},'         ' , num2str(S_Voc_Freq{i})])
    
end
%% 3.c (10 top minigful words)
[mean_voc,mean_freq]=List_meaningfull(S_Voc,S_Voc_Freq);
disp('WORD   WORD FREQUENCY')
disp('----   --------------')
for i=1:10
    disp([mean_voc{i},'         ' , num2str(mean_freq{i})])
    
end
%% 3.d minimum number of unique words counting
s=0;
for i=1:S_Voc_Size
    s=s+S_Voc_Freq{i};
    if s>=(num_S_token/2)
        disp(' minimum number of unique words counting for half of total number of words:')
        disp(i)
        break;
    end
end
%% 4 find K and Beta for heap law
[K,Beta]=Heap_Law(token);
disp(' K and Beta ')
disp([K   Beta])
%% determine number of voc for n=500,000
num_voc=K*(500000^Beta);
disp('vocabulary size for 500,000 words')
disp(num_voc)
%% determine number of voc for n=2,000,000
num_voc=K*(2000000^Beta);
disp('vocabulary size for 2,000,000 words')
disp(num_voc)
