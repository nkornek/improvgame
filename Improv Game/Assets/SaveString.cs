using UnityEngine;
using System.Collections;

public class SaveString : MonoBehaviour {
	public string[] savedStrings;

	public ChoiceText choiceScript;
	public int whichString;


	public void saveString()
	{
		savedStrings [whichString] = choiceScript.choiceDetails.text;
		whichString++;
		if (whichString >= savedStrings.Length) 
		{
			whichString = 0;
		}
	}

	public void recallString()
	{
		choiceScript.choiceDetails.text = savedStrings [whichString];
		whichString++;
		if (whichString >= savedStrings.Length) 
		{
			whichString = 0;
			//stuff to end game goes here
            choiceScript.gamePhases.gameOver = true;
		}
	}
}
