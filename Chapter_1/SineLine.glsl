
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float offset_max=0.5;
float offset_Left=0.005;
float line_center=0.5;
float line_width=0.002;



void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    
    float line_width=0.001;
    float smooth_=line_width+0.01;
    float offset_line=0.5;
    float size_sine=0.2;
    float speed_sine=5.;
    float frequency=60.;
    
    // Calculate the line with threshold between line_width and smooth
    float c=1.-smoothstep(line_width,smooth_,abs(st.y-offset_line-size_sine*sin(u_time*speed_sine+st.x*frequency)*st.x));

    float base_c=0.5*(sin(u_time)+1.);
    vec3 color = c*vec3(base_c+0.8,0.,base_c);
    gl_FragColor = vec4(color,1.0);
}