uniform sampler2D texture;
uniform vec2 textureSize;
uniform float power; 

void main() {
    vec2 uv = gl_TexCoord[0].xy;
    vec2 off = vec2(power) / textureSize;
    
    vec4 c = texture2D(texture, uv);
    c += texture2D(texture, uv + vec2(off.x, 0.0));
    c += texture2D(texture, uv - vec2(off.x, 0.0));
    c += texture2D(texture, uv + vec2(0.0, off.y));
    c += texture2D(texture, uv - vec2(0.0, off.y));
    
    gl_FragColor = (c / 5.0) * gl_Color;
}
