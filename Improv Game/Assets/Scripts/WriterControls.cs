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
        int randomInt = Random.Range(0, 4);
        //check if player is in game
        PlayerIndex testPlayerIndex = (PlayerIndex)randomInt;
        GamePadState testState = GamePad.GetState(testPlayerIndex);
        if (controllerMaster.controllerConnected[randomInt]
            & controllerMaster.playerInGame[randomInt]
            & testState.IsConnected)
        {
            playerIndex = (PlayerIndex)randomInt;
            GamePad.SetVibration(playerIndex, 1, 1);
            Invoke("StopRumble", 0.3f);
            print("Player " + (randomInt + 1));
        }
        else
        {
            choosePlayer();
        }
		
		
	}

	public void playerControls()
	{
		
	}

    void StopRumble()
    {
        GamePad.SetVibration(playerIndex, 0, 0);
    }

}
