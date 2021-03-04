using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class pisoLuces : MonoBehaviour
{

    public Transform luz, luz2, luz3, luz4, luz5;
    public Renderer ren;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        //  LUZ 1
        ren.material.SetVector("_Luz", new Vector4(
            luz.transform.position.x,
            luz.transform.position.y,
            luz.transform.position.z,
            1
        ));

        //  LUZ 2
        ren.material.SetVector("_Luz2", new Vector4(
            luz2.transform.position.x,
            luz2.transform.position.y,
            luz2.transform.position.z,
            1
        ));

        //  LUZ 3
        ren.material.SetVector("_Luz3", new Vector4(
            luz3.transform.position.x,
            luz3.transform.position.y,
            luz3.transform.position.z,
            1
        ));

        //  LUZ 4
        ren.material.SetVector("_Luz4", new Vector4(
            luz4.transform.position.x,
            luz4.transform.position.y,
            luz4.transform.position.z,
            1
        ));

        //  LUZ 5
        ren.material.SetVector("_Luz5", new Vector4(
            luz5.transform.position.x,
            luz5.transform.position.y,
            luz5.transform.position.z,
            1
        ));
        
    }
}
