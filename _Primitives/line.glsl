
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// obsoletize Coor?
float plotLine(vec2 Coor, float degree, float offset,float width)
    {
    float a;
    float b = offset/10.;
    float c;
    if(degree==0.)
        {
        a=1.;
        c=0.;
    }
    else if(abs(degree)==90.)
        {
        a=0.;
        c=1.;
    }
    else
        {
        a=atan(radians(degree));
        c=atan(radians(90.-degree));
    }
    float function =a*Coor.x+b-c*Coor.y;
    return step(max(0.,width/100.),abs(function));
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 color = vec3(0.);
    vec3 colorline = vec3(0.);
	//vec3 colorBG=vec3(st.x,st.y,st.x-st.y);
	vec3 colorBG=vec3(1.,1.,1.);
	//Test setting of color (with more lines??)
    colorline = vec3(plotLine(st,15.0,5.0,1.0));
	color=colorBG*colorline;
    gl_FragColor = vec4(color,1.0);
}