using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cubeLines : MonoBehaviour
{

    public Material mat;
    public Transform reference;

    public float scale = 0.5f;

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
        
        
        
        
       

        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z+scale)));

        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z+scale)));

        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z-scale)));

        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z-scale)));




        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z+scale)));

        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z+scale)));

        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z-scale)));

        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z-scale)));
        


        

        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z+scale)));


        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z+scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z+scale)));

        GL.Vertex(new Vector3((origin.x+scale),(origin.y+scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x+scale),(origin.y-scale),(origin.z-scale)));

        GL.Vertex(new Vector3((origin.x-scale),(origin.y+scale),(origin.z-scale)));
        GL.Vertex(new Vector3((origin.x-scale),(origin.y-scale),(origin.z-scale)));

        
        GL.End();
        

        
        GL.PopMatrix();
       
    }

 
   
}
