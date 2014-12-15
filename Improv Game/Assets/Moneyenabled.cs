using UnityEngine;
using System.Collections;

public class Moneyenabled : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        gameObject.GetComponent<ParticleSystem>().enableEmission = gameObject.GetComponentInParent<MeshRenderer>().enabled;
	
	}
}
