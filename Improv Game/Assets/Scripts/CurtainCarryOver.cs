using UnityEngine;
using System.Collections;

public class CurtainCarryOver : MonoBehaviour {

    void Awake()
    {
        DontDestroyOnLoad(transform);
    }

}
