using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class WriterControls : MonoBehaviour {
    public GetControllers controllerMaster;

	PlayerIndex playerIndex;
    GamePadState state;
    GamePadState prevState;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

        prevState = state;
        state = GamePad.GetState(playerIndex);

        if (Input.GetKeyDown(KeyCode.V))
        {
            choosePlayer();
        }
	
	}
	
	public void choosePlayer()
	{
        
		int whichPlayer = 0;
		playerIndex = (PlayerIndex)whichPlayer;
        GamePad.SetVibration(playerIndex, 1, 1);
        Invoke("StopRumble", 0.3f);
		
	}

	public void playerControls()
	{
		
	}

    void StopRumble()
    {
        GamePad.SetVibration(playerIndex, 0, 0);
    }

}
