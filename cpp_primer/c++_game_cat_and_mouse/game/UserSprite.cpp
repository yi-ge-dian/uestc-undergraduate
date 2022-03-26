#include "UserSprite.h"
#include "acllib.h"
UserSprite::UserSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r)
    :SpriteBase(x,y,width,height,dx,dy,img,r){
    score = 0;
    life = 3;
    level = 1;
}
UserSprite::UserSprite(UserSprite& sprite) :SpriteBase(sprite){
    score = sprite.score;
    life = sprite.life;
    level = sprite.level;
}
UserSprite::~UserSprite() {
}
void UserSprite::move(int xx, int yy) {
    x = xx;
    y = yy;
    if (x < r.x) x = r.x;
    if (x > (r.x + r.width - width)) x = r.x + r.width - width;
    if (y < r.y) y = r.y;
    if (y > (r.y + r.height - height)) y = r.y + r.height - height;
}
void UserSprite::move(int key) {
    switch (key) {
    case VK_UP:
        y -= dy;
        if (y < r.y) y = r.y;
        break;
    case VK_DOWN:
        y += dy;
        if (y > (r.y + r.height - height)) y = r.y + r.height - height;
        break;
    case VK_LEFT:
        x -= dx;
        if (x < r.x) x = r.x;
        break;
    case VK_RIGHT:
        x += dx;
        if (x > (r.x + r.width - width)) x = r.x + r.width - width;
        break;
    default:
        break;
    }
}
int UserSprite::crash(boundary r2) {
    boundary r1 = { x,y,width,height };
    int c = 1;
    if (r1.x<r2.x && r1.x + r1.width>r2.x) {
        if (r1.y > r2.y&& r1.y < r2.y + r2.height) return c;
        if (r1.y<r2.y && r1.y + r1.height>r2.y) return c;
    }
    else {
        if (r1.x > r2.x&& r1.x < r2.x + r2.width) {
            if (r1.y > r2.y&& r1.y < r2.y + r2.height) return c;
            if (r1.y<r2.y && r1.y + r1.height>r2.y) return c;
        }
    }
    c = 0;
    return c;
}
void UserSprite:: move(boundary r1) {
    x = r1.x;
    y = r1.y;
    if (x < r.x) x = r.x;
    if (x > (r.x + r.width - width)) x = r.x + r.width - width;
    if (y < r.y) y = r.y;
    if (y > (r.y + r.height - height)) y = r.y + r.height - height;
}
//分数操作
int UserSprite::getscore() {
    return score;
}
void UserSprite::setscore(int s) {
    score = s;
}
void UserSprite::modifyscore(int m) {
    score += m;
} 
//生命操作
int UserSprite::getLife()
{
    return life;
}
void UserSprite::setLife(int a)
{
    life = a;
}
void UserSprite::decLife(int c)
{
    life -= c;
}
void UserSprite::addLife(int b )
{
    life += b;
}
//对等级的操作
int UserSprite::getlevel()
{
	return level;
}
void UserSprite::setlevel(int a)
{
	level = a;
	width = (int)(1.4*width);
	height = (int)(1.4*height);
	dx = (int)(1.6*dx);
	dy = (int)(1.6*dy);
}
void UserSprite::addlevel(int b)
{
	level += b;
	width = (int)(1.4*width);
	height = (int)(1.4*height);
	dx = (int)(1.6*dx);
	dy = (int)(1.6*dy);
}

