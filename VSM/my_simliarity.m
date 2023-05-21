function [list_doc,sim_value,top_list,top_sim]=my_simliarity(Qweight,Doc_weights,top)
%this function calculate cosine similarty of documents and a query
% inputs:
%Qweight=weight vector of the query
%Doc_weights=weight vector of Documents
%% variables
num_doc=size(Doc_weights,1);
num_doc=num_doc+2; %%2 empty documents
new_Doc_weights(1:470,:)=Doc_weights(1:470,:);
new_Doc_weights(471,:)=0;
new_Doc_weights(472:994,:)=Doc_weights(471:993,:);
new_Doc_weights(995,:)=0;
new_Doc_weights(996:1400,:)=Doc_weights(994:1398,:);
  
for i=1:num_doc
    m=Qweight.*new_Doc_weights(i,:);
    d1=norm(Qweight);
    if d1==0
        d1=10^-6;
    end
    d2=norm(new_Doc_weights(i,:));
    if d2==0
        d2=10^-6;
    end
    if (sum(m)==0) && (d1*d2==0)
        sim(i)=0;
    end
        
    sim(i)=sum(m)/(d1*d2);
end
[sim_value,list_doc]=sort(sim,'descend');
avg_sim=mean(sim_value)
for i=1:top
    top_list(i)=list_doc(i);
    top_sim(i)=sim_value(i);
end
    
