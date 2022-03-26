import os
from re import*
from mydic import*


#将括号和逗号处理，返回独立的字符列表
def getins(a):
    a=sub(',|\(', ' ',a);
    a=sub(';|\)','',a);
    a=a.split(' ');
    if len(a)==2:
        a[1]=int(a[1]);
        return a;
    for i in range(1,len(a)):
        a[i]=int(a[i].replace('r',''));
    return a;

def getnum(a):
    #得到在关键字列表中的位置
    num=-1;
    for i in range(len(Keylist)):
        if a[0]==Keylist[i]:
            num=i;
            break;
    if num==-1:
        return num;
    Op = Oplist[num];#Op码
    #第一种类型
    if num<6:
        Op2=Op2list[num];#func码
        rd = "{:05b}".format(a[1]);  # rd是第二个字段
        if num<4:#add,and,or,xor
            rs = "{:05b}".format(a[2]);
            rt = "{:05b}".format(a[3]);  # rt
            ans = Op + Op2 + ZERO_5 + rd + rs + rt;
        else:
            shift = "{:05b}".format(a[3]);  # shift
            rt = "{:05b}".format(a[2]);  # rt是第三个字段
            ans = Op + Op2 + shift + rd + ZERO_5 + rt;
    elif num<10:
        imm="{:016b}".format(a[3]);  # imm
        rs="{:05b}".format(a[2]);  # rs
        rt="{:05b}".format(a[1]);  #rt
        ans=Op+imm+rs+rt;
    elif num < 12:
        offset="{:016b}".format(a[2]);#offset
        rt="{:05b}".format(a[1]);#rt
        rs="{:05b}".format(a[3]);#rs
        ans=Op+offset+rs+rt;
    elif num<14:
        label="{:016b}".format(a[3]);#label
        rs="{:05b}".format(a[1]);#rs
        rt="{:05b}".format(a[2]);#rt
        ans=Op+label+rs+rt;
    else:
        address="{:026b}".format(a[1]);#address
        ans=Op+address;
    ans = "{:08x}".format(int(hex(int(ans, 2)), 16));
    return ans;


while 1:
    print('Please input your instruction');
    #此处为了方便，每次只读一条并解析
    a=input();
    if a=='bye':
        print('bye');
        break;
    elif a=='clear':
        os.system("cls");
        continue;
    a=getins(a);
    ans=getnum(a);
    if ans==-1:
        print(a[0]+" not found!\nPlease input right instruction");
        continue;
    print('this is the result:');
    print(ans);
    print('\n');