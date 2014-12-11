using UnityEngine;
using System;
using System.Collections; 

public class ColorPicker : MonoBehaviour {
    public Texture2D colorPicker;
    public int ImageWidth = 256;
    public int ImageHeight = 256;
 

    void OnGUI(){
        if (GUI.RepeatButton(new Rect(5, 135, ImageWidth, ImageHeight), colorPicker)) {
                Vector2 pickpos = Event.current.mousePosition;
                int aaa = Convert.ToInt32(pickpos.x);
                int bbb = Convert.ToInt32(pickpos.y);
                Color col = colorPicker.GetPixel(aaa,41-bbb);
        }
    }
}