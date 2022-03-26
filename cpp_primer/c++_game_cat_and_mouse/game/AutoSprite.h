#pragma once
#include "SpriteBase.h"
class AutoSprite :public SpriteBase
{
    int score;
	int life;
public:
	AutoSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r, int score, int life);
    AutoSprite(AutoSprite& sprite);
    ~AutoSprite();
    void move(boundary r);
    int getscore();
	int getlife();
};

