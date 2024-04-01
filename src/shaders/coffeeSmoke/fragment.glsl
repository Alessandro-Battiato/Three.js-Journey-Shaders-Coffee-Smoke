uniform sampler2D uPerlinTexture;

varying vec2 vUv;

void main() {
    // Smoke
    float smoke = texture(uPerlinTexture, vUv).r; // retrieve only the R channel out of the RGB

    // Final color
    gl_FragColor = vec4(smoke, smoke, smoke, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}