function [K,Beta]=Heap_Law(token)
%% find k , Beta for heap law consider 2 random subset 
num_doc=size(token,2);
low=int32(0.01*num_doc);
high=int32(0.3*num_doc);
num_S1=randi([low high],1);
num_S2=randi([low high],1);
%% select random doc for first set
list(1)=0;
l=1;
n1=0;
for i=1:num_S1
    item=randi([1 num_doc],1);
    while ~isempty(find(list==item,1))
        item=randi([1 num_doc],1);
    end
    l=l+1;
    list(l)=item;
    s1{l-1}=token{item};
    n1=n1+size(token{item},2);
end

%% select random doc for second set
clear list
list(1)=0;
l=1;
n2=0;
for i=1:num_S2
    item=randi([1 num_doc],1);
    while ~isempty(find(list==item,1))
        item=randi([1 num_doc],1);
    end
    l=l+1;
    list(l)=item;
    s2{l-1}=token{item};
    n2=n2+size(token{item},2);
end
%% determine vocabulary for the sets
[Voc1,Voc_Freq1]=my_vocab(s1);
v1= size(Voc1,2);

[Voc2,Voc_Freq2]=my_vocab(s2);
v2=size(Voc2,2);

%% solve for finding k,Beta
syms k b
[S1,S2]=solve(k*(n1^b)==v1 ,k*(n2^b)==v2)
if S1<S2
K=S2;
Beta=S1;
else
 K=S1;
Beta=S2;
end