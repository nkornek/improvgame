using UnityEngine;
using System.Collections;

public class PropScript : MonoBehaviour {

    public enum PropTypes {held, background, foreground, clothesHat}
    public PropTypes propType;

    public int playerNum;

	// Use this for initialization
	void Start () {
       

	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void SetProp()
	{
		switch (propType)
		{
		case PropTypes.held:
			foreach (GameObject g in GameObject.FindGameObjectsWithTag("Player"))
			{
				if (g.GetComponent<SaveSkeleton>().player == playerNum)
				{
					transform.parent = g.GetComponent<SaveSkeleton>().handAttach.transform;
					transform.position = transform.parent.position;
					transform.rotation = transform.parent.rotation;
				}
			}
			break;
		case PropTypes.background:
			transform.parent = GameObject.Find("Background Parent").transform;
			transform.position = transform.parent.position;
			break;
		case PropTypes.foreground:
			break;
		}
	}
}
