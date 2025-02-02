function[bool]=aresame(x1,x2,tol)
%ARESAME Test whether two N-D arrays are the same
%
%   ARESAME(X,Y) first checks if X and Y are the same size, and if so, 
%   checks if every element in X is equal to the corresponding
%   element in Y.  If so, ARESAME returns 1, otherwise it returns 0.
%
%   ARESAME considers two NAN values to be equal.  
%
%   ARESAME(X,Y,TOL) uses a numerical tolerance TOL on the maximum
%   absolute value of the difference between X and Y as a test of 
%   sameness.
%   _________________________________________________________________
%   This is part of JLAB --- type 'help jlab' for more information 
%   (C) 2003, 2004 J.M. Lilly --- type 'help jlab_license' for details

  
if strcmp(x1, '--t')
  local_test,return
end

bool=0;  
if length(size(x1))==length(size(x2))
  if all(size(x1)==size(x2))
    index1=find(~isnan(x1));
    index2=find(~isnan(x2));
    if isempty(index1) && isempty(index2)
      bool=1;  %True if both contain no data
    elseif length(index1)==length(index2)
      if allall(index1==index2)
         x1=x1(index1);
         x2=x2(index1);
         if nargin==3
	   bool=maxmax(abs(x1-x2))<tol;  %use tol if supplied
	 else 
           bool=allall(x1==x2);  %else use exact equality
         end
      end
    end
  end
end


function[]=local_test
x1=1:4;
x2=x1';
ans1=aresame(x1,x2);
ans2=0;
reporttest('ARESAME transpose case', ans1==ans2)

x1=1:4;
x2=[];
ans1=aresame(x1,x2);
ans2=0;
reporttest('ARESAME empty set case', ans1==ans2)

end
end
