#include "SpriteBase.h"
SpriteBase::SpriteBase(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r) {
    this->x = x;
    this->y = y;
    this->width = width;
    this->height = height;
    this->dx = dx;
    this->dy = dy;
    this->img = img;
    this->r = r;
}
SpriteBase::SpriteBase(SpriteBase& sprite) {
    x = sprite.x;
    y = sprite.y;
    width = sprite.width;
    height = sprite.height;
    dx = sprite.dx;
    dy = sprite.dy;
    img = sprite.img;
    r = sprite.r;
}
SpriteBase::~SpriteBase() {
}
void SpriteBase::showSprite(int width, int height) {
    putImageTransparent(img, x, y, width, height, WHITE);
}
void SpriteBase::showSprite() {
    putImageTransparent(img, x, y, width, height, WHITE);
}
boundary SpriteBase::getboundary() {
    boundary r = { x, y, width, height };
    return r;
}
