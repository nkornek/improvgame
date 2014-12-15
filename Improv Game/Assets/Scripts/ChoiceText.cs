using UnityEngine;
using System.Collections;
using UnityEngine.UI;


public class ChoiceText : MonoBehaviour {
    public WriterControls writerScript;
    public GamePhases gamePhases;
    public DirectorVoice directorVoices;

    public ActDatabase act;
    public int actNum, sceneNum, choiceNum;

	public Text[] choiceText;
	public Text choiceDetails;
	public string[] details, selection;
    public string blankSelection;
    public int numberOfSelections;
	public SaveString stringSaver;

    public bool canChoose;

	public Storage bg, fg;
	public TriggerSave skeleton1, skeleton2;

	// Use this for initialization
	void Start () {
		SetText ();
	
	}
	
	// Update is called once per frame
	void Update () {
        //display text and choices
        choiceDetails.text = "";
        for (int i = 0; i < numberOfSelections; i++)
        {
            choiceDetails.text += (details[i] + " " + selection[i] + " ");
        }
            
	
	}

	public void SetText()
	{
        numberOfSelections = act.whichAct[actNum].whichScene[sceneNum].Choices.Length;
        for (int i = 0; i < selection.Length; i++)
        {
            if (selection[i] == "")
            {
                selection[i] = blankSelection;
            }
        }
        for (int i = 0; i < numberOfSelections; i++)
        {
            details[i] = act.whichAct[actNum].whichScene[sceneNum].Details[i].choice[0];

        }

        //randomize choices
        for (int t = 0; t < act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice.Length; t++)
        {
            string tmpString = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[t];
            AudioClip tmpChoiceAudio = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choiceAudio[t];
            GameObject tmpProp = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].prop[t];
            int r = Random.Range(t, act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice.Length);
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[t] = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[r];
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choiceAudio[t] = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choiceAudio[r];
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].prop[t] = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].prop[r];
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[r] = tmpString;
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choiceAudio[r] = tmpChoiceAudio;
            act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].prop[r] = tmpProp;
        }

        for (int i = 0; i < 4; i++)
        {
            choiceText[i].text = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[i];
        }

        //set base audio
        directorVoices.numberOfSamples = numberOfSelections * 3;
        for (int i = 0; i < numberOfSelections; i++ )
        {
            //call out player number
            directorVoices.voiceSamples[i * 3] = act.whichAct[actNum].whichScene[sceneNum].Details[i].forPlayer;
            //detail interstitials
            directorVoices.voiceSamples[(i * 3) + 1] = act.whichAct[actNum].whichScene[sceneNum].Details[i].choiceAudio[0];
        }


        
	}

	public void ChooseText(int choice)
	{
        if (canChoose)
        {
            selection[choiceNum] = choiceText[choice].text;
            //set choice audio
            directorVoices.voiceSamples[(choiceNum * 3) + 2] = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choiceAudio[choice];

            //spawn Prop
            GameObject newProp;
            newProp = Instantiate(act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].prop[choice]) as GameObject;
            newProp.GetComponent<PropScript>().playerNum = act.whichAct[actNum].whichScene[sceneNum].Details[choiceNum].whichPlayer;
			newProp.GetComponent<PropScript>().act = actNum;
			newProp.GetComponent<PropScript>().scene = sceneNum;
			newProp.GetComponent<PropScript>().SetProp();
            choiceDetails.text = details[0] + " " + selection[0] + " " + details[1] + " " + selection[1];
            //////// put stuff to set audio and visual here
            choiceNum++;
            if (choiceNum >= numberOfSelections)
            {
				//go to next step
                choiceNum = 0;
                canChoose = false;
				stringSaver.saveString();
                gamePhases.Invoke("ToDirector", 1);
            }
            else
            {
                writerScript.choosePlayer();
                SetText();
				gamePhases.hmm();
            }
        }
	}

	public void NextScene()
	{
		sceneNum++;
		if (sceneNum >= act.whichAct[actNum].whichScene.Length)
		{
			sceneNum = 0;
			NextAct();
		}
		else if (gamePhases.gameState == GamePhases.GameState.recall)
		{
			Invoke("recallStuff", 5);
		}
	}

	public void HideStuff()
	{
		bg.HideBackground ();
		fg.HideBackground ();
		gamePhases.player1.RemoveProps ();
		gamePhases.player2.RemoveProps ();
	}

	public void NextAct()
	{
		HideStuff ();
		actNum++;
		if (actNum >= act.whichAct.Length)
		{
			actNum = 0;
			//go to final replay
			gamePhases.startrecall();
		}
		else if (gamePhases.gameState == GamePhases.GameState.recall)
		{
			Invoke("recallStuff", 5);
		}
	}

	
	public void recallStuff()
	{
		for (int i=0; i < bg.stored.Length; i++)
		{
			if (bg.stored[i].GetComponent<PropScript>().act == actNum 
			    & bg.stored[i].GetComponent<PropScript>().scene == sceneNum)
			{
				bg.stored[i].GetComponent<SpriteRenderer>().enabled = true;
			}
			else
			{
				bg.stored[i].GetComponent<SpriteRenderer>().enabled = false;
			}
		}
		for (int i=0; i < fg.stored.Length; i++)
		{
			if (fg.stored[i].GetComponent<PropScript>().act == actNum 
			    & fg.stored[i].GetComponent<PropScript>().scene == sceneNum)
			{
				fg.stored[i].GetComponent<SpriteRenderer>().enabled = true;
			}
			else
			{
				fg.stored[i].GetComponent<SpriteRenderer>().enabled = false;
			}
		}
		for (int i=0; i < skeleton1.storage.Length; i++)
		{
			if (skeleton1.storage[i].GetComponent<SaveSkeleton>().act == actNum 
			    & skeleton1.storage[i].GetComponent<SaveSkeleton>().scene == sceneNum)
			{
				skeleton1.storage[i].GetComponent<MeshRenderer>().enabled = true;
				skeleton1.storage[i].GetComponent<SpriteRenderer>().enabled = true;
			}
			else
			{
				skeleton1.storage[i].GetComponent<MeshRenderer>().enabled = false;
				skeleton1.storage[i].GetComponent<SpriteRenderer>().enabled = false;
			}
		}
		for (int i=0; i < skeleton2.storage.Length; i++)
		{
			if (skeleton2.storage[i].GetComponent<SaveSkeleton>().act == actNum 
			    & skeleton2.storage[i].GetComponent<SaveSkeleton>().scene == sceneNum)
			{
				skeleton2.storage[i].GetComponent<MeshRenderer>().enabled = true;
				skeleton2.storage[i].GetComponent<SpriteRenderer>().enabled = true;
			}
			else
			{
				skeleton2.storage[i].GetComponent<MeshRenderer>().enabled = false;
				skeleton2.storage[i].GetComponent<SpriteRenderer>().enabled = false;
			}
		}
		NextScene ();

	}

}
