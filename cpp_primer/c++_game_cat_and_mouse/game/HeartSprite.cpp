#include "HeartSprite.h"
HeartSprite::HeartSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r1, int score,int life)
	:AutoSprite(x, y, width, height, dx, dy, img, r1, score,life) {
}
HeartSprite::HeartSprite(HeartSprite& sprite)
	: AutoSprite(sprite) {
}
HeartSprite::~HeartSprite() {
}
void HeartSprite::move(boundary ur) {
	AutoSprite::move(ur);
}