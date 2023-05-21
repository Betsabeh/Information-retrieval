%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUC optimzation
clc
clear all
close all
%% variables
num_Query=10;
num_Retrieve=20;
Beta=[5 10 50 100 1000 10000];
Mu=[0.001 0.01 0.1 0.3 0.5 1] ;
fold=10;
%% step1:Documents preprocessing is done in Assignment 1
load('Stem_token.mat')
%total_num_Doc=size(stem_token,2);
%% step 2:Query preprocessing 
load('Stem_Q_token.mat')
%% step 3:vocabulary 
switch 1
    case 1
        load ('Sort_Stem_Voc')
        load('Full_TF.mat')
        load('Full_DF.mat')

    case 2
        [Q_Voc,Q_Voc_Freq]=my_vocab(stem_Q_token);
        [S_Voc,Q_Voc_Freq] = sort_Alph(Q_Voc,Q_Voc_Freq );
        %% step 4 :TF-DF calculating
        %[TF,DF]=my_indexing(S_Voc,stem_token);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change to 1400
D_TF(:,1:470)=TF(:,1:470);
D_TF(:,471)=0;
D_TF(:,472:994)=TF(:,471:993);
D_TF(:,995)=0;
D_TF(:,996:1400)=TF(:,994:1398);
total_num_Doc=1400;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% query TF,DF
[Q_TF,Q_DF]=my_indexing(S_Voc,stem_Q_token);
%% step 5:claculating number of REl and number of non-REl Doc for Querys
for i=1:10
    [num_Rel(i),Num_NRel(i),Rel_list{i}]=Cal_Num_REL(i,total_num_Doc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%query weighting
Q_weights=Initialize_Q_Weight(Q_TF,DF,total_num_Doc, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% step 6:reweighting and roc
for i=1:num_Query
    [test_set,num_Rel,num_NRel,Rel_id]=divide(D_TF',fold,Rel_list{i});
   % for k=1:6
        for j=1:fold
            figure,
            weights=Initialize_Weight(test_set{j}', 2);
            %% befor learning
            [list_doc,dis_value,top_list]=my_simliarity3(Q_weights(i,:),weights,size(weights,1));
            [B_TP_rate{j},B_FP_rate{j},B_Area(j)]=my_TP_FP_rate1(top_list,num_Rel(j),num_NRel(j),Rel_id{j},'g');
            %% after learning
            Doc_weights=new_Optimum_weights(test_set{j}',Q_weights(i,:)',weights,num_Rel(j),num_NRel(j),Beta(2),Mu(3),size(weights,1));
            [list_doc,dis_value,top_list]=my_simliarity3(Q_weights(i,:),Doc_weights,size(weights,1));
            [A_TP_rate{j},A_FP_rate{j},A_Area(j)]=my_TP_FP_rate1(top_list,num_Rel(j),num_NRel(j),Rel_id{j},'b');
           end
        figure
         [B_TP_avg{i},B_Area_avg(i)]=Average_ROC(B_TP_rate,B_FP_rate,size(weights,1),'g');
         [A_TP_avg{i},A_Area_avg(i)]=Average_ROC(A_TP_rate,A_FP_rate,size(weights,1),'b');
        
         close all
   % end
         
end
