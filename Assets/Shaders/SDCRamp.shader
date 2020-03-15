Shader "Custom/Ramp"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        _RampTex("RampTex", 2D) = "white"{}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM
            #pragma surface surf Ramp

            half4 _Albedo;
            sampler2D _RampTex;

            half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
            {
                half NdotL = dot(s.Normal, lightDir);
                half diff = NdotL * 0.5 + 0.5;
                float2 uv_RampTex = float2(diff, 0);
                half3 rampColor = tex2D(_RampTex, uv_RampTex).rgb;
                half4 c;
                c.rgb = s.Albedo * rampColor * _LightColor0.rgb * atten;
                c.a = s.Alpha;
                return c;
            }

            struct Input 
            {
                float a;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _Albedo;
            }
        ENDCG
    }
}