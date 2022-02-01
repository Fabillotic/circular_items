#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

#moj_import <hotbarstuff.glsl>

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = cylindrical_distance(ModelViewMat, IViewRotMat * Position);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
	
	int id = (gl_VertexID + 1) % 4;
	const vec2[4] corners = vec2[4](vec2(0, 0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
	if(Position.z < 300.0 && Position.z > 150.0) {
		int i = int((Position.x - 256 + 32 - 4 - 4 - 1) / (24.0 - 4)) + int(id < 2) * 2 - 1;
		if(Position.x - 256 + 32 - 4 - 4 < 0.5) i--;
		if(corners[(gl_VertexID % 4)].y == 0) i-=2;
		i+=2;
		if(i <= 0) i = 0;
		vec2 o = moveCount(i) * 16;
		gl_Position = ProjMat * ModelViewMat * vec4(Position.xy - vec2(i * 20 - (i == 0 ? 8 : 0) + 256.0 - 128 + 16, 256.0) + o, Position.z, 1.0);
	}
}
