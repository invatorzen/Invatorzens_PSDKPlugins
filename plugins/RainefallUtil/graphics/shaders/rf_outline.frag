uniform sampler2D texture;
uniform vec2 textureSize;
uniform vec4 outlineColor;
uniform float width;

void main() {
    vec2 uv = gl_TexCoord[0].xy;
    vec2 size = vec2(width) / textureSize;
    vec4 center = texture2D(texture, uv);
    
    if (center.a > 0.0) {
        gl_FragColor = center * gl_Color;
        return;
    }
    
    float alpha = 0.0;
    alpha += texture2D(texture, uv + vec2(-size.x, 0.0)).a;
    alpha += texture2D(texture, uv + vec2(size.x, 0.0)).a;
    alpha += texture2D(texture, uv + vec2(0.0, -size.y)).a;
    alpha += texture2D(texture, uv + vec2(0.0, size.y)).a;
    
    if (alpha > 0.0) {
        gl_FragColor = outlineColor * gl_Color;
    } else {
        gl_FragColor = vec4(0.0);
    }
}
