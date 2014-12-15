using UnityEngine;
using System.Collections;

public class BeutifulFaceScript : MonoBehaviour {
	public Sprite[] Face;

	// Use this for initialization
	void Start () {
		int randomInt = Random.Range (0, Face.Length);
		gameObject.GetComponent<SpriteRenderer> ().sprite = Face [randomInt];
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
