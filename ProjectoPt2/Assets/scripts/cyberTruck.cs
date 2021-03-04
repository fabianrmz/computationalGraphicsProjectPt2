using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cyberTruck : MonoBehaviour
{
    
    public float speed = 1f;
    Vector3 movement;
    // Start is called before the first frame update
    void Start()
    {

        
    }

    // Update is called once per frame
    void Update()
    {

    }

    void FixedUpdate() {
        Movement();
        
    }

    void Movement()
    {
        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
        movement.Set(v, 0f, -h);
        movement = movement.normalized * speed * Time.deltaTime;

        transform.Translate(movement);
    }

    void OnCollisionEnter(Collision collision) {
        
		
	}
}
