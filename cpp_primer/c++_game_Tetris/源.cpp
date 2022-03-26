#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "acllib.h"

//定义单位像素的边长
#define step 20
//游戏窗体高度
#define boundaryH 28
//游戏窗体宽体
#define boundaryW 14
//俄罗斯方块形状的总数目（包括旋转后的）
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
	//一
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
	//田
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
//画出图形
void cube::picture_a_Cube()
{
	beginPaint();
	//清屏
	clearDevice();
	//定义画笔画刷为黑色
	setPenColor(BLACK);
	setBrushColor(BLACK);

	//将WINDOW内存在的并且还未消除的俄罗斯方块画出
	for (int i = 0; i < boundaryH; i++) 
	{
		for (int j = 0; j < boundaryW; j++)
		{
			if (WINDOW[i][j])
				rectangle(j * step, i * step, (j + 1) * step, (i + 1) * step);
		}
	}
	//旋转
	if (isTransform)
	{
		isTransform = false;
		//temp用于存储原来的形状
		int temp = num;
		num = SHAPE[num].next;
		//判断是否可以进行旋转，如果旋转后的与原WINDOW内存在内容冲突则撤销
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
		if (isReach) num = temp; //撤销
	}
	//左移
	if (isToLeft)
	{
		isToLeft = false;
		bool isReach = false;
		//判断左移后是否冲突
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
	//右移
	if (isToRight) 
	{
		isToRight = false;
		bool isReach = false;
		//判断是否冲突
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
	//画出俄罗斯方块图形
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

	//判断WINDOW数组是否存在某一行都存在方块，如果是则消除该行，并将之上的数据下移一行
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
	//srand生成随机因子，rand生成随机数
	srand((unsigned)time(NULL));
	num = s[rand() % 7];
}
void cube::keyEvent(int key, int event) 
{
	//形变

	if (key == VK_UP) 
	{
		if (event == KEY_UP) 
		{
			C.isTransform = true;
		}
	}
	//左移
	if (key == VK_LEFT) 
	{
		if (event == KEY_UP)
		{
			C.isToLeft = true;
		}
	}
	//右移
	if (key == VK_RIGHT) 
	{
		if (event == KEY_UP) 
		{
			C.isToRight = true;
		}
	}
	//加速下降，50ms改为10ms
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
	//每隔50*5ms下降一个单位
	if (cnt >= 10) 
	{
		cnt = 0;
		bool isReach = false;
		//判断是否可以下降
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
		{ //方块落地/障碍。
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
	//重绘游戏窗体
	C.picture_a_Cube();
}
int Setup()
{
	//生成窗口
	initWindow("Russan Cube", DEFAULT, DEFAULT, boundaryW * step, boundaryH * step);
	C.initCube();
	//注册定时器中断
	registerTimerEvent(C.timeEvent);
	//注册键盘中断
	registerKeyboardEvent(C.keyEvent);
	//开启定时器，50ms
	startTimer(0, 50);
	return 0;
}