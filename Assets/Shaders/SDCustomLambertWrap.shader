Shader "Custom/LambertWrap"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1) //rgba
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM
            #pragma surface surf LambertWrap

            half4 LightingLambertWrap(SurfaceOutput s, half3 lightDir, half atten)
            {
                half NdotL = dot(s.Normal, lightDir);
                half diff = NdotL * 0.5 + 0.5;
                half4 c;
                c.rgb = diff * _LightColor0.rgb * s.Albedo * atten;
                c.a = s.Alpha;
                return c;
            }

            half4 _Albedo;

            struct Input
            {
                fixed a;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _Albedo.rgb;
            }
        ENDCG
    }
}