﻿using UnityEngine;
using System.Collections;

public class DirectorVoice : MonoBehaviour {

    public AudioClip[] voiceSamples;
    public int numberOfSamples;
    public int currentClip;

    public AudioSource directorTalk;

	public GamePhases gameControl;
	public AudioClip action;

	public AudioClip[] hmms, setup, toActors;

	public AudioClip[] review, wrap;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    public void StartVoice()
    {        
        directorTalk.clip = voiceSamples[currentClip];
        float length = directorTalk.clip.length;
        directorTalk.Play();
        currentClip++;
        if (currentClip < numberOfSamples)
        {
            Invoke("StartVoice", length);
        }
        else
        {
            currentClip = 0;
            //move to next phase 
			gameControl.Invoke("ToActors", 5);
        }
    }
}
