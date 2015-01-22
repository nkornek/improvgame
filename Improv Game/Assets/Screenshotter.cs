using UnityEngine;
using System.Collections;
using System.IO;

public class Screenshotter : MonoBehaviour {
	public int screenshotNumber, loadNumber;
	public int shotNum;
	public string newFolderPath;
	public SpriteRenderer renderSprite;
	public string directoryPath;

	void Start ()
	{
		directoryPath = Application.dataPath + "/Screenshots";
		if(!Directory.Exists(directoryPath))
		{    
			print ("made path");
			//if it doesn't, create it
			Directory.CreateDirectory(directoryPath);
			
		}
	}

	void Update ()
	{
		if (Input.GetKeyDown (KeyCode.S)) 
		{
			TakeScreenShot();
		}
		if (Input.GetKeyDown (KeyCode.C)) 
		{
			LoadScreenshot();
		}
	}
	
	public void StartScreenshots ()
	{

	}

	void TakeScreenShot ()
	{
		print ("screenshot");
		Application.CaptureScreenshot (directoryPath + "/"  + screenshotNumber.ToString() + ".png");
		screenshotNumber++;
	}

	public void LoadScreenshot ()
	{
		print ("test");
		Texture2D texture = new Texture2D (Screen.width, Screen.height);
		WWW www = new WWW("file://" + directoryPath + "/" + loadNumber.ToString() + ".png"); 
		while (!www.isDone)
			;
		www.LoadImageIntoTexture(texture);
		Sprite texSprite = Sprite.Create (texture, new Rect (0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f));
		renderSprite.sprite = texSprite;
	}
}