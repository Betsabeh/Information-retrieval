function [num_token,Doc_token]=my_tokenization(Doc)
[n,m]=size(Doc);
num_token=0;
token= {};
r1=1;
for i=1:n
    num_token_Doc(i)=0;
    token= {};
       for j=1:m
       t=cell2mat(Doc(i,j));
       if isempty(t)==0
           string=t;
           while not(isempty(string))        
             [temp,string]=my_token2(string);
             [y,te]=check_word(temp);                 
             if y==1
                 token{end+1}=te;
                  num_token_Doc(i)=num_token_Doc(i)+1;
                 num_token=num_token+1;
             end
           end          
       end
   end
   tok={token};
   Doc_token(i)=tok;
   
end
