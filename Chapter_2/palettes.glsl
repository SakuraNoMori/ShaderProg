
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

	vec3 colorBG=vec3(1.);
	float var=st.x;
	vec3 brightness=vec3(0.3);
	vec3 contrast=vec3(0.25,0.5,0.75);
	vec3 frequency=vec3(1.,0.66,0.33);
	vec3 phase=vec3(0.2,0.8,0.5);

    vec3 colorP1;
    if(st.y>0.5)
        {
        colorP1 = palette(
	var,
	brightness*sin(u_time),
	contrast,
	frequency,
	phase);
    }
    if(st.y<0.5)
        {
        colorP1 = palette(
	var,
	brightness,
	contrast,
	frequency,
	phase);
    }
    //vec3 colorP1 = vec3(st.x,st.y,abs(sin(u_time)));

    vec3 color = mix(colorBG,colorP1,0.8);

    gl_FragColor = vec4(color,1.0);
}