using UnityEngine;
using System.Collections;
using UnityEditor;

public class SaveSkeleton : MonoBehaviour {
    public ChoiceText choiceScript;
    public Transform closet;

    public int act, scene, player;
    public bool canClone;

    public Transform handAttach, headAttach, bodyAttach, leftHandAttach;



	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

        //debug
        if (Input.GetKeyDown(KeyCode.C))
        {
            CloneSkeleton();
        }       	
	}

    void CloneSkeleton()
    {
        if (canClone)
        {
            act = choiceScript.actNum;
            scene = choiceScript.sceneNum;
            GameObject SkeletonClone;
            SkeletonClone = Instantiate(gameObject) as GameObject;
            SkeletonClone.GetComponent<SaveSkeleton>().canClone = false;
            SkeletonClone.transform.parent = closet;
        }
    }




}
