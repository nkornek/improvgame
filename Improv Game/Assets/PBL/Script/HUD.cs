using UnityEngine;
using System.Collections; 

public class HUD : MonoBehaviour {
	private float Glossiness = 0.01f;
	private float OrenNayarFactor = 0.0f;
	private float Reflectivity = 0.0f;
	private float FresnelBias = 0.2f;
	private float FresnelPower = 5.0f;
	private Color diffColor = Color.gray;
	private Color specColor = Color.white;
	
	private bool rotateTeapot = false;
	private bool rotateLight1 = false;
	private bool rotateLight2 = false;
	
	public Texture2D[] diffuseTexture;
	public Texture2D[] specularTexture;
	public Texture2D[] bumpTexture;
	public GUISkin mySkin;
	
	private GameObject teapot;
	private GameObject Light1;
	private GameObject Light2;
	// Use this for initialization
	void Start () {
		teapot = GameObject.Find("Teapot");
		Light1 = GameObject.Find("Light1");
		Light2 = GameObject.Find("Light2");
	}
	
	// Update is called once per frame
	void Update () {
		teapot.renderer.material.SetFloat("roughnessV", Glossiness);
		teapot.renderer.material.SetFloat("orenNayar", OrenNayarFactor);
		teapot.renderer.material.SetFloat("_Reflective", Reflectivity);
		teapot.renderer.material.SetFloat("freBias", FresnelBias);
		teapot.renderer.material.SetFloat("frePow", FresnelPower);
		teapot.renderer.material.SetColor("_Color", diffColor);
		teapot.renderer.material.SetColor("cSpecular", specColor);
		
		if(rotateTeapot){
			teapot.transform.Rotate(0, 0 ,1);
		}
		else{
			teapot.transform.Rotate(0, 0 ,0);			
		}
		
		if(rotateLight1){
			Light1.transform.Rotate(0, 1 ,0);
		}
		else{
			Light1.transform.Rotate(0, 0 ,0);			
		}
		
		if(rotateLight2){
			Light2.transform.Rotate(0, 1 ,0);
		}
		else{
			Light2.transform.Rotate(0, 0 ,0);			
		}
	}
	
	void OnGUI(){
		#region ShaderSettings
		GUI.color = Color.yellow;
		GUI.skin = mySkin;
		GUI.Box(new Rect(0,0,300,500), "");
		
		Glossiness = GUI.HorizontalSlider(new Rect(5, 10, 100, 25), Glossiness, 0.01f, 0.99f);
		GUI.color = Color.black;
		GUI.Label(new Rect(105, 8, 100,25), "Glossiness");
		
		GUI.color = Color.yellow;
		OrenNayarFactor = GUI.HorizontalSlider(new Rect(5, 35, 100, 25), OrenNayarFactor, 0.0f, 1.0f);
		GUI.color = Color.black;
		GUI.Label(new Rect(105, 33, 100,25), "Roughness");
		
		GUI.color = Color.yellow;
		Reflectivity = GUI.HorizontalSlider(new Rect(5, 60, 100, 25), Reflectivity, 0.0f, 1.0f);
		GUI.color = Color.black;
		GUI.Label(new Rect(105, 58, 100,25), "Reflectivity");
		
		GUI.color = Color.yellow;
		FresnelBias = GUI.HorizontalSlider(new Rect(5, 85, 100, 25), FresnelBias, 0.0f, 1.0f);
		GUI.color = Color.black;
		GUI.Label(new Rect(105, 83, 100,25), "Fresnel Bias");
		GUI.color = Color.yellow;
		FresnelPower = GUI.HorizontalSlider(new Rect(5, 110, 100, 25), FresnelPower, 0.0f, 1.0f);
		GUI.color = Color.black;
		GUI.Label(new Rect(105, 108, 100,25), "Fresnel Power");		
		
		GUI.color = Color.black;
		GUI.Label(new Rect(5, 135, 100,25), "Diffuse Color");
		GUI.color = Color.yellow;
		diffColor.r = GUI.HorizontalSlider(new Rect(5, 135 + 25, 100, 25), diffColor.r, 0.0f, 1.0f);
		diffColor.g = GUI.HorizontalSlider(new Rect(5, 160 + 25, 100, 25), diffColor.g, 0.0f, 1.0f);
		diffColor.b = GUI.HorizontalSlider(new Rect(5, 185 + 25, 100, 25), diffColor.b, 0.0f, 1.0f);
		
		GUI.color = Color.black;
		GUI.Label(new Rect(5, 185 + 25 + 25, 100,25), "Specular Color");
		GUI.color = Color.yellow;
		specColor.r = GUI.HorizontalSlider(new Rect(5, 185 + 25 + 25 + 25, 100, 25), specColor.r, 0.0f, 1.0f);
		specColor.g = GUI.HorizontalSlider(new Rect(5, 185 + 50 + 25 + 25 , 100, 25), specColor.g, 0.0f, 1.0f);
		specColor.b = GUI.HorizontalSlider(new Rect(5, 185 + 75 + 25 + 25, 100, 25), specColor.b, 0.0f, 1.0f);
		
		GUI.color = Color.white;
		GUI.Label(new Rect(5, 310 + 25, 100, 25), "Diff Maps");
		for(int cnt=0; cnt < diffuseTexture.Length; cnt++){
			if(GUI.Button(new Rect(5, 360 + (64 * cnt), 64, 64), diffuseTexture[cnt])){
				teapot.renderer.material.SetTexture("_MainTex", diffuseTexture[cnt]);			
			}
		}
		
		GUI.Label(new Rect(75, 310 + 25, 100, 25), "Spec Maps");
		for(int cnt=0; cnt < specularTexture.Length; cnt++){
			if(GUI.Button(new Rect(64 + 15, 360 + (64 * cnt), 64, 64), specularTexture[cnt])){
				teapot.renderer.material.SetTexture("_SpecularMap", specularTexture[cnt]);			
			}
		}
		
		GUI.Label(new Rect(155, 310 + 25, 100, 25), "Bump Maps");
		for(int cnt=0; cnt < bumpTexture.Length; cnt++){
			if(GUI.Button(new Rect(128 + 25, 360 + (64 * cnt), 64, 64), bumpTexture[cnt])){
				teapot.renderer.material.SetTexture("_BumpMap", bumpTexture[cnt]);			
			}
		}
		
		if(GUI.Button(new Rect(5, 500, 100, 25), "Rotate Object")){
			rotateTeapot = !rotateTeapot;
		}
		
		if(GUI.Button(new Rect(5, 530, 100, 25), "Rotate Light 1")){
			rotateLight1 = !rotateLight1;
		}
		
		if(GUI.Button(new Rect(5, 530 + 30, 100, 25), "Rotate Light 2")){
			rotateLight2 = !rotateLight2;
		}
		#endregion				
	}
}
