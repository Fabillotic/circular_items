#version 150

#define PI 3.141592653589
//Hard-coded location of the items and selection
#define itemX 27.5
#define itemY 17.0
//Hard-coded location of the count text and durability
#define textX 370.0
#define textY 208.25

uniform vec2 ScreenSize;

vec3 moveItem(vec3 Position) {
	float f = ((ModelViewMat[3][0] * 16.0) - ScreenSize.x / 2.0) / 20.0;
	int i = int((f - 120.0) / 16.0);
	float o = 0.0;
	if(i != 0) {
		o = ((i - 1) * 1.25) + 0.25;
	}
	else {
		o = -1.5 - (1 / 16.0);
	}
	vec3 pos = vec3((Position.x - 12.5) - 1.75 - o, (Position.y + 20.0), Position.z); //General (0;0) kinda vector
	
	pos += vec3(itemX, -itemY, 0.0);

	if(i > 0) {
		float a = (i - 1) * (2 * PI / 9);
		pos.x += sin(a) * 2;
		pos.y += cos(a) * 2;
	}
	
	return pos;
}

vec2 moveSelection(int i) {
	float a = i * (2 * PI / 9);
	return vec2(itemX + sin(a) * 2, itemY - cos(a) * 2);
}

vec2 moveCount(int i) {
	if(i == 0) return vec2(0);
	i--;
	float a = i * (2 * PI / 9);
	return vec2(sin(a) * 2, -cos(a) * 2);
}
