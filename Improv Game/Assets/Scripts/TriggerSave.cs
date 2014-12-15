using UnityEngine;
using System.Collections;

public class TriggerSave : MonoBehaviour {

	public GameObject[] storage;
	public int whichSkeleton;

	// Use this for initialization
	void Start () {
	
	}
	
	public void AddToCloset(GameObject skeleton)
	{
		storage [whichSkeleton] = skeleton;
		whichSkeleton++;
	}
}
