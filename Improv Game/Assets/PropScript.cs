using UnityEngine;
using System.Collections;

public class PropScript : MonoBehaviour {

    public enum PropTypes {held, background, foreground, clothesHat, Head, heldLeft}
    public PropTypes propType;

    public int playerNum;

	// Use this for initialization
	void Start () {
       

	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void SetProp()
	{
		switch (propType)
		{
		case PropTypes.held:
			if (playerNum != 0)
			{
				foreach (GameObject g in GameObject.FindGameObjectsWithTag("Player"))
				{
					if (g.GetComponent<SaveSkeleton>().player == playerNum)
					{
						transform.parent = g.GetComponent<SaveSkeleton>().handAttach.transform;
						transform.position = transform.parent.position;
						transform.rotation = transform.parent.rotation;
					}
				}
			}
			else
			{
				if (playerNum == 3)
				{
					propType = PropTypes.heldLeft;
				}
				GameObject cloneProp;
				cloneProp = Instantiate(gameObject) as GameObject;
				cloneProp.GetComponent<PropScript>().playerNum = 1;
				cloneProp.GetComponent<PropScript>().SetProp();
				playerNum = 2;
				SetProp();
			}
			break;
		case PropTypes.heldLeft:
			if (playerNum != 0)
			{
				foreach (GameObject g in GameObject.FindGameObjectsWithTag("Player"))
				{
					if (g.GetComponent<SaveSkeleton>().player == playerNum)
					{
						transform.parent = g.GetComponent<SaveSkeleton>().leftHandAttach.transform;
						transform.position = transform.parent.position;
						transform.rotation = transform.parent.rotation;
					}
				}
			}
			else
			{
				GameObject cloneProp;
				cloneProp = Instantiate(gameObject) as GameObject;
				cloneProp.GetComponent<PropScript>().playerNum = 1;
				cloneProp.GetComponent<PropScript>().SetProp();
				playerNum = 2;
				SetProp();
			}
			break;
		case PropTypes.background:
			transform.parent = GameObject.Find("Background Parent").transform;
			transform.position = transform.parent.position;
			transform.parent.GetComponent<Storage>().StoreBackground(gameObject.GetComponent<SpriteRenderer>());
			break;
		case PropTypes.foreground:
			transform.parent = GameObject.Find("Foreground Parent").transform;
			transform.position = transform.parent.position;
			transform.parent.GetComponent<Storage>().StoreBackground(gameObject.GetComponent<SpriteRenderer>());
			break;
		case PropTypes.clothesHat:
			foreach (GameObject g in GameObject.FindGameObjectsWithTag("Player"))
			{
				if (g.GetComponent<SaveSkeleton>().player == playerNum)
				{
					//hat
					gameObject.GetComponent<ClothesAndHat>().hat.transform.parent = g.GetComponent<SaveSkeleton>().headAttach.transform;
					gameObject.GetComponent<ClothesAndHat>().hat.transform.position = gameObject.GetComponent<ClothesAndHat>().hat.transform.parent.position;
					gameObject.GetComponent<ClothesAndHat>().hat.transform.rotation = gameObject.GetComponent<ClothesAndHat>().hat.transform.parent.rotation;

					//clothes
					gameObject.GetComponent<ClothesAndHat>().clothes.transform.parent = g.GetComponent<SaveSkeleton>().bodyAttach.transform;
					gameObject.GetComponent<ClothesAndHat>().clothes.transform.position = gameObject.GetComponent<ClothesAndHat>().clothes.transform.parent.position; 
					gameObject.GetComponent<ClothesAndHat>().clothes.transform.rotation = gameObject.GetComponent<ClothesAndHat>().clothes.transform.parent.rotation; 
				}
			}
			break;
		case PropTypes.Head:
			foreach (GameObject g in GameObject.FindGameObjectsWithTag("Player"))
			{
				if (g.GetComponent<SaveSkeleton>().player == playerNum)
				{
					transform.parent = g.GetComponent<SaveSkeleton>().headAttach.transform;
					transform.position = transform.parent.position;
					transform.rotation = transform.parent.rotation;
				}
			}
			break;
		}
	}
}
