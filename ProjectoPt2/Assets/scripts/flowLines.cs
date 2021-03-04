using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flowLines : MonoBehaviour
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
        Vector3 variablePoints = origin;

        GL.Begin(GL.LINES);
        float a = 0f;
        for(int i=0;i<iterations;i++){
            GL.Color(Color.green);
            GL.Vertex(origin); 

            float x = (2*Mathf.Cos(a)) +origin.x;
            float y = (2*Mathf.Sin(a)) +origin.y;
            variablePoints.x=x;
            variablePoints.y=y;
            a+=0.4f;

            GL.Color(Color.red);
            GL.Vertex(variablePoints); //end


        }
        GL.End();
        GL.PopMatrix();
    }

   
}
