function H=CurveComputation(p,LdMax,LdMin,x,LldMax,LldMin)

% tolerance for comparizon with 0
tol=0.00000001;

% display characteristics

%luminance 
black = LdMin;
white = LdMax;



% Compute the CDF
Pcum = cumsum(p);
disp=((Pcum-Pcum(1))./(Pcum(end)-Pcum(1)));
% caclulate the curve [0-1] using the CDF
disp=[0 disp];
dispcode=diff(disp);
y1=max(max(dispcode));
% normilize the curve to the actual PQ range
OrgDisp=LldMin+(LldMax-LldMin).*disp;

% calculate the size of each bin projection on the SDR range
dispPQ=OrgDisp;
dispcode=(diff(double(dispPQ))); 

% distance of each HDR bin
minimum=x(100)-x(99);
pqcode=diff(x);


%priorities
ORgprio=diff(OrgDisp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CEILING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% loopong vars
valid=1;

counter=0;
ceiledRange=0;
CeiledBins=zeros(numel(dispcode),1);

for i=1:numel(dispcode)
   % if you find an overload remove the redudant distance
   counter=counter+1;
   dispcode=(diff(double(dispPQ)));  
   if (monotonous(dispcode))
   find(dispcode<0)
   end
   compaire=double(pqcode)-double(dispcode);      
   if compaire(i)<-tol
       % check if the bin point i do not go lower than the point i-1
       if dispPQ(i+1)+compaire(i)>dispPQ(i)
          dispPQ(i+1:end)=dispPQ(i+1:end)+compaire(i);
          toRemove=compaire(i);
       else 
           toRemove=(dispPQ(i+1)-dispPQ(i));
           dispPQ(i+1:end)=dispPQ(i+1:end)-toRemove;
       end
       if (dispPQ(i+1)-dispPQ(i))-minimum>tol
           dispPQ(i+1)
       end
       % save the distance
       toRemove = abs(toRemove);
       % buffer with redutant distance from previous loops
       ceiledRange = toRemove+ceiledRange;      
       CeiledBins(counter)=1;
   end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REDISTRIBUTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Project 1 %%%%%
 
% to the smallest projection of bins that had even the slmaller slope but not 0 
dispcode=diff(dispPQ); 
[InitialSlopes,NumberOfBin]=sort(ORgprio,'ascend');
%order the projections regarding their given range from the cdf at the biggining
NumberOfBin(InitialSlopes==0)=[];
InitialSlopes(InitialSlopes==0)=[];

% calculte the maximum range that can given to each projection but not going over the threshold
MaxPerBin=minimum-InitialSlopes;



for j=1:numel(NumberOfBin)
    bin=NumberOfBin(j);
    point=bin+1;
       
    toAdd=MaxPerBin(j);
    
    if toAdd<ceiledRange
        dispPQ(point:end)=dispPQ(point:end)+toAdd;
        dispPQ(dispPQ>LldMax)=LldMax;
        ceiledRange=ceiledRange-toAdd;
    else 
        toAdd=ceiledRange;
        dispPQ(point:end)=dispPQ(point:end)+toAdd;
        dispPQ(dispPQ>LldMax)=LldMax;
        ceiledRange=ceiledRange-toAdd;
    end
    
    if ceiledRange<=0
        break;
    end
    
end
   

% RETURNT THE FINAL CURVE


%flickering % Project 2


H=dispPQ;
end

