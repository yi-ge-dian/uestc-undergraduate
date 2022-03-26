#pragma once
#include"acllib.h"
class SpriteBase
{
protected:
    int x, y;
    int width, height;
    int dx, dy;
    ACL_Image* img;
    boundary r;
public:
    SpriteBase(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r);
    SpriteBase(SpriteBase& sprite);
    virtual~SpriteBase();
    virtual void move(boundary r)=0;
    void showSprite(int width, int heigth);
    void showSprite();
    boundary getboundary();
};


