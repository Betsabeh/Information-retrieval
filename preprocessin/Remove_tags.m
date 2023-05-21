function Remove_tags(filename)
cran=textread(filename,'%s','delimiter','\n');
fid=fopen('All_Documents.txt','w');
[n,m]=size(cran);
j=1;
i=1;
k=1;
counter=1;
fprintf(fid,'%s\n','-----------------------Document1-------------------');
while i<=n
       temp=char(cran(i,:));
% % % % %        if strcmp(temp,'.T')
% % % % %            i=i+1;
% % % % %            temp=char(cran(i,:));
% % % % %            while (strcmp(temp,'.A')==0)
% % % % %                    Doc(j,k)=cran(i,:);
% % % % %                    words=cell2mat(cran(i,:));
% % % % %                    fprintf(fid,'%s',words);
% % % % %                    clear words
% % % % %                    i=i+1;
% % % % %                    k=k+1; 
% % % % %                    temp=char(cran(i,:));
% % % % %            end
% % % % %        else
         if strcmp(temp,'.W')==1
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               a1=counter+1;
               count=1;
               name1='.I ';
               name2='';
               while (a1>0)
                    r(count)=mod(a1,10);
                    a1=floor(a1/10);
                    count=count+1;
                end
                for g=count-1:-1:1
                    v=r(g);
                    name2=strcat(name2, char(v+48));
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                i=i+1;
                temp=char(cran(i,:));
                C = strsplit(temp);
                while (strcmp(C(1),name1)==0)&& (strcmp(C(2), name2)==0)&&(i<n)
                   Doc(j,k)=cran(i,:);
                   words=cell2mat(cran(i,:));
                   fprintf(fid,'%s',words);
                   clear words
                   i=i+1;
                   k=k+1; 
                   temp=char(cran(i,:));
                   C = strsplit(temp);
                   if size(C,2)==1
                      C{2}='  ' ;
                   end
                end
                if k==1
                    counter=counter+1;
                    j
                else
                    j=j+1;
                    counter=counter+1;
                    k=1;
                    e=strcat('---------------------------------Document',name2);
                    fprintf(fid,'\n%s\n',e);
                end
         else
             i=i+1;
         end
% % % % %       end
end
save('remove_xml_Doc.mat','Doc')


