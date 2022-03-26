#include<stdio.h>
#include"list.h"
//��������Ҫ�Ľṹ�� 
struct mylist{
	int number;//�����
	struct list_head list;
};
struct list_head running;	//��ʾ����״̬�ĳ��� 
struct list_head ready;	    //��ʾ����״̬�ĳ��� 
struct list_head block;		//��ʾ����״̬�ĳ��� 
struct mylist *list_array[8];	
//������״̬��������г�ʼ�� 
void init(){
	INIT_LIST_HEAD(&running);
	INIT_LIST_HEAD(&ready);
	INIT_LIST_HEAD(&block);
}
//��ʼ�����������Ÿ�ÿһ������ 
int init_list(){
	int i = 0;
	for(i=0; i<8; i++){
		list_array[i] = malloc(sizeof(struct mylist));
		INIT_LIST_HEAD(&list_array[i]->list);
		list_array[i] -> number = i;
	}
	return 0;
}
//��8������ֱ�װ������״̬�������С���һ������װ��running�����ڶ�������װ��ready״̬��ʣ��ĳ���װ��block״̬ 
int insert(){
	int i = 0;
	list_add(&list_array[0]->list, &running);
	list_add(&list_array[1]->list, &ready);
	for(i=2; i<8; i++){
		list_add(&list_array[i]->list, &block);
	}
	return 0;
}
//�������еĳ����ӡ���� 
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
//�������״̬������ָ�룬�ֱ����show_list�������д�ӡ
int show(){
	printf("����״̬�ĳ���");
	show_list(&running);
	printf("����״̬�ĳ���");
	show_list(&ready);
	printf("����״̬�ĳ���");
	show_list(&block);
	printf("\n");
	return 0;
}
//�������������нڵ��ת����ʵ�ֳ���״̬��ת����num���ڿ���һ��ת�����ٸ������״̬ 
int move(struct list_head *current, struct list_head *new, int num){
	struct mylist *entry = NULL;
	int i;
	for(i=0; i<num; i++){
		if(list_empty_careful(current)==1){
			printf("Empty List!\n");
			return 0;
		}
		entry = list_first_entry(current, struct mylist, list);
		printf("���� %d �任״̬\n", entry->number);
		list_move_tail(&entry->list, new);
	}
	return 0;
}
int main(){
	int n, count;
	init();					//�����ʼ��
	init_list();			//�����ʼ��
	insert();				//�ѳ�����뵽������
	show();                 //չʾ���������״̬
	printf("����״̬ת�����֣�0��ʾ�Ӿ���̬ת��Ϊִ��̬��1��ʾ��ִ��̬ת��Ϊ����̬��2��ʾ������̬ת��������̬����ת���Ľ�������");
	scanf("%d %d",&n,&count);	//n��ʾת��״̬��count��ʾһ��ת��״̬�ĳ������� 
	while(count>0){			
		if(n==0){			//��n==0,�����Ӿ���״̬ת����ִ��״̬ 
			move(&ready, &running, count);
		}else if(n==1){		//��n==1,������ִ��״̬ת��������״̬ 
			move(&running, &block, count);
		}else if(n==2){		//��n==2,����������״̬ת��������״̬		
			move(&block, &ready, count);
		}else{		
			printf("����������ת��״̬��\n");
		}
		show();
		printf("����״̬ת�����֣�0��ʾ�Ӿ���̬ת��Ϊִ��̬��1��ʾ��ִ��̬ת��Ϊ����̬��2��ʾ������̬ת��������̬����ת���Ľ�������");
		scanf("%d %d", &n, &count);
	}
	printf("����ת������\n");
	return 0;
}
