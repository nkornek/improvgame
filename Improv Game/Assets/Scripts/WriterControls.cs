using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class WriterControls : MonoBehaviour {
    public GetControllers controllerMaster;
    public ChoiceText choiceScript;
    public bool[] playerHasActed;
    public int playersWhoHaveActed;



	PlayerIndex playerIndex;
    int currentPlayer, currentSelection;
    GamePadState state;
    GamePadState prevState;

	// Use this for initialization
	void Start () {
        controllerMaster = GameObject.Find("Controllers").GetComponent<GetControllers>();
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void WritersTurn()
    {
        prevState = state;
        state = GamePad.GetState(playerIndex);


        //debug
        if (Input.GetKeyDown(KeyCode.V) & controllerMaster.playersInGame > 0)
        {
            choosePlayer();
        }
        playerControls();    
    }

	public void StartWriterTurn()
	{
		for (int i = 0; i < choiceScript.selection.Length; i++)
		{
			choiceScript.selection[i] = choiceScript.blankSelection;
		}
		choiceScript.SetText ();
		choosePlayer ();
	}
	
	public void choosePlayer()
	{
        choiceScript.canChoose = true;
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
            currentPlayer = randomInt;
            GamePad.SetVibration(playerIndex, 1, 1);
            Invoke("StopRumble", 0.3f);
            playerHasActed[randomInt] = true;          
        }
        else
        {
            choosePlayer();
        }
		
		
	}

	public void playerControls()
	{

        if (controllerMaster.controllerConnected[currentPlayer])
        {
            if (prevState.Buttons.A == ButtonState.Released && state.Buttons.A == ButtonState.Pressed)
            {
                choiceScript.ChooseText(0);
            }
            if (prevState.Buttons.B == ButtonState.Released && state.Buttons.B == ButtonState.Pressed)
            {
                choiceScript.ChooseText(1);
            }
            if (prevState.Buttons.X == ButtonState.Released && state.Buttons.X == ButtonState.Pressed)
            {
                choiceScript.ChooseText(2);
            }
            if (prevState.Buttons.Y == ButtonState.Released && state.Buttons.Y == ButtonState.Pressed)
            {
                choiceScript.ChooseText(3);
            }
        }
	}

    void StopRumble()
    {
        GamePad.SetVibration(playerIndex, 0, 0);
    }

}
