using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GamePhases : MonoBehaviour {

	public enum GameState {writer, director, actor}
	public GameState gameState;

    public WriterControls writers;
    public DirectorVoice director;

    //writer UI
    public GameObject writerUI;


	// Use this for initialization
	void Start () {
        gameState = GameState.writer;
        
	
	}
	
	// Update is called once per frame
	void Update () {

        foreach (Image i in writerUI.GetComponentsInChildren<Image>())
        {
            i.enabled = (gameState == GameState.writer);
        }
        foreach (Text t in writerUI.GetComponentsInChildren<Text>())
        {
            t.enabled = (gameState == GameState.writer);
        }

        if (gameState == GameState.writer)
        {
            writers.WritersTurn();
        }
	
	}

    void ToDirector()
    {
        gameState = GameState.director;
        director.StartVoice();
    }

}
