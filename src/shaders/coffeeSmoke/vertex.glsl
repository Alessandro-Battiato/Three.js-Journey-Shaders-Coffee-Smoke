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

    // Wind animation using the texture as to give randomness
    vec2 windOffset = vec2(
        texture(uPerlinTexture, vec2(0.25, uTime * 0.01)).r - 0.5, // r channel again, and vec2 takes 0.25 as for the x axis of the texture and uTime as the y axis, while the 0.5 subtracted after the .r makes it possible for the smoke to move both in the positive and negative x axis
        texture(uPerlinTexture, vec2(0.75, uTime * 0.01)).r - 0.5 // moves on the z axis
    );
    windOffset *= pow(uv.y, 3.0) * 10.0; // this value locks the lower bottom of the smoke above the coffee, and we use the pow function as to gradually release the smoke and let it be "hit  by the wind 
    newPosition.xz += windOffset;

    // Final position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);

    // Varyings
    vUv = uv;
}