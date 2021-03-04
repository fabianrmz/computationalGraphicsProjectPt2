Shader "Custom/humanShader"
{

    Properties
    {
        _Textura("Textura", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        _Velocidad("Velocidad de animacion", Range(0, 3)) = 0
        _Offset("Offset", Range(0 ,10)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"

        fixed4 _Color;
        uniform float _Velocidad;
        uniform float _Offset;

        struct vInput {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
        };

        struct vOutput {
            float2 uv : TEXCOORD0;
            float4 vertex : SV_POSITION;
        };

        vOutput vert (vInput input) {
            vOutput result;
            input.vertex.x += sin(_Time.y * _Velocidad + input.vertex.y * _Offset);
            result.vertex =  UnityObjectToClipPos(input.vertex);
            result.uv = input.uv;
            return result;
        }
    
        fixed4 frag (vOutput input) : SV_Target{
            fixed2 p = -1.0f + 2.0f * input.uv.xy; 
            fixed x = p.x;
            fixed y = p.y;

            fixed mov0 = x + y + cos(sin(_Time.y) * 2.0) * 100. + sin(x/100.) * 1000.;
            fixed mov1 = y / 0.9 +  _Time.y;
            fixed mov2 = x / 0.2;

            fixed c1 = abs(sin(mov1+_Time.y)/2. + mov2/2. - mov1 - mov2 + _Time.y);
            fixed c2 = abs(sin(c1 + sin(mov0/1000. + _Time.y) + sin(y/40. + _Time.y) + sin((x + y)/100.) * 3.));
            fixed c3 = abs(sin(c2 + cos(mov1 + mov2 + c2) + cos(mov2) + sin(x/1000.)));

            return fixed4(c1,c2,c3,1);
            //Inv colors
            // return fixed4(1-c1,1-c2,1-c3,1);
        }

        ENDCG
        }
    }
    FallBack "Diffuse"
}
