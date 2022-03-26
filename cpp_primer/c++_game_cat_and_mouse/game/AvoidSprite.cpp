#include "AvoidSprite.h"
#include<math.h>
AvoidSprite::AvoidSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r1,int score,int life)
	:AutoSprite(x, y, width, height, dx, dy, img, r1,score,life) {
}
AvoidSprite::AvoidSprite(AvoidSprite& sprite) 
	:AutoSprite(sprite) {
	}
AvoidSprite::~AvoidSprite(){
}
void AvoidSprite::move(boundary ur) {
	float cx = (x + width) / 2;
	float cy = (y + height) / 2;
	float ux = (ur.x + ur.width) / 2;
	float uy = (ur.y + ur.height) / 2;
	float dist = (cx - ux) * (cx - ux) + (cy - uy) * (cy - uy);
	if (dist <= 8000) {
		dx -= (int)3 * (ux - cx)/ sqrt(dist);
		dy -= (int)3 * (uy - cy) / sqrt(dist);
	}
	else if (dist > 10000) {
		if (dx > 5) dx--;
		if (dx < -5)dx++;
		if (dy > 5) dy--;
		if (dy < -5)dy++;
	}
	AutoSprite::move(ur);
}