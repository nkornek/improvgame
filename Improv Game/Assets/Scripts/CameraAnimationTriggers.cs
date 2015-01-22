using UnityEngine;
using System.Collections;

public class CameraAnimationTriggers : MonoBehaviour {
    public Animator Curtains;

    void Start()
    {
        Curtains = GameObject.Find("Curtains").GetComponent<Animator>();
    }


    void CloseCurtains()
    {
        Curtains.SetTrigger("Close");
    }

    void StartGame()
    {
        Application.LoadLevel(2);
    }

}
