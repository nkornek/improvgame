using UnityEngine;
using System.Collections;

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

    public void CloneSkeleton()
    {
        if (canClone)
        {
            act = choiceScript.actNum;
            scene = choiceScript.sceneNum;
            GameObject SkeletonClone;
            SkeletonClone = Instantiate(gameObject) as GameObject;
            SkeletonClone.GetComponent<SaveSkeleton>().canClone = false;
            SkeletonClone.transform.parent = closet;
			SkeletonClone.transform.tag = "Clone";
			closet.gameObject.GetComponent<TriggerSave>().AddToCloset(SkeletonClone);

			foreach (MeshRenderer m in SkeletonClone.GetComponentsInChildren<MeshRenderer>())
			{
				m.enabled = false;
			}
			foreach (SpriteRenderer m in SkeletonClone.GetComponentsInChildren<SpriteRenderer>())
			{
				m.enabled = false;
			}
        }
    }

	public void RemoveProps()
	{
		foreach (PropScript p in gameObject.GetComponentsInChildren<PropScript>())
		{
			if (p.propType == PropScript.PropTypes.held || p.propType == PropScript.PropTypes.heldLeft)
			{
				Destroy(p.gameObject);
			}
		}
	}




}
