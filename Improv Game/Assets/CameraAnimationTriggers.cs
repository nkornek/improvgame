using UnityEngine;
using System.Collections;

public class CameraAnimationTriggers : MonoBehaviour {
    public Animator Curtains;


    void CloseCurtains()
    {
        Curtains.SetTrigger("Close");
    }

    void StartGame()
    {
        Application.LoadLevelAsync(1);
    }

}
