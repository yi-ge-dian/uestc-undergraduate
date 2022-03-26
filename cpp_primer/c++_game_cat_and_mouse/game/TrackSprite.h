#pragma once
#include "AutoSprite.h"
class TrackSprite :public AutoSprite
{
public:
	TrackSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r,int score,int life);
	TrackSprite(TrackSprite& sprite);
	virtual~TrackSprite();
	void move(boundary ur);
};

