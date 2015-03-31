function [ basefreq ] = W_AMDF1( X, fs )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
N=fix(fs*0.015);%帧长
L=length(X);%原信号共有多少点
frameN=fix(L/N); %原信号共有多少帧

%%%%%%%%%%%%%%%%%%%%
%%短时能量
%%短时过零率
%%短时平均幅度
%%%%%%%%%%%%%%%%%%%%
En(1:frameN)=0;%短时能量
Mn(1:frameN)=0;%短时平均幅度
crosszero(1:frameN)=0;%过零率
basefreq(1:frameN)=0;%基音频率

for j=1:frameN
    Xn=X((j-1)*N+1:j*N);
    En(j)=sum(Xn.*Xn);
    for i=1:N
        Mn(j)=Mn(j)+abs(Xn(i));
    end
    for i=1:N
        if(Xn(i)>=0)
            sgn(i)=1;
        else
            sgn(i)=-1;
        end
    end
    for i=2:N
        crosszero(j)=crosszero(j)+abs(sgn(i)-sgn(i-1));
    end
    crosszero(j)=0.5*crosszero(j);
end


%%%%%%%%%%%%%%%%%%%%
%%边缘检测
%%%%%%%%%%%%%%%%%%%%
key1=1;
key2=1;
flag1(1:100)=0;
flag2(1:100)=0;
Flag(1:100)=0;

%第一级判决——能量
for i=1:frameN-1
    if(En(i)<1&&En(i+1)>1)
        flag1(key1)=i;
        key1=key1+1;
    end
    if(En(i)>1&&En(i+1)<1)
        flag2(key2)=i;
        key2=key2+1;
    end
end
for key=1:key1-1
    num1=flag1(key);
    num2=flag2(key);
    while(En(num1)>0.11)
        num1=num1-1;
    end
    flag1(key)=num1;
    while(En(num2)>0.11)
        num2=num2+1;
    end
    flag2(key)=num2;
end
flag1new=flag1;


%取出无重复点
cnt=2;
fedge(1:100)=0;
mini=flag1(1);
fedge(1)=flag1(1);
for k=2:key1-1
    if(flag1(k)>mini)
        fedge(cnt)=flag1(k);
        mini=flag1(k);
        cnt=cnt+1;
    end
end
cnt=2;
bedge(1:100)=0;
mini=flag2(1);
bedge(1)=flag2(1);
for k=2:key2-1
    if(flag2(k)>mini)
        bedge(cnt)=flag2(k);
        mini=flag2(k);
        cnt=cnt+1;
    end
end

front=fedge;
back=bedge;

%第二级判决——过零率
for k=1:100
    fedge(k)=int32(fedge(k));
    bedge(k)=int32(bedge(k));
end
k=1;
while(fedge(k))
    while(crosszero(fedge(k))>12)
        fedge(k)=fedge(k)-1;
    end
    while(crosszero(bedge(k))>12)
        bedge(k)=bedge(k)+1;
    end
    k=k+1;
end

%%%%%%%%%%%%%%%%%%%%
%清浊音判决
%%%%%%%%%%%%%%%%%%%%

for key=1:key1-1
    num=flag1new(key);
    while(crosszero(num)<11)
        num=num+1;
    end
    while(~(crosszero(num-1)>crosszero(num)&&crosszero(num)<crosszero(num+1)))
        if num + 1 < length(crosszero)
            num=num+1;
        else
            break;
        end
    end
    Flag(key)=num;
end

cnt=2;
Flag1(1:100)=0;
mini=Flag(1);
Flag1(1)=Flag(1);
for k=2:key1-1
    if(Flag(k)>mini)
        Flag1(cnt)=Flag(k);
        mini=Flag1(k);
        cnt=cnt+1;
    end
end


%%%%%%%%%%%%%%%%%%%%
%%基音频率计算
%%%%%%%%%%%%%%%%%%%%
sto(1:100)=0;
Fn = 0;
Xnk(1:N)=0;
for i=1:cnt-1
    for j=1:(back(i)-Flag1(i))
        sto(1:100)=0;
        Xnk(1: N)=X(Flag1(i)*N+1+j*N:Flag1(i)*N+ N+j*N);
%         Xnk = Xnk .* hamming(N)';
        count=3;
        %求信号的AMDF
        Fn(1:N)=0;
        for k=1:N/2
            Fn(k)=0;
            for m=1:N/2
                Fn(k)=Fn(k)+abs(Xnk(m)-Xnk(m+k-1));
            end
%             Fn(k) = Fn(k) / (N - k - 1);
        end
%         Fn = Fn.^2;
        AMDF_MAX=max(Fn);
        for k=2:N-1
            if(Fn(k)<Fn(k-1) && Fn(k)<Fn(k+1) &&Fn(k)<0.5*AMDF_MAX)  % &&Fn(k)<0.5*AMDF_MAX
                sto(count)=k;
                count=count+1;
            end
        end
        basefreq(Flag1(i)+j)=fs/abs(sto(count-1)-sto(count-2));
    end
end

%%%%%%%%%%%%%%%%%%%%
%%基音周期估值后处理
%%%%%%%%%%%%%%%%%%%%

for i=2:frameN
    % 除去判决误差造成的非浊音信号段的点
    if (basefreq(i)>800)
        basefreq(i)=0;
    end
    % 修正倍频点
    if (basefreq(i) > 600)
        basefreq(i) = basefreq(i) / 2;
    end
end


basefreq = basefreq(basefreq ~= 0);

end

