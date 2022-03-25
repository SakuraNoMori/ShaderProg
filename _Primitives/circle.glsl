
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float cirlceEmpty(vec2 st,vec2 center,float r,float width)
{
	float dist=distance(st,center);
	return (dist<=r+width/2&&dist>=r-width/2)?1.:0.;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 color = vec3(0.);
	vec2 center=vec2(0.6,0.5);
	float radius=0.2;
	float width;
    color = vec3(cirlceEmpty(st,center,radius,0.15));

    gl_FragColor = vec4(color,1.0);
}