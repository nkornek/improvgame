using UnityEngine;
using System.Collections;

public class ZigStart : MonoBehaviour {
	public ZigEngageSplitScreen zig;
	bool swapped;


	// Use this for initialization
	void awake () {
		DontDestroyOnLoad(transform.gameObject);
	}

	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (Application.loadedLevel == 2 & !swapped)
		{			
			swapped = true;
			zig.LeftPlayer = GameObject.Find("Player Left");
			zig.RightPlayer = GameObject.Find("Player Right");
		}
	
	}
}
