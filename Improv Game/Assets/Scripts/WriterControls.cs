using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class WriterControls : MonoBehaviour {
    public GetControllers controllerMaster;
    public bool[] playerHasActed;
    public int playersWhoHaveActed;

	PlayerIndex playerIndex;
    GamePadState state;
    GamePadState prevState;

	// Use this for initialization
	void Start () {
        controllerMaster = GameObject.Find("Controllers").GetComponent<GetControllers>();
	}
	
	// Update is called once per frame
	void Update () {

        prevState = state;
        state = GamePad.GetState(playerIndex);

        if (Input.GetKeyDown(KeyCode.V) & controllerMaster.playersInGame > 0)
        {
            choosePlayer();
        }
	
	}
	
	public void choosePlayer()
	{
        //check if all players have had a turn
        playersWhoHaveActed = 0;
        for (int i = 0; i < 4; i++)
        {
            if (playerHasActed[i])
            {
                playersWhoHaveActed++;
            }
        }
        if (playersWhoHaveActed >= controllerMaster.playersInGame)
        {
            for (int i = 0; i < 4; i++)
            {
                playerHasActed[i] = false;
            }
        }
        int randomInt = Random.Range(0, 4);
        //check if player is in game
        PlayerIndex testPlayerIndex = (PlayerIndex)randomInt;
        GamePadState testState = GamePad.GetState(testPlayerIndex);
        if (controllerMaster.controllerConnected[randomInt] & controllerMaster.playerInGame[randomInt] & testState.IsConnected & !playerHasActed[randomInt])
        {
            playerIndex = (PlayerIndex)randomInt;
            GamePad.SetVibration(playerIndex, 1, 1);
            Invoke("StopRumble", 0.3f);
            print("Player " + (randomInt + 1));
            playerHasActed[randomInt] = true;
            
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
