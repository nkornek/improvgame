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

    public bool canChoose;

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
        for (int i = 0; i < 4; i++)
        {
            //this is where code can be put to sort and randomize from a larger choice pool
            choiceText[i].text = act.whichAct[actNum].whichScene[sceneNum].Choices[choiceNum].choice[i];
        }

        //set base audio
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

            choiceDetails.text = details[0] + " " + selection[0] + " " + details[1] + " " + selection[1];
            //////// put stuff to set audio and visual here
            choiceNum++;
            if (choiceNum >= numberOfSelections)
            {
                print("test");
                choiceNum--;
                canChoose = false;
                gamePhases.Invoke("ToDirector", 1);
            }
            else
            {
                writerScript.choosePlayer();
                SetText();
            }
        }
	}

}
