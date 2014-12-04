using UnityEngine;
using System.Collections;

public class GamePhases : MonoBehaviour {

	public enum GameState {writer, director, actor}
	public GameState gameState;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}



	void WriterChooses(int choiceNum)
	{
		gameState = GameState.writer;

	}
}
