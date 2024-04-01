uniform float uTime;
uniform sampler2D uPerlinTexture;

varying vec2 vUv;

void main() {
    // Scale and animate
    vec2 smokeUv = vUv;
    smokeUv.x *= 0.5; // picks half of the texture on the x axis
    smokeUv.y *= 0.3; // picks 0.3 of the texture on the y axis
    smokeUv.y -= uTime * 0.03;

    // Smoke
    float smoke = texture(uPerlinTexture, smokeUv).r; // retrieve only the R channel out of the RGB

    // Final color
    gl_FragColor = vec4(1.0, 1.0, 1.0, smoke);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}