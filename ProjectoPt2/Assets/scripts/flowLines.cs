using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flowLines : MonoBehaviour
{
    public Color baseColor;
    public Material material;

    public Transform origin;
    public Vector3[] points;

    public Vector3[] pointsOrigin;
    public Color[] colors;

    void OnPostRender()
    {
        RenderLines(points, colors);
    }

    void OnDrawGizmos()
    {
        RenderLines(points, colors);
    }

    void RenderLines(Vector3[] points, Color[] colors)
    {
        if (!ValidateInput(points, colors))
        {
            return;
        }

        GL.Begin(GL.LINES);
        material.SetPass(0);
        for (int i = 0; i < points.Length; i++)
        {
            GL.Color(baseColor);
            GL.Vertex(pointsOrigin[i]);
            GL.Color(Color.green);
            GL.Vertex(points[i]);
        }
        GL.End();
    }

    private bool ValidateInput(Vector3[] points, Color[] colors)
    {
        return points != null && colors != null && points.Length == colors.Length;
    }
}
