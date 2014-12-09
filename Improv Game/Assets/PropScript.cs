using UnityEngine;
using System.Collections;

public class PropScript : MonoBehaviour {

    public enum PropTypes {held, background, foreground}
    public PropTypes propType;

    public int playerNum;

	// Use this for initialization
	void Start () {
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
                break;
            case PropTypes.foreground:
                break;
        }

	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
