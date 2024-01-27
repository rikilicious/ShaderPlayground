//
//  Shaders.metal
//  ShaderPlayground
//
//  Created by Ricardo Gonzalez on 2024-01-21.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

float2 rotatedBy(float2 thingy, float a) {
    float2x2 rotation = float2x2(cos(a), -sin(a), sin(a), cos(a));

    return thingy * rotation;
}
half3 palette(float t, half3 a, half3 b, half3 c, half3 d) {
    return a + b * cos(6.28318 * (c*t*d));
}

half3 coolPalette(float t) {
    half3 a = half3(0.5, 0.5, 0.5);
    half3 b = half3(0.5, 0.5, 0.5);
    half3 c = half3(1.0, 1.0, 1.0);
    half3 d = half3(0.263, 0.416, 0.557);
    return palette(t, a, b, c, d);
}

[[ stitchable ]] half4 wip(float2 position, half4 currentColor, float time, float2 size) {
    float2 uv = (position / size) - 0.5;
    half3 finalColor = half3(0);
    uv *= 3 + sin(time / 10);

    uv.x *= size.x / size.y;
    float2 uv0 = uv;

    for (float i = 0.0; i < 4.0; i++) {
        uv = fract(uv * 1.5) - 0.5;
        float d = length(uv) * exp(-length(uv0));
        half3 color = coolPalette(length(uv0) + i * 0.4 + time);
        d = sin(d * 8 + time) / 8;
        d = abs(d);
        d = pow(0.01 / d, 1.2);

        finalColor += color * d;
    }


    return half4(finalColor, 1.0); // * currentColor;
}
