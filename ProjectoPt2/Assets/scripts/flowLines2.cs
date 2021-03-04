using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flowLines2 : MonoBehaviour
{

    public Material mat;
    public Transform reference;


    public float iterations = 90;



    void OnPostRender()
    {
        RenderLines(reference.position);
    }
    void OnDrawGizmos()
    {
        
        RenderLines(reference.position);
    }

    void RenderLines(Vector3 origin)
    {
        if (!mat)
        {
            Debug.LogError("Please Assign a material on the inspector");
            return;
        }
        GL.PushMatrix();
        mat.SetPass(0);
        

        GL.Begin(GL.LINES);
        
        
        
        
       

        GL.Vertex(new Vector3(origin.x+0.27f,origin.y-0.34f,origin.z));
        GL.Vertex(new Vector3(origin.x+0.54f,origin.y+2.06f,origin.z));

        GL.Vertex(new Vector3(origin.x-0.43f,origin.y+1.44f,origin.z));
        GL.Vertex(new Vector3(origin.x+1.58f,origin.y+2.81f,origin.z));

        GL.Vertex(new Vector3(origin.x+1.58f,origin.y+2.81f,origin.z));
        GL.Vertex(new Vector3(origin.x+0.87f,origin.y+3.81f,origin.z));

        GL.Vertex(new Vector3(origin.x+0.87f,origin.y+3.81f,origin.z));
        GL.Vertex(new Vector3(origin.x-0.03f,origin.y+4.11f,origin.z));

        GL.Vertex(new Vector3(origin.x-0.03f,origin.y+4.11f,origin.z));
        GL.Vertex(new Vector3(origin.x-0.94f,origin.y+3.38f,origin.z));

        GL.Vertex(new Vector3(origin.x-0.94f,origin.y+3.38f,origin.z));
        GL.Vertex(new Vector3(origin.x-1.13f,origin.y+1.74f,origin.z));

        GL.Vertex(new Vector3(origin.x-1.13f,origin.y+1.74f,origin.z));
        GL.Vertex(new Vector3(origin.x-0.43f,origin.y+1.44f,origin.z));

        GL.Vertex(new Vector3(origin.x-0.03f,origin.y+4.11f,origin.z));
        GL.Vertex(new Vector3(origin.x-1.33f,origin.y+4.47f,origin.z));

        GL.Vertex(new Vector3(origin.x-1.33f,origin.y+4.47f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.63f,origin.y+4.51f,origin.z));

        GL.Vertex(new Vector3(origin.x-2.63f,origin.y+4.51f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.97f,origin.y+4.05f,origin.z));

        GL.Vertex(new Vector3(origin.x-2.97f,origin.y+4.05f,origin.z));
        GL.Vertex(new Vector3(origin.x-4.69f,origin.y+3.78f,origin.z));

        GL.Vertex(new Vector3(origin.x-4.69f,origin.y+3.78f,origin.z));
        GL.Vertex(new Vector3(origin.x-4.96f,origin.y+3.07f,origin.z));

        GL.Vertex(new Vector3(origin.x-4.96f,origin.y+3.07f,origin.z));
        GL.Vertex(new Vector3(origin.x-4.15f,origin.y+2.32f,origin.z));

        GL.Vertex(new Vector3(origin.x-4.15f,origin.y+2.32f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.46f,origin.y+1.58f,origin.z));

        GL.Vertex(new Vector3(origin.x-2.46f,origin.y+1.58f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.88f,origin.y-0.29f,origin.z));


        GL.Vertex(new Vector3(origin.x-2.36f,origin.y+4.15f,origin.z));
        GL.Vertex(new Vector3(origin.x-1.62f,origin.y+4.21f,origin.z));

        GL.Vertex(new Vector3(origin.x-1.62f,origin.y+4.21f,origin.z));
        GL.Vertex(new Vector3(origin.x-1f,origin.y+4.09f,origin.z));

        GL.Vertex(new Vector3(origin.x-1f,origin.y+4.09f,origin.z));
        GL.Vertex(new Vector3(origin.x-1.76f,origin.y+4.08f,origin.z));

        GL.Vertex(new Vector3(origin.x-1.76f,origin.y+4.08f,origin.z));
        GL.Vertex(new Vector3(origin.x-1.94f,origin.y+3.8f,origin.z));

        GL.Vertex(new Vector3(origin.x-1.94f,origin.y+3.8f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.46f,origin.y+3.82f,origin.z));

        GL.Vertex(new Vector3(origin.x-2.46f,origin.y+3.82f,origin.z));
        GL.Vertex(new Vector3(origin.x-2.36f,origin.y+4.15f,origin.z));
        
        GL.End();
        

        
        GL.PopMatrix();
       
    }

 
   
}
