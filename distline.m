function [simL,simR]=distline(line1,line2)

    simL=getCNdist(line1,line2,'L');
    simR=getCNdist(line1,line2,'R');
end

function [sidesim] = getCNdist(line1,line2,side)

sidesim=0;
maxp=40;
if side=='L'
    sidep1=line1.pleft;
    sidep2=line2.pleft;
else
     sidep1=line1.pright;
     sidep2=line2.pright;
end
if isempty(sidep1) || isempty(sidep2)
    return;
end
 [~,ind1,ind2]=intersect(sidep1(:,3),sidep2(:,3));
 n=length(ind1);
if n<3
    return;
elseif n>maxp
    n=maxp;
    ind1=ind1(1:maxp);
    ind2=ind2(1:maxp);
end


ps1=sidep1(ind1,1:2);
ps2=sidep2(ind2,1:2);

simed=zeros(n,1);
for i=1:n
    m=0;
    simi=zeros( (n-1)*(n-2)/2, 1 );
    for j=1:n
        if j==i
            continue;
        end
        for k=j+1:n
            
            if k==i
                continue;
            end
            CN1=charanums5(line1.point1(1), line1.point1(2), line1.point2(1),line1.point2(2), ps1(i,1), ps1(i,2),ps1(j,1),ps1(j,2), ps1(k,1),ps1(k,2));
            CN2=charanums5(line2.point1(1), line2.point1(2), line2.point2(1),line2.point2(2), ps2(i,1), ps2(i,2),ps2(j,1),ps2(j,2), ps2(k,1),ps2(k,2));
            m=m+1;  
            
            if isnan(CN1)||isnan(CN2)
                simi(m)=0;
            else
                simi(m)=exp(-abs(CN1-CN2));
            end
        end

    end
    simed(i)=median(simi(1:m));
end

sidesim=max(simed);
end
