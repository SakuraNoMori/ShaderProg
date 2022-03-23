
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rectangleIF(vec2 st, vec2 left_up, vec2 right_down)
{
	if(st.x>left_up.x&&st.x<right_down.x&&st.y<left_up.y&&st.y>right_down.y)
	return 0.;
	else
	return step(0.5,0.7);
}

vec3 rectangle(vec2 st, vec2 p1, vec2 p2)
{
	return 1.-
	(1.-step(vec3(max(p2.x,p1.x)),vec3(st.x)))*
	(step(vec3(min(p2.x,p1.x)),vec3(st.x)))*
	(1.-step(vec3(max(p2.y,p1.y)),vec3(st.y)))*
	(step(vec3(min(p2.y,p1.y)),vec3(st.y)))
	;
}

vec3 rectangleColor(vec3 c,vec2 st, vec2 p1, vec2 p2)
{
	return c*
	(1.-step(vec3(max(p2.x,p1.x)),vec3(st.x)))*
	(step(vec3(min(p2.x,p1.x)),vec3(st.x)))*
	(1.-step(vec3(max(p2.y,p1.y)),vec3(st.y)))*
	(step(vec3(min(p2.y,p1.y)),vec3(st.y)))
	;
}
vec3 rectangleSmoothColor(vec3 c,vec2 st, vec2 p1, vec2 p2, float t)
{
	return c*
	(1.-smoothstep(vec3(max(p1.x,p2.x)-t/2),vec3(max(p1.x,p2.x)+t/2),vec3(st.x)))*
	(smoothstep(vec3(min(p1.x,p2.x)-t/2),vec3(min(p1.x,p2.x)+t/2),vec3(st.x)))*
	(1.-smoothstep(vec3(max(p1.y,p2.y)-t/2),vec3(max(p1.y,p2.y)+t/2),vec3(st.y)))*
	(smoothstep(vec3(min(p1.y,p2.y)-t/2),vec3(min(p1.y,p2.y)+t/2),vec3(st.y)))
	;
}

vec3 rectangleSmooth(vec2 st, vec2 p1, vec2 p2,float t)
{
	return 1.-
	(1.-smoothstep(vec3(max(p1.x,p2.x)-t/2),vec3(max(p1.x,p2.x)+t/2),vec3(st.x)))*
	(smoothstep(vec3(min(p1.x,p2.x)-t/2),vec3(min(p1.x,p2.x)+t/2),vec3(st.x)))*
	(1.-smoothstep(vec3(max(p1.y,p2.y)-t/2),vec3(max(p1.y,p2.y)+t/2),vec3(st.y)))*
	(smoothstep(vec3(min(p1.y,p2.y)-t/2),vec3(min(p1.y,p2.y)+t/2),vec3(st.y)))
	;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //st.x *= u_resolution.x/u_resolution.y;

	//Code for testing
	/*
	vec3 cBG=vec3(1.,1.,1.);
	float thresh=0.2;

	vec2 ld=vec2(0.2,0.8);
	vec2 ru=vec2(0.55,0.1);
	vec3 rectC=vec3(0.9,0.,0.9);
	vec3 rectSC=vec3(1.-st.x,0.0,1.-st.y);
	//vec3 color = vec3(rectangleIF(st,ld,ru));
	//vec3 color = vec3(rectangle(st,ld,ru));
	//vec3 color = vec3(rectangleColor(rectC,st,ld,ru));
	vec3 color = rectangleSmooth(st,ld,ru,thresh);
	//vec3 color = rectangleSmoothColor(rectC,st,ld,ru,thresh);
	
    //gl_FragColor = vec4(mix(color,cBG,vec3(rectangle(st,ld,ru))),1.0);

	//colorF=
    //gl_FragColor = vec4(color,1.0);
    gl_FragColor = vec4(mix(color,cBG,vec3(rectangleSmooth(st,ld,ru,thresh))),1.0);
	*/

	//Code for shaping
	vec3 cBG=vec3(1.,1.,1.);
	vec3 colorF;
	vec3 colorr1=vec3(0.5,0.,0.5);
	vec3 colorr2=vec3(0.,0.5,0.5);
	vec3 colorr3=vec3(0.5,0.5,0.);
	vec3 colorr4=vec3(1.,1.,1.);
	vec3 colorr5=vec3(0.25,0.5,0.75);

	float r1t=0.2;
	float r2t=0.2;
	float r3t=0.2;
	float r4t=0.2;
	float r5t=0.2;

	vec2 r1p1=vec2(0.1,0.9);
	vec2 r1p2=vec2(0.2,0.8);
	vec2 r2p1=vec2(0.2,0.8);
	vec2 r2p2=vec2(0.3,0.7);
	vec2 r3p1=vec2(0.3,0.7);
	vec2 r3p2=vec2(0.4,0.6);
	vec2 r4p1=vec2(0.4,0.65);
	vec2 r4p2=vec2(0.55,0.45);
	vec2 r5p1=vec2(0.5,0.5);
	vec2 r5p2=vec2(0.6,0.4);

	colorF=rectangleColor(colorr1,st,r1p1,r1p2);
	colorF+=mix(colorF,rectangleColor(colorr2,st,r2p1,r2p2),0.5);
	colorF+=mix(colorF,rectangleColor(colorr3,st,r3p1,r3p2),0.5);
	colorF+=mix(colorF,rectangleColor(colorr4,st,r4p1,r4p2),0.5);
	colorF+=mix(colorF,rectangleColor(colorr5,st,r5p1,r5p2),0.5);

	gl_FragColor=vec4(colorF,1.);
}