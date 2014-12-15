using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GamePhases : MonoBehaviour {

	public enum GameState {writer, director, actor, recall}
	public GameState gameState;

    public WriterControls writers;
    public DirectorVoice director;

    //writer UI
    public GameObject writerUI;

	//curtains
	public Animator curtains;

	public SaveSkeleton player1, player2;
	public ChoiceText choiceScript;


	// Use this for initialization
	void Start () {
        gameState = GameState.writer;
		curtains = GameObject.Find ("Curtains").GetComponent<Animator> ();
	
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
		curtains.SetTrigger ("Open");
		gameState = GameState.director;
		int randomInt = Random.Range (0, director.toActors.Length);
		director.directorTalk.clip = director.toActors [randomInt];
		director.directorTalk.Play ();
		Invoke ("StartDirector", director.directorTalk.clip.length + 1);
    }

	void StartDirector ()
	{
		director.StartVoice();
	}

	void ToActors()
	{
		gameState = GameState.actor;

		//trigger save
		director.directorTalk.clip = director.action;
		director.directorTalk.Play ();
		Invoke ("saveSkeletons", director.action.length + 2);

		//go to writers again
		Invoke ("ToWriters", director.action.length + 2);
	}

	void saveSkeletons()
	{
		player1.CloneSkeleton ();
		player2.CloneSkeleton ();
		choiceScript.NextScene();
	}

	void ToWriters()
	{

		curtains.SetTrigger ("Close");
		int randomInt = Random.Range (0, director.setup.Length);
		director.directorTalk.clip = director.setup [randomInt];
		director.directorTalk.Play ();
		Invoke ("ShowWriterUI", director.directorTalk.clip.length);
	}

	void ShowWriterUI()
	{
		gameState = GameState.writer;
		writers.StartWriterTurn ();
	}

	public void hmm()
	{
		int randomInt = Random.Range (0, director.hmms.Length);
		director.directorTalk.clip = director.hmms[randomInt];
		director.directorTalk.Play ();
	}

	public void startrecall()
	{
		int randomInt = Random.Range (0, director.review.Length);
		director.directorTalk.clip = director.review[randomInt];
		director.directorTalk.Play ();
	}

}
