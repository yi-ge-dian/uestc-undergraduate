begin
  intger m;
  integer function F(n);
    begin
      integer n;
      if n<=0 then F:=1
      else F:=n*F(n-1)
    end;
  readm);
  integer m;
  k:=F(m);
  write(k)
end