function [objvalue]=calobjvalue(pop,popsize)
%Ŀ�꺯����һ�������ֵ
%% ����Ȩ��
w1=2;
w2=1;
w3=0.075;
w4=0.024;
w5=0.035;
w6=8.05;
%% ���ָ���Ҷ�任�ķ�ֵ
S=zeros(size(pop));
[m,n]=size(pop);
M=zeros(1,m);
num=0;
for i=1:popsize
   s=pop(i,:);
   S(i,:)=abs(fft(s));
end
%% ���������С�1���ĸ���
c=zeros(1,m);
for i=1:m                          
    for j=1:n
        if pop(i,j)==1
            num=num+1;
        end
    end
    c(i)=num;
    num=0;
end
%% �����С�0����1��ת���Ĵ���
r=zeros(1,m);
for i=1:m                          
    for j=2:n
        if pop(i,j)~=pop(i,j-1)
            num=num+1;
        end
    end
    r(i)=num;
    num=0;
end
%% SNR
for i=1:m
    f=zeros(n,n);
    for j=1:n
        if j==1
            f(j,:)=pop(i,:);
        else
            f(j,1:(n-j+1))=pop(i,j:n);
            f(j,(n-j+2):n)=pop(i,1:(j-1));
        end
    end
    T(i)=sqrt(trace(pinv(f'*f)));
end
SNR=zeros(1,m);
SNR=(c/n)./(T.*sqrt(0.2936+0.0845*(c/n)));
%% ��Ƶ�ɷ�
for i=1:popsize
   s=pop(i,:);
   h=zeros(1,n);
   H=zeros(1,n);
   for j=1:n
       h=abs(fft(s));
       H(j)=h(j)/(j+1);
   end
   M(i)=mean(H);
end
%% Ŀ�꺯��
objvalue=w1*min(S')-w2*var(S')+w3*SNR+w4*c-w5*r+w6*M;
objvalue=objvalue';        %תΪ������





