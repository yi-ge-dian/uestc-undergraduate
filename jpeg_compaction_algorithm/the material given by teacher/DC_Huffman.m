function DCH = DC_Huffman(Z,last_Z,n)
%ÁÁ¶ÈÂë×Ö 
T1 = {'00' '010' '011' '100' '101' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110'}; 
%É«¶ÈÂë×Ö 
T2 = {'00' '01' '10' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110' '1111111110' '11111111110'}; 
DIFF = Z-last_Z; 
if DIFF == 0  
    SSSS = 0; 
elseif (abs(DIFF) == 1)  
    SSSS = 1; 
elseif (abs(DIFF) >= 2 && abs(DIFF)<=3)  
    SSSS = 2; 
elseif (abs(DIFF) >= 4 && abs(DIFF)<=7)  
    SSSS = 3; 
elseif (abs(DIFF) >= 8 && abs(DIFF)<=15)  
    SSSS = 4; 
elseif (abs(DIFF) >= 16 && abs(DIFF)<=31)  
    SSSS = 5; 
elseif (abs(DIFF) >= 32 && abs(DIFF)<=63)  
    SSSS = 6; 
elseif (abs(DIFF) >= 64 && abs(DIFF)<=127)  
    SSSS = 7; 
elseif (abs(DIFF) >= 128 && abs(DIFF)<=255)  
    SSSS = 8; 
elseif (abs(DIFF) >= 256 && abs(DIFF)<=511)  
    SSSS = 9; 
elseif (abs(DIFF) >= 512 && abs(DIFF)<=1023)  
    SSSS = 10; 
elseif (abs(DIFF) >= 1024 && abs(DIFF)<=2047)  
    SSSS = 11; 
end 
%Ç°×ºÂë 
if n == 1 
    S1 = char(T1(SSSS+1)); 
else 
    S1 = char(T2(SSSS+1)); 
end 
%ºó×ºÂë 
if DIFF >= 0  
    S2 = dec2bin(DIFF); 
else 
    S2 = dec2bin(-DIFF); 
    for i = 1:length(S2) 
        if S2(i) == '0'
            S2(i) = '1'; 
        else 
            S2(i) = '0'; 
        end 
    end 
end 
DCH = [S1 S2];