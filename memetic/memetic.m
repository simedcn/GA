clear all;
close all;
tic;
%%  ��������
popsize = 50;   %��Ⱥ��С
pop = initpop(popsize); %��ʼ��Ⱥ
pc = 0.85;   %����
pm = 0.01;    %����
t=100;    % ��ʼ�¶�
tf = 25;    % �ȶ��¶�
a = 0.95;    % �¶��½�����

%% �Ŵ��㷨
for i=1:50
    [objvalue]=calobjvalue(pop,popsize);%����Ŀ�꺯��
    E_current=calfitvalue(objvalue);%����Ⱥ����ÿ���������Ӧ��
    [newpop]=selection(pop,E_current); %����
    [newpop]=crossover(newpop,pc); %����
    [newpop]=mutation(newpop,pm); %����
    [objvalue1]=calobjvalue(newpop,popsize);
    E_new=calfitvalue(objvalue1);

   %%      %��ʼ�˻�ģ��
    while t>=tf%��7���������� 
    %%  ��������Ŷ�
        k=round(rand(1,1)*popsize);
        if k==0
            k=k+1;
        end
        r=round(rand(1,1)*32);  %52��ʾ������Ŀ���ı����ֳ���ʱҪ�����޸�
       if r==0
            r=r+1;
        end
        R=rand(1,1);      
        copypop=newpop;
        if newpop(k,r)==0;
            copypop(k,r)=1;
        else
            copypop(k,r)=0;
        end
        %%  �Ƚ��Ŷ��������Ӧ��H
       [objvalue2]=calobjvalue(copypop,popsize);
        E_rao=calfitvalue(objvalue2);
        H=E_rao(k,:)-E_new(k,:)
        if H<0&&R>exp((H)/t)
            newpop=newpop;
        else
            newpop=copypop;
            E_new(k,:)=E_rao(k,:);
            
        end  
        t=t*a;%��6������  
    end
    %% ������Ⱥ����ѡ�����ŵĸ������һ���µ���Ⱥ
        pop=newpop;
        [bestindividual,bestfit]=best(pop,E_new); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
        y(i)=bestfit; %��Ѹ�����Ӧ��
        bestpop(i,:)=bestindividual;
%          code1=bestindividual;
%          fcode1=abs(fft(code1,512))
%          w=var(fcode1);
%          W=min(fcode1);
        if bestfit>35    %���õĽ�������
            break;
        end
end
%         
%         plot(i,E_best,'*')  
%         hold on 
%% �趨������50�ν�������Ѱ�ҳ�50����������Ÿ�����Ӧ��
   if i==50
   [objvalue3]=calobjvalue(bestpop,popsize);%����Ŀ�꺯��
    E_best=calfitvalue(objvalue3);%����Ⱥ����ÿ���������Ӧ��   
    [bestindividual,bestfit]=best(bestpop,E_best);
    code1=bestindividual;
   else
       code1=bestindividual;
   end
   
%   code1=[1 1 0 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 1 0 1 1 0 0 0 0 0	0 0 1 0	1 1	1 0	1 0	0 0	0 0	1 0	1 1	0 0	0 0	0 0	1]
  fcode1=abs(fft(code1,512));%/max(abs(fft(code1)));
  plot(fcode1);
  xlabel('f(Hz)');
  ylabel('������ֵ');
%   axis([0 17 0 2]);
  print(gcf,'-dtiff','test4.tiff');
  w=var(fcode1);
  W=min(fcode1);

toc;



%[1,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,1,1,1,1,0,1]
%
