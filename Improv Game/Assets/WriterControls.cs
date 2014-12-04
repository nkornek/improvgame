using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class WriterControls : MonoBehaviour {
	public int activePlayer;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public void choosePlayer()
	{
		//will change to a proper algorithm  later
		int whichPlayer = 0;
		activePlayer = whichPlayer;
		switch(whichPlayer)
		{
		case 1:
			GamePad.SetVibration(activePlayer, 1, 1); 
		}
		
	}

	public void playerControls()
	{
		switch (activePlayer)
		{
		case 0:
			//0 = null player
			break;

		}

	}
}
