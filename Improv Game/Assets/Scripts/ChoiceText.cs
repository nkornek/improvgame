using UnityEngine;
using System.Collections;
using UnityEngine.UI;


public class ChoiceText : MonoBehaviour {

	public Text[] choiceText;
	public string[] choiceStrings;
	public Text choiceDetails;
	public string details, selection;

    public bool canChoose;

	// Use this for initialization
	void Start () {
		SetText ();
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void SetText()
	{
		//set choices
		for (int i = 0; i < choiceText.Length; i++)
		{
			choiceText[i].text = choiceStrings[i];
		}
		//set details
		selection = "";
		choiceDetails.text = details + " " + selection;
	}

	public void ChooseText(int choice)
	{
        if (canChoose)
        {
            print(choice);
            selection = choiceText[choice].text;
            choiceDetails.text = details + " " + selection;
        }
	}


}
