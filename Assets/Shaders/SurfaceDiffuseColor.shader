Shader "Custom/SurfaceDiffuseColor"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1) // (r, g, b, a)
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM
            float4 _Albedo;

            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_MainTex;
            };  

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _Albedo;
            }            
        ENDCG
    }
}