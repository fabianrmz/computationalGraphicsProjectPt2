using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class npcMovement : MonoBehaviour
{

	public Material nuevoMaterial;
	public MeshRenderer ren;
    // Start is called before the first frame update
   
   void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

	}

	void OnCollisionEnter(Collision collision) {
		if(collision.gameObject.tag == "Player"){
			ren.material = nuevoMaterial;

			Color nuevoColor = collision.gameObject.GetComponent<MeshRenderer>().materials[0].GetColor("_Difusito");
			ren.material.SetColor("_Color", nuevoColor);
			gameObject.GetComponent<crashScript>().activate = 1;
			ren.material.SetVector("_PuntoGolpe", new Vector4(
				collision.contacts[0].point.x, 
				collision.contacts[0].point.y,
				collision.contacts[0].point.z,
				1));

			Destroy(gameObject, 5f);
        }

	}
}
