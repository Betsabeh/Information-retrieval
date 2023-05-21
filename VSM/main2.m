%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Assignment 2 
clc
clear all
%% step1:preprocessing is done in Assignment 1
load('Stem_token.mat')
%% reduce Vocabulary size with just the word in queries
for i=1:10
    %% read query file name
    a1=i;
    count=1;
    name='D:\IR\IR_94\Subset of queries\q';
     while (a1>0)
         r(count)=mod(a1,10);
         a1=floor(a1/10);
         count=count+1;
     end
     for g=count-1:-1:1
         v=r(g);
         name=strcat(name, char(v+48));
     end
     name=strcat(name,'.txt');
     q=textread(name,'%s','delimiter','\n');
     %% query tokenization
     [num_Q_token(i),Query_token(i,:)]=my_tokenization(q);
     
end
%% remove stop words and stemming
new_Q_token=my_stop_word_remove(Query_token');
[stem_Q_token , num_Q_token]=my_stem_porter(new_Q_token);
 save('Stem_Q_token.mat','stem_Q_token')
%% determine vocabulary 
switch 1
    case 1
        %% reduced vocabulary
        [Q_Voc,Q_Voc_Freq]=my_vocab(stem_Q_token);
        [Voc,Q_Voc_Freq] = sort_Alph(Q_Voc,Q_Voc_Freq );
        %% step2: Document and query indexing 
        [TF,DF]=my_indexing(Voc,stem_token);
        [Q_TF,Q_DF]=my_indexing(Voc,stem_Q_token);

    case 2
        %% full vocab
        load('Sort_Stem_Voc.mat');
        Voc=S_Voc;
        load('Full_TF.mat')
        load('Full_DF.mat')
        [Q_TF,Q_DF]=my_indexing(Voc,stem_Q_token);

  end

%% weighting scheme
switch 1
    %% TF_IDF
    case 1
        total_num_doc=size(stem_token,2);
        Doc_weights=my_Doc_weight(TF,DF,total_num_doc);
        Querys_weights=my_Doc_weight(Q_TF,DF,total_num_doc);

    %% Txc-nfx    
    case 2
        total_num_doc=size(stem_token,2);
        Doc_weights=my_Doc_weight2(TF,DF,total_num_doc,'Doc');
        Querys_weights=my_Doc_weight2(Q_TF,DF,total_num_doc,'Query');
    case 3
        total_num_doc=size(stem_token,2);
        Doc_weights=my_Doc_weight3(TF,DF,total_num_doc,'Doc');
        Querys_weights=my_Doc_weight3(Q_TF,DF,total_num_doc,'Query');   
end

%% step 3:similarity
retrieve_num={10,50,100,500};
for j=1:4
    top=cell2mat(retrieve_num(j));
     disp([' the result of top ',  top, 'documents in the ranking'])
for i=1:10
    disp('---------------------Query--------------------------')
    [list_doc,sim_value,top_list,top_sim]=my_simliarity(Querys_weights(i,:),Doc_weights,top);
    [precision(i),recall(i)]=my_percision_recall(top_list,i,top_sim)
end

Avg_P(j)=mean(precision)
Avg_R(j)=mean(recall)
end


