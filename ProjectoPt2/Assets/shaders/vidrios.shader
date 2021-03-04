Shader "ClaseCG/vidrios"
{
    Properties
    {
        _Ambientecito("Color ambiente", Color) = (1, 1, 1, 1)
        _Difusito("Color difuso", Color) = (1, 0, 0, 1)
        _Especularcito("Color especular", Color) = (1, 1, 1, 1)
        _ColorLuz("Color Luz 1", Color) = (1, 1, 1, 1)
        _Brillito("Coeficiente de brillo", Float) = 10
        _Box("Skybox", Cube) = ""
        _Coeficiente("coeficiente de refraccion", Float) = 0.5
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
        uniform sampler2D _Normalita;
        uniform float4 _ColorLuz;
        uniform samplerCUBE _Box;
        uniform float _Coeficiente;
        

        struct vInput {
            float4 pos : POSITION;

            float3 normal : NORMAL;
        };

        struct vOutput {

            float3 v : TEXCOORD1;
            // cosas que regresar:
            // - posición modificada
            float4 pos : SV_POSITION;

            // - normal
            float3 normal : NORMAL;
            float4 tex : TEXCOORD0;
        };


        vOutput vert(vInput input) {


            float4 result = UnityObjectToClipPos(input.pos);


            // sin(), cos()
            vOutput resultado;
            resultado.pos = result;
            resultado.normal = input.normal;


            float3 vertexGlobal = mul(input.pos, unity_ObjectToWorld).xyz;
            float3 haciaVista = _WorldSpaceCameraPos - vertexGlobal;
            resultado.v = normalize(haciaVista);


            return resultado;

            //return result;
        }

        float4 phong(float4 lColor, float3 normal, float3 vParam) {
            
            // Ambiental : ka * ia
            float4 ambiental = float4(0, 0, 0, 0);
            ambiental = _Ambientecito * lColor * 0.2;


            float3 l = normalize(_WorldSpaceLightPos0.xyz * -1);

            float3 n = normalize(mul(float4(normal, 0.0), unity_WorldToObject));


            float productito = max(0.0, dot(-l, n));

            float4 difuso = float4(0, 0, 0, 0);
            difuso = _Difusito * productito * lColor;

            float4 especular = float4(0, 0, 0, 0);

            float3 v = vParam;
            float3 r = reflect(-l, n);
            float productote = max(0.0, dot(v, r));

            float3 direccionReflejo = reflect(v, n);


            especular = _Especularcito * pow(productote, _Brillito) * lColor;


            return (ambiental + difuso + especular) * texCUBE(_Box, direccionReflejo);

        }


        float4 frag(vOutput input) : COLOR{


            float4 l1 = phong( _ColorLuz, input.normal, input.v);

            return l1;
            
        }

        ENDCG
        }
    }
    FallBack "Diffuse"
}
