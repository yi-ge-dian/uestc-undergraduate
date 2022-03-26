#include "AutoSprite.h"
AutoSprite::AutoSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r,int score,int life)
    :SpriteBase(x,y,width,height,dx,dy,img,r)
{
    this->score = score;
	this->life = life;
}
AutoSprite::AutoSprite(AutoSprite& sprite) : SpriteBase(sprite) {
    score = sprite.score;
	life = sprite.life;
}
AutoSprite::~AutoSprite() {
}
void AutoSprite::move(boundary r1) {
    x += dx;
    y += dy;
    if (x<r.x || x>(r.x + r.width - width)) dx *= -1;
    if (y<r.y || y>(r.y + r.height - height)) dy *= -1;
}
int AutoSprite::getscore() {
    return score;
}
int AutoSprite::getlife() {
	return life;
}