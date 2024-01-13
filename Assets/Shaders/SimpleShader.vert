#version 410 core

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

layout (row_major) uniform UniformData
{
	mat4 world;
	mat4 projection;
};


layout(location = 0) in vec3 position;
layout(location = 1) in vec2 texcoord;

layout(location = 0) out vec3 vertOutColor;

void main()
{
	vec4 pos = vec4(position,1) * world;
	pos = pos * projection;

	gl_Position = pos;


	float pct = abs(sin(u_time));

	vertOutColor = vec3(texcoord.x,texcoord.y,0.5);
}