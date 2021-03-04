Shader "ClaseCG/Shadercito"
{
    Properties
    {
        _Ambientecito("Color ambiente", Color) = (1, 1, 1, 1)
        _Difusito("Color difuso", Color) = (1, 0, 0, 1)
        _Especularcito("Color especular", Color) = (1, 1, 1, 1)
        _ColorLuz("Color Luz 1", Color) = (1, 1, 1, 1)
        _ColorLuz2("Color Luz 2", Color) = (1, 1, 1, 1)
        _ColorLuz3("Color Luz 2", Color) = (1, 1, 1, 1)
        _ColorLuz4("Color Luz 2", Color) = (1, 1, 1, 1)
        _ColorLuz5("Color Luz 2", Color) = (1, 1, 1, 1)
        _Brillito("Coeficiente de brillo", Float) = 10
        _Texturita("Textura", 2D) = "white"
        _Normalita("Mapa normal", 2D) = "white"
        _Luz("Luz", Vector) = (0, 0, 0, 0)
        _Luz2("Luz 2", Vector) = (0, 0, 0, 0)
        _Luz3("Luz 3", Vector) = (0, 0, 0, 0)
        _Luz4("Luz 4", Vector) = (0, 0, 0, 0)
        _Luz5("Luz 5", Vector) = (0, 0, 0, 0)
    }
        SubShader
    {
        Pass {

        CGPROGRAM


        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"

        uniform float4 _Ambientecito;
        uniform float4 _Difusito;
        uniform float4 _Especularcito;
        uniform float _Brillito;
        uniform float4 _LightColor0;
        uniform sampler2D _Texturita;
        uniform sampler2D _Normalita;
        uniform float4 _Luz;
        uniform float4 _Luz2;
        uniform float4 _Luz3;
        uniform float4 _Luz4;
        uniform float4 _Luz5;
        uniform float4 _ColorLuz;
        uniform float4 _ColorLuz2;
        uniform float4 _ColorLuz3;
        uniform float4 _ColorLuz4;
        uniform float4 _ColorLuz5;
        

        struct vInput {
            float4 pos : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
        };

        struct vOutput {

            float3 v : TEXCOORD1;
            float3 l3 : TEXCOORD2;
            float3 l4 : TEXCOORD4;
            float3 l5 : TEXCOORD5;
            float3 l6 : TEXCOORD6;
            float3 l7 : TEXCOORD7;

            float4 pos : SV_POSITION;

            float3 normal : NORMAL;
            float4 tex : TEXCOORD0;
        };

        vOutput vert(vInput input) {

            float4 result = UnityObjectToClipPos(input.pos);
            
            vOutput resultado;
            resultado.pos = result;
            resultado.normal = input.normal;
            resultado.tex = input.texcoord;

            float3 vertexGlobal = mul(input.pos, unity_ObjectToWorld).xyz;
            float3 haciaVista = _WorldSpaceCameraPos - vertexGlobal;
            resultado.v = normalize(haciaVista);

            resultado.l3 = normalize(_Luz.xyz + vertexGlobal+15);
            resultado.l4 = normalize(_Luz2.xyz + vertexGlobal+15);
            resultado.l5 = normalize(_Luz3.xyz + vertexGlobal+15);
            resultado.l6 = normalize(_Luz4.xyz + vertexGlobal+15);
            resultado.l7 = normalize(_Luz5.xyz + vertexGlobal+15);
            

            return resultado;
        }

        float4 phong(float3 l3Param, float4 lColor, float3 normal, float4 tex, float3 vParam) {
            
            float4 ambiental = float4(0, 0, 0, 0);
            ambiental = _Ambientecito * lColor * 0.2;

            float3 l3 = normalize(l3Param);

            float3 n3 = normalize(tex2D(_Normalita, tex.xy));

            float productito = max(0.0, dot(l3, n3));

            float4 difuso = float4(0, 0, 0, 0);
            difuso = _Difusito * productito * lColor;

            float4 especular = float4(0, 0, 0, 0);

            float3 v = normalize(l3.xyz - normal.xyz);
            float3 r = normalize(reflect(-l3, n3));
            float productote = max(0.0, dot(v, r));

            especular = _Especularcito * pow(productote, _Brillito) * lColor;

            
            return (ambiental + difuso + especular) * tex2D(_Texturita, tex.xy);

        }

      
        float4 frag(vOutput input) : COLOR{


            float4 l1 = phong(input.l3, _ColorLuz, input.normal, input.tex, input.v);
            float4 l2 = phong(input.l4, _ColorLuz2, input.normal, input.tex, input.v);
            float4 l3 = phong(input.l5, _ColorLuz3, input.normal, input.tex, input.v);
            float4 l4 = phong(input.l6, _ColorLuz4, input.normal, input.tex, input.v);
            float4 l5 = phong(input.l7, _ColorLuz5, input.normal, input.tex, input.v);

            return l1 * 0.2 + l2 * 0.2 + l3 * 0.2 + l4 * 0.2 + l5 * 0.2;
            
        }

        ENDCG
        }
    }
    FallBack "Diffuse"
}