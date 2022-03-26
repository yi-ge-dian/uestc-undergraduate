#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "acllib.h"

//���嵥λ���صı߳�
#define step 20
//��Ϸ����߶�
#define boundaryH 28
//��Ϸ�������
#define boundaryW 14
//����˹������״������Ŀ��������ת��ģ�
#define Max_Shape 19
int WINDOW[boundaryH][boundaryW] = { 0 };
int s[7] = { 0,2,6,10,12,14,15 };
int num = 0, cnt = 0;
class  cube
{
public:
    bool isTransform = false;
    bool isToLeft = false;
	bool isToRight = false;
	void picture_a_Cube();
	void initCube();
	static void keyEvent(int key, int event);
	static void timeEvent(int tid);
};
class Pstruct
{
public:
	int  y,x;
};
class Sstruct
{
public:
	int shape[4][4];
	int next;
}SHAPE[19] = 
{
	//l
	{
	 1,0,0,0,
	 1,0,0,0,
	 1,0,0,0,
	 1,0,0,0,1
	}
	,
	//һ
	{
		0,0,0,0,
		0,0,0,0,
		1,1,1,1,
		0,0,0,0,0
	}
	//L
	,{
		0,0,0,0,
		1,0,0,0,
		1,0,0,0,
		1,1,0,0,3
	}
	,
	{
		0,0,0,0,
		1,1,1,0,
		1,0,0,0,
		0,0,0,0,4
	}

	,{
		0,0,0,0,
		1,1,0,0,
		0,1,0,0,
		0,1,0,0,5
	}
	,
	{
		0,0,0,0,
		0,0,1,0,
		1,1,1,0,
		0,0,0,0,2
	}
	//rL
	,{
		0,0,0,0,
		0,1,0,0,
		0,1,0,0,
		1,1,0,0,7
	}
	,
	{
		0,0,0,0,
		1,0,0,0,
		1,1,1,0,
		0,0,0,0,8
	}

	,{
		0,0,0,0,
		1,1,0,0,
		1,0,0,0,
		1,0,0,0,9
	}

	,
	{
		0,0,0,0,
		1,1,1,0,
		0,0,1,0,
		0,0,0,0,6
	}
	//Z
	,
	{
		0,0,0,0,
		0,1,0,0,
		1,1,0,0,
		1,0,0,0,11
	}
	,
	{
		0,0,0,0,
		1,1,0,0,
		0,1,1,0,
		0,0,0,0,10
	}
	,
	//rZ
	{
		0,0,0,0,
		0,1,1,0,
		1,1,0,0,
		0,0,0,0,13
	}
	,
	{
		0,0,0,0,
		1,0,0,0,
		1,1,0,0,
		0,1,0,0,12
	}
	,
	//��
	{
		0, 0, 0, 0,
		1, 1, 0, 0,
		1, 1, 0, 0,
		0, 0, 0, 0,14
	}
	,
	//T
	{
		0, 0, 0, 0,
		0, 1, 0, 0,
		1, 1, 1, 0,
		0, 0, 0, 0,16
	}
	,
	{
		0,0,0,0,
		1,0,0,0,
		1,1,0,0,
		1,0,0,0,17
	}
	,
	{
		0, 0, 0, 0,
		1, 1, 1, 0,
		0, 1, 0, 0,
		0, 0, 0, 0,18
	}
	,
	{
		0,0, 0, 0,
		0,1, 0, 0,
		1,1, 0, 0,
		0,1, 0, 0,15
	}
};
Pstruct posi;
cube C;
//����ͼ��
void cube::picture_a_Cube()
{
	beginPaint();
	//����
	clearDevice();
	//���廭�ʻ�ˢΪ��ɫ
	setPenColor(BLACK);
	setBrushColor(BLACK);

	//��WINDOW�ڴ��ڵĲ��һ�δ�����Ķ���˹���黭��
	for (int i = 0; i < boundaryH; i++) 
	{
		for (int j = 0; j < boundaryW; j++)
		{
			if (WINDOW[i][j])
				rectangle(j * step, i * step, (j + 1) * step, (i + 1) * step);
		}
	}
	//��ת
	if (isTransform)
	{
		isTransform = false;
		//temp���ڴ洢ԭ������״
		int temp = num;
		num = SHAPE[num].next;
		//�ж��Ƿ���Խ�����ת�������ת�����ԭWINDOW�ڴ������ݳ�ͻ����
		bool isReach = false;
		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				if (SHAPE[num].shape[i][j]) 
				{
					if (posi.y + i + 1 >= boundaryH || WINDOW[posi.y + i + 1][posi.x + j])
					{
						isReach = true;
						break;
					}
				}
			}
		if (isReach) num = temp; //����
	}
	//����
	if (isToLeft)
	{
		isToLeft = false;
		bool isReach = false;
		//�ж����ƺ��Ƿ��ͻ
		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++) 
			{
				if (SHAPE[num].shape[i][j])
				{
					if (posi.x + j - 1 < 0 || WINDOW[posi.y + i][posi.x + j - 1]) 
					{
						isReach = true;
						break;
					}
				}
			}
		if (!isReach) posi.x--;

	}
	//����
	if (isToRight) 
	{
		isToRight = false;
		bool isReach = false;
		//�ж��Ƿ��ͻ
		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				if (SHAPE[num].shape[i][j]) 
				{
					if (posi.x + j + 1 >= boundaryW || WINDOW[posi.y + i][posi.x + j + 1])
					{
						isReach = true;
						break;
					}
				}
			}
		if (!isReach) posi.x++;
	}
	//��������˹����ͼ��
	for (int i = 0; i < 4; i++) 
	{
		for (int j = 0; j < 4; j++) 
		{
			if (SHAPE[num].shape[i][j]) 
			{
				rectangle((posi.x + j) * step, (posi.y + i) * step, (posi.x + j + 1) * step, (posi.y + i + 1) * step);
			}
		}
	}

	//�ж�WINDOW�����Ƿ����ĳһ�ж����ڷ��飬��������������У�����֮�ϵ���������һ��
	for (int i = 0; i < boundaryH; i++)
	{
		int count = 0;
		for (int j = 0; j < boundaryW; j++) 
		{
			if (!WINDOW[i][j])break;
			count++;
		}
		if (count == boundaryW) 
		{
			for (int k = i - 1; k >= 0; k--) 
			{
				for (int j = 0; j < boundaryW; j++) 
				{
					WINDOW[k + 1][j] = WINDOW[k][j];
				}
			}
			for (int j = 0; j < boundaryW; j++) WINDOW[0][j] = 0;
		}
	}
	endPaint();
}
void cube::initCube() 
{
	posi.y = 0;
	posi.x = boundaryW / 2 - 1;
	//srand����������ӣ�rand���������
	srand((unsigned)time(NULL));
	num = s[rand() % 7];
}
void cube::keyEvent(int key, int event) 
{
	//�α�

	if (key == VK_UP) 
	{
		if (event == KEY_UP) 
		{
			C.isTransform = true;
		}
	}
	//����
	if (key == VK_LEFT) 
	{
		if (event == KEY_UP)
		{
			C.isToLeft = true;
		}
	}
	//����
	if (key == VK_RIGHT) 
	{
		if (event == KEY_UP) 
		{
			C.isToRight = true;
		}
	}
	//�����½���50ms��Ϊ10ms
	if (key == VK_DOWN)
	{
		if (event == KEY_DOWN)
		{
			startTimer(0, 10);
		}
		else if (event == KEY_UP) 
		{
			startTimer(0, 50);
		}
	}
}
void cube::timeEvent(int tid) 
{
	cnt++;
	//ÿ��50*5ms�½�һ����λ
	if (cnt >= 10) 
	{
		cnt = 0;
		bool isReach = false;
		//�ж��Ƿ�����½�
		for (int i = 0; i < 4; i++)
			for (int j = 0; j < 4; j++)
			{
				if (SHAPE[num].shape[i][j]) 
				{
					if (posi.y + i + 1 >= boundaryH || WINDOW[posi.y + i + 1][posi.x + j])
					{
						isReach = true;
						break;
					}
				}
			}
		if (!isReach) posi.y++;
		else 
		{ //�������/�ϰ���
			for (int i = 0; i < 4; i++)
				for (int j = 0; j < 4; j++) 
				{
					if (SHAPE[num].shape[i][j]) 
					{
						WINDOW[posi.y + i][posi.x + j] = 1;
					}
				}
			C.initCube();
		}
	}
	//�ػ���Ϸ����
	C.picture_a_Cube();
}
int Setup()
{
	//���ɴ���
	initWindow("Russan Cube", DEFAULT, DEFAULT, boundaryW * step, boundaryH * step);
	C.initCube();
	//ע�ᶨʱ���ж�
	registerTimerEvent(C.timeEvent);
	//ע������ж�
	registerKeyboardEvent(C.keyEvent);
	//������ʱ����50ms
	startTimer(0, 50);
	return 0;
}