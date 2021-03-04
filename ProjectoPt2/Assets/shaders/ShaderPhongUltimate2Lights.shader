Shader "ClaseCG/ShaderTexture"
{
    Properties
    {
        _Ambientecito("Color ambiente", Color) = (1, 1, 1, 1)
        _Difusito("Color difuso", Color) = (1, 0, 0, 1)
        _Especularcito("Color especular", Color) = (1, 1, 1, 1)
        _Brillito("Coeficiente de brillo", Float) = 10
        _Texturita("Textura", 2D) = "white" {}
        _Lucecita("Luz", Vector) = (0, 0, 0, 0)
        _Lucecita2("Luz2", Vector) = (0, 0, 0, 0)
        _NumLuces("Numero de luces", Float) = 1
    }
        SubShader
    {
        Pass {

        CGPROGRAM

        // definir 2 shaders
        // vertex shader 
        // fragment shader

        // hay que avisarle al compilador como se llaman
        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"

        // cuando recibamos variables del exterior hay que declarar
        // una variable local del mismo nombre con el modificador uniform
        uniform float4 _Ambientecito;
        uniform float4 _Difusito;
        uniform float4 _LightColor0;
        uniform sampler2D _Texturita;
        uniform float _Brillito;
        uniform float4 _Especularcito;
        uniform float4 _Lucecita;
        uniform float4 _Lucecita2;
        uniform float _NumLuces;
        
        // como definir varios valores de entrada
        // struct - como un objeto pero mas elemental, sólo datos
        struct vInput {
            float4 pos : POSITION;
            // vector normal - vector que apunta hacia "adelante" o
            // "afuera"
            // chequen normalize
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
        };

        struct vOutput {

            // cosas que regresar:
            // - posición modificada
            float4 pos : SV_POSITION;

            // - normal
            float3 normal : NORMAL;
            float4 tex : TEXCOORD0;
        };

        vOutput vert(vInput input) {

            float4 result = UnityObjectToClipPos(input.pos);

            vOutput resultado;
            resultado.pos = result;
            resultado.normal = input.normal;
            resultado.tex = input.texcoord;

            return resultado;

        }

        // fragment shader - regresa un color de un fragmento
        float4 frag(vOutput input) : COLOR{

            float4 ambiental = float4(0, 0, 0, 0);
            ambiental = _Ambientecito * _LightColor0 * 0.5;

            float3 l = normalize(_WorldSpaceLightPos0.xyz);
            float3 n = normalize(mul(float4(input.normal, 0), unity_WorldToObject));

            float4 difuso = float4(0, 0, 0, 0);
            difuso = _Difusito * _LightColor0 * max(0.0, dot(n, l));
            

            // Especular : ks (R . V)**a is
            float4 especular = float4(0, 0, 0, 0);
            
            float3 r = normalize(reflect(-l,n));
            float3 v = normalize(_Lucecita.xyz - input.pos.xyz);
            especular = _Especularcito * _LightColor0 * pow(max(0.0, dot(r,v)), _Brillito);

            if(_NumLuces == 2){
                float4 ambiental2 = float4(0, 0, 0, 0);
                ambiental2 = _Ambientecito * _LightColor0 * 0.5;

                float3 l2 = normalize(_Lucecita2.xyz);
                float3 n2 = normalize(mul(float4(input.normal, 0), unity_WorldToObject));

                float4 difuso2 = float4(0, 0, 0, 0);
                difuso2 = _Difusito * _LightColor0 * max(0.0, dot(n2, l2));

                float4 especular2 = float4(0, 0, 0, 0);
            
                float3 r2 = normalize(reflect(-l2,n2));
                float3 v2 = normalize(_Lucecita2.xyz - input.pos.xyz);
                especular2 = _Especularcito * _LightColor0 * pow(max(0.0, dot(r2,v2)), _Brillito);


                return (ambiental + difuso + especular) + tex2D(_Texturita, input.tex.xy) + (ambiental2 + difuso2 + especular2);
            } else{
                return ambiental + difuso + especular + tex2D(_Texturita, input.tex.xy);
            }
            
            
        }

        ENDCG
        }
    }
    FallBack "Diffuse"
}
