#pragma once
#include "SpriteBase.h"
#include<cstring>
#include<iostream>
using namespace std;
class UserSprite :public SpriteBase
{
    int score;
    int life;
    int level;
public:
    UserSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r);
    UserSprite(UserSprite& sprite);
    ~UserSprite();
    void move(int x,int y);
    void move(int key);
    void move(boundary r);
    int crash(boundary r1);
    int getscore();
    void setscore(int s);
    void modifyscore(int m);
    int getLife();
    void setLife(int a);
    void addLife(int b);
    void decLife(int c);
    int getlevel();
    void setlevel(int a);
    void addlevel(int b);
};


