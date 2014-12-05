using UnityEngine;
using System.Collections;
using UnityEngine.UI;


public class ChoiceText : MonoBehaviour {
    public WriterControls writerScript;

	public Text[] choiceText;
	public ChoiceDatabase choiceStrings;
	public Text choiceDetails;
	public string[] details, selection;
    public string blankSelection;
    public int currentSelection, numberOfSelections, sceneNum;
    public int[] NumberOfChoicesThisScene;

    public bool canChoose;

	// Use this for initialization
	void Start () {
		SetText ();
	
	}
	
	// Update is called once per frame
	void Update () {
        //display text and choices
        details = new string[numberOfSelections];
        selection = new string[numberOfSelections];
        for (int i = 0; i < numberOfSelections; i++)
        {
            if (selection[i] == null)
            {
                selection[i] = blankSelection;
            }
            choiceDetails.text += (details[i] + " " + selection[i] + " ");
        }
            
	
	}

	public void SetText()
	{
		//set choices
		for (int i = 0; i < choiceText.Length; i++)
		{
			//choiceText[i].text = choiceStrings.possiblechoices[i];
		}
		//set details

        
	}

	public void ChooseText(int choice)
	{
        if (canChoose)
        {
            selection[currentSelection] = choiceText[choice].text;
            choiceDetails.text = details[0] + " " + selection[0] + " " + details[1] + " " + selection[1];
            currentSelection++;
            if (currentSelection > selection.Length)
            {
                canChoose = false;

                //stuff to change to next phase
            }
            else
            {
                writerScript.choosePlayer();
            }
        }
	}


}
