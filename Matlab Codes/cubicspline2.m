function [G] = cubicspline2(M,S)

[nm]=length(M);
% Generate matrix G, which contains all spline functions, depending on dtm_spline
G=zeros(nm,(length(S)+1));


[~,ind]=histc(M,S);
Q=[0 S S(end)];
for l=1:(length(S)+1)
    %G(ind<l-2,l)=0;
    G(ind<l-1,l)=0;
    G(ind==l-1,l) = ((M(ind==l-1)-Q(l)).^3)...
                    /(6*(Q(l+1)-Q(l)));
    if l<length(S)+1
        if l<length(S)
            G(ind==l,l) = ((Q(l+1)- Q(l)).^2)/6 ...
                       + ((Q(l+1)-Q(l)).*(M(ind==l) - Q(l+1)))./2 ...
                       + ((M(ind==l)-Q(l+1)).^2)./2 ...
                       - ((M(ind==l)-Q(l+1)).^3) ./(6*(Q(l+2)-Q(l+1)));
            G(ind>=l+1,l) = (Q(l+2)-Q(l)).* ((2*Q(l+2) - Q(l+1) - Q(l))/6 ...
                                            + (M(ind>=l+1)-Q(l+2))/2);
        elseif l==length(S)
            G(ind==l,l) = ((Q(l+1)- Q(l)).^2)/6 ...
                       + ((Q(l+1)-Q(l)).*(M(ind==l) - Q(l+1)))./2 ...
                       + ((M(ind==l)-Q(l+1)).^2)./2;
        end            
    elseif l==length(S)+1
        G(:,l)=M;
    end
end

% % l=1
% l=1;
% c1=zeros(size(dtm_spline));
% 
% c2=zeros(size(dtm_spline));
% 
% c3=dtm_spline;
% c3(c3<0 | c3>=S(l+1))=0;
% c3=((c3.^2)./2)-((c3.^3)./(6*S(l+1)));
% 
% c4=dtm_spline;
% c4(c4<S(l+1))=NaN;
% c4=S(l+1).*((2*S(l+1)./6)+(c4./2));
% c4(isnan(c4)==1)=0;
% 
% G1=c1+c2+c3+c4;
% G=[G G1];
% G(:,1)=[];
% 
% % l=2:N-2
% for l=2:n-2
%     c1=dtm_spline;
%     c1(c1>=S(l-1))=0;
%     c1(c1<S(l-1))=0;
%     
%     c2=dtm_spline;
%     c2(c2<S(l-1) | c2>=S(l))=NaN;
%     c2=((c2-S(l)).^3)/(6*(S(l)-S(l-1)));
%     c2(isnan(c2)==1)=0;
%     
%     c3=dtm_spline;
%     c3(c3<S(l) | c3>=S(l+1))=NaN;
%     c3=(S(l)-S(l-1)^2/6)+(((S(l)-S(l-1)).*(c3-S(l)))./2)+(((c3-S(l)).^2)./2)-(((c3-S(l)).^3)./(6*(S(l+1)-S(l))));
%     c3(isnan(c3)==1)=0;
%     
%     c4=dtm_spline;
%     c4(c4<S(l+1))=NaN;
%     c4=(S(l+1)-S(l)).*(((2*S(l+1)-S(l)-S(l-1))./6)+((c4-S(l+1))./2));
%     c4(isnan(c4)==1)=0;
%     
%     G_j=c1+c2+c3+c4;
%     G=[G G_j];
% end
% 
% %l=n
% G=[G dtm_spline];



end