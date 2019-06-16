close all;clear all;
%�Ŵ��㷨������
%function My_GA
% global Cmin;
% Cmin=-10^6;
tic;
popsize=50; %Ⱥ���С
Gene=50;   %��������
%chromlength=20; %�ַ������ȣ����峤�ȣ�  �ĵ�initpop���������ã��޸ĺ�ǵñ���
pc=0.85; %�������
pm=0.01; %�������
% Xmax=10;
% Xmin=0;
pop=initpop(popsize); %���������ʼȺ��

x1 = zeros(1,30);
x2 = zeros(1,30);
codelist = zeros(27,32)


for i=1:Gene 
     [objvalue]=calobjvalue(pop,popsize); %����Ŀ�꺯��
     %[objvalue]=calobjvaluetradition(pop,popsize); %��ͳ׼��
    fitvalue=calfitvalue(objvalue); %����Ⱥ����ÿ���������Ӧ��
    [newpop]=selection(pop,fitvalue); %����
    [newpop]=crossover(newpop,pc); %����
    [newpop]=mutation(newpop,pm); %����
    [bestindividual,bestfit]=best(pop,fitvalue); %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
    y(i)=bestfit; %��Ѹ�����Ӧ��
    bestpop(i,:)=bestindividual;
    pop=newpop;
%     if y(i)>6000 && y(i)>y(i-1)
%         break;
%     end
    c = 1;
    code1 = bestindividual;
    for z = 3:1:16
            if rem(z,2) ==0
                M = round((16-2)/z);
                for i = 0 :1 :M-1
                    if rem(z,(16-1)) ==0
                        x1(:,c) = round(z/2*(i+1))
                        x2(:,c) = round(16-1-z/2*i)
                        c = c+1;
                    else
                        x1(:,c) = round(z/2*(i+1))
                        x2(:,c) = round(16-z/2*i)
                        c = c+1;
                    end
                end
            else
                M = round((16-1)/z)
                for i = 0:1:M-1
                    if rem(i,2) ==0
                        x1(:,c) = round(16-1-z/2*i)
                        x2(:,c) = round(((i+1)*z-1)/2)
                        c = c+1;
                    else
                        x1(:,c) = round((i+1)*z/2)
                        x2(:,c) = round((16-1-(z*i-1)/2))
                        c = c+1;
                    end
                end
            end
    end
    anothercode1 = zeros(size(code1))
    anothercode2 = zeros(size(code1))
    for x = 1:1:27
        if x1(:,x)==16
            anothercode1 = code1;
        else
            anothercode1(:,1:16-(x1(:,x))) = code1(:,(x1(:,x)+1):16);
            anothercode1(:,17-(x1(:,x)):16) = code1(:,1:x1(:,x));
        end
        if x2(:,x)==16
            anothercode2 = code1;
        else
            anothercode2(:,1:16-(x2(:,x))) = code1(:,(x2(:,x)+1):16);
            anothercode2(:,17-(x2(:,x)):16) = code1(:,1:x2(:,x));
        end

        for j = 1:1:32
            if rem(j,2) == 0
                codelist(x,j) = anothercode1(1,j/2)
            else
                codelist(x,j) = anothercode2(1,round(j/2))
            end
        end

    end
    x = 0
    for y = 1:1:27
        fcodelist = abs(fft(codelist(y,:),256))
        H=min(fcodelist);
        if H>0
            x = x+1;
        end
    end
    if x>3
        bestcode(i,:) = code1
    end
end
toc;
  code1=bestindividual;
%   code1=[1 0 1 0 0 0 0 0 1 1 1 1 1 0 0 1 1 0 1 1 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 0 1 0 0 0 0 0 1 1 0 0 1 0 1 1 1];
%  
%   ran=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1];%32

%  code1 = [1 1 1 0 1 1 0 1 1 0 1 1 1 0 0 0 1 1 0 1 1 1 1 0 1 0 0 0 1 0 1 1]
%  code1 = [1 0 1 1 1 0 0 0]
%  code1 = [1 0 0 0 1 0 1 1]
%  code1 = [1 1 1 0 0 0 1 0]
%  code1 = [1 1 0 1 0 0 0 1]
% code1 = [1 0 0 0 1 0 1 1 1 1 0 1 0 0 0 1]
% code1 = [1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0]
% code1 = [1 1 0 1 0 0 0 1 1 0 0 0 1 0 1 1]
% code1 = [1 1 1 1 0 0 1 0 1 0 1 1 1 0 0 0]
% code1 = [1 0 1 1 1 0 0 0 0 0 0 0 1 1 0 1]
% code1 = [1 0 0 0 1 0 1 1 0 0 1 0 1 1 1 0] 
% code1 = [1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1]
% code1 = [1 1 0 1 0 0 0 1 0 1 1 1 0 1 0 0]
code1 = [1 1 1 1 0 0 1 0 1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1]
code2 = [1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 1 0 0 0 0 0 0 0 1 1 0 1]
code3 = [1 0 1 1 1 0 0 0 0 0 0 0 1 1 0 1 1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0]
% code1 = [1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1 1 1 1 1 0 0 1 0 1 0 1 1 1 0 0 0] 
% code1 = [1 0 1 1 1 0 0 0 1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1 1 1 1 1 0 0 1 0]
% code1 = [1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1 0 0 0 0 1 1 0 1 1 0 1 1 1 0 0 0]
% code1 = [1 0 1 1 1 0 0 0 0 0 0 0 1 1 0 1 0 1 0 0 0 1 1 1 0 0 0 0 1 1 0 1]
% code1 = [1 1 1 1 0 0 1 0 0 1 0 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 0 1 1 1]
 
  fcode1=abs(fft(code1,256));%/max(abs(fft(code1)));
  plot(fcode1);
  xlabel('f(Hz)');
  ylabel('H(jw)');
  axis([0 256 0 12]);
  print(gcf,'-dtiff','test4.tiff');
%   set(gca,'xtick',[0:100:600]);
%   set(gca,'ytick',[0:1:10]);
%   axis([0 600 0 10]);
%   figure;plot(fcode1);
   h=var(fcode1);
   H=min(fcode1);
% fcode2=abs(fft(code2,512));%/max(abs(fft(code2)));
% plot(fcode1,'-');hold on;
% plot(fcode2,':');hold off;