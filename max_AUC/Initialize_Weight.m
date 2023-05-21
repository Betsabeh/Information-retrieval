function weights=Initialize_Weight(TF, Option)
%% this function initialize weights for weighting in different approch
%% option values:
%% 1=just normlized TF
%% 2=TF_IDF 
%% 3=TF * random weight
%% 4= i=(TF(i,Doc_J)*logN/n)/sqrt(sum(tfi(log(N/ni))^2)

num_Doc=size(TF,2);
num_Voc=size(TF,1);

switch Option
    case 1
        for i=1:num_Doc
            if sum(TF(:,i))==0
                weights(i,:)=0;
            else
                weights(i,:)=TF(:,i)'/sum(TF(:,i));
            end
        end
    case 2
        for i=1:num_Voc
            DF(i)=size(find(TF(i,:)~=0),2);
        end
        for i=1:num_Doc
             max_Freq=max(TF(:,i));
             if max_Freq==0
                 weights(i,:)=0;
                 continue;
             end
            for j=1:num_Voc
                 if DF(j)==0;
                     DF(j)=10^-6;
                 end
                weights(i,j)=(TF(j,i)/max_Freq)*log10(num_Doc/DF(j));
            end
        end
    case 3
        for i=1:num_Doc
            for j=1:num_Voc
                if TF(j,i)==0
                    weights(i,j)=0;
                else
                    weights(i,j)=TF(:,i)*rand(1,1);
                end
            end
            weights(i,:)=weights(i,:)/sum(weights(i,:));
        end
    case 4
         for i=1:num_Voc
            DF(i)=size(find(TF(i,:)~=0),2);
            if DF(i)==0
                 DF(i)=10^-6;
             end
         end
          for i=1:num_Doc
               t1=TF(:,i)'.*log10(num_Doc./DF);
               t2=sqrt(sum(t1.^2));
               if t2==0
                  weights(i,:)=0;
               else
                  weights(i,:)=t1./t2;
              end
       end
end
