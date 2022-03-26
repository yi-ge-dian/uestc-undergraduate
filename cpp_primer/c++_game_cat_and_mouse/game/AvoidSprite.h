#pragma once
#include "AutoSprite.h"
class AvoidSprite :public AutoSprite
{
public:
	AvoidSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r, int score, int life);
	AvoidSprite(AvoidSprite &sprite);
	virtual~AvoidSprite();
	void move(boundary ur);
};

