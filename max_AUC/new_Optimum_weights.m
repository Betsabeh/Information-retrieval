function Weights_Doc=new_Optimum_weights2_1(D_TF,Q_TF,Weights_Doc,P,N,Beta,Mu,Num_Retr)
%this function claculate the optimum weight with gradient descent
%D_TF:document term frequency
%Q_TF:query term frequency
%P: number of releveant Documents
%N:number of non-relevent Documents
%Beta:sigmoid parameter
%% use TF * W in order to set zero for the term with TF=0
%% initializing weights with normal TF
num_Doc=size(D_TF,2);
num_voc=size(D_TF,1);
D_TF=D_TF>0;
Weight_Q=Q_TF';
%% initlaize J
[J_val]=Cal_J1(Weights_Doc,Weight_Q,Beta,N,P,Num_Retr);
new_J=10;
diff=abs(J_val-new_J);
Iter=0;
%% repeat until no significant change in weights
while (diff>10^-20) &&(Iter<200)
    new_Weights_Doc=Weights_Doc;
    %% calculate distance of Doc ,Q and sort
    for j=1:num_Doc
        d(j)=norm(Weight_Q-Weights_Doc(j,:));
        
    end

    [val,index]=sort(d);
    for i=1:Num_Retr
        if i==1
             TP(1)=0;
             FP(1)=0;
             Ith=0;
         end
          [TP(i+1),FP(i+1),Ith]=Cal_TP1(Weights_Doc,Weight_Q,Beta,N,P,i,TP(i),Ith,val);
         if FP(i)==FP(i+1)
             continue;
         else
             for j=1:num_Doc
                   dj=val(j);
                   indexj=index(j);
                   di=val(Ith);
                   indexi=index(Ith);
                   if indexj==indexi
                       continue;
                   else
                     if dj==0
                       dj=10^-5;
                     end
                     r=di/dj;
                     % calculate S'
                     S1=Beta*exp(Beta*(1-r));
                     S2=(1+exp(Beta*(1-r)))^2;
                     S=S1/(S2+10^-5);
                     
                     % update Doc J
                     m=Weight_Q-Weights_Doc(indexj,:);
                     m=(m*di)/(dj^3);
                     temp1=(new_Weights_Doc(indexj,:)+Mu*S*(m)).*D_TF(:,indexj)';
                     [x,y]=find(temp1<0);
                     new_Weights_Doc(indexj,y)=(new_Weights_Doc(indexj,y)-(new_Weights_Doc(indexj,y)/2)).*D_TF(y,indexj)';
                     [x,y]=find(temp1>=0); 
                     new_Weights_Doc(indexj,y)=(new_Weights_Doc(indexj,y)+Mu*S*(m(y))).*D_TF(y,indexj)';
                     new_Weights_Doc(indexj,:)=new_Weights_Doc(indexj,:)/(N*P);
                     %%   update Doc Ith
                     m1=Weight_Q-Weights_Doc(indexi,:);
                     m1=m1/(di*dj);
                     temp=(new_Weights_Doc(indexi,:)-Mu*S*m1).*D_TF(:,indexi)';
                     [x,y]=find(temp<0);
                     new_Weights_Doc(indexi,y)=(new_Weights_Doc(indexi,y)-(new_Weights_Doc(indexi,y)/2)).*D_TF(y,indexi)';
                     [x,y]=find(temp>=0); 
                      new_Weights_Doc(indexi,y)=(new_Weights_Doc(indexi,y)-Mu*S*m1(y)).*D_TF(y,indexi)';
                      new_Weights_Doc(indexi,:)=new_Weights_Doc(indexi,:)/(N*P);
                      end
               end
       end
              
    end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Weights_Doc=new_Weights_Doc;
new_J=Cal_J1(Weights_Doc,Weight_Q,Beta,N,P,Num_Retr);
diff=abs(new_J-J_val);
J_val=new_J;
Iter=Iter+1
end
