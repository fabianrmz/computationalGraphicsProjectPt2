using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class crashScript : MonoBehaviour
{
    // Start is called before the first frame update

    public float inicio = 0.0f;
    public float fin = 1.0f;
    public float speed = 1.0f;
    public float brillo = 0.0f;

    public int activate = 0;

    public MeshRenderer ren;
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if(activate == 1){
            brillo = inicio + Mathf.PingPong(Time.time * speed, fin - inicio);
            ren.material.SetFloat("_Brillo", brillo);
            Debug.Log("hola");
        }
    }
}
