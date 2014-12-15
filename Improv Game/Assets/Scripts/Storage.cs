using UnityEngine;
using System.Collections;

public class Storage : MonoBehaviour {
	public GameObject[] stored;
	public int currentStored;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void StoreBackground (GameObject background)
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
                if (stored[i].GetComponent<SpriteRenderer>())
                {
                    stored[i].GetComponent<SpriteRenderer>().enabled = false;
                }
                else
                {
                    foreach (Light l in stored[i].GetComponentsInChildren<Light>())
                    {
                        l.enabled = false;
                    }
                }
				
			}
		}
	}

}
