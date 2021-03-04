Shader "Custom/crashShader"
{
    Properties{
        _Textura("Textura", 2D) = "white" {}
        _PuntoGolpe("Punto de Impacto", Vector) = (0, 0, 0, 0)
        _Color("Color", Color) = (0,0,0,0)
        _Brillo("Brillo", Range(0, 5)) = 0
        _Contraste("Contraste", Range(0, 5)) = 0
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            uniform sampler2D _Textura;
            uniform float4 _PuntoGolpe;
            uniform float4 _Color;
            uniform float _Brillo;
            uniform float _Contraste;

            struct vInput {
                float4 pos : POSITION;
                float4 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };
            
            struct vOutput {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            vOutput vert(vInput input) {
                vOutput resultado;
                input.pos.xyz += input.normal.xyz * 10.6 * _Time.y;
                resultado.pos = UnityObjectToClipPos(input.pos);
                resultado.uv = input.uv;
                return resultado;
            }
            
            float4 frag(vOutput input) : COLOR{
                return pow(tex2D(_Textura, input.uv)* _Color, _Contraste) * _Brillo;
            }

            ENDCG
        }
    }
}
