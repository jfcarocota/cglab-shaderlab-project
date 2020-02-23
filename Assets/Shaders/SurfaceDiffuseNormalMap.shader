Shader "Custom/SurfaceDiffuseNormalMap"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        _MainTex("Main Texture", 2D) = "white" {}
        _BumpMap("Normal Map", 2D) = "bump" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

            half4 _Albedo;
            sampler2D _MainTex;
            sampler2D _BumpMap;

            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_MainTex;
                float2 uv_BumpMap;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                half4 texColor = tex2D(_MainTex, IN.uv_MainTex);
                half4 bumpColor = tex2D(_BumpMap, IN.uv_BumpMap);

                o.Albedo = texColor.rgb * _Albedo;
                o.Normal = UnpackNormal(bumpColor);
            }
        ENDCG
    }
}