% This example is used to explain the GA.
%  max f(x1, x2) = 21.5 + x1��sin(4pi*x1) + x2��sin(20pi*x2)
%  s.t.    -3.0 <=  x1 <= 12.1
%           4.1 <=  x2 <= 5.8
clc; clear all;
M = 40;N = 33;
generation = 1000;
it = 1;
pm = 0.05;%�������
pc = 0.8;%�������
maxdata = -200;
pop = round(rand(M,N));%��ʼ�����󣬲�����ʼ��Ⱥ                      
x1 = decode_x1(pop(:,1:18));  %��x1 x2���н���
x2 = decode_x2(pop(:,19:end));
fitness = 21.5 + x1.*sin(4*pi*x1) +x2.*sin(20*pi*x2);%��Ӧ�Ⱥ���
while it < generation
    [B] = seclection(fitness,pop);%���̶�ѡ��
    [newpop] = crossover(pc,B);%����
    [B] = mutation(pm,newpop);%�������
    pop = B;
    x1 = decode_x1(pop(:,1:18));
    x2 = decode_x2(pop(:,19:end));
    fitness = 21.5 + x1.*sin(4*pi*x1) +x2.*sin(20*pi*x2);%������Ӧ��
    [fit_best,index] = max(fitness);%�����е�����Ŀ��ֵ
    if fit_best >= maxdata
        maxdata = fit_best;
        verter = pop(index,:);
        x_1 = decode_x1(verter(1:18));
        x_2 = decode_x2(verter(19:end));
    end
    num(it) = maxdata;
    it = it + 1;
end
disp(sprintf('max_f=��%.6f',num(it-1)));%������Ž�
disp(sprintf('x_1=��%.5f  x_2=��%.5f',x_1,x_2));%���Ž��Ӧ��x1 x2��ֵ
figure(1)   
plot(num,'k');%����ͼ��