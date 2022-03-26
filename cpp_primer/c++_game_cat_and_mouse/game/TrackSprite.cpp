#include "TrackSprite.h"
#include <cmath>
TrackSprite::TrackSprite(int x, int y, int width, int height, int dx, int dy, ACL_Image* img, boundary r1,int score,int life)
	:AutoSprite(x, y, width, height, dx, dy, img, r1,score,life){
}
TrackSprite::TrackSprite(TrackSprite& sprite) : AutoSprite(sprite) {
}
TrackSprite::~TrackSprite() {
}
void TrackSprite::move(boundary ur) {
	float cx = (x + width) / 2;
	float cy = (y + height) / 2;
	float ux = (ur.x + ur.width) / 2;
	float uy = (ur.y + ur.height) / 2;
	float dist = (cx - ux) * (cx - ux) + (cy - uy) * (cy - uy);
	if (dist <= 20000) {
		dx -= (int)3 * (cx - ux) / sqrt(dist);
		dy -= (int)3 * (cy - uy) / sqrt(dist);
	}
	else if (dist > 15000) {
		if (dx > 5) dx--;
		if (dx < -5)dx++;
		if (dy > 5) dy--;
		if (dy < -5)dy++;
	}
	AutoSprite::move(ur);
}