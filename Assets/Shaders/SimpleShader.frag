#version 410 core

layout(location = 0) in vec3 vertOutColor;
layout(location = 0) out vec4 outColor;

void main()
{
    vec3 neonColor = vec3(0.4, 0.8, 0.9); // Soft blue-green color
    float intensity = 1.5; // Neon intensity

    // Apply neon effect by boosting the color intensity
    vec3 baseColor = vertOutColor * intensity;

    // Adjust the mix factor to control the balance between base color and neon color
    outColor.rgb = mix(baseColor, neonColor, 0.5);
    outColor.a = 1.0;

    // Optional: Add a threshold to avoid overly bright pixels
    outColor.rgb = max(outColor.rgb, vec3(0.0));
    outColor.rgb = min(outColor.rgb, vec3(1.0));
}
