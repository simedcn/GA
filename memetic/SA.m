clear  
clc  
tic 
%���ɳ�ʼ�� 
popsize=50;
pop=initpop(popsize);
% %��1����ռ䣨��ʼ�⣩  
% sol_new1=pop;  
% sol_best1 = sol_new1;   
E_best = -inf;  


pc=0.85; %�������
pm=0.01; %�������
% rand(50,52); %��ʼ�������������  
t=90; %��ʼ�¶�  
tf=89.9; %�����¶�  
a = 0.95; %�¶��½�����  
  
while t>=tf%��7����������  
    for r=1:50 %�˻����  
          
        %��������Ŷ���3���½�Ĳ��� 
        [objvalue]=calobjvalue(pop,popsize)
        E_current=calfitvalue(objvalue);
        [newpop]=selection(pop,E_current); %����
        [newpop]=crossover(newpop,pc); %����
        [newpop]=mutation(newpop,pm); %����
        [objvalue1]=calobjvalue(newpop,popsize);
        R=rand(1,1);
        
%         sol_new2=sol_new2+rand*0.2;  
%         sol_new1=sol_new2+rand*0.2;  
%           
        %����Ƿ�����Լ��  
%         if sol_new1^2-sol_new2>=0 &&  sol_new1>=0 &&sol_new2>=0  
%         else  
%             sol_new2=rand*2;  
%             sol_new1=sol_new1;  
%             continue;  
%         end  
          
        %�˻����  
        E_new=calfitvalue(objvalue1);%��2����Ӧ��  
        if E_new>E_current%��5������׼��  
                E_current=E_new;
                pop=newpop;  
              
%                 
%                 if E_new>E_best  
%                     %����ȴ��������õĽⱣ������
%                     E_best=E_new;  
%                     sol_best1=newpop;
%                 end  
        else  
                if R<exp((E_new-E_current)/t)%��4�����ۺ�����  
  
                    pop=newpop; 
                    E_current=E_new;
                else  
                    pop=pop;
                end  
        end 
        [bestindividual,bestfit]=best(pop,E_current); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
        y(r)=bestfit; %��Ѹ�����Ӧ��
        bestpop(r,:)=bestindividual;
        plot(r,E_best,'*')  
        hold on  
    end  
    t=t*a;%��6������  
end  
 

  code1=bestindividual;
% code2=[1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 0 1 0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0 1];
  fcode1=abs(fft(code1,512));%/max(abs(fft(code1)));
  plot(fcode1);
  xlabel('f(Hz)');
  ylabel('H(jw)');
  axis([0 512 0 8]);
  print(gcf,'-dtiff','test3.tiff');
  
  h=var(fcode1);
  H=min(fcode1);
% fcode2=abs(fft(code2,512));%/max(abs(fft(code2)));
% plot(fcode1,'-');hold on;
% plot(fcode2,':');hold off;
% disp('���Ž�Ϊ��')  
% disp(pop)  ;
% 
% disp('Ŀ����ʽ����Сֵ���ڣ�')  
% disp(E_best)  
toc;

% c=imread('test1.tiff');
% figure,imshow(c);