using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using XInputDotNetPure;

public class LobbyControl : MonoBehaviour {

    public GetControllers controllerScript;
    public ZigEngageSplitScreen zig;
    public Image[] UI;
    public Text[] UItext;

    GamePadState state;
    GamePadState prevState;

    public float timer, maxtime;
    public bool gameStarting;

    public Animator camera;

	// Use this for initialization
	void Start () {
        timer = maxtime;
        controllerScript = GameObject.Find("Controllers").GetComponent<GetControllers>();

	}
	
	// Update is called once per frame
    void Update()
    {
        for (int i = 0; i < 2; i++)
        {
            UI[i].enabled = !gameStarting;
            UItext[i].enabled = !gameStarting;
        }
        for (int i = 2; i < 4; i++)
        {
            UI[i].enabled = gameStarting;
            UItext[i].enabled = gameStarting;
        }
        if (controllerScript.playersInGame > 0 & zig.AllUsersEngaged & !gameStarting)
        {
            UI[4].enabled = true;
            UItext[4].enabled = true;
            for (int i = 0; i < 4; ++i)
            {
                if (controllerScript.controllerConnected[i] & controllerScript.playerInGame[i])
                {
                    prevState = state;
                    state = GamePad.GetState((PlayerIndex)i);
                    if (prevState.Buttons.A == ButtonState.Released && state.Buttons.A == ButtonState.Pressed)
                    {
                        gameStarting = true;
                    }
                }
            }
        }
        else
        {
            UI[4].enabled = false;
            UItext[4].enabled = false;
        }

        if (gameStarting)
        {
            timer -= Time.deltaTime;
            UItext[3].text = Mathf.FloorToInt(timer).ToString();
            if (timer <= 0.1f)
            {
                timer = 0;
                StartGame();
            }

            for (int i = 0; i < 4; ++i)
            {
                if (controllerScript.controllerConnected[i] & controllerScript.playerInGame[i])
                {
                    prevState = state;
                    state = GamePad.GetState((PlayerIndex)i);
                    if (prevState.Buttons.B == ButtonState.Released && state.Buttons.B == ButtonState.Pressed)
                    {
                        print("test2");
                        gameStarting = false;
                        timer = maxtime;
                    }
                }
            }
        }
    }

    void StartGame()
    {
        camera.SetTrigger("StartLoad");
    }
}
