using UnityEngine;
using System.Collections;

public class GamePhases : MonoBehaviour {

	public enum GameState {writer, director, actor}
	public GameState gameState;

    public WriterControls writers;


	// Use this for initialization
	void Start () {
        gameState = GameState.writer;
        
	
	}
	
	// Update is called once per frame
	void Update () {

        if (gameState == GameState.writer)
        {
            writers.WritersTurn();
        }
	
	}

}
