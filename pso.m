clc,clear all, close all
as=-10;us=10;ssize=5;d=100;w=0.8;c1=2;c2=2;
suru=unifrnd(as,us,[ssize d]);
obj=zeros(ssize,1);
for i=1:ssize
    obj(i)=sum(suru(i,:).^2);
end

velocity=zeros(ssize,d);

en_iyi_pozisyon=suru;
en_iyi_deger=obj;
surunun_en_iyi_degeri=min(obj);
idx=find(surunun_en_iyi_degeri==obj);
surunun_en_iyi_pozisyonu=suru(idx,:);
iteration=1;

while iteration<=50
    
    for i=1:ssize
        velocity(i,:)=w*velocity(i,:)+c1*unifrnd(0,1)*(en_iyi_pozisyon(i,:)-suru(i,:))+c2*unifrnd(0,1)*(surunun_en_iyi_pozisyonu-suru(i,:));
    end
    
    vmax=(us-as)/2;
    
    for i=1:ssize
        for j=1:d
            if velocity(i,j)>vmax
                velocity(i,j)=vmax;
            elseif velocity(i,j)<-vmax
                velocity(i,j)=-vmax;
            end
        end
    end
    
    suru=suru+velocity;
    
   for i=1:ssize
        for j=1:d
            if suru(i,j)>us
                suru(i,j)=us;
            elseif suru(i,j)<as
                suru(i,j)=as;
            end
        end
   end
   
    for i=1:ssize
    obj(i)=sum(suru(i,:).^2);
    end
    % En �yi De�erleri Tutma Ve G�ncelleme
    for i=1:ssize
        if obj(i)<en_iyi_deger(i)
            en_iyi_deger(i)=obj(i);
            en_iyi_pozisyon(i,:)=suru(i,:);
        end
    end
    % S�r�lerin Gelmi� En iyi de�erleri ve o de�erin pozisyonlar�
    if min(obj)<surunun_en_iyi_degeri
        surunun_en_iyi_degeri=min(obj);
        idx=find(surunun_en_iyi_degeri==obj);
        surunun_en_iyi_pozisyonu=suru(idx,:);
    end
    iteration=iteration+1;
end
