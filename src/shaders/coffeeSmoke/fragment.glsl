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

    // Remap using smoothstep which returns a clamped value between 0 and 1
    smoke = smoothstep(0.4, 1.0, smoke); // first parameter is the bottom value where it begins and then it eases until the end using the second parameter

    // Edges of the texture, left and right side
    smoke *= smoothstep(0.0, 0.1, vUv.x);
    smoke *= smoothstep(1.0, 0.9, vUv.x);
    smoke *= smoothstep(0.0, 0.1, vUv.y);
    smoke *= smoothstep(1.0, 0.4, vUv.y);

    // Final color
    gl_FragColor = vec4(0.3, 0.2, 0.1, smoke);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}