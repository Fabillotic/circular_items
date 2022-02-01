#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float GameTime;

out vec4 vertexColor;

#moj_import <hotbarstuff.glsl>

void main() {
	gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
	
	int id = gl_VertexID % 4;
	if(Position.z == 0 && Position.y > 336 && Position.y < 340) {
		int i = int((Position.x - 256.0 + 32 - 4) / 20.0);
		if(!(id < 2) && Position.x - 256.0 + 32 - 6 < 0.0) i--;
		i++;
		vec2 pos = vec2(Position.x - 20.0 * i + (i == 0 ? 10.0 : 0), Position.y);
		pos.x += -256.0 + 128.0 - 20.0;
		pos.y -= 256.0;
		vec2 o = moveCount(i) * 16;
		gl_Position = ProjMat * ModelViewMat * vec4(vec3(pos + o, Position.z), 1.0);
		vertexColor = Color;
		return;
	}
	
	vertexColor = Color;
}
