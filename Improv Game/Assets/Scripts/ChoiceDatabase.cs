﻿using UnityEngine;
using System.Collections;

public class ChoiceDatabase : MonoBehaviour {

    [System.Serializable]
    public class class1
    {
        public string[] choice;
        public AudioClip forPlayer;
        public int whichPlayer;
        public AudioClip[] choiceAudio;
        public GameObject[] prop;
    }

    public class1[] Choices;
    public class1[] Details;
   

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void MakeChoice()
    {

    }


}