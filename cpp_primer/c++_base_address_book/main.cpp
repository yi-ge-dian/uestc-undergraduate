#include<iostream>
using namespace std;
#include<string>
#include<stdlib.h>
#define MAX 1000
//设计联系人结构体
typedef struct Person {
    string m_Name;  //姓名
    int m_Sex;      //性别 1男 2女
    int m_Age; 		//年龄
    string m_Phone;	//电话
    string m_Addr; 	//住址
}Person;
//设计通讯录结构体
struct Addressbooks
{
    //通讯录中保存的联系人数组
    struct Person personArray[MAX];
    //通讯录中当前记录联系人个数
    int m_size;
};
//1.添加联系人
void addPerson(Addressbooks* abs)
{
    //判断通讯录是否已满，满了不再添加
    if (abs->m_size>=MAX)
    {
        cout << "通讯录已满，无法添加！" << endl;
    }
    else
    {
        //添加联系人
        //姓名
        string name;
        cout << "请输入姓名" << endl;
        cin >> name;
        abs->personArray[abs->m_size].m_Name = name;
        //性别
        cout << "请输入性别：1男 2女" << endl;
        int sex= 0;
        while (true)
        {
            cin >> sex;
            if (sex == 1 || sex == 2)
            {
                abs->personArray[abs->m_size].m_Sex = sex;
                break;
            }
            else
            {
                cout << "您输入的数字有误，请重新输入" << endl;
            }
        }
        //年龄
        cout << "请输入年龄" << endl;
        int age = 0;
        while (true)
        {
            cin >>age;
            if (0<=age&&age<=150)
            {
                abs->personArray[abs->m_size].m_Age = age;
                break;
            }
            else
            {
                cout << "您输入的年龄有误，请重新输入" << endl;
            }
        }
        //电话
        cout << "输入联系电话" << endl;
        string phone;
        cin >> phone;
        abs->personArray[abs->m_size].m_Phone = phone;
        //住址
        cout << "请输入家庭住址" << endl;
        string address;
        cin >> address;
        abs->personArray[abs->m_size].m_Addr = address;
        //更新通讯录的人数
        abs->m_size++;
        cout << "添加成功" << endl;
        system("pause");
        system("cls");//清屏的操作
    }

}
//显示所有的联系人
void ShowPerson(Addressbooks* abs) {
    //判断通讯录中人数是否为0
    if (abs->m_size==0)
    {
        cout << "当前记录为空" << endl;
    }
    else
    {
        for (int i = 0; i < abs->m_size; i++)
        {
            cout << "姓名：" << abs->personArray[i].m_Name << "\t";
            cout << "性别：" <<(abs->personArray[i].m_Sex ==1 ?"男":"女")<< "\t";
            cout << "年龄：" << abs->personArray[i].m_Age << "\t";
            cout << "电话：" << abs->personArray[i].m_Phone << "\t";
            cout << "住址：" << abs->personArray[i].m_Addr << endl;
        }
    }
    system("pause");
    system("cls");
}
//查找是否存在此联系人
int isExit(Addressbooks* abs, string name)
{
    for (int i = 0; i < abs->m_size; i++)
    {
        if (abs->personArray[i].m_Name == name)
            return i;
    }
    return -1;
}
//删除联系人
void deletePerson(Addressbooks* abs)
{
    cout << "请输入删除联系人的姓名 " << endl;
    string name;
    cin >> name;
    int ret = isExit(abs, name);

    if(ret!=-1){
        for (int i = ret; i < abs->m_size; i++)
        {
            abs->personArray[i] = abs->personArray[i + 1];
        };
        abs->m_size--;
    }
    else
    {
        cout << "查无此人" << endl;
    }
    system("pause");
    system("cls");
}
//查找指定联系人信息
void findPerson(Addressbooks* abs)
{
    cout << "请输入您要查找的联系人" << endl;
    string name;
    cin >> name;
    int ret=isExit(abs, name);
    if (ret!=-1)
    {
        cout << "姓名： " << abs->personArray[ret].m_Name << '\t';
        cout << "性别： " << (abs->personArray[ret].m_Sex == 1 ? "男" : "女") << '\t';
        cout << "年龄： " << abs->personArray[ret].m_Age<< '\t';
        cout << "电话： " << abs->personArray[ret].m_Phone << '\t';
        cout << "住址： " << abs->personArray[ret].m_Addr<< '\t';
    }
    else
    {
        cout << "查无此人" << endl;
    }
    system("pause");
    system("cls");
}
//修改联系人
void modifyPerson(Addressbooks* abs)
{
    cout << "请输入你要查找的联系人" << endl;
    string name;
    cin >> name;
    int ret=isExit(abs, name);
    if (ret != -1)
    {
        string name;
        cout << "请输入姓名" << endl;
        cin >> name;
        abs->personArray[ret].m_Name = name;
        cout << "请输入性别：  " << endl;
        cout << "1-------男：  " << endl;
        cout << "2-------女：  " << endl;
        int sex = 0;
        while (1) {
            cin >> sex;
            if (sex == 1 || sex == 2)
            {
                abs->personArray[ret].m_Sex = sex;
                break;
            }
            else
            {
                cout << "输入有误，请重新输入" << endl;
            }
        }
        int age = 0;
        cout << "请输入年龄" << endl;
        abs->personArray[ret].m_Age = age;
        cout << "请输入电话" << endl;
        string phone;
        cin >> phone;
        abs->personArray[ret].m_Phone = phone;
        cout << "请输入住址" << endl;
        string address;
        cin >> address;
        abs->personArray[ret].m_Addr = address;
    }
    else
    {
        cout << "查无此人" << endl;
    }
    system("pause");
    system("cls");
}
//清空联系人
void clearPerson(Addressbooks* abs)
{
    abs->m_size = 0;
    cout << "通讯录已清空" << endl;
    system("pause");
    system("cls");
}
//菜单界面
void showMenu()
{
    cout << "**********************" << endl;
    cout << "*****1.添加联系人*****" << endl;
    cout << "*****2.显示联系人*****" << endl;
    cout << "*****3.删除联系人*****" << endl;
    cout << "*****4.查找联系人*****" << endl;
    cout << "*****5.修改联系人*****" << endl;
    cout << "*****6.清空联系人*****" << endl;
    cout << "*****0.退出通讯录*****" << endl;
    cout << "**********************" << endl;
}
int main()
{
    //创建通讯录结构体变量
    Addressbooks abs;
    //初始化通讯录中当前人员个数
    abs.m_size = 0;
    int select = 0;
    while (true) {
        showMenu(); //菜单的调用
        cin >> select;
        switch (select)
        {
            case 1://1.添加联系人
                addPerson(&abs);
                break;
            case 2://2.显示联系人
                ShowPerson(&abs);
                break;
            case 3://3.删除联系人
                deletePerson(&abs);
                break;
            case 4://4.查找联系人
                findPerson(&abs);
                break;
            case 5://5.修改联系人
                modifyPerson(&abs);
                break;
            case 6://6.清空联系人
                clearPerson(&abs);
                break;
            case 0://0.退出通讯录
                cout << "欢迎下次使用" << endl;
                system("pause");
                return 0;
                break;
            default:
                break;
        }
    }
    system("pause");
    return 0;
}