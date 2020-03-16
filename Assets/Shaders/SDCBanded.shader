Shader "Custom/Banded"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        _Steps("Banded Steps", Range(1, 100)) = 20
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

            #pragma surface surf Banded

            fixed4 _Albedo;
            fixed _Steps;

            half4 LightingBanded(SurfaceOutput s, half3 lightDir, half atten)
            {
                half NdotL = dot(s.Normal, lightDir);
                half lightBandsMultiplier = _Steps / 256;
                half lightBandsAdditive = _Steps / 2;
                fixed bandedLightModel = (floor((NdotL * 256  + lightBandsAdditive) / _Steps)) * lightBandsMultiplier;
                half4 c;
                c.rgb = s.Albedo * atten * _LightColor0.rgb * bandedLightModel;
                c.a = s.Alpha;
                return c;
            }


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