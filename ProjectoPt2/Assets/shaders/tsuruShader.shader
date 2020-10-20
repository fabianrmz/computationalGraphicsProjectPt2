Shader "Custom/tsuruShader"
{
    Properties
    {
        _Ambientecito("Color ambiente", Color) = (1, 1, 1, 1)
        _Difusito("Color difuso", Color) = (1, 0, 0, 1)
        _Especularcito("Color especular", Color) = (1, 1, 1, 1)
        _ColorLuz("Color Luz 1", Color) = (1, 1, 1, 1)
        _ColorLuz2("Color Luz 2", Color) = (1, 1, 1, 1)
        _Brillito("Coeficiente de brillo", Float) = 10
        _Texturita("Textura", 2D) = "white"
        _Normalita("Mapa normal", 2D) = "white"
        _Lucecita("Luz", Vector) = (0, 0, 0, 0)
        _Lucecita2("Luz 2", Vector) = (0, 0, 0, 0)
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
        uniform float4 _Especularcito;
        uniform float _Brillito;
        uniform float4 _LightColor0;
        uniform sampler2D _Texturita;
        uniform sampler2D _Normalita;
        uniform float4 _Lucecita;
        uniform float4 _Lucecita2;
        uniform float4 _ColorLuz;
        uniform float4 _ColorLuz2;
        
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

            float3 v : TEXCOORD1;
            float3 l3 : TEXCOORD2;
            float3 l4 : TEXCOORD3;
            // cosas que regresar:
            // - posición modificada
            float4 pos : SV_POSITION;

            // - normal
            float3 normal : NORMAL;
            float4 tex : TEXCOORD0;
        };

        // float4 - vector tamaño 4 de floats
        // existen los tipos regulares 
        // SEMANTICS - le indican a GPU como interpretar un dato
        // vertex shader - regresa posición con modificación
        vOutput vert(vInput input) {

            //float4 modPos = float4(input.pos.x, input.pos.y, input.pos.z, input.pos.w);


            float4 result = UnityObjectToClipPos(input.pos);

            vOutput resultado;
            resultado.pos = result + cos(_Time.y*60)/300;
            resultado.normal = input.normal;
            resultado.tex = input.texcoord;

            // calcular vector v
            // Restar posición de vista - posición de vertice en coordenadas
            // globales
            float3 vertexGlobal = mul(input.pos, unity_ObjectToWorld).xyz;
            float3 haciaVista = _WorldSpaceCameraPos - vertexGlobal;
            resultado.v = normalize(haciaVista);

            resultado.l3 = normalize(_Lucecita.xyz - vertexGlobal);
            resultado.l4 = normalize(_Lucecita2.xyz - vertexGlobal);

            return resultado;

            //return result;
        }

        float4 phong(float4 lColor, float3 normal, float4 tex, float3 vParam) {
            
            // Ambiental : ka * ia
            float4 ambiental = float4(0, 0, 0, 0);
            ambiental = _Ambientecito * lColor * 0.2;

            // Difuso : kd (L . N) id
            // L - vector que va en dirección de la luz
            float3 l = normalize(_WorldSpaceLightPos0.xyz * -1);
            float3 l2 = normalize(_WorldSpaceLightPos0.xyz);

            // N - vector normal
            // la multiplicación es de un vector (normal) por una matriz
            // para cambiar el espacio de las coordenadas
            float3 n = normalize(mul(float4(normal, 0), unity_WorldToObject));
            float3 n2 = normalize(UnityObjectToViewPos(normal));
            float3 n3 = normalize(tex2D(_Normalita, tex.xy));

            // COSAS POR HACER:
            // dot() - método para producto punto
            // resultado puede ser negativo
            // max() - te da el valor máximo entre 2 parámetros (hint: uno es cero)
            float productito = max(0.0, dot(-l, n3));

            float4 difuso = float4(0, 0, 0, 0);
            difuso = _Difusito * productito * lColor;

            // Especular : ks (R . V)**a is
            // R - reflejo perfecto de la luz
            // V - vector que apunta de la posicion actual al ojo
            float4 especular = float4(0, 0, 0, 0);

            float3 v = vParam;
            float3 r = reflect(-l, n3);
            float productote = max(0.0, dot(v, r));

            especular = _Especularcito * pow(productote, _Brillito) * lColor;

            // MODELO DE ILUMINACIÓN DE PHONG
            return (ambiental + difuso + especular) * tex2D(_Texturita, tex.xy);

        }

        // fragment shader - regresa un color de un fragmento
        float4 frag(vOutput input) : COLOR{


            float4 l1 = phong(_ColorLuz, input.normal, input.tex, input.v);

            // blending - mezcla de colores
            return l1;
            
        }

        ENDCG
        }
    }
    FallBack "Diffuse"
}
