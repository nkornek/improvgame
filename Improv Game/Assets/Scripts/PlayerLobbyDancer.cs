using UnityEngine;
using System.Collections;

public class PlayerLobbyDancer : MonoBehaviour {

    public GetControllers controllerScript;
    public ZigEngageSplitScreen zig;
    public SpriteRenderer notJoined, joined;
    public SpriteRenderer[] controllerConnected;
    public int playerNum;
    public Vector3 joinedPos, startPos;

	// Use this for initialization
	void Start () {
        startPos = transform.position;
        controllerScript = GameObject.Find("Controllers").GetComponent<GetControllers>();
	
	}
	
	// Update is called once per frame
	void Update () {

        //actors
        if (playerNum >= 4)
        {
            if (zig.AllUsersEngaged)
            {
                joined.enabled = true;
                notJoined.enabled = false;
            }
            else
            {
                joined.enabled = false;
                notJoined.enabled = true;
            }
        }

        //writers
        if (playerNum < 4)
        {
            controllerConnected[0].enabled = controllerScript.controllerConnected[playerNum];
            controllerConnected[1].enabled = controllerScript.controllerConnected[playerNum];

            //join game
            if (controllerScript.playerInGame[playerNum])
            {
                transform.position = Vector3.Lerp(transform.position, joinedPos, 0.05f);
                joined.enabled = true;
                notJoined.enabled = false;
            }
            else
            {
                transform.position = Vector3.Lerp(transform.position, startPos, 0.05f);
                joined.enabled = false;
                notJoined.enabled = true;
            }
        }
	
	}
}
