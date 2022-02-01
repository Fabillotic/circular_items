#version 150

#moj_import <colors.glsl>

#define PI 3.141592653589

in vec3 Position;
in vec2 UV0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform sampler2D Sampler0;
uniform float GameTime;

out vec2 texCoord0;

#moj_import <hotbarstuff.glsl>

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
	
	//Hotbar selection
	if(cmatch(texture(Sampler0, vec2(231 / 256.0, 24 / 256.0)), vec4(221 / 256.0, 50 / 256.0, 50 / 256.0, 1.0))) {
		vec2 uv = floor(UV0 * 256);
		int id = (gl_VertexID + 1) % 4;
		const vec2[4] corners = vec2[4](vec2(0, 0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
		if((uv.y > 22 || (uv.y == 22 && (id == 0 || id == 3))) && (uv.x < 24 || (uv.x == 24 && id > 1)) && uv.y < 45) {
			int i = int((Position.x - 256 + 32 - 4 - 4) / (24.0 - 4)) + int(id < 2) * 2 - 1;
			if(Position.x - 256 + 32 - 4 - 4 < 0.5) i -= 1;
			vec2 p = vec2(Position.x - 256 + 32 - 4 - 4 - (i * 20.0), Position.y - 256.0 - 64);
			vec2 m = p - corners[id] * 24.0 + vec2(12.0);
			vec2 c = corners[id] * 2 - 1;
			float a = i * (2 * PI / 9);
			c *= mat2(cos(a), -sin(a), sin(a), cos(a));
			p = m + ((c + 1) / 2) * 24.0 - vec2(12.0);
			vec2 o = moveSelection(i) * 16.0;
			gl_Position = ProjMat * ModelViewMat * vec4(p + o, Position.z, 1.0);
		}
		else if((uv.y < 22 || (uv.y == 22 && (id == 1 || id == 2))) && uv.x < 183) {
			gl_Position = vec4(0.0);
		}
		else if((uv.y > 22 || (uv.y == 22 && (id == 0 || id == 3))) && (uv.y < 46 || (uv.y == 46 && (id == 1 || id == 2))) && (uv.x > 24 || (uv.x == 24 && id < 2))) {
			gl_Position = vec4(0.0);
		}
	}

    texCoord0 = UV0;
}
