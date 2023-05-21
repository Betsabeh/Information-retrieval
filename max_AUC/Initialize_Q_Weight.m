function Q_weights=Initialize_Q_Weight(TF,DF,total_num_doc, Option)
%% this function initialize weights for weighting in different approch
%% option values:
%% 1=just TF
%% 2=
%for query weight of term i=(0.5+0.5*(TF(i,Q)/max(TF(:,Q))))* log(N/n)
% N is the total number of Documents
% n is the number of document a term is assigned


num_Doc=size(TF,2);
num_Voc=size(TF,1);

switch Option
    case 1
        Q_weights=TF';
    case 2
       num_voc=size(TF,1);
       num_q=size(TF,2);
       query=TF'; 
       for i=1:num_q
           max_Freq=max(query(i,:));
           for j=1:num_voc
               t=0.5+0.5*(query(i,j)/max_Freq);
               Q_weights(i,j)=t*log10(total_num_doc/DF(j));
           end
       end
end
