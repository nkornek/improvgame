using UnityEngine;
using System.Collections;
using XInputDotNetPure;
using UnityEngine.UI;

public class GetControllers : MonoBehaviour {

    public bool[] controllerConnected;
    GamePadState state;
    GamePadState prevState;
    public bool[] playerInGame;
    public int playersInGame;


    //display disconnection
    public Image[] disconnection;
    public Text disconnectText;
    public Image[] disconnectUI;

    void Awake()
    {
        DontDestroyOnLoad(transform.gameObject);
    }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        //hide disconnection UI
        disconnectUI[0].enabled = false;
        disconnectUI[1].enabled = false;
        disconnectText.enabled = false;
        
        foreach (Image image in disconnection)
        {
            image.enabled = false;
        }
        
        for (int i = 0; i < 4; ++i)
        {
            PlayerIndex testPlayerIndex = (PlayerIndex)i;
            GamePadState testState = GamePad.GetState(testPlayerIndex);
            controllerConnected[i] = testState.IsConnected;
            prevState = state;
            state = GamePad.GetState((PlayerIndex)i);

            if (controllerConnected[i])
            {
                if (prevState.Buttons.Start == ButtonState.Released && state.Buttons.Start == ButtonState.Pressed)
                {
                    playerInGame[i] = true;
                }
 
            }
            
            if (playerInGame[i] & !controllerConnected[i])
            {
                print("Reconnect: " + (i + 1));
                //change for a visible display later
                disconnectUI[0].enabled = true;
                disconnectUI[1].enabled = true;
                disconnectText.enabled = true;
                disconnection[i].enabled = true;
            }
        }

        //count number of players
        playersInGame = 0;
        for (int i = 0; i < 4; i++)
        {
            if (playerInGame[i] & controllerConnected[i])
            {
                playersInGame++;
            }
        }



	
	}
}
