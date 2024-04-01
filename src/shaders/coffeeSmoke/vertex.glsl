uniform float uTime;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;

vec2 rotate2D(vec2 value, float angle)
{
    float s = sin(angle);
    float c = cos(angle);
    mat2 m = mat2(c, s, -s, c);
    return m * value;
}

void main() {
    vec3 newPosition = position; // you can't change directly an attribute, so position is changed using another variable

    // Twist
    // The following twist perlin value picks, for each vertex, a point on the y axis of the texture of this project and when the axis ends, it begins once again, and as such we are introducing some randomness
    float twistPerlin = texture(
        uPerlinTexture, 
        vec2(0.5, uv.y * 0.2 - uTime * 0.005) // the uTime animates everything
        ).r; // we use the r channel
    float angle = twistPerlin * 10.0; // elevation
    newPosition.xz = rotate2D(newPosition.xz, angle);

    // Final position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);

    // Varyings
    vUv = uv;
}