Shader "ClaseCG/ToonShader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Ambientecito("Color ambiente", Color) = (1, 1, 1, 1)
        _Difusito("Color difuso", Color) = (1, 0, 0, 1)
        _Especularcito("Color especular", Color) = (1, 1, 1, 1)
        _Brillito("Coeficiente de brillo", Float) = 10
        _Detail("Detalle", Range(0,1)) = 0.3
        _Lucecita("Luz", Vector) = (0, 0, 0, 0)
        _Lucecita2("Luz2", Vector) = (0, 0, 0, 0)
        _NumLuces("Numero de luces", Float) = 1

        _OutlineColor("Color borde", Color) = (1, 1, 1, 1)
        _OutlineGrosor("Grosor borde", Range(0, 1)) = 0.716
    }
        SubShader
    {
        Pass {

        Tags
            {
	            "LightMode" = "ForwardBase"
	            "PassFlags" = "OnlyDirectional"
            }

        CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"


        uniform float4 _Ambientecito;
        uniform float4 _Difusito;
        uniform float4 _LightColor0;
        uniform float4 _Lucecita;
        uniform float4 _Lucecita2;
        uniform float _NumLuces;
        float _Detail;
        float4 _OutlineColor;
        float _OutlineGrosor;
        
        struct vInput {
            float4 pos : POSITION;
            float3 normal : NORMAL;
        };

        struct vOutput {
            float4 pos : SV_POSITION;
            float3 normal : NORMAL;
            float3 viewDir : TEXCOORD1;
        };

        vOutput vert(vInput input) {

            float4 result = UnityObjectToClipPos(input.pos);

            vOutput resultado;
            resultado.pos = result;
            resultado.normal = input.normal;
            resultado.viewDir = WorldSpaceViewDir(input.pos);
            return resultado;
        }

        float4 frag(vOutput input) : COLOR{

            float4 ambiental = float4(0, 0, 0, 0);
            ambiental = _Ambientecito * _LightColor0 * 0.5;

            float3 l = normalize(_Lucecita.xyz);

            float3 n = normalize(mul(float4(input.normal, 0), unity_WorldToObject));

            float4 difuso = float4(0, 0, 0, 0);
            float NdotL = floor(max(0.0, dot(n, l)) / _Detail);
            difuso = _Difusito * _LightColor0 * NdotL;

            float4 especular = float4(0, 0, 0, 0);

            float3 viewDir = normalize(input.viewDir);

            float outline = 1 - dot(n, viewDir);
            float rimInt = smoothstep(_OutlineGrosor - 0.01, _OutlineGrosor + 0.01, outline);
            float4 borde = rimInt * _OutlineColor;

            if(_NumLuces == 2){
                 float4 ambiental2 = float4(0, 0, 0, 0);
                ambiental2 = _Ambientecito * _LightColor0 * 0.5;

                float3 l2 = normalize(_Lucecita2.xyz);

                float3 n2 = normalize(mul(float4(input.normal, 0), unity_WorldToObject));

                float4 difuso2 = float4(0, 0, 0, 0);
                float NdotL2 = floor(max(0.0, dot(n2, l2)) / _Detail);
                difuso2 = _Difusito * _LightColor0 * NdotL2;

                float4 especular2 = float4(0, 0, 0, 0);

                return (ambiental + difuso + especular) + borde + (ambiental2 + difuso2 + especular2);
            } else{
                return ambiental + difuso + especular + borde;
            }

        }

       
        ENDCG
        }
    }
    FallBack "Diffuse"
}
