function DC_decode = huffmandeco_DC( DCH,n )
T1 = {'00' '010' '011' '100' '101' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110'}; 
T2 = {'00' '01' '10' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110' '1111111110' '11111111110'};
 if n==1
     for i=2:1:length(DCH)
    [x,y] = find(strcmp(T1, DCH(1:i)));%找到前缀码的位置
        if x~=0&y~=0
          break
        end
     end
    tmp=DCH(length(char(T1(y)))+1:length(DCH));
    if tmp(1)=='1'
        DC_decode=bin2dec(tmp);
    else
        for j=1:length(tmp)
            if tmp(j)=='0'
                tmp(j)='1';
            else 
                tmp(j)='0';
            end
         DC_decode=-bin2dec(tmp);
        end
    end
 end
  if n==2
     for i=2:1:length(DCH)
    [x,y] = find(strcmp(T2, DCH(1:i)));%找到前缀码的位置
        if x~=0&y~=0
          break;
        end
     end
   tmp=DCH(length(char(T2(y)))+1:length(DCH));
    if tmp(1)=='1'
        DC_decode=bin2dec(tmp);
    else
        for j=1:length(tmp)
            if tmp(j)=='0'
                tmp(j)='1';
            else 
                tmp(j)='0';
            end
         DC_decode=-bin2dec(tmp);
        end
    end
 end
     
end