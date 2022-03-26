#pragma once
#include "AutoSprite.h"
class HeartSprite :public AutoSprite
{
	int life;
public:
	HeartSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r, int score,int life);
	HeartSprite(HeartSprite& sprite);
	virtual~HeartSprite();
	void move(boundary ur);
};

