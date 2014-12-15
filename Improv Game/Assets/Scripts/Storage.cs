using UnityEngine;
using System.Collections;

public class Storage : MonoBehaviour {
	public SpriteRenderer[] stored;
	public int currentStored;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void StoreBackground (SpriteRenderer background)
	{
		stored [currentStored] = background;
		currentStored ++;
	}

	public void HideBackground ()
	{
		for (int i=0; i < stored.Length; i++)
		{
			if (stored[i])
			{
				stored[i].enabled = false;
			}
		}
	}

}
