ZERO_5="00000";

Oplist=[0, 1, 1, 1,
        2, 2, 5, 9,
        10, 12, 13, 14,
        15, 16, 18];
for i in range(len(Oplist)):
       Oplist[i] = "{:06b}".format(Oplist[i]);

Keylist=['add','and','or','xor',
         'srl','sll','addi','andi',
         'ori','xori','load','store',
         'beq','bne','jump'];

Op2list=[1,1,2,4,2,3];
for i in range(len(Op2list)):
       Op2list[i] = "{:06b}".format(Op2list[i]);
