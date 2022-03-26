#include "acllib.h"
#include "AutoSprite.h"
#include "UserSprite.h"
#include "AvoidSprite.h"
#include "TrackSprite.h"
#include "HeartSprite.h"
#include<time.h>
#include<stdio.h>
const int maxnum = 200;//���������������
const int winWidth = 1080, winHeight = 780;//���ڴ�С
int jerrywidth = 100, jerryheight = 100;//����Ŀ��
int tomwidth = 100, tomheight = 100;//è�Ŀ��
AutoSprite* autosprite[maxnum] = { 0 };
UserSprite* tomsprite = NULL;
//����ͼƬ
ACL_Image tom_img, jerry_img,heart_img,dog_img,fish_img;
boundary tomboundary = { DEFAULT,DEFAULT,winWidth,winHeight };//è�ı߽�
void createauto(AutoSprite** autoSprite);
void createtom(UserSprite** tomsprite);
int index = 0;//��¼��ǰ��������
void paint();
void putImageTransparent(ACL_Image* pImage, int x, int y, int width, int height, ACL_Color bkColor);
void timerEvent(int id);
void keyEvent(int key, int event);
int Setup() {
    //���ڵĳ�ʼ��
    initWindow("һֻè",DEFAULT,DEFAULT,winWidth,winHeight);
    //�������������
    srand((unsigned)time(NULL));
    //����ͼƬ
	loadImage("jerry.bmp", &jerry_img);
    loadImage("tom.bmp", &tom_img);
    loadImage("fish.bmp", &fish_img);
    loadImage("heart.bmp", &heart_img);
    loadImage("dog.bmp", &dog_img);
    //���쾫��
    createtom(&tomsprite);
    createauto(autosprite);
    //��ʱ��
    registerTimerEvent(timerEvent);
    registerKeyboardEvent(keyEvent);
    startTimer(0, 50);//�����ƶ�
    startTimer(1, 1000);//�����Զ�������(�����㣬��������)
    return 0;
}
void createauto(AutoSprite** autoSprite) {
    int x = rand() % winWidth - jerrywidth;
    if (x < 0)x = 0;
    int y = rand() % winHeight - jerryheight;
    if (y < 0)y = 0;
    int dx = rand() % 3 + 1;
    int dy = rand() % 3 + 1;
    int t = rand() % 100;
    if (t < 60) {
        autosprite[index] = new AutoSprite(x, y, jerrywidth, jerryheight, dx, dy, &jerry_img, tomboundary, 1,0);
        index++;
    }
    else if (t >= 60 && t <= 75) {
        autosprite[index] = new AvoidSprite(x, y, jerrywidth, jerryheight, dx, dy, &fish_img, tomboundary, 2,0);
        index++;
    }
    else if (t > 75 && t <= 83) {
        autosprite[index] = new TrackSprite(x, y, jerrywidth * 1.5, jerryheight * 1.5, dx, dy, &dog_img, tomboundary, -5,-1);
        index++;
    }
    else {
        autosprite[index] = new HeartSprite(x, y, jerrywidth /2, jerryheight /2, dx, dy, &heart_img, tomboundary, 0,1);
        index++;
}
}
void createtom(UserSprite** tomsprite) {
    int x = rand() % winWidth - tomwidth;
    if (x < 0)  x = 0;
    int y = rand() % winHeight - tomheight;
    if (y < 0)  y = 0;
    int dx = 5;
    int dy = 5;
    *tomsprite = new UserSprite(x, y, tomwidth, tomheight, dx, dy, &tom_img, tomboundary);
}
void timerEvent(int id) {
	if (tomsprite->getLife() <= 0) {
		beginPaint(); clearDevice();
		char txt1[50];
		sprintf_s(txt1, "��ֻè����������һ��", tomsprite->getscore());
		setTextSize(30);
		paintText(540, 360, txt1);
		endPaint();
		return;
	}
	if (tomsprite->getscore() >= 30) {
		beginPaint(); clearDevice();
		char txt1[50];
		sprintf_s(txt1, "��ϲ��ȡ��ʤ��", tomsprite->getscore());
		setTextSize(30);
		paintText(540, 360, txt1);
		endPaint();
		return;
	}
    int i= 0;
    switch (id) {
    case 0:
        for(i = 0; i < index; ++i)
            if (autosprite[i])
            {
				boundary ur = tomsprite->getboundary();
                autosprite[i]->move(ur);
            }
		for (int i = 0; i < index; ++i)
		{
			if (autosprite[i])
			{
				if (tomsprite->crash(autosprite[i]->getboundary()))
				{
					int s = autosprite[i]->getscore();
					int l = autosprite[i]->getlife();
					if (tomsprite) {
						tomsprite->modifyscore(s);
						tomsprite->addLife(l);
					}
					if (tomsprite->getscore() == 6)   tomsprite->setlevel(2);
					if (tomsprite->getscore() == 15)  tomsprite->setlevel(3);
					delete(autosprite[i]);
					autosprite[i] = NULL;
				}
			}
		}
		break;
    case 1:
        if (index < maxnum)
        {
            createauto(autosprite);
        }
        break;
    default:
        break;
  }
    paint();
}
void paint(){
    beginPaint();
    clearDevice();
    int i = 0;
    for (i = 0; i < index; ++i)
    {
        if (autosprite[i])
        {
            autosprite[i]->showSprite();
        }
    }
    if (tomsprite) {
        tomsprite->showSprite();
        char txt[100];
        sprintf_s(txt, "�÷֣�%d ������%d �ȼ���%d ����ʤ����%d", tomsprite->getscore(), tomsprite->getLife(), tomsprite->getlevel(),(30-tomsprite->getscore()));
        setTextSize(20);
        paintText(220, 5, txt);
    }
    endPaint();
}
void keyEvent(int key, int event) {
    if (event != KEY_DOWN) return;
    if (tomsprite)
        tomsprite->move(key);
}