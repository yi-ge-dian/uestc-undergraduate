#include<stdio.h>
#include"list.h"
//定义所需要的结构体 
struct mylist{
	int number;//程序号
	struct list_head list;
};
struct list_head running;	//表示运行状态的程序 
struct list_head ready;	    //表示就绪状态的程序 
struct list_head block;		//表示阻塞状态的程序 
struct mylist *list_array[8];	
//对三种状态的链表进行初始化 
void init(){
	INIT_LIST_HEAD(&running);
	INIT_LIST_HEAD(&ready);
	INIT_LIST_HEAD(&block);
}
//初始化，分配程序号给每一个程序 
int init_list(){
	int i = 0;
	for(i=0; i<8; i++){
		list_array[i] = malloc(sizeof(struct mylist));
		INIT_LIST_HEAD(&list_array[i]->list);
		list_array[i] -> number = i;
	}
	return 0;
}
//将8个程序分别装入三种状态的链表中。第一个程序装入running链表，第二个程序装入ready状态，剩余的程序装入block状态 
int insert(){
	int i = 0;
	list_add(&list_array[0]->list, &running);
	list_add(&list_array[1]->list, &ready);
	for(i=2; i<8; i++){
		list_add(&list_array[i]->list, &block);
	}
	return 0;
}
//将链表中的程序打印出来 
int show_list(struct list_head *list_head){
	int i = 0;
	struct mylist *entry, *tmp;
	if(list_empty_careful(list_head)==1){
		printf("Empty List!\n");
		return 0;
	}
	list_for_each_entry_safe(entry, tmp, list_head, list){
		printf("[%d]=%d\t", i++, entry->number);
	}
	printf("\n");
	return 0;
}
//传入各个状态的链表指针，分别调用show_list函数进行打印
int show(){
	printf("运行状态的程序：");
	show_list(&running);
	printf("就绪状态的程序：");
	show_list(&ready);
	printf("阻塞状态的程序：");
	show_list(&block);
	printf("\n");
	return 0;
}
//进行两个链表中节点的转换，实现程序状态的转换。num用于控制一次转换多少个程序的状态 
int move(struct list_head *current, struct list_head *new, int num){
	struct mylist *entry = NULL;
	int i;
	for(i=0; i<num; i++){
		if(list_empty_careful(current)==1){
			printf("Empty List!\n");
			return 0;
		}
		entry = list_first_entry(current, struct mylist, list);
		printf("程序 %d 变换状态\n", entry->number);
		list_move_tail(&entry->list, new);
	}
	return 0;
}
int main(){
	int n, count;
	init();					//链表初始化
	init_list();			//程序初始化
	insert();				//把程序插入到链表中
	show();                 //展示各个程序的状态
	printf("输入状态转换数字（0表示从就绪态转换为执行态，1表示从执行态转换为阻塞态，2表示从阻塞态转换到就绪态）和转换的进程数：");
	scanf("%d %d",&n,&count);	//n表示转换状态，count表示一次转换状态的程序数量 
	while(count>0){			
		if(n==0){			//若n==0,则程序从就绪状态转换到执行状态 
			move(&ready, &running, count);
		}else if(n==1){		//若n==1,则程序从执行状态转换到阻塞状态 
			move(&running, &block, count);
		}else if(n==2){		//若n==2,则程序从阻塞状态转换到就绪状态		
			move(&block, &ready, count);
		}else{		
			printf("不存在这种转换状态！\n");
		}
		show();
		printf("输入状态转换数字（0表示从就绪态转换为执行态，1表示从执行态转换为阻塞态，2表示从阻塞态转换到就绪态）和转换的进程数：");
		scanf("%d %d", &n, &count);
	}
	printf("进程转换出错\n");
	return 0;
}
