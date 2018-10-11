function valid=monotonous(code)
test=find(code<0);
if (isempty(test))
    valid=0;
else
    valid=1;
end