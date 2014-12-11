Shader "Brian/PhysicalBaseShaderAnizo" {
	Properties {
		roughnessV("Glossiness", Range(0.01, 0.99)) = 0.075
		orenNayar("Roughness ", Range(0.0, 1)) = 0
		//_Mip ("Envirioment Blur", Range(0, 7)) = 0
		_Reflective("Reflectivety", Range(0.00, 1.0)) = 1
		freBias("Fresnel Bias", Range(0, 1)) = 0.2
		frePow("Fresnel Power", Range(0, 5)) = 5
		_Color("Color(RGB)", Color) = (1,1,1,1)
		AnisoSpecular("Anisotropic Specular Color", Color) = (1,1,1,1)		
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_SpecularMap ("Specular Map(RGB), Gloss(A)", 2D) = "white" {}
		_Cube ("Cubemap", CUBE) = "black" {}
		_AnizoX("Anizo X", Float) = 0
		_AnizoY("Anizo Y", Float) = 0
	}
SubShader {
		Tags { "Queue"="Geometry"
			   "IgnoreProjector"="False"
			   "RenderType"="Opaque"}
			   
		Cull Back
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		LOD 400
		
			
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 9
//   d3d9 - ALU: 39 to 101
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_15;
  vec3 x2_18;
  vec3 x1_19;
  x1_19.x = dot (unity_SHAr, tmpvar_17);
  x1_19.y = dot (unity_SHAg, tmpvar_17);
  x1_19.z = dot (unity_SHAb, tmpvar_17);
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_18.x = dot (unity_SHBr, tmpvar_20);
  x2_18.y = dot (unity_SHBg, tmpvar_20);
  x2_18.z = dot (unity_SHBb, tmpvar_20);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_7 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = ((x1_19 + x2_18) + (unity_SHC.xyz * ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_6.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_6.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_7;
  tmpvar_7.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_6, tmpvar_2) * tmpvar_6)));
  tmpvar_7.w = (tmpvar_5.w * (roughnessV * 7.0));
  vec3 tmpvar_8;
  tmpvar_8 = ((((textureCubeLod (_Cube, tmpvar_7.xyz, tmpvar_7.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_5) * _LightColor0).xyz;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 c_9;
  vec3 SpecularAniso_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normal_3);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_14;
  tmpvar_14.x = _AnizoX;
  tmpvar_14.y = _AnizoY;
  vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 + vec2(1e-05, 1e-05));
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((tmpvar_11.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_11.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_17;
  tmpvar_17 = clamp (dot (tmpvar_11, tmpvar_12), 0.0, 1.0);
  float tmpvar_18;
  tmpvar_18 = (dot (tmpvar_12, tmpvar_16) / tmpvar_15.x);
  float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_12, normalize(((tmpvar_11.yzx * tmpvar_16.zxy) - (tmpvar_11.zxy * tmpvar_16.yzx)))) / tmpvar_15.y);
  float tmpvar_20;
  tmpvar_20 = (-2.0 * (((tmpvar_18 * tmpvar_18) + (tmpvar_19 * tmpvar_19)) / (1.0 + tmpvar_17)));
  float tmpvar_21;
  tmpvar_21 = (((12.5664 * tmpvar_15.x) * tmpvar_15.y) * sqrt((tmpvar_17 * clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0))));
  if ((tmpvar_21 != 0.0)) {
    SpecularAniso_10 = (vec3((exp(tmpvar_20) / tmpvar_21)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_10 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_22;
  tmpvar_22 = (orenNayar * orenNayar);
  float x_23;
  x_23 = dot (tmpvar_13, tmpvar_11);
  float x_24;
  x_24 = dot (tmpvar_12, tmpvar_11);
  float x_25;
  x_25 = dot (tmpvar_13, tmpvar_11);
  float x_26;
  x_26 = dot (tmpvar_12, tmpvar_11);
  float tmpvar_27;
  tmpvar_27 = min ((1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))), (1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))));
  c_9.xyz = (((((tmpvar_4 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_17))) * vec3(((1.0 - (0.5 * (tmpvar_22 / (tmpvar_22 + 0.57)))) + (((0.45 * (tmpvar_22 / (tmpvar_22 + 0.09))) * max (0.0, dot ((tmpvar_13 - (tmpvar_11 * dot (tmpvar_13, tmpvar_11))), (tmpvar_12 - (tmpvar_11 * dot (tmpvar_12, tmpvar_11)))))) * (sin(max ((1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))), (1.5708 - (sign(x_24) * (1.5708 - (sqrt((1.0 - abs(x_24))) * (1.5708 + (abs(x_24) * (-0.214602 + (abs(x_24) * (0.0865667 + (abs(x_24) * -0.0310296)))))))))))) * (sin(tmpvar_27) / cos(tmpvar_27))))))) + ((SpecularAniso_10 * tmpvar_5.x) * _LightColor0.xyz)) * 2.0);
  c_9.w = 1.0;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_4 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_8);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 65 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c24.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r2.xyz, r1, c21.w, -v0
mul r1.xyz, v2, c21.w
dp3 r0.y, r2, r3
dp3 r0.x, r2, v1
dp3 r0.z, v2, r2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp3 r2.w, r1, c5
mov r0.y, r2.w
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.w, c24.x
mul r1, r0.xyzz, r0.yzzx
dp4 r4.z, r0, c16
dp4 r4.y, r0, c15
dp4 r4.x, r0, c14
mul r2.w, r2, r2
dp4 r0.w, r1, c19
dp4 r0.z, r1, c18
dp4 r0.y, r1, c17
add r1.xyz, r4, r0.yzww
mad r0.x, r0, r0, -r2.w
mul r4.xyz, r0.x, c20
add o7.xyz, r1, r4
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c21.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c21.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o6.y, r3, r4
mul o5, r0, c21.w
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [unity_SHAr]
Vector 464 [unity_SHAg]
Vector 463 [unity_SHAb]
Vector 462 [unity_SHBr]
Vector 461 [unity_SHBg]
Vector 460 [unity_SHBb]
Vector 459 [unity_SHC]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 458 [unity_Scale]
Vector 457 [_MainTex_ST]
Vector 456 [_BumpMap_ST]
"sce_vp_rsx // 59 instructions using 9 registers
[Configuration]
8
0000003b41050900
[Microcode]
944
00019c6c005d200d8186c0836041fffc00029c6c00400e0c0106c0836041dffc
00021c6c005d300c0186c0836041dffc00031c6c009ca20c013fc0c36041dffc
401f9c6c011c8800810040d560607f9c401f9c6c011c9808010400d740619f9c
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c01506e0c010600c360411ffc00001c6c0150620c010600c360405ffc
00009c6c01505e0c010600c360411ffc00009c6c0150520c010600c360405ffc
00011c6c01504e0c010600c360411ffc00011c6c0150420c010600c360405ffc
00039c6c01d0a00d8686c0c360405ffc00039c6c01d0900d8686c0c360409ffc
00039c6c01d0800d8686c0c360411ffc00019c6c0150400c0c8600c360411ffc
00019c6c0150600c0c8600c360405ffc00001c6c0150500c0c8600c360409ffc
00031c6c0190a00c0886c0c360405ffc00031c6c0190900c0886c0c360409ffc
00031c6c0190800c0886c0c360411ffc00021c6c00800243011845436041dffc
00021c6c01000230812185630221dffc00041c6c011ca00c0cbfc0e30041dffc
401f9c6c0140020c0106074360405fb0401f9c6c01400e0c0106074360411fb0
00009c6c0080002a8095404360409ffc00019c6c0040002a8086c08360409ffc
00031c6c00800e0c08bfc0836041dffc00001c6c0150608c108600c360403ffc
00009c6c0150508c108600c360403ffc00011c6c0150408c108600c360403ffc
00029c6c0140020c0106084360405ffc00029c6c01400e0c1086008360411ffc
00021c6c019cf00c0686c0c360405ffc00021c6c019d000c0686c0c360409ffc
00021c6c019d100c0686c0c360411ffc00021c6c010000000680036aa0a03ffc
00019c6c0080000d069a03436041fffc401f9c6c0140000c0c86074360409fb0
00029c6c0140000c1086064360409ffc00001c6c0150600c0c8600c360409ffc
00009c6c0150500c0c8600c360409ffc00011c6c0150400c0c8600c360409ffc
00031c6c01dcc00d8686c0c360405ffc00031c6c01dcd00d8686c0c360409ffc
00031c6c01dce00d8686c0c360411ffc00019c6c00c0000c0886c0830321dffc
00021c6c009cb07f888600c36041dffc401f9c6c00c0000c0886c08301a1dfb4
00019c6c0140000c0a86054360411ffc401f9c6c009ca00d84bfc0c36041ffa4
401f9c6c209ca00d82bfc0c001b1e128401f9c6c009ca00d80bfc0c36041ffac
401f9c6c00800000048605436041dfa1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_18 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_33;
  mediump vec4 normal_34;
  normal_34 = tmpvar_32;
  highp float vC_35;
  mediump vec3 x3_36;
  mediump vec3 x2_37;
  mediump vec3 x1_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHAr, normal_34);
  x1_38.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAg, normal_34);
  x1_38.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAb, normal_34);
  x1_38.z = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_34.xyzz * normal_34.yzzx);
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHBr, tmpvar_42);
  x2_37.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBg, tmpvar_42);
  x2_37.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBb, tmpvar_42);
  x2_37.z = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y));
  vC_35 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = (unity_SHC.xyz * vC_35);
  x3_36 = tmpvar_47;
  tmpvar_33 = ((x1_38 + x2_37) + x3_36);
  shlight_3 = tmpvar_33;
  tmpvar_10 = shlight_3;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_33;
  lightDir_33 = xlv_TEXCOORD5;
  mediump vec3 viewDir_34;
  viewDir_34 = xlv_TEXCOORD1;
  mediump vec4 c_35;
  mediump vec3 SpecularFinal_36;
  mediump float B_37;
  mediump float A_38;
  highp float rough_sq_39;
  highp vec3 SpecularAniso_40;
  highp float beta_b_41;
  highp float beta_a_42;
  mediump float HdotB_43;
  mediump float HdotT_44;
  mediump vec3 n_45;
  lowp vec3 tmpvar_46;
  tmpvar_46 = normalize(tmpvar_18);
  n_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = normalize(lightDir_33);
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(viewDir_34);
  mediump vec2 tmpvar_49;
  tmpvar_49.x = _AnizoX;
  tmpvar_49.y = _AnizoY;
  mediump vec2 tmpvar_50;
  tmpvar_50 = (tmpvar_49 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((n_45.yzx * vec3(0.0, 1.0, 0.0)) - (n_45.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_52;
  tmpvar_52 = clamp (dot (n_45, tmpvar_47), 0.0, 1.0);
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_47, tmpvar_51);
  HdotT_44 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (tmpvar_47, normalize(((n_45.yzx * tmpvar_51.zxy) - (n_45.zxy * tmpvar_51.yzx))));
  HdotB_43 = tmpvar_54;
  mediump float tmpvar_55;
  tmpvar_55 = (HdotT_44 / tmpvar_50.x);
  beta_a_42 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = (beta_a_42 * beta_a_42);
  beta_a_42 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotB_43 / tmpvar_50.y);
  beta_b_41 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_b_41 * beta_b_41);
  beta_b_41 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = (-2.0 * ((tmpvar_56 + tmpvar_58) / (1.0 + tmpvar_52)));
  mediump float tmpvar_60;
  tmpvar_60 = sqrt((tmpvar_52 * clamp (dot (n_45, tmpvar_48), 0.0, 1.0)));
  highp float tmpvar_61;
  tmpvar_61 = (((12.5664 * tmpvar_50.x) * tmpvar_50.y) * tmpvar_60);
  if ((tmpvar_61 != 0.0)) {
    SpecularAniso_40 = (vec3((exp(tmpvar_59) / tmpvar_61)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_40 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_62;
  tmpvar_62 = (orenNayar * orenNayar);
  rough_sq_39 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (1.0 - (0.5 * (rough_sq_39 / (rough_sq_39 + 0.57))));
  A_38 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (0.45 * (rough_sq_39 / (rough_sq_39 + 0.09)));
  B_37 = tmpvar_64;
  mediump float x_65;
  x_65 = dot (tmpvar_48, n_45);
  mediump float x_66;
  x_66 = dot (tmpvar_47, n_45);
  mediump float x_67;
  x_67 = dot (tmpvar_48, n_45);
  mediump float x_68;
  x_68 = dot (tmpvar_47, n_45);
  mediump float tmpvar_69;
  tmpvar_69 = min ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))));
  SpecularFinal_36 = SpecularAniso_40;
  c_35.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_52))) * vec3((A_38 + ((B_37 * max (0.0, dot ((tmpvar_48 - (n_45 * dot (tmpvar_48, n_45))), (tmpvar_47 - (n_45 * dot (tmpvar_47, n_45)))))) * (sin(max ((1.5708 - (sign(x_65) * (1.5708 - (sqrt((1.0 - abs(x_65))) * (1.5708 + (abs(x_65) * (-0.214602 + (abs(x_65) * (0.0865667 + (abs(x_65) * -0.0310296)))))))))), (1.5708 - (sign(x_66) * (1.5708 - (sqrt((1.0 - abs(x_66))) * (1.5708 + (abs(x_66) * (-0.214602 + (abs(x_66) * (0.0865667 + (abs(x_66) * -0.0310296)))))))))))) * (sin(tmpvar_69) / cos(tmpvar_69))))))) + ((SpecularFinal_36 * SpecularTex_15.x) * _LightColor0.xyz)) * 2.0);
  c_35.w = 1.0;
  c_1 = c_35;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_18 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_33;
  mediump vec4 normal_34;
  normal_34 = tmpvar_32;
  highp float vC_35;
  mediump vec3 x3_36;
  mediump vec3 x2_37;
  mediump vec3 x1_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHAr, normal_34);
  x1_38.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAg, normal_34);
  x1_38.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAb, normal_34);
  x1_38.z = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_34.xyzz * normal_34.yzzx);
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHBr, tmpvar_42);
  x2_37.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBg, tmpvar_42);
  x2_37.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBb, tmpvar_42);
  x2_37.z = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y));
  vC_35 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = (unity_SHC.xyz * vC_35);
  x3_36 = tmpvar_47;
  tmpvar_33 = ((x1_38 + x2_37) + x3_36);
  shlight_3 = tmpvar_33;
  tmpvar_10 = shlight_3;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_33;
  lightDir_33 = xlv_TEXCOORD5;
  mediump vec3 viewDir_34;
  viewDir_34 = xlv_TEXCOORD1;
  mediump vec4 c_35;
  mediump vec3 SpecularFinal_36;
  mediump float B_37;
  mediump float A_38;
  highp float rough_sq_39;
  highp vec3 SpecularAniso_40;
  highp float beta_b_41;
  highp float beta_a_42;
  mediump float HdotB_43;
  mediump float HdotT_44;
  mediump vec3 n_45;
  lowp vec3 tmpvar_46;
  tmpvar_46 = normalize(normal_18);
  n_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = normalize(lightDir_33);
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(viewDir_34);
  mediump vec2 tmpvar_49;
  tmpvar_49.x = _AnizoX;
  tmpvar_49.y = _AnizoY;
  mediump vec2 tmpvar_50;
  tmpvar_50 = (tmpvar_49 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((n_45.yzx * vec3(0.0, 1.0, 0.0)) - (n_45.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_52;
  tmpvar_52 = clamp (dot (n_45, tmpvar_47), 0.0, 1.0);
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_47, tmpvar_51);
  HdotT_44 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (tmpvar_47, normalize(((n_45.yzx * tmpvar_51.zxy) - (n_45.zxy * tmpvar_51.yzx))));
  HdotB_43 = tmpvar_54;
  mediump float tmpvar_55;
  tmpvar_55 = (HdotT_44 / tmpvar_50.x);
  beta_a_42 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = (beta_a_42 * beta_a_42);
  beta_a_42 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotB_43 / tmpvar_50.y);
  beta_b_41 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_b_41 * beta_b_41);
  beta_b_41 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = (-2.0 * ((tmpvar_56 + tmpvar_58) / (1.0 + tmpvar_52)));
  mediump float tmpvar_60;
  tmpvar_60 = sqrt((tmpvar_52 * clamp (dot (n_45, tmpvar_48), 0.0, 1.0)));
  highp float tmpvar_61;
  tmpvar_61 = (((12.5664 * tmpvar_50.x) * tmpvar_50.y) * tmpvar_60);
  if ((tmpvar_61 != 0.0)) {
    SpecularAniso_40 = (vec3((exp(tmpvar_59) / tmpvar_61)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_40 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_62;
  tmpvar_62 = (orenNayar * orenNayar);
  rough_sq_39 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (1.0 - (0.5 * (rough_sq_39 / (rough_sq_39 + 0.57))));
  A_38 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (0.45 * (rough_sq_39 / (rough_sq_39 + 0.09)));
  B_37 = tmpvar_64;
  mediump float x_65;
  x_65 = dot (tmpvar_48, n_45);
  mediump float x_66;
  x_66 = dot (tmpvar_47, n_45);
  mediump float x_67;
  x_67 = dot (tmpvar_48, n_45);
  mediump float x_68;
  x_68 = dot (tmpvar_47, n_45);
  mediump float tmpvar_69;
  tmpvar_69 = min ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))));
  SpecularFinal_36 = SpecularAniso_40;
  c_35.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_52))) * vec3((A_38 + ((B_37 * max (0.0, dot ((tmpvar_48 - (n_45 * dot (tmpvar_48, n_45))), (tmpvar_47 - (n_45 * dot (tmpvar_47, n_45)))))) * (sin(max ((1.5708 - (sign(x_65) * (1.5708 - (sqrt((1.0 - abs(x_65))) * (1.5708 + (abs(x_65) * (-0.214602 + (abs(x_65) * (0.0865667 + (abs(x_65) * -0.0310296)))))))))), (1.5708 - (sign(x_66) * (1.5708 - (sqrt((1.0 - abs(x_66))) * (1.5708 + (abs(x_66) * (-0.214602 + (abs(x_66) * (0.0865667 + (abs(x_66) * -0.0310296)))))))))))) * (sin(tmpvar_69) / cos(tmpvar_69))))))) + ((SpecularFinal_36 * SpecularTex_15.x) * _LightColor0.xyz)) * 2.0);
  c_35.w = 1.0;
  c_1 = c_35;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_7 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_6;
  tmpvar_6.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)));
  tmpvar_6.w = (tmpvar_4.w * (roughnessV * 7.0));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  c_1.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz * ((8.0 * tmpvar_7.w) * tmpvar_7.xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + ((((textureCubeLod (_Cube, tmpvar_6.xyz, tmpvar_6.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_4) * _LightColor0).xyz);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 39 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r1.xyz, r1, c13.w, -v0
dp3 r0.y, r1, r2
dp3 r0.x, r1, v1
dp3 r0.z, v2, r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp3 r0.y, r2, c4
dp3 r0.w, -r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c13.w
dp3 r0.y, r2, c5
dp3 r0.w, -r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c13.w
dp3 r0.y, r2, c6
dp3 r0.w, -r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c13.w
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o6.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 467 [_WorldSpaceCameraPos]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 466 [unity_Scale]
Vector 465 [unity_LightmapST]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 6 registers
[Configuration]
8
0000002443050600
[Microcode]
576
00021c6c00400e0c0106c0836041dffc00029c6c005d300c0186c0836041dffc
401f9c6c011cf800810040d560607f9c401f9c6c011d0808010400d740619f9c
401f9c6c011d1908010400d740619fb0401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01506e0c010600c360411ffc
00001c6c0150620c010600c360405ffc00009c6c01505e0c010600c360411ffc
00009c6c0150520c010600c360405ffc00011c6c01504e0c010600c360411ffc
00011c6c0150420c010600c360405ffc00019c6c0190a00c0a86c0c360405ffc
00019c6c0190900c0a86c0c360409ffc00019c6c0190800c0a86c0c360411ffc
00029c6c00800243011844436041dffc00021c6c010002308121846302a1dffc
00029c6c011d200c06bfc0e30041dffc00021c6c00800e0c08bfc0836041dffc
00001c6c0150608c0a8600c360403ffc00009c6c0150508c0a8600c360403ffc
00011c6c0150408c0a8600c360403ffc00019c6c0140020c0106054360405ffc
00019c6c01400e0c0a86008360411ffc00019c6c0140000c0a86044360409ffc
00001c6c0150600c088600c360409ffc00009c6c0150500c088600c360409ffc
00011c6c0150400c088600c360409ffc00019c6c0140000c0686034360403ffc
401f9c6c009d200d84bfc0c36041ffa4401f9c6c209d200d82bfc0dfe1b1e128
401f9c6c009d200d80bfc0c36041ffac401f9c6c00800000048603436041dfa1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_15 * (((_World2Object * tmpvar_25).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_4 = tmpvar_26;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  c_1.xyz = (tmpvar_11 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_15 * (((_World2Object * tmpvar_25).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_4 = tmpvar_26;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  c_1.xyz = (tmpvar_11 * ((8.0 * tmpvar_33.w) * tmpvar_33.xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (gl_Vertex.xyz - ((_World2Object * tmpvar_3).xyz * unity_Scale.w)));
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_6 = TANGENT.xyz;
  tmpvar_7 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = gl_Normal.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = gl_Normal.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = gl_Normal.z;
  vec4 v_9;
  v_9.x = _Object2World[0].x;
  v_9.y = _Object2World[1].x;
  v_9.z = _Object2World[2].x;
  v_9.w = _Object2World[3].x;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_8 * v_9.xyz);
  tmpvar_10.w = tmpvar_5.x;
  vec4 v_11;
  v_11.x = _Object2World[0].y;
  v_11.y = _Object2World[1].y;
  v_11.z = _Object2World[2].y;
  v_11.w = _Object2World[3].y;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_8 * v_11.xyz);
  tmpvar_12.w = tmpvar_5.y;
  vec4 v_13;
  v_13.x = _Object2World[0].z;
  v_13.y = _Object2World[1].z;
  v_13.z = _Object2World[2].z;
  v_13.w = _Object2World[3].z;
  vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_8 * v_13.xyz);
  tmpvar_14.w = tmpvar_5.z;
  mat3 tmpvar_15;
  tmpvar_15[0] = _Object2World[0].xyz;
  tmpvar_15[1] = _Object2World[1].xyz;
  tmpvar_15[2] = _Object2World[2].xyz;
  vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_16;
  vec3 x2_19;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_18);
  x1_20.y = dot (unity_SHAg, tmpvar_18);
  x1_20.z = dot (unity_SHAb, tmpvar_18);
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_21);
  x2_19.y = dot (unity_SHBg, tmpvar_21);
  x2_19.z = dot (unity_SHBb, tmpvar_21);
  vec4 o_22;
  vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_2 * 0.5);
  vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_23.x;
  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
  o_22.xy = (tmpvar_24 + tmpvar_23.w);
  o_22.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_8 * (((_World2Object * tmpvar_17).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_14 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = ((x1_20 + x2_19) + (unity_SHC.xyz * ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y))));
  xlv_TEXCOORD7 = o_22;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_6.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_6.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_7;
  tmpvar_7.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_6, tmpvar_2) * tmpvar_6)));
  tmpvar_7.w = (tmpvar_5.w * (roughnessV * 7.0));
  vec3 tmpvar_8;
  tmpvar_8 = ((((textureCubeLod (_Cube, tmpvar_7.xyz, tmpvar_7.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_5) * _LightColor0).xyz;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  float atten_9;
  atten_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  vec4 c_10;
  vec3 SpecularAniso_11;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(normal_3);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD5);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_15;
  tmpvar_15.x = _AnizoX;
  tmpvar_15.y = _AnizoY;
  vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + vec2(1e-05, 1e-05));
  vec3 tmpvar_17;
  tmpvar_17 = normalize(((tmpvar_12.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_12.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_18;
  tmpvar_18 = clamp (dot (tmpvar_12, tmpvar_13), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_13, tmpvar_17) / tmpvar_16.x);
  float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_13, normalize(((tmpvar_12.yzx * tmpvar_17.zxy) - (tmpvar_12.zxy * tmpvar_17.yzx)))) / tmpvar_16.y);
  float tmpvar_21;
  tmpvar_21 = (-2.0 * (((tmpvar_19 * tmpvar_19) + (tmpvar_20 * tmpvar_20)) / (1.0 + tmpvar_18)));
  float tmpvar_22;
  tmpvar_22 = (((12.5664 * tmpvar_16.x) * tmpvar_16.y) * sqrt((tmpvar_18 * clamp (dot (tmpvar_12, tmpvar_14), 0.0, 1.0))));
  if ((tmpvar_22 != 0.0)) {
    SpecularAniso_11 = (vec3((exp(tmpvar_21) / tmpvar_22)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_11 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_23;
  tmpvar_23 = (orenNayar * orenNayar);
  float x_24;
  x_24 = dot (tmpvar_14, tmpvar_12);
  float x_25;
  x_25 = dot (tmpvar_13, tmpvar_12);
  float x_26;
  x_26 = dot (tmpvar_14, tmpvar_12);
  float x_27;
  x_27 = dot (tmpvar_13, tmpvar_12);
  float tmpvar_28;
  tmpvar_28 = min ((1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))), (1.5708 - (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))))));
  c_10.xyz = (((((tmpvar_4 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_18))) * vec3(((1.0 - (0.5 * (tmpvar_23 / (tmpvar_23 + 0.57)))) + (((0.45 * (tmpvar_23 / (tmpvar_23 + 0.09))) * max (0.0, dot ((tmpvar_14 - (tmpvar_12 * dot (tmpvar_14, tmpvar_12))), (tmpvar_13 - (tmpvar_12 * dot (tmpvar_13, tmpvar_12)))))) * (sin(max ((1.5708 - (sign(x_24) * (1.5708 - (sqrt((1.0 - abs(x_24))) * (1.5708 + (abs(x_24) * (-0.214602 + (abs(x_24) * (0.0865667 + (abs(x_24) * -0.0310296)))))))))), (1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))))) * (sin(tmpvar_28) / cos(tmpvar_28))))))) + ((SpecularAniso_11 * tmpvar_5.x) * _LightColor0.xyz)) * (atten_9 * 2.0));
  c_10.w = 1.0;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_4 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_8);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_3_0
; 70 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c26.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r2.xyz, r1, c23.w, -v0
mul r1.xyz, v2, c23.w
dp3 r0.y, r2, r3
dp3 r0.x, r2, v1
dp3 r0.z, v2, r2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp3 r2.w, r1, c5
mov r0.y, r2.w
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.w, c26.x
mul r1, r0.xyzz, r0.yzzx
dp4 r4.z, r0, c18
dp4 r4.y, r0, c17
dp4 r4.x, r0, c16
mul r2.w, r2, r2
dp4 r0.w, r1, c21
dp4 r0.z, r1, c20
dp4 r0.y, r1, c19
add r1.xyz, r4, r0.yzww
mad r0.x, r0, r0, -r2.w
mul r4.xyz, r0.x, c22
add o7.xyz, r1, r4
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c23.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c23.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c23.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c13.x
dp3 o6.y, r3, r4
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_ProjectionParams]
Vector 465 [_WorldSpaceLightPos0]
Vector 464 [unity_SHAr]
Vector 463 [unity_SHAg]
Vector 462 [unity_SHAb]
Vector 461 [unity_SHBr]
Vector 460 [unity_SHBg]
Vector 459 [unity_SHBb]
Vector 458 [unity_SHC]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 457 [unity_Scale]
Vector 456 [_MainTex_ST]
Vector 455 [_BumpMap_ST]
"sce_vp_rsx // 64 instructions using 9 registers
[Configuration]
8
0000004041050900
[Defaults]
1
454 1
3f000000
[Microcode]
1024
00019c6c005d100d8186c0836041fffc00031c6c00400e0c0106c0836041dffc
00029c6c005d300c0186c0836041dffc00041c6c009c920c013fc0c36041dffc
401f9c6c011c7800810040d560607f9c401f9c6c011c8808010400d740619f9c
00001c6c01506e0c010600c360411ffc00001c6c0150620c010600c360405ffc
00009c6c01505e0c010600c360411ffc00009c6c0150520c010600c360405ffc
00011c6c01504e0c010600c360411ffc00011c6c0150420c010600c360405ffc
00021c6c01d0300d8106c0c360403ffc00021c6c01d0200d8106c0c360405ffc
00021c6c01d0100d8106c0c360409ffc00021c6c01d0000d8106c0c360411ffc
00039c6c01d0a00d8686c0c360405ffc00039c6c01d0900d8686c0c360409ffc
00039c6c01d0800d8686c0c360411ffc00019c6c0150400c108600c360411ffc
00019c6c0150600c108600c360405ffc00001c6c0150500c108600c360409ffc
00041c6c0190a00c0a86c0c360405ffc00041c6c0190900c0a86c0c360409ffc
00041c6c0190800c0a86c0c360411ffc00029c6c00800243011846436041dffc
00029c6c010002308121866302a1dffc401f9c6c0040000d8886c0836041ff80
401f9c6c004000558886c08360407fb800041c6c011c900c10bfc0e30041dffc
00021c6c009c600e088000c36041dffc401f9c6c0140020c0106074360405fb0
401f9c6c01400e0c0106074360411fb000021c6c009d202a888000c360409ffc
00009c6c0080002a8095404360409ffc00019c6c0040002a8086c08360409ffc
401f9c6c00c000080886c09542219fb800031c6c00800e0c0abfc0836041dffc
00001c6c0150608c108600c360403ffc00009c6c0150508c108600c360403ffc
00011c6c0150408c108600c360403ffc00029c6c0140020c0106084360405ffc
00029c6c01400e0c1086008360411ffc00021c6c019ce00c0686c0c360405ffc
00021c6c019cf00c0686c0c360409ffc00021c6c019d000c0686c0c360411ffc
00021c6c010000000680036aa0a03ffc00019c6c0080000d069a03436041fffc
401f9c6c0140000c0c86074360409fb000029c6c0140000c1086064360409ffc
00001c6c0150600c0c8600c360409ffc00009c6c0150500c0c8600c360409ffc
00011c6c0150400c0c8600c360409ffc00031c6c01dcb00d8686c0c360405ffc
00031c6c01dcc00d8686c0c360409ffc00031c6c01dcd00d8686c0c360411ffc
00019c6c00c0000c0886c0830321dffc00021c6c009ca07f888600c36041dffc
401f9c6c00c0000c0886c08301a1dfb400019c6c0140000c0a86054360411ffc
401f9c6c009c900d84bfc0c36041ffa4401f9c6c209c900d82bfc0c001b1e128
401f9c6c009c900d80bfc0c36041ffac401f9c6c00800000048605436041dfa1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_18 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_33;
  mediump vec4 normal_34;
  normal_34 = tmpvar_32;
  highp float vC_35;
  mediump vec3 x3_36;
  mediump vec3 x2_37;
  mediump vec3 x1_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHAr, normal_34);
  x1_38.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAg, normal_34);
  x1_38.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAb, normal_34);
  x1_38.z = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_34.xyzz * normal_34.yzzx);
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHBr, tmpvar_42);
  x2_37.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBg, tmpvar_42);
  x2_37.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBb, tmpvar_42);
  x2_37.z = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y));
  vC_35 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = (unity_SHC.xyz * vC_35);
  x3_36 = tmpvar_47;
  tmpvar_33 = ((x1_38 + x2_37) + x3_36);
  shlight_3 = tmpvar_33;
  tmpvar_10 = shlight_3;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float tmpvar_33;
  mediump float lightShadowDataX_34;
  highp float dist_35;
  lowp float tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_35 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = _LightShadowData.x;
  lightShadowDataX_34 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = max (float((dist_35 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_34);
  tmpvar_33 = tmpvar_38;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_39;
  lightDir_39 = xlv_TEXCOORD5;
  mediump vec3 viewDir_40;
  viewDir_40 = xlv_TEXCOORD1;
  mediump float atten_41;
  atten_41 = tmpvar_33;
  mediump vec4 c_42;
  mediump vec3 SpecularFinal_43;
  mediump float B_44;
  mediump float A_45;
  highp float rough_sq_46;
  highp vec3 SpecularAniso_47;
  highp float beta_b_48;
  highp float beta_a_49;
  mediump float HdotB_50;
  mediump float HdotT_51;
  mediump vec3 n_52;
  lowp vec3 tmpvar_53;
  tmpvar_53 = normalize(tmpvar_18);
  n_52 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54 = normalize(lightDir_39);
  mediump vec3 tmpvar_55;
  tmpvar_55 = normalize(viewDir_40);
  mediump vec2 tmpvar_56;
  tmpvar_56.x = _AnizoX;
  tmpvar_56.y = _AnizoY;
  mediump vec2 tmpvar_57;
  tmpvar_57 = (tmpvar_56 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_58;
  tmpvar_58 = normalize(((n_52.yzx * vec3(0.0, 1.0, 0.0)) - (n_52.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (n_52, tmpvar_54), 0.0, 1.0);
  highp float tmpvar_60;
  tmpvar_60 = dot (tmpvar_54, tmpvar_58);
  HdotT_51 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = dot (tmpvar_54, normalize(((n_52.yzx * tmpvar_58.zxy) - (n_52.zxy * tmpvar_58.yzx))));
  HdotB_50 = tmpvar_61;
  mediump float tmpvar_62;
  tmpvar_62 = (HdotT_51 / tmpvar_57.x);
  beta_a_49 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (beta_a_49 * beta_a_49);
  beta_a_49 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (HdotB_50 / tmpvar_57.y);
  beta_b_48 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (beta_b_48 * beta_b_48);
  beta_b_48 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (-2.0 * ((tmpvar_63 + tmpvar_65) / (1.0 + tmpvar_59)));
  mediump float tmpvar_67;
  tmpvar_67 = sqrt((tmpvar_59 * clamp (dot (n_52, tmpvar_55), 0.0, 1.0)));
  highp float tmpvar_68;
  tmpvar_68 = (((12.5664 * tmpvar_57.x) * tmpvar_57.y) * tmpvar_67);
  if ((tmpvar_68 != 0.0)) {
    SpecularAniso_47 = (vec3((exp(tmpvar_66) / tmpvar_68)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_47 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_69;
  tmpvar_69 = (orenNayar * orenNayar);
  rough_sq_46 = tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = (1.0 - (0.5 * (rough_sq_46 / (rough_sq_46 + 0.57))));
  A_45 = tmpvar_70;
  highp float tmpvar_71;
  tmpvar_71 = (0.45 * (rough_sq_46 / (rough_sq_46 + 0.09)));
  B_44 = tmpvar_71;
  mediump float x_72;
  x_72 = dot (tmpvar_55, n_52);
  mediump float x_73;
  x_73 = dot (tmpvar_54, n_52);
  mediump float x_74;
  x_74 = dot (tmpvar_55, n_52);
  mediump float x_75;
  x_75 = dot (tmpvar_54, n_52);
  mediump float tmpvar_76;
  tmpvar_76 = min ((1.5708 - (sign(x_74) * (1.5708 - (sqrt((1.0 - abs(x_74))) * (1.5708 + (abs(x_74) * (-0.214602 + (abs(x_74) * (0.0865667 + (abs(x_74) * -0.0310296)))))))))), (1.5708 - (sign(x_75) * (1.5708 - (sqrt((1.0 - abs(x_75))) * (1.5708 + (abs(x_75) * (-0.214602 + (abs(x_75) * (0.0865667 + (abs(x_75) * -0.0310296)))))))))));
  SpecularFinal_43 = SpecularAniso_47;
  c_42.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_59))) * vec3((A_45 + ((B_44 * max (0.0, dot ((tmpvar_55 - (n_52 * dot (tmpvar_55, n_52))), (tmpvar_54 - (n_52 * dot (tmpvar_54, n_52)))))) * (sin(max ((1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))), (1.5708 - (sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296)))))))))))) * (sin(tmpvar_76) / cos(tmpvar_76))))))) + ((SpecularFinal_43 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_41 * 2.0));
  c_42.w = 1.0;
  c_1 = c_42;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (gl_ModelViewProjectionMatrix * _glesVertex);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_15;
  tmpvar_15[0] = _Object2World[0].xyz;
  tmpvar_15[1] = _Object2World[1].xyz;
  tmpvar_15[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (_glesVertex.xyz - ((_World2Object * tmpvar_14).xyz * unity_Scale.w)));
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_1.xyz;
  tmpvar_18 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_2.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_2.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_2.z;
  vec4 v_20;
  v_20.x = _Object2World[0].x;
  v_20.y = _Object2World[1].x;
  v_20.z = _Object2World[2].x;
  v_20.w = _Object2World[3].x;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_19 * v_20.xyz);
  tmpvar_21.w = tmpvar_16.x;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  vec4 v_23;
  v_23.x = _Object2World[0].y;
  v_23.y = _Object2World[1].y;
  v_23.z = _Object2World[2].y;
  v_23.w = _Object2World[3].y;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (tmpvar_19 * v_23.xyz);
  tmpvar_24.w = tmpvar_16.y;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_24 * unity_Scale.w);
  tmpvar_7 = tmpvar_25;
  vec4 v_26;
  v_26.x = _Object2World[0].z;
  v_26.y = _Object2World[1].z;
  v_26.z = _Object2World[2].z;
  v_26.w = _Object2World[3].z;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_19 * v_26.xyz);
  tmpvar_27.w = tmpvar_16.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * unity_Scale.w);
  tmpvar_8 = tmpvar_28;
  mat3 tmpvar_29;
  tmpvar_29[0] = _Object2World[0].xyz;
  tmpvar_29[1] = _Object2World[1].xyz;
  tmpvar_29[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_19 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_19 * (((_World2Object * tmpvar_31).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = (tmpvar_29 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_34;
  mediump vec4 normal_35;
  normal_35 = tmpvar_33;
  highp float vC_36;
  mediump vec3 x3_37;
  mediump vec3 x2_38;
  mediump vec3 x1_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAr, normal_35);
  x1_39.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAg, normal_35);
  x1_39.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAb, normal_35);
  x1_39.z = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (normal_35.xyzz * normal_35.yzzx);
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBr, tmpvar_43);
  x2_38.x = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBg, tmpvar_43);
  x2_38.y = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBb, tmpvar_43);
  x2_38.z = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y));
  vC_36 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = (unity_SHC.xyz * vC_36);
  x3_37 = tmpvar_48;
  tmpvar_34 = ((x1_39 + x2_38) + x3_37);
  shlight_3 = tmpvar_34;
  tmpvar_10 = shlight_3;
  highp vec4 o_49;
  highp vec4 tmpvar_50;
  tmpvar_50 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_51;
  tmpvar_51.x = tmpvar_50.x;
  tmpvar_51.y = (tmpvar_50.y * _ProjectionParams.x);
  o_49.xy = (tmpvar_51 + tmpvar_50.w);
  o_49.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = o_49;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_34;
  lightDir_34 = xlv_TEXCOORD5;
  mediump vec3 viewDir_35;
  viewDir_35 = xlv_TEXCOORD1;
  mediump float atten_36;
  atten_36 = tmpvar_33;
  mediump vec4 c_37;
  mediump vec3 SpecularFinal_38;
  mediump float B_39;
  mediump float A_40;
  highp float rough_sq_41;
  highp vec3 SpecularAniso_42;
  highp float beta_b_43;
  highp float beta_a_44;
  mediump float HdotB_45;
  mediump float HdotT_46;
  mediump vec3 n_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = normalize(normal_18);
  n_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = normalize(lightDir_34);
  mediump vec3 tmpvar_50;
  tmpvar_50 = normalize(viewDir_35);
  mediump vec2 tmpvar_51;
  tmpvar_51.x = _AnizoX;
  tmpvar_51.y = _AnizoY;
  mediump vec2 tmpvar_52;
  tmpvar_52 = (tmpvar_51 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(((n_47.yzx * vec3(0.0, 1.0, 0.0)) - (n_47.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_54;
  tmpvar_54 = clamp (dot (n_47, tmpvar_49), 0.0, 1.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (tmpvar_49, tmpvar_53);
  HdotT_46 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (tmpvar_49, normalize(((n_47.yzx * tmpvar_53.zxy) - (n_47.zxy * tmpvar_53.yzx))));
  HdotB_45 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotT_46 / tmpvar_52.x);
  beta_a_44 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_a_44 * beta_a_44);
  beta_a_44 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotB_45 / tmpvar_52.y);
  beta_b_43 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_b_43 * beta_b_43);
  beta_b_43 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (-2.0 * ((tmpvar_58 + tmpvar_60) / (1.0 + tmpvar_54)));
  mediump float tmpvar_62;
  tmpvar_62 = sqrt((tmpvar_54 * clamp (dot (n_47, tmpvar_50), 0.0, 1.0)));
  highp float tmpvar_63;
  tmpvar_63 = (((12.5664 * tmpvar_52.x) * tmpvar_52.y) * tmpvar_62);
  if ((tmpvar_63 != 0.0)) {
    SpecularAniso_42 = (vec3((exp(tmpvar_61) / tmpvar_63)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_42 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_64;
  tmpvar_64 = (orenNayar * orenNayar);
  rough_sq_41 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (1.0 - (0.5 * (rough_sq_41 / (rough_sq_41 + 0.57))));
  A_40 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (0.45 * (rough_sq_41 / (rough_sq_41 + 0.09)));
  B_39 = tmpvar_66;
  mediump float x_67;
  x_67 = dot (tmpvar_50, n_47);
  mediump float x_68;
  x_68 = dot (tmpvar_49, n_47);
  mediump float x_69;
  x_69 = dot (tmpvar_50, n_47);
  mediump float x_70;
  x_70 = dot (tmpvar_49, n_47);
  mediump float tmpvar_71;
  tmpvar_71 = min ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))));
  SpecularFinal_38 = SpecularAniso_42;
  c_37.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_54))) * vec3((A_40 + ((B_39 * max (0.0, dot ((tmpvar_50 - (n_47 * dot (tmpvar_50, n_47))), (tmpvar_49 - (n_47 * dot (tmpvar_49, n_47)))))) * (sin(max ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))))) * (sin(tmpvar_71) / cos(tmpvar_71))))))) + ((SpecularFinal_38 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_36 * 2.0));
  c_37.w = 1.0;
  c_1 = c_37;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (gl_Vertex.xyz - ((_World2Object * tmpvar_3).xyz * unity_Scale.w)));
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_6 = TANGENT.xyz;
  tmpvar_7 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = gl_Normal.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = gl_Normal.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = gl_Normal.z;
  vec4 v_9;
  v_9.x = _Object2World[0].x;
  v_9.y = _Object2World[1].x;
  v_9.z = _Object2World[2].x;
  v_9.w = _Object2World[3].x;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_8 * v_9.xyz);
  tmpvar_10.w = tmpvar_5.x;
  vec4 v_11;
  v_11.x = _Object2World[0].y;
  v_11.y = _Object2World[1].y;
  v_11.z = _Object2World[2].y;
  v_11.w = _Object2World[3].y;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_8 * v_11.xyz);
  tmpvar_12.w = tmpvar_5.y;
  vec4 v_13;
  v_13.x = _Object2World[0].z;
  v_13.y = _Object2World[1].z;
  v_13.z = _Object2World[2].z;
  v_13.w = _Object2World[3].z;
  vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_8 * v_13.xyz);
  tmpvar_14.w = tmpvar_5.z;
  vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_2 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_8 * (((_World2Object * tmpvar_15).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_14 * unity_Scale.w);
  xlv_TEXCOORD5 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = o_16;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD6;
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_6;
  tmpvar_6.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)));
  tmpvar_6.w = (tmpvar_4.w * (roughnessV * 7.0));
  vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  vec3 tmpvar_9;
  tmpvar_9 = ((8.0 * tmpvar_8.w) * tmpvar_8.xyz);
  c_1.xyz = ((texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz * max (min (tmpvar_9, ((tmpvar_7.x * 2.0) * tmpvar_8.xyz)), (tmpvar_9 * tmpvar_7.x)));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + ((((textureCubeLod (_Cube, tmpvar_6.xyz, tmpvar_6.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_4) * _LightColor0).xyz);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 45 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c19.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r1.xyz, r1, c15.w, -v0
dp3 r0.y, r1, r2
dp3 r0.x, r1, v1
dp3 r0.z, v2, r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp3 r0.w, -r1, c4
dp3 r0.y, r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c15.w
dp3 r0.w, -r1, c5
dp3 r0.y, r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c15.w
dp3 r0.w, -r1, c6
dp4 r1.z, v0, c2
dp3 r0.y, r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c19.y
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c15.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o7.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o7.zw, r1
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o6.xy, v4, c16, c16.zwzw
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_ProjectionParams]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 465 [unity_Scale]
Vector 464 [unity_LightmapST]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 41 instructions using 7 registers
[Configuration]
8
0000002943050700
[Defaults]
1
461 1
3f000000
[Microcode]
656
00029c6c00400e0c0106c0836041dffc00031c6c005d300c0186c0836041dffc
401f9c6c011ce800810040d560607f9c401f9c6c011cf808010400d740619f9c
401f9c6c011d0908010400d740619fb000001c6c01506e0c010600c360411ffc
00001c6c0150620c010600c360405ffc00009c6c01505e0c010600c360411ffc
00009c6c0150520c010600c360405ffc00011c6c01504e0c010600c360411ffc
00011c6c0150420c010600c360405ffc00019c6c01d0300d8106c0c360403ffc
00019c6c01d0200d8106c0c360405ffc00019c6c01d0100d8106c0c360409ffc
00019c6c01d0000d8106c0c360411ffc00021c6c0190a00c0c86c0c360405ffc
00021c6c0190900c0c86c0c360409ffc00021c6c0190800c0c86c0c360411ffc
00031c6c00800243011845436041dffc00031c6c01000230812185630321dffc
401f9c6c0040000d8686c0836041ff80401f9c6c004000558686c08360407fb4
00029c6c011d100c08bfc0e30041dffc00019c6c009cd00e068000c36041dffc
00019c6c009d202a868000c360409ffc401f9c6c00c000080686c09541a19fb4
00021c6c00800e0c0cbfc0836041dffc00001c6c0150608c0a8600c360403ffc
00009c6c0150508c0a8600c360403ffc00011c6c0150408c0a8600c360403ffc
00019c6c0140020c0106054360405ffc00019c6c01400e0c0a86008360411ffc
00019c6c0140000c0a86044360409ffc00001c6c0150600c088600c360409ffc
00009c6c0150500c088600c360409ffc00011c6c0150400c088600c360409ffc
00019c6c0140000c0686034360403ffc401f9c6c009d100d84bfc0c36041ffa4
401f9c6c209d100d82bfc0dfe1b1e128401f9c6c009d100d80bfc0c36041ffac
401f9c6c00800000048603436041dfa1
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_15 * (((_World2Object * tmpvar_25).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_4 = tmpvar_26;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float tmpvar_33;
  mediump float lightShadowDataX_34;
  highp float dist_35;
  lowp float tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6).x;
  dist_35 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = _LightShadowData.x;
  lightShadowDataX_34 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = max (float((dist_35 > (xlv_TEXCOORD6.z / xlv_TEXCOORD6.w))), lightShadowDataX_34);
  tmpvar_33 = tmpvar_38;
  c_1.xyz = (tmpvar_11 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz), vec3((tmpvar_33 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (gl_ModelViewProjectionMatrix * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_12;
  tmpvar_12[0] = _Object2World[0].xyz;
  tmpvar_12[1] = _Object2World[1].xyz;
  tmpvar_12[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_glesVertex.xyz - ((_World2Object * tmpvar_11).xyz * unity_Scale.w)));
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_14 = tmpvar_1.xyz;
  tmpvar_15 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14.x;
  tmpvar_16[0].y = tmpvar_15.x;
  tmpvar_16[0].z = tmpvar_2.x;
  tmpvar_16[1].x = tmpvar_14.y;
  tmpvar_16[1].y = tmpvar_15.y;
  tmpvar_16[1].z = tmpvar_2.y;
  tmpvar_16[2].x = tmpvar_14.z;
  tmpvar_16[2].y = tmpvar_15.z;
  tmpvar_16[2].z = tmpvar_2.z;
  vec4 v_17;
  v_17.x = _Object2World[0].x;
  v_17.y = _Object2World[1].x;
  v_17.z = _Object2World[2].x;
  v_17.w = _Object2World[3].x;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = (tmpvar_16 * v_17.xyz);
  tmpvar_18.w = tmpvar_13.x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * unity_Scale.w);
  tmpvar_5 = tmpvar_19;
  vec4 v_20;
  v_20.x = _Object2World[0].y;
  v_20.y = _Object2World[1].y;
  v_20.z = _Object2World[2].y;
  v_20.w = _Object2World[3].y;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_16 * v_20.xyz);
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  vec4 v_23;
  v_23.x = _Object2World[0].z;
  v_23.y = _Object2World[1].z;
  v_23.z = _Object2World[2].z;
  v_23.w = _Object2World[3].z;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (tmpvar_16 * v_23.xyz);
  tmpvar_24.w = tmpvar_13.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_24 * unity_Scale.w);
  tmpvar_7 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_16 * (((_World2Object * tmpvar_26).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_4 = tmpvar_27;
  highp vec4 o_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_30;
  tmpvar_30.x = tmpvar_29.x;
  tmpvar_30.y = (tmpvar_29.y * _ProjectionParams.x);
  o_28.xy = (tmpvar_30 + tmpvar_29.w);
  o_28.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = o_28;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD6);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  lowp vec3 tmpvar_35;
  tmpvar_35 = ((8.0 * tmpvar_34.w) * tmpvar_34.xyz);
  c_1.xyz = (tmpvar_11 * max (min (tmpvar_35, ((tmpvar_33.x * 2.0) * tmpvar_34.xyz)), (tmpvar_35 * tmpvar_33.x)));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 unity_LightColor[4];
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosX0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_15;
  vec3 x2_18;
  vec3 x1_19;
  x1_19.x = dot (unity_SHAr, tmpvar_17);
  x1_19.y = dot (unity_SHAg, tmpvar_17);
  x1_19.z = dot (unity_SHAb, tmpvar_17);
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_18.x = dot (unity_SHBr, tmpvar_20);
  x2_18.y = dot (unity_SHBg, tmpvar_20);
  x2_18.z = dot (unity_SHBb, tmpvar_20);
  vec3 tmpvar_21;
  tmpvar_21 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_21.x);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_21.y);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_21.z);
  vec4 tmpvar_25;
  tmpvar_25 = (((tmpvar_22 * tmpvar_22) + (tmpvar_23 * tmpvar_23)) + (tmpvar_24 * tmpvar_24));
  vec4 tmpvar_26;
  tmpvar_26 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_22 * tmpvar_15.x) + (tmpvar_23 * tmpvar_15.y)) + (tmpvar_24 * tmpvar_15.z)) * inversesqrt(tmpvar_25))) * (1.0/((1.0 + (tmpvar_25 * unity_4LightAtten0)))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_7 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = (((x1_19 + x2_18) + (unity_SHC.xyz * ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y)))) + ((((unity_LightColor[0].xyz * tmpvar_26.x) + (unity_LightColor[1].xyz * tmpvar_26.y)) + (unity_LightColor[2].xyz * tmpvar_26.z)) + (unity_LightColor[3].xyz * tmpvar_26.w)));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_6.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_6.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_7;
  tmpvar_7.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_6, tmpvar_2) * tmpvar_6)));
  tmpvar_7.w = (tmpvar_5.w * (roughnessV * 7.0));
  vec3 tmpvar_8;
  tmpvar_8 = ((((textureCubeLod (_Cube, tmpvar_7.xyz, tmpvar_7.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_5) * _LightColor0).xyz;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 c_9;
  vec3 SpecularAniso_10;
  vec3 tmpvar_11;
  tmpvar_11 = normalize(normal_3);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_14;
  tmpvar_14.x = _AnizoX;
  tmpvar_14.y = _AnizoY;
  vec2 tmpvar_15;
  tmpvar_15 = (tmpvar_14 + vec2(1e-05, 1e-05));
  vec3 tmpvar_16;
  tmpvar_16 = normalize(((tmpvar_11.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_11.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_17;
  tmpvar_17 = clamp (dot (tmpvar_11, tmpvar_12), 0.0, 1.0);
  float tmpvar_18;
  tmpvar_18 = (dot (tmpvar_12, tmpvar_16) / tmpvar_15.x);
  float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_12, normalize(((tmpvar_11.yzx * tmpvar_16.zxy) - (tmpvar_11.zxy * tmpvar_16.yzx)))) / tmpvar_15.y);
  float tmpvar_20;
  tmpvar_20 = (-2.0 * (((tmpvar_18 * tmpvar_18) + (tmpvar_19 * tmpvar_19)) / (1.0 + tmpvar_17)));
  float tmpvar_21;
  tmpvar_21 = (((12.5664 * tmpvar_15.x) * tmpvar_15.y) * sqrt((tmpvar_17 * clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0))));
  if ((tmpvar_21 != 0.0)) {
    SpecularAniso_10 = (vec3((exp(tmpvar_20) / tmpvar_21)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_10 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_22;
  tmpvar_22 = (orenNayar * orenNayar);
  float x_23;
  x_23 = dot (tmpvar_13, tmpvar_11);
  float x_24;
  x_24 = dot (tmpvar_12, tmpvar_11);
  float x_25;
  x_25 = dot (tmpvar_13, tmpvar_11);
  float x_26;
  x_26 = dot (tmpvar_12, tmpvar_11);
  float tmpvar_27;
  tmpvar_27 = min ((1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))), (1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))));
  c_9.xyz = (((((tmpvar_4 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_17))) * vec3(((1.0 - (0.5 * (tmpvar_22 / (tmpvar_22 + 0.57)))) + (((0.45 * (tmpvar_22 / (tmpvar_22 + 0.09))) * max (0.0, dot ((tmpvar_13 - (tmpvar_11 * dot (tmpvar_13, tmpvar_11))), (tmpvar_12 - (tmpvar_11 * dot (tmpvar_12, tmpvar_11)))))) * (sin(max ((1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))), (1.5708 - (sign(x_24) * (1.5708 - (sqrt((1.0 - abs(x_24))) * (1.5708 + (abs(x_24) * (-0.214602 + (abs(x_24) * (0.0865667 + (abs(x_24) * -0.0310296)))))))))))) * (sin(tmpvar_27) / cos(tmpvar_27))))))) + ((SpecularAniso_10 * tmpvar_5.x) * _LightColor0.xyz)) * 2.0);
  c_9.w = 1.0;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_4 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_8);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 96 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mul r1, r4.xyzz, r4.yzzx
mad r0.xyz, r0.w, c21, r0
mul r0.w, r3, r3
mad r0.w, r4.x, r4.x, -r0
dp4 r3.z, r1, c27
dp4 r3.y, r1, c26
dp4 r3.x, r1, c25
add r1.xyz, r2, r3
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mul r4.xyz, r0.w, c28
add r4.xyz, r1, r4
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mul r3.xyz, r2, v1.w
mov r1.xyz, c12
mov r1.w, c32.x
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
add o7.xyz, r4, r0
dp3 r1.y, r2, r3
dp3 r1.x, r2, v1
dp3 r1.z, v2, r2
dp3 r0.w, r1, r1
rsq r1.w, r0.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mul o2.xyz, r1.w, r1
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c29.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c29.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o6.y, r3, r4
mul o5, r0, c29.w
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [unity_4LightPosX0]
Vector 464 [unity_4LightPosY0]
Vector 463 [unity_4LightPosZ0]
Vector 462 [unity_4LightAtten0]
Vector 461 [unity_LightColor0]
Vector 460 [unity_LightColor1]
Vector 459 [unity_LightColor2]
Vector 458 [unity_LightColor3]
Vector 457 [unity_SHAr]
Vector 456 [unity_SHAg]
Vector 455 [unity_SHAb]
Vector 454 [unity_SHBr]
Vector 453 [unity_SHBg]
Vector 452 [unity_SHBb]
Vector 451 [unity_SHC]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 450 [unity_Scale]
Vector 449 [_MainTex_ST]
Vector 448 [_BumpMap_ST]
"sce_vp_rsx // 82 instructions using 12 registers
[Configuration]
8
0000005241050c00
[Defaults]
1
447 2
000000003f800000
[Microcode]
1312
00019c6c005d200d8186c0836041fffc00041c6c00400e0c0106c0836041dffc
00029c6c005d300c0186c0836041dffc00031c6c009c220c013fc0c36041dffc
401f9c6c011c0800810040d560607f9c401f9c6c011c1808010400d740619f9c
401f9c6c01d0300d8106c0c360403f80401f9c6c01d0200d8106c0c360405f80
401f9c6c01d0100d8106c0c360409f80401f9c6c01d0000d8106c0c360411f80
00001c6c01506e0c010600c360411ffc00001c6c0150620c010600c360405ffc
00009c6c01505e0c010600c360411ffc00009c6c0150520c010600c360405ffc
00011c6c01504e0c010600c360411ffc00011c6c0150420c010600c360405ffc
00009c6c01d0500d8106c0c360409ffc00009c6c01d0400d8106c0c360403ffc
00011c6c01d0600d8106c0c360409ffc00059c6c01d0a00d8686c0c360405ffc
00059c6c01d0900d8686c0c360409ffc00059c6c01d0800d8686c0c360411ffc
00021c6c0150400c0c8600c360411ffc00001c6c0150600c0c8600c360409ffc
00001c6c0150500c0c8600c360403ffc00019c6c0190a00c0a86c0c360405ffc
00019c6c0190900c0a86c0c360409ffc00019c6c0190800c0a86c0c360411ffc
00029c6c00dcf00d8186c0aaa121fffc00031c6c00dd100d8186c0bfe0a1fffc
00039c6c00dd000d8186c0aaa0a1fffc00049c6c00800243011848436041dffc
00041c6c010002308121886304a1dffc00049c6c011c200c06bfc0e30041dffc
401f9c6c0140020c01060b4360405fb0401f9c6c01400e0c01060b4360411fb0
00019c6c0080007f8086c7436041fffc00039c6c0080000d8e86c7436041fffc
00009c6c0080007f80bfc04360409ffc00021c6c0040007f8086c08360409ffc
00021c6c0040002a8086c08360405ffc00019c6c010000000886c64361a1fffc
00031c6c0100000d8c86c64363a1fffc00039c6c00800e0c10bfc0836041dffc
00001c6c0150608c128600c360403ffc00009c6c0150508c128600c360403ffc
00011c6c0150408c128600c360403ffc00051c6c0140020c0106094360405ffc
00051c6c01400e0c1286008360411ffc00041c6c019c700c0886c0c360405ffc
00041c6c019c800c0886c0c360409ffc00041c6c019c900c0886c0c360411ffc
00009c6c010000000880046aa0a09ffc00021c6c0080000d089a04436041fffc
401f9c6c0140000c0e860b4360409fb000019c6c0100002a8086c54361a1fffc
00029c6c0100000d8a86c5436321fffc00051c6c0140000c1286074360409ffc
00031c6c01dc400d8886c0c360405ffc00031c6c01dc500d8886c0c360409ffc
00031c6c01dc600d8886c0c360411ffc00001c6c0150600c0e8600c360409ffc
00021c6c00c0000c1086c0830321dffc00031c6c009c302a828600c36041dffc
00041c6c00c0000c0c86c0830221dffc00009c6c2150500c0e8600c002b0827c
00011c6c2150400c0e8600caa2a8827c00031c6c209ce00d8a86c0d542a5e27c
00039c6c2140000c14860a5fe2a3027c00029c6c00dbf02a8186c0836321fffc
401f9c6c209c200d84bfc0c003b1e324401f9c6c109c200d82bfc0c002b1e128
401f9c6c109c200d80bfc0caa2a9e12c00001c6c1080000d8686c45542a5e17c
00001c6c129bf00d808000dfe2a3e17c401f9c6c008000000c860a436041dfa0
00001c6c0080000d8086c2436041fffc00009c6c009cc02a808600c36041dffc
00009c6c011cd000008600c300a1dffc00001c6c011cb055008600c300a1dffc
00001c6c011ca07f808600c30021dffc401f9c6c00c0000c1086c0830021dfb5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_18 * (((_World2Object * tmpvar_31).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_29;
  mediump vec3 tmpvar_34;
  mediump vec4 normal_35;
  normal_35 = tmpvar_33;
  highp float vC_36;
  mediump vec3 x3_37;
  mediump vec3 x2_38;
  mediump vec3 x1_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAr, normal_35);
  x1_39.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAg, normal_35);
  x1_39.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAb, normal_35);
  x1_39.z = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (normal_35.xyzz * normal_35.yzzx);
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBr, tmpvar_43);
  x2_38.x = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBg, tmpvar_43);
  x2_38.y = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBb, tmpvar_43);
  x2_38.z = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y));
  vC_36 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = (unity_SHC.xyz * vC_36);
  x3_37 = tmpvar_48;
  tmpvar_34 = ((x1_39 + x2_38) + x3_37);
  shlight_3 = tmpvar_34;
  tmpvar_10 = shlight_3;
  highp vec3 tmpvar_49;
  tmpvar_49 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosX0 - tmpvar_49.x);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosY0 - tmpvar_49.y);
  highp vec4 tmpvar_52;
  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_49.z);
  highp vec4 tmpvar_53;
  tmpvar_53 = (((tmpvar_50 * tmpvar_50) + (tmpvar_51 * tmpvar_51)) + (tmpvar_52 * tmpvar_52));
  highp vec4 tmpvar_54;
  tmpvar_54 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_50 * tmpvar_29.x) + (tmpvar_51 * tmpvar_29.y)) + (tmpvar_52 * tmpvar_29.z)) * inversesqrt(tmpvar_53))) * (1.0/((1.0 + (tmpvar_53 * unity_4LightAtten0)))));
  highp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_10 + ((((unity_LightColor[0].xyz * tmpvar_54.x) + (unity_LightColor[1].xyz * tmpvar_54.y)) + (unity_LightColor[2].xyz * tmpvar_54.z)) + (unity_LightColor[3].xyz * tmpvar_54.w)));
  tmpvar_10 = tmpvar_55;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_33;
  lightDir_33 = xlv_TEXCOORD5;
  mediump vec3 viewDir_34;
  viewDir_34 = xlv_TEXCOORD1;
  mediump vec4 c_35;
  mediump vec3 SpecularFinal_36;
  mediump float B_37;
  mediump float A_38;
  highp float rough_sq_39;
  highp vec3 SpecularAniso_40;
  highp float beta_b_41;
  highp float beta_a_42;
  mediump float HdotB_43;
  mediump float HdotT_44;
  mediump vec3 n_45;
  lowp vec3 tmpvar_46;
  tmpvar_46 = normalize(tmpvar_18);
  n_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = normalize(lightDir_33);
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(viewDir_34);
  mediump vec2 tmpvar_49;
  tmpvar_49.x = _AnizoX;
  tmpvar_49.y = _AnizoY;
  mediump vec2 tmpvar_50;
  tmpvar_50 = (tmpvar_49 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((n_45.yzx * vec3(0.0, 1.0, 0.0)) - (n_45.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_52;
  tmpvar_52 = clamp (dot (n_45, tmpvar_47), 0.0, 1.0);
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_47, tmpvar_51);
  HdotT_44 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (tmpvar_47, normalize(((n_45.yzx * tmpvar_51.zxy) - (n_45.zxy * tmpvar_51.yzx))));
  HdotB_43 = tmpvar_54;
  mediump float tmpvar_55;
  tmpvar_55 = (HdotT_44 / tmpvar_50.x);
  beta_a_42 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = (beta_a_42 * beta_a_42);
  beta_a_42 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotB_43 / tmpvar_50.y);
  beta_b_41 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_b_41 * beta_b_41);
  beta_b_41 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = (-2.0 * ((tmpvar_56 + tmpvar_58) / (1.0 + tmpvar_52)));
  mediump float tmpvar_60;
  tmpvar_60 = sqrt((tmpvar_52 * clamp (dot (n_45, tmpvar_48), 0.0, 1.0)));
  highp float tmpvar_61;
  tmpvar_61 = (((12.5664 * tmpvar_50.x) * tmpvar_50.y) * tmpvar_60);
  if ((tmpvar_61 != 0.0)) {
    SpecularAniso_40 = (vec3((exp(tmpvar_59) / tmpvar_61)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_40 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_62;
  tmpvar_62 = (orenNayar * orenNayar);
  rough_sq_39 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (1.0 - (0.5 * (rough_sq_39 / (rough_sq_39 + 0.57))));
  A_38 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (0.45 * (rough_sq_39 / (rough_sq_39 + 0.09)));
  B_37 = tmpvar_64;
  mediump float x_65;
  x_65 = dot (tmpvar_48, n_45);
  mediump float x_66;
  x_66 = dot (tmpvar_47, n_45);
  mediump float x_67;
  x_67 = dot (tmpvar_48, n_45);
  mediump float x_68;
  x_68 = dot (tmpvar_47, n_45);
  mediump float tmpvar_69;
  tmpvar_69 = min ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))));
  SpecularFinal_36 = SpecularAniso_40;
  c_35.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_52))) * vec3((A_38 + ((B_37 * max (0.0, dot ((tmpvar_48 - (n_45 * dot (tmpvar_48, n_45))), (tmpvar_47 - (n_45 * dot (tmpvar_47, n_45)))))) * (sin(max ((1.5708 - (sign(x_65) * (1.5708 - (sqrt((1.0 - abs(x_65))) * (1.5708 + (abs(x_65) * (-0.214602 + (abs(x_65) * (0.0865667 + (abs(x_65) * -0.0310296)))))))))), (1.5708 - (sign(x_66) * (1.5708 - (sqrt((1.0 - abs(x_66))) * (1.5708 + (abs(x_66) * (-0.214602 + (abs(x_66) * (0.0865667 + (abs(x_66) * -0.0310296)))))))))))) * (sin(tmpvar_69) / cos(tmpvar_69))))))) + ((SpecularFinal_36 * SpecularTex_15.x) * _LightColor0.xyz)) * 2.0);
  c_35.w = 1.0;
  c_1 = c_35;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_18 * (((_World2Object * tmpvar_31).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_29;
  mediump vec3 tmpvar_34;
  mediump vec4 normal_35;
  normal_35 = tmpvar_33;
  highp float vC_36;
  mediump vec3 x3_37;
  mediump vec3 x2_38;
  mediump vec3 x1_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAr, normal_35);
  x1_39.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAg, normal_35);
  x1_39.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAb, normal_35);
  x1_39.z = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (normal_35.xyzz * normal_35.yzzx);
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBr, tmpvar_43);
  x2_38.x = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBg, tmpvar_43);
  x2_38.y = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBb, tmpvar_43);
  x2_38.z = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y));
  vC_36 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = (unity_SHC.xyz * vC_36);
  x3_37 = tmpvar_48;
  tmpvar_34 = ((x1_39 + x2_38) + x3_37);
  shlight_3 = tmpvar_34;
  tmpvar_10 = shlight_3;
  highp vec3 tmpvar_49;
  tmpvar_49 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosX0 - tmpvar_49.x);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosY0 - tmpvar_49.y);
  highp vec4 tmpvar_52;
  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_49.z);
  highp vec4 tmpvar_53;
  tmpvar_53 = (((tmpvar_50 * tmpvar_50) + (tmpvar_51 * tmpvar_51)) + (tmpvar_52 * tmpvar_52));
  highp vec4 tmpvar_54;
  tmpvar_54 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_50 * tmpvar_29.x) + (tmpvar_51 * tmpvar_29.y)) + (tmpvar_52 * tmpvar_29.z)) * inversesqrt(tmpvar_53))) * (1.0/((1.0 + (tmpvar_53 * unity_4LightAtten0)))));
  highp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_10 + ((((unity_LightColor[0].xyz * tmpvar_54.x) + (unity_LightColor[1].xyz * tmpvar_54.y)) + (unity_LightColor[2].xyz * tmpvar_54.z)) + (unity_LightColor[3].xyz * tmpvar_54.w)));
  tmpvar_10 = tmpvar_55;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_33;
  lightDir_33 = xlv_TEXCOORD5;
  mediump vec3 viewDir_34;
  viewDir_34 = xlv_TEXCOORD1;
  mediump vec4 c_35;
  mediump vec3 SpecularFinal_36;
  mediump float B_37;
  mediump float A_38;
  highp float rough_sq_39;
  highp vec3 SpecularAniso_40;
  highp float beta_b_41;
  highp float beta_a_42;
  mediump float HdotB_43;
  mediump float HdotT_44;
  mediump vec3 n_45;
  lowp vec3 tmpvar_46;
  tmpvar_46 = normalize(normal_18);
  n_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = normalize(lightDir_33);
  mediump vec3 tmpvar_48;
  tmpvar_48 = normalize(viewDir_34);
  mediump vec2 tmpvar_49;
  tmpvar_49.x = _AnizoX;
  tmpvar_49.y = _AnizoY;
  mediump vec2 tmpvar_50;
  tmpvar_50 = (tmpvar_49 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((n_45.yzx * vec3(0.0, 1.0, 0.0)) - (n_45.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_52;
  tmpvar_52 = clamp (dot (n_45, tmpvar_47), 0.0, 1.0);
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_47, tmpvar_51);
  HdotT_44 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (tmpvar_47, normalize(((n_45.yzx * tmpvar_51.zxy) - (n_45.zxy * tmpvar_51.yzx))));
  HdotB_43 = tmpvar_54;
  mediump float tmpvar_55;
  tmpvar_55 = (HdotT_44 / tmpvar_50.x);
  beta_a_42 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = (beta_a_42 * beta_a_42);
  beta_a_42 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotB_43 / tmpvar_50.y);
  beta_b_41 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_b_41 * beta_b_41);
  beta_b_41 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = (-2.0 * ((tmpvar_56 + tmpvar_58) / (1.0 + tmpvar_52)));
  mediump float tmpvar_60;
  tmpvar_60 = sqrt((tmpvar_52 * clamp (dot (n_45, tmpvar_48), 0.0, 1.0)));
  highp float tmpvar_61;
  tmpvar_61 = (((12.5664 * tmpvar_50.x) * tmpvar_50.y) * tmpvar_60);
  if ((tmpvar_61 != 0.0)) {
    SpecularAniso_40 = (vec3((exp(tmpvar_59) / tmpvar_61)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_40 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_62;
  tmpvar_62 = (orenNayar * orenNayar);
  rough_sq_39 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (1.0 - (0.5 * (rough_sq_39 / (rough_sq_39 + 0.57))));
  A_38 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (0.45 * (rough_sq_39 / (rough_sq_39 + 0.09)));
  B_37 = tmpvar_64;
  mediump float x_65;
  x_65 = dot (tmpvar_48, n_45);
  mediump float x_66;
  x_66 = dot (tmpvar_47, n_45);
  mediump float x_67;
  x_67 = dot (tmpvar_48, n_45);
  mediump float x_68;
  x_68 = dot (tmpvar_47, n_45);
  mediump float tmpvar_69;
  tmpvar_69 = min ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))));
  SpecularFinal_36 = SpecularAniso_40;
  c_35.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_52))) * vec3((A_38 + ((B_37 * max (0.0, dot ((tmpvar_48 - (n_45 * dot (tmpvar_48, n_45))), (tmpvar_47 - (n_45 * dot (tmpvar_47, n_45)))))) * (sin(max ((1.5708 - (sign(x_65) * (1.5708 - (sqrt((1.0 - abs(x_65))) * (1.5708 + (abs(x_65) * (-0.214602 + (abs(x_65) * (0.0865667 + (abs(x_65) * -0.0310296)))))))))), (1.5708 - (sign(x_66) * (1.5708 - (sqrt((1.0 - abs(x_66))) * (1.5708 + (abs(x_66) * (-0.214602 + (abs(x_66) * (0.0865667 + (abs(x_66) * -0.0310296)))))))))))) * (sin(tmpvar_69) / cos(tmpvar_69))))))) + ((SpecularFinal_36 * SpecularTex_15.x) * _LightColor0.xyz)) * 2.0);
  c_35.w = 1.0;
  c_1 = c_35;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 unity_LightColor[4];
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosX0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (gl_Vertex.xyz - ((_World2Object * tmpvar_3).xyz * unity_Scale.w)));
  vec3 tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_6 = TANGENT.xyz;
  tmpvar_7 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = gl_Normal.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = gl_Normal.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = gl_Normal.z;
  vec4 v_9;
  v_9.x = _Object2World[0].x;
  v_9.y = _Object2World[1].x;
  v_9.z = _Object2World[2].x;
  v_9.w = _Object2World[3].x;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_8 * v_9.xyz);
  tmpvar_10.w = tmpvar_5.x;
  vec4 v_11;
  v_11.x = _Object2World[0].y;
  v_11.y = _Object2World[1].y;
  v_11.z = _Object2World[2].y;
  v_11.w = _Object2World[3].y;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_8 * v_11.xyz);
  tmpvar_12.w = tmpvar_5.y;
  vec4 v_13;
  v_13.x = _Object2World[0].z;
  v_13.y = _Object2World[1].z;
  v_13.z = _Object2World[2].z;
  v_13.w = _Object2World[3].z;
  vec4 tmpvar_14;
  tmpvar_14.xyz = (tmpvar_8 * v_13.xyz);
  tmpvar_14.w = tmpvar_5.z;
  mat3 tmpvar_15;
  tmpvar_15[0] = _Object2World[0].xyz;
  tmpvar_15[1] = _Object2World[1].xyz;
  tmpvar_15[2] = _Object2World[2].xyz;
  vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_16;
  vec3 x2_19;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_18);
  x1_20.y = dot (unity_SHAg, tmpvar_18);
  x1_20.z = dot (unity_SHAb, tmpvar_18);
  vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_16.xyzz * tmpvar_16.yzzx);
  x2_19.x = dot (unity_SHBr, tmpvar_21);
  x2_19.y = dot (unity_SHBg, tmpvar_21);
  x2_19.z = dot (unity_SHBb, tmpvar_21);
  vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_16.x) + (tmpvar_24 * tmpvar_16.y)) + (tmpvar_25 * tmpvar_16.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  vec4 o_28;
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_2 * 0.5);
  vec2 tmpvar_30;
  tmpvar_30.x = tmpvar_29.x;
  tmpvar_30.y = (tmpvar_29.y * _ProjectionParams.x);
  o_28.xy = (tmpvar_30 + tmpvar_29.w);
  o_28.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((tmpvar_8 * (((_World2Object * tmpvar_17).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_14 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_8 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = (((x1_20 + x2_19) + (unity_SHC.xyz * ((tmpvar_16.x * tmpvar_16.x) - (tmpvar_16.y * tmpvar_16.y)))) + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  xlv_TEXCOORD7 = o_28;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform float frePow;
uniform float freBias;
uniform float _Reflective;
uniform float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt(((1.0 - (normal_3.x * normal_3.x)) - (normal_3.y * normal_3.y)));
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD2.xyz, normalize(normal_3));
  tmpvar_6.y = dot (xlv_TEXCOORD3.xyz, normalize(normal_3));
  tmpvar_6.z = dot (xlv_TEXCOORD4.xyz, normalize(normal_3));
  vec4 tmpvar_7;
  tmpvar_7.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_6, tmpvar_2) * tmpvar_6)));
  tmpvar_7.w = (tmpvar_5.w * (roughnessV * 7.0));
  vec3 tmpvar_8;
  tmpvar_8 = ((((textureCubeLod (_Cube, tmpvar_7.xyz, tmpvar_7.w) * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - max (dot (normalize(xlv_TEXCOORD1), normalize(normal_3)), 0.0)), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * tmpvar_5) * _LightColor0).xyz;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  float atten_9;
  atten_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  vec4 c_10;
  vec3 SpecularAniso_11;
  vec3 tmpvar_12;
  tmpvar_12 = normalize(normal_3);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD5);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD1);
  vec2 tmpvar_15;
  tmpvar_15.x = _AnizoX;
  tmpvar_15.y = _AnizoY;
  vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_15 + vec2(1e-05, 1e-05));
  vec3 tmpvar_17;
  tmpvar_17 = normalize(((tmpvar_12.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_12.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_18;
  tmpvar_18 = clamp (dot (tmpvar_12, tmpvar_13), 0.0, 1.0);
  float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_13, tmpvar_17) / tmpvar_16.x);
  float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_13, normalize(((tmpvar_12.yzx * tmpvar_17.zxy) - (tmpvar_12.zxy * tmpvar_17.yzx)))) / tmpvar_16.y);
  float tmpvar_21;
  tmpvar_21 = (-2.0 * (((tmpvar_19 * tmpvar_19) + (tmpvar_20 * tmpvar_20)) / (1.0 + tmpvar_18)));
  float tmpvar_22;
  tmpvar_22 = (((12.5664 * tmpvar_16.x) * tmpvar_16.y) * sqrt((tmpvar_18 * clamp (dot (tmpvar_12, tmpvar_14), 0.0, 1.0))));
  if ((tmpvar_22 != 0.0)) {
    SpecularAniso_11 = (vec3((exp(tmpvar_21) / tmpvar_22)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_11 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_23;
  tmpvar_23 = (orenNayar * orenNayar);
  float x_24;
  x_24 = dot (tmpvar_14, tmpvar_12);
  float x_25;
  x_25 = dot (tmpvar_13, tmpvar_12);
  float x_26;
  x_26 = dot (tmpvar_14, tmpvar_12);
  float x_27;
  x_27 = dot (tmpvar_13, tmpvar_12);
  float tmpvar_28;
  tmpvar_28 = min ((1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))), (1.5708 - (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))))));
  c_10.xyz = (((((tmpvar_4 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_18))) * vec3(((1.0 - (0.5 * (tmpvar_23 / (tmpvar_23 + 0.57)))) + (((0.45 * (tmpvar_23 / (tmpvar_23 + 0.09))) * max (0.0, dot ((tmpvar_14 - (tmpvar_12 * dot (tmpvar_14, tmpvar_12))), (tmpvar_13 - (tmpvar_12 * dot (tmpvar_13, tmpvar_12)))))) * (sin(max ((1.5708 - (sign(x_24) * (1.5708 - (sqrt((1.0 - abs(x_24))) * (1.5708 + (abs(x_24) * (-0.214602 + (abs(x_24) * (0.0865667 + (abs(x_24) * -0.0310296)))))))))), (1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))))) * (sin(tmpvar_28) / cos(tmpvar_28))))))) + ((SpecularAniso_11 * tmpvar_5.x) * _LightColor0.xyz)) * (atten_9 * 2.0));
  c_10.w = 1.0;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_4 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_8);
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_3_0
; 101 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mul r1, r4.xyzz, r4.yzzx
mad r0.xyz, r0.w, c23, r0
mul r0.w, r3, r3
mad r0.w, r4.x, r4.x, -r0
dp4 r3.z, r1, c29
dp4 r3.y, r1, c28
dp4 r3.x, r1, c27
add r1.xyz, r2, r3
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mul r4.xyz, r0.w, c30
add r4.xyz, r1, r4
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mul r3.xyz, r2, v1.w
mov r1.xyz, c12
mov r1.w, c34.x
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c31.w, -v0
add o7.xyz, r4, r0
dp3 r1.y, r2, r3
dp3 r1.x, r2, v1
dp3 r1.z, v2, r2
dp3 r0.w, r1, r1
rsq r1.w, r0.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mul o2.xyz, r1.w, r1
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c31.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c31.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5, r0, c31.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c13.x
dp3 o6.y, r3, r4
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_ProjectionParams]
Vector 465 [_WorldSpaceLightPos0]
Vector 464 [unity_4LightPosX0]
Vector 463 [unity_4LightPosY0]
Vector 462 [unity_4LightPosZ0]
Vector 461 [unity_4LightAtten0]
Vector 460 [unity_LightColor0]
Vector 459 [unity_LightColor1]
Vector 458 [unity_LightColor2]
Vector 457 [unity_LightColor3]
Vector 456 [unity_SHAr]
Vector 455 [unity_SHAg]
Vector 454 [unity_SHAb]
Vector 453 [unity_SHBr]
Vector 452 [unity_SHBg]
Vector 451 [unity_SHBb]
Vector 450 [unity_SHC]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 449 [unity_Scale]
Vector 448 [_MainTex_ST]
Vector 447 [_BumpMap_ST]
"sce_vp_rsx // 87 instructions using 12 registers
[Configuration]
8
0000005741050c00
[Defaults]
1
446 3
000000003f8000003f000000
[Microcode]
1392
00021c6c005d100d8186c0836041fffc00041c6c00400e0c0106c0836041dffc
00029c6c005d300c0186c0836041dffc00031c6c009c120c013fc0c36041dffc
401f9c6c011bf800810040d560607f9c401f9c6c011c0808010400d740619f9c
00001c6c01506e0c010600c360411ffc00001c6c0150620c010600c360405ffc
00009c6c01505e0c010600c360411ffc00009c6c0150520c010600c360405ffc
00011c6c01504e0c010600c360411ffc00011c6c0150420c010600c360405ffc
00019c6c01d0300d8106c0c360403ffc00019c6c01d0200d8106c0c360405ffc
00019c6c01d0100d8106c0c360409ffc00019c6c01d0000d8106c0c360411ffc
00009c6c01d0500d8106c0c360409ffc00009c6c01d0400d8106c0c360403ffc
00011c6c01d0600d8106c0c360409ffc00059c6c01d0a00d8886c0c360405ffc
00059c6c01d0900d8886c0c360409ffc00059c6c01d0800d8886c0c360411ffc
00021c6c0150400c0c8600c360411ffc00001c6c0150600c0c8600c360409ffc
00001c6c0150500c0c8600c360403ffc00049c6c0190a00c0a86c0c360405ffc
00049c6c0190900c0a86c0c360409ffc00049c6c0190800c0a86c0c360411ffc
00029c6c00dce00d8186c0aaa121fffc00031c6c00dd000d8186c0bfe0a1fffc
00039c6c00dcf00d8186c0aaa0a1fffc00051c6c00800243011848436041dffc
00041c6c01000230812188630521dffc401f9c6c0040000d8686c0836041ff80
401f9c6c004000558686c08360407fb800049c6c011c100c12bfc0e30041dffc
00051c6c009be00e06aa80c36041dffc401f9c6c0140020c01060b4360405fb0
401f9c6c01400e0c01060b4360411fb000019c6c0080007f8086c7436041fffc
00051c6c009d202a948000c360409ffc00039c6c0080000d8e86c7436041fffc
00009c6c0080007f80bfc04360409ffc00021c6c0040007f8086c08360409ffc
00021c6c0040002a8086c08360405ffc00019c6c010000000886c64361a1fffc
00031c6c0100000d8c86c64363a1fffc401f9c6c00c000081486c09545219fb8
00039c6c00800e0c10bfc0836041dffc00001c6c0150608c128600c360403ffc
00009c6c0150508c128600c360403ffc00011c6c0150408c128600c360403ffc
00051c6c0140020c0106094360405ffc00051c6c01400e0c1286008360411ffc
00041c6c019c600c0886c0c360405ffc00041c6c019c700c0886c0c360409ffc
00041c6c019c800c0886c0c360411ffc00009c6c010000000880046aa0a09ffc
00021c6c0080000d089a04436041fffc401f9c6c0140000c0e860b4360409fb0
00019c6c0100002a8086c54361a1fffc00029c6c0100000d8a86c5436321fffc
00051c6c0140000c1286074360409ffc00031c6c01dc300d8886c0c360405ffc
00031c6c01dc400d8886c0c360409ffc00031c6c01dc500d8886c0c360411ffc
00001c6c0150600c0e8600c360409ffc00021c6c00c0000c1086c0830321dffc
00031c6c009c202a828600c36041dffc00041c6c00c0000c0c86c0830221dffc
00009c6c2150500c0e8600c002b0827c00011c6c2150400c0e8600caa2a8827c
00031c6c209cd00d8a86c0d542a5e27c00039c6c2140000c14860a5fe2a3027c
00029c6c00dbe02a8186c0836321fffc401f9c6c209c100d84bfc0c003b1e324
401f9c6c109c100d82bfc0c002b1e128401f9c6c109c100d80bfc0caa2a9e12c
00001c6c1080000d8686c45542a5e17c00001c6c129be00d808000dfe2a3e17c
401f9c6c008000000c860a436041dfa000001c6c0080000d8086c2436041fffc
00009c6c009cb02a808600c36041dffc00009c6c011cc000008600c300a1dffc
00001c6c011ca055008600c300a1dffc00001c6c011c907f808600c30021dffc
401f9c6c00c0000c1086c0830021dfb5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_18 * (((_World2Object * tmpvar_31).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_29;
  mediump vec3 tmpvar_34;
  mediump vec4 normal_35;
  normal_35 = tmpvar_33;
  highp float vC_36;
  mediump vec3 x3_37;
  mediump vec3 x2_38;
  mediump vec3 x1_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAr, normal_35);
  x1_39.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAg, normal_35);
  x1_39.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAb, normal_35);
  x1_39.z = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (normal_35.xyzz * normal_35.yzzx);
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBr, tmpvar_43);
  x2_38.x = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBg, tmpvar_43);
  x2_38.y = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBb, tmpvar_43);
  x2_38.z = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y));
  vC_36 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = (unity_SHC.xyz * vC_36);
  x3_37 = tmpvar_48;
  tmpvar_34 = ((x1_39 + x2_38) + x3_37);
  shlight_3 = tmpvar_34;
  tmpvar_10 = shlight_3;
  highp vec3 tmpvar_49;
  tmpvar_49 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosX0 - tmpvar_49.x);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosY0 - tmpvar_49.y);
  highp vec4 tmpvar_52;
  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_49.z);
  highp vec4 tmpvar_53;
  tmpvar_53 = (((tmpvar_50 * tmpvar_50) + (tmpvar_51 * tmpvar_51)) + (tmpvar_52 * tmpvar_52));
  highp vec4 tmpvar_54;
  tmpvar_54 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_50 * tmpvar_29.x) + (tmpvar_51 * tmpvar_29.y)) + (tmpvar_52 * tmpvar_29.z)) * inversesqrt(tmpvar_53))) * (1.0/((1.0 + (tmpvar_53 * unity_4LightAtten0)))));
  highp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_10 + ((((unity_LightColor[0].xyz * tmpvar_54.x) + (unity_LightColor[1].xyz * tmpvar_54.y)) + (unity_LightColor[2].xyz * tmpvar_54.z)) + (unity_LightColor[3].xyz * tmpvar_54.w)));
  tmpvar_10 = tmpvar_55;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float tmpvar_33;
  mediump float lightShadowDataX_34;
  highp float dist_35;
  lowp float tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  dist_35 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = _LightShadowData.x;
  lightShadowDataX_34 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = max (float((dist_35 > (xlv_TEXCOORD7.z / xlv_TEXCOORD7.w))), lightShadowDataX_34);
  tmpvar_33 = tmpvar_38;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_39;
  lightDir_39 = xlv_TEXCOORD5;
  mediump vec3 viewDir_40;
  viewDir_40 = xlv_TEXCOORD1;
  mediump float atten_41;
  atten_41 = tmpvar_33;
  mediump vec4 c_42;
  mediump vec3 SpecularFinal_43;
  mediump float B_44;
  mediump float A_45;
  highp float rough_sq_46;
  highp vec3 SpecularAniso_47;
  highp float beta_b_48;
  highp float beta_a_49;
  mediump float HdotB_50;
  mediump float HdotT_51;
  mediump vec3 n_52;
  lowp vec3 tmpvar_53;
  tmpvar_53 = normalize(tmpvar_18);
  n_52 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54 = normalize(lightDir_39);
  mediump vec3 tmpvar_55;
  tmpvar_55 = normalize(viewDir_40);
  mediump vec2 tmpvar_56;
  tmpvar_56.x = _AnizoX;
  tmpvar_56.y = _AnizoY;
  mediump vec2 tmpvar_57;
  tmpvar_57 = (tmpvar_56 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_58;
  tmpvar_58 = normalize(((n_52.yzx * vec3(0.0, 1.0, 0.0)) - (n_52.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_59;
  tmpvar_59 = clamp (dot (n_52, tmpvar_54), 0.0, 1.0);
  highp float tmpvar_60;
  tmpvar_60 = dot (tmpvar_54, tmpvar_58);
  HdotT_51 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = dot (tmpvar_54, normalize(((n_52.yzx * tmpvar_58.zxy) - (n_52.zxy * tmpvar_58.yzx))));
  HdotB_50 = tmpvar_61;
  mediump float tmpvar_62;
  tmpvar_62 = (HdotT_51 / tmpvar_57.x);
  beta_a_49 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (beta_a_49 * beta_a_49);
  beta_a_49 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = (HdotB_50 / tmpvar_57.y);
  beta_b_48 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (beta_b_48 * beta_b_48);
  beta_b_48 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (-2.0 * ((tmpvar_63 + tmpvar_65) / (1.0 + tmpvar_59)));
  mediump float tmpvar_67;
  tmpvar_67 = sqrt((tmpvar_59 * clamp (dot (n_52, tmpvar_55), 0.0, 1.0)));
  highp float tmpvar_68;
  tmpvar_68 = (((12.5664 * tmpvar_57.x) * tmpvar_57.y) * tmpvar_67);
  if ((tmpvar_68 != 0.0)) {
    SpecularAniso_47 = (vec3((exp(tmpvar_66) / tmpvar_68)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_47 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_69;
  tmpvar_69 = (orenNayar * orenNayar);
  rough_sq_46 = tmpvar_69;
  highp float tmpvar_70;
  tmpvar_70 = (1.0 - (0.5 * (rough_sq_46 / (rough_sq_46 + 0.57))));
  A_45 = tmpvar_70;
  highp float tmpvar_71;
  tmpvar_71 = (0.45 * (rough_sq_46 / (rough_sq_46 + 0.09)));
  B_44 = tmpvar_71;
  mediump float x_72;
  x_72 = dot (tmpvar_55, n_52);
  mediump float x_73;
  x_73 = dot (tmpvar_54, n_52);
  mediump float x_74;
  x_74 = dot (tmpvar_55, n_52);
  mediump float x_75;
  x_75 = dot (tmpvar_54, n_52);
  mediump float tmpvar_76;
  tmpvar_76 = min ((1.5708 - (sign(x_74) * (1.5708 - (sqrt((1.0 - abs(x_74))) * (1.5708 + (abs(x_74) * (-0.214602 + (abs(x_74) * (0.0865667 + (abs(x_74) * -0.0310296)))))))))), (1.5708 - (sign(x_75) * (1.5708 - (sqrt((1.0 - abs(x_75))) * (1.5708 + (abs(x_75) * (-0.214602 + (abs(x_75) * (0.0865667 + (abs(x_75) * -0.0310296)))))))))));
  SpecularFinal_43 = SpecularAniso_47;
  c_42.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_59))) * vec3((A_45 + ((B_44 * max (0.0, dot ((tmpvar_55 - (n_52 * dot (tmpvar_55, n_52))), (tmpvar_54 - (n_52 * dot (tmpvar_54, n_52)))))) * (sin(max ((1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))), (1.5708 - (sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296)))))))))))) * (sin(tmpvar_76) / cos(tmpvar_76))))))) + ((SpecularFinal_43 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_41 * 2.0));
  c_42.w = 1.0;
  c_1 = c_42;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (gl_ModelViewProjectionMatrix * _glesVertex);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_15;
  tmpvar_15[0] = _Object2World[0].xyz;
  tmpvar_15[1] = _Object2World[1].xyz;
  tmpvar_15[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * (_glesVertex.xyz - ((_World2Object * tmpvar_14).xyz * unity_Scale.w)));
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_1.xyz;
  tmpvar_18 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_2.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_2.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_2.z;
  vec4 v_20;
  v_20.x = _Object2World[0].x;
  v_20.y = _Object2World[1].x;
  v_20.z = _Object2World[2].x;
  v_20.w = _Object2World[3].x;
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = (tmpvar_19 * v_20.xyz);
  tmpvar_21.w = tmpvar_16.x;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_21 * unity_Scale.w);
  tmpvar_6 = tmpvar_22;
  vec4 v_23;
  v_23.x = _Object2World[0].y;
  v_23.y = _Object2World[1].y;
  v_23.z = _Object2World[2].y;
  v_23.w = _Object2World[3].y;
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (tmpvar_19 * v_23.xyz);
  tmpvar_24.w = tmpvar_16.y;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_24 * unity_Scale.w);
  tmpvar_7 = tmpvar_25;
  vec4 v_26;
  v_26.x = _Object2World[0].z;
  v_26.y = _Object2World[1].z;
  v_26.z = _Object2World[2].z;
  v_26.w = _Object2World[3].z;
  highp vec4 tmpvar_27;
  tmpvar_27.xyz = (tmpvar_19 * v_26.xyz);
  tmpvar_27.w = tmpvar_16.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * unity_Scale.w);
  tmpvar_8 = tmpvar_28;
  mat3 tmpvar_29;
  tmpvar_29[0] = _Object2World[0].xyz;
  tmpvar_29[1] = _Object2World[1].xyz;
  tmpvar_29[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_19 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_19 * (((_World2Object * tmpvar_32).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_30;
  mediump vec3 tmpvar_35;
  mediump vec4 normal_36;
  normal_36 = tmpvar_34;
  highp float vC_37;
  mediump vec3 x3_38;
  mediump vec3 x2_39;
  mediump vec3 x1_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAr, normal_36);
  x1_40.x = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAg, normal_36);
  x1_40.y = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHAb, normal_36);
  x1_40.z = tmpvar_43;
  mediump vec4 tmpvar_44;
  tmpvar_44 = (normal_36.xyzz * normal_36.yzzx);
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBr, tmpvar_44);
  x2_39.x = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBg, tmpvar_44);
  x2_39.y = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = dot (unity_SHBb, tmpvar_44);
  x2_39.z = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y));
  vC_37 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = (unity_SHC.xyz * vC_37);
  x3_38 = tmpvar_49;
  tmpvar_35 = ((x1_40 + x2_39) + x3_38);
  shlight_3 = tmpvar_35;
  tmpvar_10 = shlight_3;
  highp vec3 tmpvar_50;
  tmpvar_50 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosX0 - tmpvar_50.x);
  highp vec4 tmpvar_52;
  tmpvar_52 = (unity_4LightPosY0 - tmpvar_50.y);
  highp vec4 tmpvar_53;
  tmpvar_53 = (unity_4LightPosZ0 - tmpvar_50.z);
  highp vec4 tmpvar_54;
  tmpvar_54 = (((tmpvar_51 * tmpvar_51) + (tmpvar_52 * tmpvar_52)) + (tmpvar_53 * tmpvar_53));
  highp vec4 tmpvar_55;
  tmpvar_55 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_51 * tmpvar_30.x) + (tmpvar_52 * tmpvar_30.y)) + (tmpvar_53 * tmpvar_30.z)) * inversesqrt(tmpvar_54))) * (1.0/((1.0 + (tmpvar_54 * unity_4LightAtten0)))));
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_10 + ((((unity_LightColor[0].xyz * tmpvar_55.x) + (unity_LightColor[1].xyz * tmpvar_55.y)) + (unity_LightColor[2].xyz * tmpvar_55.z)) + (unity_LightColor[3].xyz * tmpvar_55.w)));
  tmpvar_10 = tmpvar_56;
  highp vec4 o_57;
  highp vec4 tmpvar_58;
  tmpvar_58 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_59;
  tmpvar_59.x = tmpvar_58.x;
  tmpvar_59.y = (tmpvar_58.y * _ProjectionParams.x);
  o_57.xy = (tmpvar_59 + tmpvar_58.w);
  o_57.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = o_57;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_18.z = sqrt(((1.0 - (normal_18.x * normal_18.x)) - (normal_18.y * normal_18.y)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float tmpvar_33;
  tmpvar_33 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7).x;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_34;
  lightDir_34 = xlv_TEXCOORD5;
  mediump vec3 viewDir_35;
  viewDir_35 = xlv_TEXCOORD1;
  mediump float atten_36;
  atten_36 = tmpvar_33;
  mediump vec4 c_37;
  mediump vec3 SpecularFinal_38;
  mediump float B_39;
  mediump float A_40;
  highp float rough_sq_41;
  highp vec3 SpecularAniso_42;
  highp float beta_b_43;
  highp float beta_a_44;
  mediump float HdotB_45;
  mediump float HdotT_46;
  mediump vec3 n_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = normalize(normal_18);
  n_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = normalize(lightDir_34);
  mediump vec3 tmpvar_50;
  tmpvar_50 = normalize(viewDir_35);
  mediump vec2 tmpvar_51;
  tmpvar_51.x = _AnizoX;
  tmpvar_51.y = _AnizoY;
  mediump vec2 tmpvar_52;
  tmpvar_52 = (tmpvar_51 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(((n_47.yzx * vec3(0.0, 1.0, 0.0)) - (n_47.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_54;
  tmpvar_54 = clamp (dot (n_47, tmpvar_49), 0.0, 1.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (tmpvar_49, tmpvar_53);
  HdotT_46 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (tmpvar_49, normalize(((n_47.yzx * tmpvar_53.zxy) - (n_47.zxy * tmpvar_53.yzx))));
  HdotB_45 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotT_46 / tmpvar_52.x);
  beta_a_44 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_a_44 * beta_a_44);
  beta_a_44 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotB_45 / tmpvar_52.y);
  beta_b_43 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_b_43 * beta_b_43);
  beta_b_43 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (-2.0 * ((tmpvar_58 + tmpvar_60) / (1.0 + tmpvar_54)));
  mediump float tmpvar_62;
  tmpvar_62 = sqrt((tmpvar_54 * clamp (dot (n_47, tmpvar_50), 0.0, 1.0)));
  highp float tmpvar_63;
  tmpvar_63 = (((12.5664 * tmpvar_52.x) * tmpvar_52.y) * tmpvar_62);
  if ((tmpvar_63 != 0.0)) {
    SpecularAniso_42 = (vec3((exp(tmpvar_61) / tmpvar_63)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_42 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_64;
  tmpvar_64 = (orenNayar * orenNayar);
  rough_sq_41 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (1.0 - (0.5 * (rough_sq_41 / (rough_sq_41 + 0.57))));
  A_40 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (0.45 * (rough_sq_41 / (rough_sq_41 + 0.09)));
  B_39 = tmpvar_66;
  mediump float x_67;
  x_67 = dot (tmpvar_50, n_47);
  mediump float x_68;
  x_68 = dot (tmpvar_49, n_47);
  mediump float x_69;
  x_69 = dot (tmpvar_50, n_47);
  mediump float x_70;
  x_70 = dot (tmpvar_49, n_47);
  mediump float tmpvar_71;
  tmpvar_71 = min ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))));
  SpecularFinal_38 = SpecularAniso_42;
  c_37.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_54))) * vec3((A_40 + ((B_39 * max (0.0, dot ((tmpvar_50 - (n_47 * dot (tmpvar_50, n_47))), (tmpvar_49 - (n_47 * dot (tmpvar_49, n_47)))))) * (sin(max ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))))) * (sin(tmpvar_71) / cos(tmpvar_71))))))) + ((SpecularFinal_38 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_36 * 2.0));
  c_37.w = 1.0;
  c_1 = c_37;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_18 * (((_World2Object * tmpvar_30).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_33;
  mediump vec4 normal_34;
  normal_34 = tmpvar_32;
  highp float vC_35;
  mediump vec3 x3_36;
  mediump vec3 x2_37;
  mediump vec3 x1_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (unity_SHAr, normal_34);
  x1_38.x = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAg, normal_34);
  x1_38.y = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAb, normal_34);
  x1_38.z = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_34.xyzz * normal_34.yzzx);
  highp float tmpvar_43;
  tmpvar_43 = dot (unity_SHBr, tmpvar_42);
  x2_37.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBg, tmpvar_42);
  x2_37.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBb, tmpvar_42);
  x2_37.z = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y));
  vC_35 = tmpvar_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = (unity_SHC.xyz * vC_35);
  x3_36 = tmpvar_47;
  tmpvar_33 = ((x1_38 + x2_37) + x3_36);
  shlight_3 = tmpvar_33;
  tmpvar_10 = shlight_3;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float shadow_33;
  lowp float tmpvar_34;
  tmpvar_34 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_35;
  tmpvar_35 = (_LightShadowData.x + (tmpvar_34 * (1.0 - _LightShadowData.x)));
  shadow_33 = tmpvar_35;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_36;
  lightDir_36 = xlv_TEXCOORD5;
  mediump vec3 viewDir_37;
  viewDir_37 = xlv_TEXCOORD1;
  mediump float atten_38;
  atten_38 = shadow_33;
  mediump vec4 c_39;
  mediump vec3 SpecularFinal_40;
  mediump float B_41;
  mediump float A_42;
  highp float rough_sq_43;
  highp vec3 SpecularAniso_44;
  highp float beta_b_45;
  highp float beta_a_46;
  mediump float HdotB_47;
  mediump float HdotT_48;
  mediump vec3 n_49;
  lowp vec3 tmpvar_50;
  tmpvar_50 = normalize(tmpvar_18);
  n_49 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = normalize(lightDir_36);
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(viewDir_37);
  mediump vec2 tmpvar_53;
  tmpvar_53.x = _AnizoX;
  tmpvar_53.y = _AnizoY;
  mediump vec2 tmpvar_54;
  tmpvar_54 = (tmpvar_53 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(((n_49.yzx * vec3(0.0, 1.0, 0.0)) - (n_49.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (n_49, tmpvar_51), 0.0, 1.0);
  highp float tmpvar_57;
  tmpvar_57 = dot (tmpvar_51, tmpvar_55);
  HdotT_48 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_51, normalize(((n_49.yzx * tmpvar_55.zxy) - (n_49.zxy * tmpvar_55.yzx))));
  HdotB_47 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotT_48 / tmpvar_54.x);
  beta_a_46 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_a_46 * beta_a_46);
  beta_a_46 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = (HdotB_47 / tmpvar_54.y);
  beta_b_45 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = (beta_b_45 * beta_b_45);
  beta_b_45 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (-2.0 * ((tmpvar_60 + tmpvar_62) / (1.0 + tmpvar_56)));
  mediump float tmpvar_64;
  tmpvar_64 = sqrt((tmpvar_56 * clamp (dot (n_49, tmpvar_52), 0.0, 1.0)));
  highp float tmpvar_65;
  tmpvar_65 = (((12.5664 * tmpvar_54.x) * tmpvar_54.y) * tmpvar_64);
  if ((tmpvar_65 != 0.0)) {
    SpecularAniso_44 = (vec3((exp(tmpvar_63) / tmpvar_65)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_44 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_66;
  tmpvar_66 = (orenNayar * orenNayar);
  rough_sq_43 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (1.0 - (0.5 * (rough_sq_43 / (rough_sq_43 + 0.57))));
  A_42 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (0.45 * (rough_sq_43 / (rough_sq_43 + 0.09)));
  B_41 = tmpvar_68;
  mediump float x_69;
  x_69 = dot (tmpvar_52, n_49);
  mediump float x_70;
  x_70 = dot (tmpvar_51, n_49);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_49);
  mediump float x_72;
  x_72 = dot (tmpvar_51, n_49);
  mediump float tmpvar_73;
  tmpvar_73 = min ((1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))), (1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))));
  SpecularFinal_40 = SpecularAniso_44;
  c_39.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_56))) * vec3((A_42 + ((B_41 * max (0.0, dot ((tmpvar_52 - (n_49 * dot (tmpvar_52, n_49))), (tmpvar_51 - (n_49 * dot (tmpvar_51, n_49)))))) * (sin(max ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))))) * (sin(tmpvar_73) / cos(tmpvar_73))))))) + ((SpecularFinal_40 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_38 * 2.0));
  c_39.w = 1.0;
  c_1 = c_39;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_11;
  tmpvar_11[0] = _Object2World[0].xyz;
  tmpvar_11[1] = _Object2World[1].xyz;
  tmpvar_11[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesVertex.xyz - ((_World2Object * tmpvar_10).xyz * unity_Scale.w)));
  highp vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_13 = tmpvar_1.xyz;
  tmpvar_14 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_15;
  tmpvar_15[0].x = tmpvar_13.x;
  tmpvar_15[0].y = tmpvar_14.x;
  tmpvar_15[0].z = tmpvar_2.x;
  tmpvar_15[1].x = tmpvar_13.y;
  tmpvar_15[1].y = tmpvar_14.y;
  tmpvar_15[1].z = tmpvar_2.y;
  tmpvar_15[2].x = tmpvar_13.z;
  tmpvar_15[2].y = tmpvar_14.z;
  tmpvar_15[2].z = tmpvar_2.z;
  vec4 v_16;
  v_16.x = _Object2World[0].x;
  v_16.y = _Object2World[1].x;
  v_16.z = _Object2World[2].x;
  v_16.w = _Object2World[3].x;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (tmpvar_15 * v_16.xyz);
  tmpvar_17.w = tmpvar_12.x;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * unity_Scale.w);
  tmpvar_5 = tmpvar_18;
  vec4 v_19;
  v_19.x = _Object2World[0].y;
  v_19.y = _Object2World[1].y;
  v_19.z = _Object2World[2].y;
  v_19.w = _Object2World[3].y;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_15 * v_19.xyz);
  tmpvar_20.w = tmpvar_12.y;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].z;
  v_22.y = _Object2World[1].z;
  v_22.z = _Object2World[2].z;
  v_22.w = _Object2World[3].z;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_15 * v_22.xyz);
  tmpvar_23.w = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_15 * (((_World2Object * tmpvar_25).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_4 = tmpvar_26;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD6 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD6;
varying highp vec2 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float shadow_33;
  lowp float tmpvar_34;
  tmpvar_34 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD6.xyz);
  highp float tmpvar_35;
  tmpvar_35 = (_LightShadowData.x + (tmpvar_34 * (1.0 - _LightShadowData.x)));
  shadow_33 = tmpvar_35;
  c_1.xyz = (tmpvar_11 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD5).xyz), vec3((shadow_33 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  mediump vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.xy = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_4.zw = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (_glesVertex.xyz - ((_World2Object * tmpvar_13).xyz * unity_Scale.w)));
  highp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_16 = tmpvar_1.xyz;
  tmpvar_17 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_18;
  tmpvar_18[0].x = tmpvar_16.x;
  tmpvar_18[0].y = tmpvar_17.x;
  tmpvar_18[0].z = tmpvar_2.x;
  tmpvar_18[1].x = tmpvar_16.y;
  tmpvar_18[1].y = tmpvar_17.y;
  tmpvar_18[1].z = tmpvar_2.y;
  tmpvar_18[2].x = tmpvar_16.z;
  tmpvar_18[2].y = tmpvar_17.z;
  tmpvar_18[2].z = tmpvar_2.z;
  vec4 v_19;
  v_19.x = _Object2World[0].x;
  v_19.y = _Object2World[1].x;
  v_19.z = _Object2World[2].x;
  v_19.w = _Object2World[3].x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_18 * v_19.xyz);
  tmpvar_20.w = tmpvar_15.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_6 = tmpvar_21;
  vec4 v_22;
  v_22.x = _Object2World[0].y;
  v_22.y = _Object2World[1].y;
  v_22.z = _Object2World[2].y;
  v_22.w = _Object2World[3].y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_18 * v_22.xyz);
  tmpvar_23.w = tmpvar_15.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_7 = tmpvar_24;
  vec4 v_25;
  v_25.x = _Object2World[0].z;
  v_25.y = _Object2World[1].z;
  v_25.z = _Object2World[2].z;
  v_25.w = _Object2World[3].z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_18 * v_25.xyz);
  tmpvar_26.w = tmpvar_15.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_8 = tmpvar_27;
  mat3 tmpvar_28;
  tmpvar_28[0] = _Object2World[0].xyz;
  tmpvar_28[1] = _Object2World[1].xyz;
  tmpvar_28[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_28 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_18 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_9 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_18 * (((_World2Object * tmpvar_31).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_29;
  mediump vec3 tmpvar_34;
  mediump vec4 normal_35;
  normal_35 = tmpvar_33;
  highp float vC_36;
  mediump vec3 x3_37;
  mediump vec3 x2_38;
  mediump vec3 x1_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (unity_SHAr, normal_35);
  x1_39.x = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = dot (unity_SHAg, normal_35);
  x1_39.y = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = dot (unity_SHAb, normal_35);
  x1_39.z = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (normal_35.xyzz * normal_35.yzzx);
  highp float tmpvar_44;
  tmpvar_44 = dot (unity_SHBr, tmpvar_43);
  x2_38.x = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (unity_SHBg, tmpvar_43);
  x2_38.y = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = dot (unity_SHBb, tmpvar_43);
  x2_38.z = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y));
  vC_36 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = (unity_SHC.xyz * vC_36);
  x3_37 = tmpvar_48;
  tmpvar_34 = ((x1_39 + x2_38) + x3_37);
  shlight_3 = tmpvar_34;
  tmpvar_10 = shlight_3;
  highp vec3 tmpvar_49;
  tmpvar_49 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_50;
  tmpvar_50 = (unity_4LightPosX0 - tmpvar_49.x);
  highp vec4 tmpvar_51;
  tmpvar_51 = (unity_4LightPosY0 - tmpvar_49.y);
  highp vec4 tmpvar_52;
  tmpvar_52 = (unity_4LightPosZ0 - tmpvar_49.z);
  highp vec4 tmpvar_53;
  tmpvar_53 = (((tmpvar_50 * tmpvar_50) + (tmpvar_51 * tmpvar_51)) + (tmpvar_52 * tmpvar_52));
  highp vec4 tmpvar_54;
  tmpvar_54 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_50 * tmpvar_29.x) + (tmpvar_51 * tmpvar_29.y)) + (tmpvar_52 * tmpvar_29.z)) * inversesqrt(tmpvar_53))) * (1.0/((1.0 + (tmpvar_53 * unity_4LightAtten0)))));
  highp vec3 tmpvar_55;
  tmpvar_55 = (tmpvar_10 + ((((unity_LightColor[0].xyz * tmpvar_54.x) + (unity_LightColor[1].xyz * tmpvar_54.y)) + (unity_LightColor[2].xyz * tmpvar_54.z)) + (unity_LightColor[3].xyz * tmpvar_54.w)));
  tmpvar_10 = tmpvar_55;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_9;
  xlv_TEXCOORD6 = tmpvar_10;
  xlv_TEXCOORD7 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD7;
varying lowp vec3 xlv_TEXCOORD6;
varying lowp vec3 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform mediump float frePow;
uniform mediump float freBias;
uniform mediump float _Reflective;
uniform mediump float roughnessV;
uniform samplerCube _Cube;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD3.w;
  tmpvar_7.z = xlv_TEXCOORD4.w;
  tmpvar_2 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_4 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_5 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  tmpvar_6 = tmpvar_10;
  tmpvar_3 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp float tmpvar_13;
  mediump vec4 env_14;
  mediump vec4 SpecularTex_15;
  mediump float ThiagoNdotL_16;
  mediump vec4 mainTex_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_17 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_18);
  highp float tmpvar_21;
  tmpvar_21 = max (dot (normalize(tmpvar_3), tmpvar_20), 0.0);
  ThiagoNdotL_16 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (mainTex_17 * _Color).xyz;
  tmpvar_11 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_15 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = SpecularTex_15.w;
  tmpvar_13 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_13 * (roughnessV * 7.0));
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_18);
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_18);
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(tmpvar_18);
  mediump vec3 tmpvar_29;
  tmpvar_29.x = dot (tmpvar_4, tmpvar_26);
  tmpvar_29.y = dot (tmpvar_5, tmpvar_27);
  tmpvar_29.z = dot (tmpvar_6, tmpvar_28);
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (tmpvar_2 - (2.0 * (dot (tmpvar_29, tmpvar_2) * tmpvar_29)));
  tmpvar_30.w = tmpvar_25;
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCubeLod (_Cube, tmpvar_30.xyz, tmpvar_30.w);
  env_14 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = ((((env_14 * clamp (max ((freBias + ((1.0 - freBias) * pow ((1.0 - ThiagoNdotL_16), frePow))), 0.0), 0.0, 1.0)) * _Reflective) * SpecularTex_15) * _LightColor0).xyz;
  tmpvar_12 = tmpvar_32;
  lowp float shadow_33;
  lowp float tmpvar_34;
  tmpvar_34 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD7.xyz);
  highp float tmpvar_35;
  tmpvar_35 = (_LightShadowData.x + (tmpvar_34 * (1.0 - _LightShadowData.x)));
  shadow_33 = tmpvar_35;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_36;
  lightDir_36 = xlv_TEXCOORD5;
  mediump vec3 viewDir_37;
  viewDir_37 = xlv_TEXCOORD1;
  mediump float atten_38;
  atten_38 = shadow_33;
  mediump vec4 c_39;
  mediump vec3 SpecularFinal_40;
  mediump float B_41;
  mediump float A_42;
  highp float rough_sq_43;
  highp vec3 SpecularAniso_44;
  highp float beta_b_45;
  highp float beta_a_46;
  mediump float HdotB_47;
  mediump float HdotT_48;
  mediump vec3 n_49;
  lowp vec3 tmpvar_50;
  tmpvar_50 = normalize(tmpvar_18);
  n_49 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = normalize(lightDir_36);
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(viewDir_37);
  mediump vec2 tmpvar_53;
  tmpvar_53.x = _AnizoX;
  tmpvar_53.y = _AnizoY;
  mediump vec2 tmpvar_54;
  tmpvar_54 = (tmpvar_53 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(((n_49.yzx * vec3(0.0, 1.0, 0.0)) - (n_49.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (n_49, tmpvar_51), 0.0, 1.0);
  highp float tmpvar_57;
  tmpvar_57 = dot (tmpvar_51, tmpvar_55);
  HdotT_48 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_51, normalize(((n_49.yzx * tmpvar_55.zxy) - (n_49.zxy * tmpvar_55.yzx))));
  HdotB_47 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotT_48 / tmpvar_54.x);
  beta_a_46 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_a_46 * beta_a_46);
  beta_a_46 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = (HdotB_47 / tmpvar_54.y);
  beta_b_45 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = (beta_b_45 * beta_b_45);
  beta_b_45 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (-2.0 * ((tmpvar_60 + tmpvar_62) / (1.0 + tmpvar_56)));
  mediump float tmpvar_64;
  tmpvar_64 = sqrt((tmpvar_56 * clamp (dot (n_49, tmpvar_52), 0.0, 1.0)));
  highp float tmpvar_65;
  tmpvar_65 = (((12.5664 * tmpvar_54.x) * tmpvar_54.y) * tmpvar_64);
  if ((tmpvar_65 != 0.0)) {
    SpecularAniso_44 = (vec3((exp(tmpvar_63) / tmpvar_65)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_44 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_66;
  tmpvar_66 = (orenNayar * orenNayar);
  rough_sq_43 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (1.0 - (0.5 * (rough_sq_43 / (rough_sq_43 + 0.57))));
  A_42 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (0.45 * (rough_sq_43 / (rough_sq_43 + 0.09)));
  B_41 = tmpvar_68;
  mediump float x_69;
  x_69 = dot (tmpvar_52, n_49);
  mediump float x_70;
  x_70 = dot (tmpvar_51, n_49);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_49);
  mediump float x_72;
  x_72 = dot (tmpvar_51, n_49);
  mediump float tmpvar_73;
  tmpvar_73 = min ((1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))), (1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))));
  SpecularFinal_40 = SpecularAniso_44;
  c_39.xyz = (((((tmpvar_11 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_56))) * vec3((A_42 + ((B_41 * max (0.0, dot ((tmpvar_52 - (n_49 * dot (tmpvar_52, n_49))), (tmpvar_51 - (n_49 * dot (tmpvar_51, n_49)))))) * (sin(max ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))))) * (sin(tmpvar_73) / cos(tmpvar_73))))))) + ((SpecularFinal_40 * SpecularTex_15.x) * _LightColor0.xyz)) * (atten_38 * 2.0));
  c_39.w = 1.0;
  c_1 = c_39;
  c_1.xyz = (c_1.xyz + (tmpvar_11 * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_12);
  gl_FragData[0] = c_1;
}



#endif"
}

}
Program "fp" {
// Fragment combos: 4
//   d3d9 - ALU: 43 to 166, TEX: 5 to 7
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [roughnessV]
Float 4 [_Reflective]
Float 5 [freBias]
Float 6 [frePow]
Float 7 [orenNayar]
Float 8 [_AnizoX]
Float 9 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
"ps_3_0
; 164 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c10, 2.00000000, -1.00000000, 7.00000000, 1.00000000
def c11, 0.00000000, 0.56999999, 0.09000000, 1.00000000
def c12, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c13, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c14, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c15, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c10.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r3.xyz, r0.w, r0
mul_pp r0.xyz, -r3.zxyw, c11.xxww
mad_pp r0.xyz, r3.yzxw, c11.xwxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r3.zxyw, r0.yzxw
mad_pp r1.xyz, r3.yzxw, r0.zxyw, -r1
dp3_pp r1.w, r1, r1
rsq_pp r1.w, r1.w
mul_pp r1.xyz, r1.w, r1
dp3_pp r0.w, v5, v5
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, v5
dp3_pp_sat r3.w, r3, r4
dp3_pp r0.x, r4, r0
add r0.z, r3.w, c10.w
dp3_pp r4.w, r3, r4
dp3_pp r0.w, r4, r1
rcp_pp r1.w, c9.x
mul_pp r0.w, r0, r1
mul r1.x, r0.w, r0.w
rcp_pp r0.w, c8.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.x
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, v1
dp3_pp_sat r0.x, r3, r5
mul_pp r0.x, r3.w, r0
mul r1.y, r0, c14.w
rsq_pp r0.y, r0.x
mov r0.x, c8
dp3_pp r5.w, r3, r5
rcp_pp r0.y, r0.y
mul r0.x, c9, r0
mul r1.x, r0, r0.y
pow r0, c15.x, r1.y
mul r0.y, r1.x, c14.z
rcp r0.z, r0.y
abs r0.w, r0.y
cmp r0.w, -r0, c11.x, c11
abs_pp r1.x, r0.w
abs_pp r0.w, r4
add_pp r1.y, -r0.w, c10.w
mul r0.x, r0, r0.z
mul r0.xyz, r0.x, c2
cmp r0.xyz, -r1.x, c11.x, r0
mad_pp r1.x, r0.w, c12, c12.y
mad_pp r1.x, r1, r0.w, c12.z
mad_pp r0.w, r1.x, r0, c12
rsq_pp r1.y, r1.y
rcp_pp r1.x, r1.y
mul_pp r1.w, r0, r1.x
abs_pp r1.x, r5.w
cmp_pp r0.w, r4, c11.x, c11
mul_pp r2.x, r0.w, r1.w
mad_pp r1.w, -r2.x, c10.x, r1
add_pp r1.z, -r1.x, c10.w
mad_pp r1.y, r1.x, c12.x, c12
mad_pp r1.y, r1, r1.x, c12.z
rsq_pp r1.z, r1.z
mad_pp r0.w, r0, c13.x, r1
mad_pp r1.x, r1.y, r1, c12.w
rcp_pp r1.z, r1.z
mul_pp r1.y, r1.x, r1.z
cmp_pp r1.x, r5.w, c11, c11.w
mul_pp r1.z, r1.x, r1.y
mad_pp r1.y, -r1.z, c10.x, r1
mad_pp r2.x, r1, c13, r1.y
texld r1, v0, s2
mul_pp r0.xyz, r1.x, r0
mul_pp r6.xyz, r0, c0
min_pp r2.y, r2.x, r0.w
max_pp r0.x, r2, r0.w
mad_pp r2.y, r2, c13, c13.z
frc_pp r0.y, r2
mad_pp r2.y, r0, c14.x, c14
mad_pp r2.x, r0, c13.y, c13.z
sincos_pp r0.xy, r2.y
frc_pp r0.z, r2.x
mad_pp r0.z, r0, c14.x, c14.y
sincos_pp r2.xy, r0.z
rcp_pp r0.x, r0.x
mul_pp r0.x, r0.y, r0
mul_pp r0.w, r2.y, r0.x
mad_pp r0.xyz, -r3, r5.w, r5
mad_pp r2.xyz, -r3, r4.w, r4
dp3_pp r0.y, r0, r2
mul_pp r2.w, c7.x, c7.x
add r4.x, r2.w, c11.z
rcp r0.x, r4.x
dp3_pp r5.x, v2, r3
dp3_pp r5.y, r3, v3
dp3_pp r5.z, r3, v4
max r0.y, r0, c11.x
mul r0.x, r2.w, r0
mul r0.x, r0, r0.y
mul r0.y, r0.x, r0.w
add r0.x, r2.w, c11.y
mul r0.z, r0.y, c13.w
rcp r0.y, r0.x
mul r0.y, r2.w, r0
mad r0.w, -r0.y, c13.z, r0.z
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r2.x, r3, r0
texld r0.xyz, v0, s1
max r2.w, r2.x, c11.x
mul_pp r0.xyz, r0, c1
mul_pp r2.xyz, r0, c0
max r3.w, r3, c11.x
mul_pp r2.xyz, r2, r3.w
add r0.w, r0, c10
mad_pp r4.xyz, r2, r0.w, r6
add_pp r3.w, -r2, c10
pow_pp r2, r3.w, c6.x
mov_pp r2.y, r2.x
mov r3.x, v2.w
mov r3.z, v4.w
mov r3.y, v3.w
dp3 r0.w, r5, r3
mul r5.xyz, r5, r0.w
mul_pp r0.w, r1, c3.x
mov r2.x, c5
add r1.w, c10, -r2.x
mad r3.xyz, -r5, c10.x, r3
mad_sat r1.w, r1, r2.y, c5.x
mul_pp r3.w, r0, c10.z
texldl r2.xyz, r3, s3
mul_pp r0.xyz, r0, v6
max r0.w, r1, c11.x
mul_pp r2.xyz, r2, r0.w
mad_pp r3.xyz, r4, c10.x, r0
mul_pp r2.xyz, r2, c4.x
mul_pp r0.xyz, r2, r1
mad_pp oC0.xyz, r0, c0, r3
mov_pp oC0.w, c10
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [roughnessV]
Float 4 [_Reflective]
Float 5 [freBias]
Float 6 [frePow]
Float 7 [orenNayar]
Float 8 [_AnizoX]
Float 9 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
"sce_fp_rsx // 174 instructions using 5 registers
[Configuration]
24
ffffffff001fc020007fff80000000000000840005000000
[Offsets]
10
_LightColor0 3 0
00000ad0000009d000000910
_Color 1 0
00000380
AnisoSpecular 1 0
000008a0
roughnessV 1 0
000008d0
_Reflective 1 0
00000a60
freBias 2 0
00000a10000009b0
frePow 1 0
00000940
orenNayar 1 0
00000040
_AnizoX 1 0
000005e0
_AnizoY 1 0
00000540
[Microcode]
2784
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ae8a3940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c800000110060300c9181c9d00020000c8000001
51ec3db80000000000000000000000000e883940c9001c9dc8000029c8000001
0e000200a5101c9fa0020000c80000010000000000003f800000000000000000
0e00040093101c9d08020000c80000010000000000003f800000000000000000
10000500c8001c9dc8000001c8000001108a0540c9101c9dc9140001c8000001
028e0340ff143c9f00020000c800000100003f80000000000000000000000000
2e8c3941c8011c9dc8000029c800bfe110880540c9101c9dc9180001c8000001
0e023b00c8001c9dfe000001c800000110800340c9103c9f00020000c8000001
00003f800000000000000000000000000e800440c9101c9fff140001c9140001
0e820440c9101c9fff100001c9180001048e0540c9001c9dc9040001c8000001
10000900ab1c1c9c00020000c800000100000000000000000000000000000000
02003a00ff181c9dfe0c0001c80000011000020000001c9cc8000001c8000001
04920a40ff141c9d00020000c800000100000000000000000000000000000000
08801b40ff001c9dc8000001c8000001108e0440c9143c9d00020000aa020000
6000bc9920003d98000000000000000002800440ff143c9dff1c000100020000
4000be5900000000000000000000000004801b40c91c1c9dc8000001c8000001
02800440ff143c9dc90000010002000000003fc9000000000000000000000000
10800440c9103c9daa02000054020001000000006000bc9920003d9800000000
10900440c9103c9dc9000001000200004000be59000000000000000000000000
02903a40c9001c9dab000000c800000102800440ff103c9dff20000100020000
00003fc900000000000000000000000010903a4001001c9c55000001c8000001
108a0a40c9101c9d00020000c800000100000000000000000000000000000000
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
000000000000000000000000000000000e000200a5101c9d92040001c8000001
0e00040093101c9da4040001c80000031e7e7d00c8001c9dc8000001c8000001
10040100c8081c9dc8000001c800000104900240ff141c9dff201001c8000001
10880240ab241c9c01201000c800000110020500c8001c9dc8000001c8000001
02860500c9181c9dc8040001c8000001fe840140c8011c9dc8000001c8003fe1
108e0500c9181c9dc8000001c8000001a2000500c8011c9dc8010001c800bfe1
02920340c9201c9dff100003c80000011e7e7d00c8001c9dc8000001c8000001
10880340c9201c9dab200002c800000110900440ab241c9c0002000001240000
00004049000000000000000000000000ae003b00c8011c9dc8000001c800bfe1
02080500c9101c9dc8000001c8000001de800140c8011c9dc8000001c8003fe1
02800540c9001c9dc9100001c80000011e920141c8011c9dc8000001c8003fe1
08800540c9101c9dc9240001c800000102900900c8101c9d00020000c8000001
0000000000000000000000000000000004800540c9101c9dc9080001c8000001
04840140ff081c9dc8000001c80000011084014000021c9cc8000001c8000001
0000000000000000000000000000000002840140ff001c9dc8000001c8000001
08840140ff241c9dc8000001c800000108000500c9001c9dc9081001c8000001
0e000400c9001c9f54000001c908000102848540c9101c9dc9140001c8000001
028a8540c9101c9dc9180001c800000102920240c9141c9dc9080001c8000001
1e7e7d00c8001c9dc8000001c80000010884014000021c9cc8000001c8000001
0000000000000000000000000000000004863b00ff1c1c9dfe040001c8000001
02840440ff141c9d00020000ff10000100004049000000000000000000000000
1088034001201c9eaa020000c80000010000000000003f800000000000000000
02881b40c9241c9dc8000001c800000102060300c9141c9d00020000c8000001
00003f8000000000000000000000000004880940ff201c9d01080000c8000001
1e7e7d00c8001c9dc8000001c800000110860840c9201c9d01080000c8000001
060203005d081c9d00020000c8000001c5ac3727000000000000000000000000
08863a40010c1c9cc8040001c800000102020200c8041c9daa040000c8000001
02862340ab101c9cc8000001c800000102023a00c8041c9dc9100001c8000001
02882340ff0c1c9dc8000001c800000102020200c8041c9d00020000c8000001
0fd0414900000000000000000000000010843a40ab0c1c9caa040000c8000001
037e4180c8041c9dc8000001c800000108842240ff0c1c9dc8000001c8000001
02923a40c9101c9d55080001c800000110860140c9081c9dc8000001c8000001
02920240c90c1c9dc9240001c8000001040238005d0c1c9d5d0c0001c8000001
02043a00aa041c9cc80c0001c800000108020300ff181c9d00020000c8000001
eb853f110000000000000000000000001002020000081c9c00021000c8000001
aa3a3fb80000000000000000000000000e880140aa021c9cc8000001c8000001
0000000000000000000000000000000010043a00c9181c9d54045001c8000001
04021c00fe041c9fc8000001c800000102023a00aa041c9cc8040001c8000001
108c090001141c9c00020000c800000100000000000000000000000000000000
10020200c8001c9d01240000c800000110040400c8041c9dc8020001c8080003
00000000000000000000000066663ee60e88020000040014c8020001c8000001
000000000000000000000000000000009e021704c8011c9dc8000001c8003fe1
10860240c8041c9d00020000c800000100000000000000000000000000000000
08860300fe081c9daa020000c80000010000000000003f800000000000000000
0e8c0240c91c1c9dc8020001c800000100000000000000000000000000000000
08821d00ff101c9dc8000001c800000108820200c9041c9d00020000c8000001
0000000000000000000000000000000006040100c8081c9dc8000001c8000001
10881c4055041c9dc8000001c80000010e88024000041c9cc9100001c8000001
0e8a0240c9181c9dff180001c80000010e8a0240c9141c9d550c0001c8000001
10000400c9101c9d00020002c910000100000000000000000000000000000000
0e8c0440c9101c9dc8021001c914000100000000000000000000000000000000
108c0240c90c1c9dc8020001c8000001000000000000000000000000000040e0
10008300c8001c9d00020000c800000100000000000000000000000000000000
0e002f06c8001c9dff180001c800000108820900fe001c9d00020000c8000001
000000000000000000000000000000001082024055041c9d00020000c8000001
000000000000000000000000000000004e880441c91c1c9dc8010001c9183fe1
0e800240c8001c9dff040001c80000011080014000021c9cc8000001c8000001
00003f800000000000000000000000000e800240c9001c9dc8040001c8000001
0e810440c9001c9dc8020001c910000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [roughnessV]
Float 3 [_Reflective]
Float 4 [freBias]
Float 5 [frePow]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 43 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 7.00000000, 1.00000000
def c7, 0.00000000, 8.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3 r1.x, v1, v1
rsq r1.x, r1.x
mul r1.xyz, r1.x, v1
dp3 r0.w, r0, r1
max r0.w, r0, c7.x
add_pp r1.w, -r0, c6
dp3_pp r2.x, v2, r0
dp3_pp r2.y, r0, v3
dp3_pp r2.z, r0, v4
pow_pp r0, r1.w, c5.x
mov r1.w, c4.x
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r2, r1
mul r2.xyz, r2, r2.w
mad r1.xyz, -r2, c6.x, r1
mov_pp r2.x, r0
texld r0, v0, s2
add r1.w, c6, -r1
mad_sat r2.x, r1.w, r2, c4
mul_pp r0.w, r0, c2.x
mul_pp r1.w, r0, c6.z
max r0.w, r2.x, c7.x
texldl r1.xyz, r1, s3
mul_pp r1.xyz, r1, r0.w
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r2.xyz, r0, c0
texld r1.xyz, v0, s1
texld r0, v5, s4
mul_pp r1.xyz, r1, c1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r0, c7.y, r2
mov_pp oC0.w, c7.x
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [roughnessV]
Float 3 [_Reflective]
Float 4 [freBias]
Float 5 [frePow]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [unity_Lightmap] 2D
"sce_fp_rsx // 57 instructions using 4 registers
[Configuration]
24
ffffffff000fc020003fffe0000000000000840004000000
[Offsets]
6
_LightColor0 1 0
00000380
_Color 1 0
00000080
roughnessV 1 0
000001e0
_Reflective 1 0
00000300
freBias 2 0
0000029000000260
frePow 1 0
00000210
[Microcode]
912
940017005c011c9dc8000001c8003fe106800440ce001c9d00020000aa020000
000040000000bf8000000000000000008e021702c8011c9dc8000001c8003fe1
08800240ab001c9cab000000c80000011088044001001c9e0100000055000003
a2040500c8011c9dc8010001c800bfe10e820240c8041c9dc8020001c8000001
000000000000000000000000000000003e021709c8011c9dc8000001c8003fe1
08800340ff101c9d00020000c800000100003f80000000000000000000000000
ae043b00c8011c9dc8080001c800bfe10e820240fe041c9dc9040001c8000001
08803b40c9003c9d55000001c80000010e840240c9041c9dc8043001c8000001
0e803940c9001c9dc8000029c800000108020500c9001c9dc8080001c8000001
de880140c8011c9dc8000001c8003fe102880540c9101c9dc9000001c8000001
fe820140c8011c9dc8000001c8003fe104880540c9001c9dc9040001c8000001
1080090054041c9d00020000c800000100000000000000000000000000000000
1e860141c8011c9dc8000001c8003fe108880540c9001c9dc90c0001c8000001
108a0340c9001c9f00020000c800000100003f80000000000000000000000000
9e061704c8011c9dc8000001c8003fe102800240fe0c1c9d00020000c8000001
0000000000000000000000000000000004801d00ff141c9dc8000001c8000001
10800200ab001c9c00020000c800000100000000000000000000000000000000
028a0140ff101c9dc8000001c800000104801c40ff001c9dc8000001c8000001
048a0140ff041c9dc8000001c800000110000400ab001c9c00020002ab000000
00000000000000000000000000000000088a0140ff0c1c9dc8000001c8000001
04008300fe001c9d00020000c800000100000000000000000000000000000000
108a024001001c9caa020000c800000100000000000040e00000000000000000
02000500c9101c9dc9141001c800000110800900aa001c9c00020000c8000001
0000000000000000000000000000000010820240c9001c9d00020000c8000001
000000000000000000000000000000000e040400c9101c9f00000000c9140001
0e002f06c8081c9dff140001c80000010e800240c8001c9dff040001c8000001
1080014000021c9cc8000001c800000100000000000000000000000000000000
0e800240c9001c9dc80c0001c80000010e810440c9001c9dc8020001c9080001
00000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [roughnessV]
Float 4 [_Reflective]
Float 5 [freBias]
Float 6 [frePow]
Float 7 [orenNayar]
Float 8 [_AnizoX]
Float 9 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 166 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c10, 2.00000000, -1.00000000, 7.00000000, 1.00000000
def c11, 0.00000000, 0.56999999, 0.09000000, 1.00000000
def c12, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c13, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c14, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c15, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c10.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, -r0.zxyw, c11.xxww
mad_pp r1.xyz, r0.yzxw, c11.xwxw, r1
dp3_pp r0.w, r1, r1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r1
mul_pp r2.xyz, r0.zxyw, r1.yzxw
mad_pp r2.xyz, r0.yzxw, r1.zxyw, -r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r2
dp3_pp r0.w, v5, v5
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v5
dp3_pp r3.w, r0, r2
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c9.x
mul_pp r0.w, r0, r1
mul r2.w, r0, r0
dp3_pp r0.w, r2, r1
rcp_pp r1.w, c8.x
mul_pp r0.w, r0, r1
mad r1.y, r0.w, r0.w, r2.w
dp3_pp_sat r0.w, r0, r2
add r1.z, r0.w, c10.w
rcp r1.z, r1.z
mul r1.y, r1, r1.z
dp3_pp r1.x, v1, v1
rsq_pp r1.x, r1.x
mul_pp r4.xyz, r1.x, v1
dp3_pp_sat r1.x, r0, r4
mul_pp r2.w, r0, r1.x
mul r3.x, r1.y, c14.w
pow r1, c15.x, r3.x
rsq_pp r1.z, r2.w
dp3_pp r2.w, r0, r4
mov r1.y, c8.x
mad_pp r2.xyz, -r0, r3.w, r2
mad_pp r4.xyz, -r0, r2.w, r4
dp3_pp r2.x, r4, r2
abs_pp r2.y, r2.w
add_pp r4.x, -r2.y, c10.w
mad_pp r2.z, r2.y, c12.x, c12.y
mad_pp r2.z, r2, r2.y, c12
rsq_pp r4.x, r4.x
rcp_pp r1.z, r1.z
mul r1.y, c9.x, r1
mul r1.y, r1, r1.z
mul r1.y, r1, c14.z
mov r1.w, r1.x
rcp r1.z, r1.y
abs r1.x, r1.y
mul r1.y, r1.w, r1.z
cmp r1.w, -r1.x, c11.x, c11
mad_pp r2.y, r2.z, r2, c12.w
rcp_pp r4.x, r4.x
mul_pp r2.z, r2.y, r4.x
abs_pp r4.x, r3.w
cmp_pp r2.y, r2.w, c11.x, c11.w
mul_pp r2.w, r2.y, r2.z
mad_pp r2.z, -r2.w, c10.x, r2
add_pp r4.y, -r4.x, c10.w
mad_pp r2.w, r4.x, c12.x, c12.y
mad_pp r2.w, r2, r4.x, c12.z
rsq_pp r4.y, r4.y
mad_pp r2.y, r2, c13.x, r2.z
mad_pp r2.w, r2, r4.x, c12
rcp_pp r4.y, r4.y
mul_pp r4.x, r2.w, r4.y
cmp_pp r2.w, r3, c11.x, c11
mul_pp r3.w, r2, r4.x
mad_pp r2.z, -r3.w, c10.x, r4.x
mad_pp r2.w, r2, c13.x, r2.z
mul_pp r3.w, c7.x, c7.x
add r2.z, r3.w, c11
min_pp r4.x, r2.y, r2.w
rcp r2.z, r2.z
mul r2.z, r3.w, r2
max r2.x, r2, c11
mul r5.x, r2.z, r2
mad_pp r4.x, r4, c13.y, c13.z
frc_pp r2.z, r4.x
max_pp r2.x, r2.y, r2.w
mad_pp r4.y, r2.z, c14.x, c14
mad_pp r4.x, r2, c13.y, c13.z
sincos_pp r2.xy, r4.y
frc_pp r2.z, r4.x
mad_pp r2.z, r2, c14.x, c14.y
sincos_pp r4.xy, r2.z
rcp_pp r2.x, r2.x
mul_pp r2.x, r2.y, r2
mul_pp r2.y, r4, r2.x
mul r2.y, r5.x, r2
add r2.x, r3.w, c11.y
mul r2.z, r2.y, c13.w
rcp r2.x, r2.x
mul r2.y, r3.w, r2.x
mad r2.y, -r2, c13.z, r2.z
dp3 r2.x, v1, v1
rsq r2.x, r2.x
mul r4.xyz, r2.x, v1
add r3.w, r2.y, c10
dp3 r2.w, r0, r4
texld r2.xyz, v0, s1
mul_pp r4.xyz, r2, c1
mul r1.xyz, r1.y, c2
abs_pp r1.w, r1
cmp r3.xyz, -r1.w, c11.x, r1
texld r1, v0, s2
mul_pp r3.xyz, r1.x, r3
mul_pp r3.xyz, r3, c0
max r0.w, r0, c11.x
mul_pp r2.xyz, r4, c0
mul_pp r2.xyz, r2, r0.w
mad_pp r2.xyz, r2, r3.w, r3
max r0.w, r2, c11.x
texldp r3.x, v7, s4
mul_pp r5.xyz, r3.x, r2
add_pp r2.w, -r0, c10
dp3_pp r3.x, v2, r0
dp3_pp r3.y, r0, v3
dp3_pp r3.z, r0, v4
pow_pp r0, r2.w, c6.x
mov_pp r0.z, r0.x
mul_pp r0.x, r1.w, c3
mov r0.y, c5.x
add r0.y, c10.w, -r0
mad_sat r0.y, r0, r0.z, c5.x
mov r2.x, v2.w
mov r2.z, v4.w
mov r2.y, v3.w
dp3 r3.w, r3, r2
mul r3.xyz, r3, r3.w
mad r2.xyz, -r3, c10.x, r2
max r0.w, r0.y, c11.x
mul_pp r2.w, r0.x, c10.z
texldl r0.xyz, r2, s3
mul_pp r0.xyz, r0, r0.w
mul_pp r2.xyz, r4, v6
mul_pp r0.xyz, r0, c4.x
mad_pp r2.xyz, r5, c10.x, r2
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r0, c0, r2
mov_pp oC0.w, c10
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [roughnessV]
Float 4 [_Reflective]
Float 5 [freBias]
Float 6 [frePow]
Float 7 [orenNayar]
Float 8 [_AnizoX]
Float 9 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [_ShadowMapTexture] 2D
"sce_fp_rsx // 176 instructions using 5 registers
[Configuration]
24
ffffffff003fc02000ffff00000000000000840005000000
[Offsets]
10
_LightColor0 3 0
00000af000000880000007d0
_Color 1 0
000004e0
AnisoSpecular 1 0
00000810
roughnessV 1 0
000008f0
_Reflective 1 0
00000a80
freBias 2 0
00000a3000000a10
frePow 1 0
000009c0
orenNayar 1 0
00000040
_AnizoX 1 0
00000480
_AnizoY 1 0
00000420
[Microcode]
2816
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ae8a3940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c800000110020300c9181c9d00020000c8000001
eb853f110000000000000000000000000e8c3940c9001c9dc8000029c8000001
2e883941c8011c9dc8000029c800bfe1048e0540c9181c9dc9100001c8000001
10820540c9181c9dc9140001c800000110800340ab1c3c9e00020000c8000001
00003f800000000000000000000000000e800440c9181c9fff040001c9140001
10880a40ab1c1c9c00020000c800000100000000000000000000000000000000
0e820440c9181c9fab1c0000c910000108820540c9001c9dc9040001c8000001
02820340ff043c9f00020000c800000100003f80000000000000000000000000
04801b40ff001c9dc8000001c800000102800440ff043c9d00020000aa020000
6000bc9920003d98000000000000000010800440ab1c3c9c00020000aa020000
6000bc9920003d98000000000000000002800440ff043c9dc900000100020000
4000be5900000000000000000000000008801b40c9041c9dc8000001c8000001
02800440ff043c9dc90000010002000000003fc9000000000000000000000000
10800440ab1c3c9cc9000001aa020000000000004000be590000000000000000
028e3a40c9001c9d55000001c800000102800440ab1c3c9cff00000100020000
00003fc9000000000000000000000000108a3a4001001c9cab000000c8000001
0e000200a5181c9fa0020000c80000010000000000003f800000000000000000
0e00040093181c9d08020000c80000010000000000003f800000000000000000
10023a00c9181c9dfe045001c800000104080500c8001c9dc8000001c8000001
02900a40ff041c9d00020000c800000100000000000000000000000000000000
10820240c9101c9dc9141001c800000102920340ff141c9dff040003c8000001
1082024001201c9c011c1000c80000010e060100c80c1c9dc8000001c8000001
108a0340011c1c9cc9040003c8000001028a8540c9181c9dc9140001c8000001
1e040100c8081c9dc8000001c800000102900440c9201c9d00020000ff140001
0000404900000000000000000000000010880440c9101c9d0002000001240000
000040490000000000000000000000000e023b00c8001c9daa100000c8000001
1000090055041c9d00020000c800000100000000000000000000000000000000
1080084001201c9cc9100001c80000011090014000021c9cc8000001c8000001
0000000000000000000000000000000008802340ff001c9dc8000001c8000001
02000300ff181c9d00020000c800000151ec3db8000000000000000000000000
02003a00ff181c9dc8000001c80000010890014000021c9cc8000001c8000001
0000000000000000000000000000000010802240ff001c9dc8000001c8000001
108a3a4055001c9dff000001c80000011000020000001c9cc8000001c8000001
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
000000000000000000000000000000000e000200a5181c9d92040001c8000001
0e00040093181c9da4040001c8000003108c0500c9101c9dc8000001c8000001
02000500c8001c9dc8000001c800000102820500c9101c9dc8040001c8000001
1e7e7e00c8001c9dc8000001c800000102843b00ff181c9dc8000001c8000001
02860940c9201c9dff100001c8000001060003005d201c9d00020000c8000001
c5ac3727000000000000000000000000108c8540c9181c9dc9100001c8000001
02040300ff181c9d00020000c800000100003f80000000000000000000000000
108c0100c9181c9dc8000001c8000001048a0900ff181c9d00020000c8000001
00000000000000000000000000000000108e3a4001081c9caa000000c8000001
04820140ff1c1c9dc8000001c800000102823a40c9041c9dc8000001c8000001
04043800c9041c9dc9040001c800000108003a00aa081c9cc8080001c8000001
02000200c8001c9daa000000c800000102880240ff181c9dc9140001c8000001
08841b40c9101c9dc8000001c8000001a2020500c8011c9dc8010001c800bfe1
08802340c90c1c9dc8000001c8000001ae083b00c8011c9dc8040001c800bfe1
02080500c9181c9dc8100001c8000001de880140c8011c9dc8000001c8003fe1
028a0540c9101c9dc9180001c80000011e7e7d00c8001c9dc8000001c8000001
10040100c8081c9dc8000001c80000011080024055001c9dc9140001c8000001
10043a0000001c9c55080001c800000102000200fe001c9dff000001c8000001
10000200c8081c9d00020000c80000010fd04149000000000000000000000000
02040400c8001c9daa020000fe0400030000000066663ee60000000000000000
1002020054001c9d00021000c8000001aa3a3fb8000000000000000000000000
0e840140aa021c9cc8000001c800000100000000000000000000000000000000
02001c00fe041c9fc8000001c800000110043a0000001c9cfe000001c8000001
0e800240c91c1c9dc8020001c800000100000000000000000000000000000000
0e800240c9001c9dab140000c8000001117e4180c8001c9dc8000001c8000001
0e840200fe081ff5c8020001c800000100000000000000000000000000000000
1080030000081c9cc8020001c800000100000000000000000000000000003f80
0e860240c9001c9dff000001c80000019e001704c8011c9dc8000001c8003fe1
0e84024000001c9cc9080001c80000010e880440c9081c9dc8020001c90c0001
000000000000000000000000000000001e860141c8011c9dc8000001c8003fe1
088a0540c9181c9dc90c0001c8000001fe840140c8011c9dc8000001c8003fe1
02860900c8101c9d00020000c800000100000000000000000000000000000000
04860240fe001c9d00020000c800000100000000000000000000000000000000
048a0540c9181c9dc9080001c800000104840140ff081c9dc8000001c8000001
10840340010c1c9e00020000c800000100003f80000000000000000000000000
10841d00ff081c9dc8000001c800000108840140ff0c1c9dc8000001c8000001
62061809c8011c9dc8000001c8003fe102840140ff101c9dc8000001c8000001
08860240ab0c1c9c00020000c8000001000040e0000000000000000000000000
08020500c9141c9dc9081001c800000110860200c9081c9d00020000c8000001
0000000000000000000000000000000008821c40ff0c1c9dc8000001c8000001
0e020400c9141c9f54040001c90800010e022f06c8041c9d550c0001c8000001
1000040055041c9d000200025504000100000000000000000000000000000000
10008300c8001c9d00020000c800000100000000000000000000000000000000
4e8a0241c91c1c9dc8015001c8003fe110880900c8001c9d00020000c8000001
0000000000000000000000000000000010860240c9101c9d00020000c8000001
000000000000000000000000000000000e880440000c1c9cc9101001c9140001
0e840240c8041c9dff0c0001c80000010e800240c9081c9dc8000001c8000001
1080014000021c9cc8000001c800000100003f80000000000000000000000000
0e810440c9001c9dc8020001c910000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [roughnessV]
Float 3 [_Reflective]
Float 4 [freBias]
Float 5 [frePow]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_3_0
; 48 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_2d s5
def c6, 8.00000000, 2.00000000, -1.00000000, 7.00000000
def c7, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.y, c6.z
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c7.x
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3 r1.x, v1, v1
rsq r1.x, r1.x
mul r1.xyz, r1.x, v1
dp3 r0.w, r0, r1
max r0.w, r0, c7.y
add_pp r1.w, -r0, c7.x
dp3_pp r2.x, v2, r0
dp3_pp r2.y, r0, v3
dp3_pp r2.z, r0, v4
pow_pp r0, r1.w, c5.x
mov r1.w, c4.x
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r2, r1
mul r2.xyz, r2, r2.w
mad r1.xyz, -r2, c6.y, r1
mov_pp r2.x, r0
texld r0, v0, s2
add r1.w, c7.x, -r1
mad_sat r2.x, r1.w, r2, c4
mul_pp r0.w, r0, c2.x
mul_pp r1.w, r0, c6
max r0.w, r2.x, c7.y
texldl r1.xyz, r1, s3
mul_pp r1.xyz, r1, r0.w
mul_pp r1.xyz, r1, c3.x
mul_pp r0.xyz, r1, r0
mul_pp r2.xyz, r0, c0
texldp r3.x, v6, s4
texld r0, v5, s5
mul_pp r1.xyz, r0, r3.x
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c6.x
mul_pp r1.xyz, r1, c6.y
min_pp r1.xyz, r0, r1
mul_pp r3.xyz, r0, r3.x
texld r0.xyz, v0, s1
max_pp r1.xyz, r1, r3
mul_pp r0.xyz, r0, c1
mad_pp oC0.xyz, r0, r1, r2
mov_pp oC0.w, c7.y
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [roughnessV]
Float 3 [_Reflective]
Float 4 [freBias]
Float 5 [frePow]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_Cube] CUBE
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"sce_fp_rsx // 66 instructions using 4 registers
[Configuration]
24
ffffffff001fc020007fffa0000000000000840004000000
[Offsets]
6
_LightColor0 1 0
00000410
_Color 2 0
000003a000000310
roughnessV 1 0
000002d0
_Reflective 1 0
00000360
freBias 2 0
0000027000000220
frePow 1 0
000001c0
[Microcode]
1056
940017005c011c9dc8000001c8003fe106800440ce001c9d00020000aa020000
000040000000bf80000000000000000010800240ab001c9cab000000c8000001
a8000500c8011c9dc8010001c800bfe10880044001001c9e01000000ff000003
1080034055001c9d00020000c800000100003f80000000000000000000000000
ae023b00c8011c9d54000001c800bfe1de8a0140c8011c9dc8000001c8003fe1
42061809c8011c9dc8000001c8003fe108803b40ff003c9dff000001c8000001
0e803940c9001c9dc8000029c800000108000500c9001c9dc8040001c8000001
fe880140c8011c9dc8000001c8003fe102840540c9141c9dc9000001c8000001
1084090054001c9d00020000c800000100000000000000000000000000000000
1e860141c8011c9dc8000001c8003fe104840540c9001c9dc9100001c8000001
08840540c9001c9dc90c0001c800000110840340c9081c9f00020000c8000001
00003f800000000000000000000000003e00170bc8011c9dc8000001c8003fe1
0e860240fe001c9dc8003001c800000108821d00ff081c9dc8000001c8000001
0e8e0240c90c1c9d000c0000c80000010288020055041c9d00020000c8000001
000000000000000000000000000000000e8c0240c8001c9d000c1000c8000001
0e8c0840c90c1c9dc9180001c800000110841c40c9101c9dc8000001c8000001
02860140ff141c9dc8000001c800000110040400c9081c9d00020002c9080001
0000000000000000000000000000000004860140ff101c9dc8000001c8000001
08860140ff0c1c9dc8000001c800000102040500c9081c9dc90c1001c8000001
10048300c8081c9d00020000c800000100000000000000000000000000000000
108a0900c8081c9d00020000c800000100000000000000000000000000000000
0e040400c9081c9f00080000c90c00019e001704c8011c9dc8000001c8003fe1
10820240c8001c9d00020000c800000100000000000000000000000000000000
0e8c0940c9181c9dc91c0001c80000018e021702c8011c9dc8000001c8003fe1
06840240c8041c9d08020000c800000100000000000000000000000000000000
10820240c9041c9d54020001c80000010000000000000000000040e000000000
0e042f06c8081c9dff040001c8000001108a0240c9141c9d00020000c8000001
000000000000000000000000000000000e880240c8081c9dff140001c8000001
0e880240c9101c9dc8000001c80000011080024054041c9d54020001c8000001
0000000000000000000000000000000006020100c8041c9dc8000001c8000001
08800240ff001c9dc9180001c800000106800240c9081c9dc9180001c8000001
1080014000021c9cc8000001c800000100000000000000000000000000000000
0e810440c9101c9dc8020001c900000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 15
//   d3d9 - ALU: 32 to 45
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w;
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize(xlv_TEXCOORD1));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c18.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 465 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 35 instructions using 5 registers
[Configuration]
8
0000002341050500
[Microcode]
560
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d0e00d8086c0c360405fa8
401f9c6c01d0d00d8086c0c360409fa8401f9c6c01d0c00d8086c0c360411fa8
00001c6c011d100c02bfc0e30041dffc00009c6c00800e0c04bfc0836041dffc
00011c6c0140020c0106004360405ffc00011c6c01400e0c0106004360411ffc
00011c6c0140000c0286004360409ffc00001c6c011d100c08bfc0e30041dffc
00001c6c0140000c0486024360403ffc401f9c6c0140020c0106004360405fa0
401f9c6c21400e0c0086009fe02300a0401f9c6c0140000c0086014360409fa0
401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10));
  mediump vec3 lightDir_12;
  lightDir_12 = lightDir_2;
  mediump float atten_13;
  atten_13 = tmpvar_11.w;
  mediump vec4 c_14;
  mediump vec3 SpecularFinal_15;
  mediump float B_16;
  mediump float A_17;
  highp float rough_sq_18;
  highp vec3 SpecularAniso_19;
  highp float beta_b_20;
  highp float beta_a_21;
  mediump float HdotB_22;
  mediump float HdotT_23;
  mediump vec3 n_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_24 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(lightDir_12);
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_28;
  tmpvar_28.x = _AnizoX;
  tmpvar_28.y = _AnizoY;
  mediump vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize(((n_24.yzx * vec3(0.0, 1.0, 0.0)) - (n_24.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_31;
  tmpvar_31 = clamp (dot (n_24, tmpvar_26), 0.0, 1.0);
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_26, tmpvar_30);
  HdotT_23 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = dot (tmpvar_26, normalize(((n_24.yzx * tmpvar_30.zxy) - (n_24.zxy * tmpvar_30.yzx))));
  HdotB_22 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = (HdotT_23 / tmpvar_29.x);
  beta_a_21 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (beta_a_21 * beta_a_21);
  beta_a_21 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = (HdotB_22 / tmpvar_29.y);
  beta_b_20 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (beta_b_20 * beta_b_20);
  beta_b_20 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (-2.0 * ((tmpvar_35 + tmpvar_37) / (1.0 + tmpvar_31)));
  mediump float tmpvar_39;
  tmpvar_39 = sqrt((tmpvar_31 * clamp (dot (n_24, tmpvar_27), 0.0, 1.0)));
  highp float tmpvar_40;
  tmpvar_40 = (((12.5664 * tmpvar_29.x) * tmpvar_29.y) * tmpvar_39);
  if ((tmpvar_40 != 0.0)) {
    SpecularAniso_19 = (vec3((exp(tmpvar_38) / tmpvar_40)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_19 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_41;
  tmpvar_41 = (orenNayar * orenNayar);
  rough_sq_18 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (1.0 - (0.5 * (rough_sq_18 / (rough_sq_18 + 0.57))));
  A_17 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (0.45 * (rough_sq_18 / (rough_sq_18 + 0.09)));
  B_16 = tmpvar_43;
  mediump float x_44;
  x_44 = dot (tmpvar_27, n_24);
  mediump float x_45;
  x_45 = dot (tmpvar_26, n_24);
  mediump float x_46;
  x_46 = dot (tmpvar_27, n_24);
  mediump float x_47;
  x_47 = dot (tmpvar_26, n_24);
  mediump float tmpvar_48;
  tmpvar_48 = min ((1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))), (1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))));
  SpecularFinal_15 = SpecularAniso_19;
  c_14.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_31))) * vec3((A_17 + ((B_16 * max (0.0, dot ((tmpvar_27 - (n_24 * dot (tmpvar_27, n_24))), (tmpvar_26 - (n_24 * dot (tmpvar_26, n_24)))))) * (sin(max ((1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))), (1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))))) * (sin(tmpvar_48) / cos(tmpvar_48))))))) + ((SpecularFinal_15 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_13 * 2.0));
  c_14.w = 1.0;
  c_1.xyz = c_14.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(tmpvar_11));
  mediump vec3 lightDir_13;
  lightDir_13 = lightDir_2;
  mediump float atten_14;
  atten_14 = tmpvar_12.w;
  mediump vec4 c_15;
  mediump vec3 SpecularFinal_16;
  mediump float B_17;
  mediump float A_18;
  highp float rough_sq_19;
  highp vec3 SpecularAniso_20;
  highp float beta_b_21;
  highp float beta_a_22;
  mediump float HdotB_23;
  mediump float HdotT_24;
  mediump vec3 n_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(normal_6);
  n_25 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(lightDir_13);
  mediump vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_29;
  tmpvar_29.x = _AnizoX;
  tmpvar_29.y = _AnizoY;
  mediump vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(((n_25.yzx * vec3(0.0, 1.0, 0.0)) - (n_25.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_32;
  tmpvar_32 = clamp (dot (n_25, tmpvar_27), 0.0, 1.0);
  highp float tmpvar_33;
  tmpvar_33 = dot (tmpvar_27, tmpvar_31);
  HdotT_24 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_27, normalize(((n_25.yzx * tmpvar_31.zxy) - (n_25.zxy * tmpvar_31.yzx))));
  HdotB_23 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = (HdotT_24 / tmpvar_30.x);
  beta_a_22 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (beta_a_22 * beta_a_22);
  beta_a_22 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = (HdotB_23 / tmpvar_30.y);
  beta_b_21 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (beta_b_21 * beta_b_21);
  beta_b_21 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (-2.0 * ((tmpvar_36 + tmpvar_38) / (1.0 + tmpvar_32)));
  mediump float tmpvar_40;
  tmpvar_40 = sqrt((tmpvar_32 * clamp (dot (n_25, tmpvar_28), 0.0, 1.0)));
  highp float tmpvar_41;
  tmpvar_41 = (((12.5664 * tmpvar_30.x) * tmpvar_30.y) * tmpvar_40);
  if ((tmpvar_41 != 0.0)) {
    SpecularAniso_20 = (vec3((exp(tmpvar_39) / tmpvar_41)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_20 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_42;
  tmpvar_42 = (orenNayar * orenNayar);
  rough_sq_19 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (1.0 - (0.5 * (rough_sq_19 / (rough_sq_19 + 0.57))));
  A_18 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (0.45 * (rough_sq_19 / (rough_sq_19 + 0.09)));
  B_17 = tmpvar_44;
  mediump float x_45;
  x_45 = dot (tmpvar_28, n_25);
  mediump float x_46;
  x_46 = dot (tmpvar_27, n_25);
  mediump float x_47;
  x_47 = dot (tmpvar_28, n_25);
  mediump float x_48;
  x_48 = dot (tmpvar_27, n_25);
  mediump float tmpvar_49;
  tmpvar_49 = min ((1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))), (1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))));
  SpecularFinal_16 = SpecularAniso_20;
  c_15.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_32))) * vec3((A_18 + ((B_17 * max (0.0, dot ((tmpvar_28 - (n_25 * dot (tmpvar_28, n_25))), (tmpvar_27 - (n_25 * dot (tmpvar_27, n_25)))))) * (sin(max ((1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))), (1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))))) * (sin(tmpvar_49) / cos(tmpvar_49))))))) + ((SpecularFinal_16 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_14 * 2.0));
  c_15.w = 1.0;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec4 c_5;
  vec3 SpecularAniso_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(normal_2);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_10;
  tmpvar_10.x = _AnizoX;
  tmpvar_10.y = _AnizoY;
  vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10 + vec2(1e-05, 1e-05));
  vec3 tmpvar_12;
  tmpvar_12 = normalize(((tmpvar_7.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_7.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_13;
  tmpvar_13 = clamp (dot (tmpvar_7, tmpvar_8), 0.0, 1.0);
  float tmpvar_14;
  tmpvar_14 = (dot (tmpvar_8, tmpvar_12) / tmpvar_11.x);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_8, normalize(((tmpvar_7.yzx * tmpvar_12.zxy) - (tmpvar_7.zxy * tmpvar_12.yzx)))) / tmpvar_11.y);
  float tmpvar_16;
  tmpvar_16 = (-2.0 * (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) / (1.0 + tmpvar_13)));
  float tmpvar_17;
  tmpvar_17 = (((12.5664 * tmpvar_11.x) * tmpvar_11.y) * sqrt((tmpvar_13 * clamp (dot (tmpvar_7, tmpvar_9), 0.0, 1.0))));
  if ((tmpvar_17 != 0.0)) {
    SpecularAniso_6 = (vec3((exp(tmpvar_16) / tmpvar_17)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_6 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_18;
  tmpvar_18 = (orenNayar * orenNayar);
  float x_19;
  x_19 = dot (tmpvar_9, tmpvar_7);
  float x_20;
  x_20 = dot (tmpvar_8, tmpvar_7);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_7);
  float x_22;
  x_22 = dot (tmpvar_8, tmpvar_7);
  float tmpvar_23;
  tmpvar_23 = min ((1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))), (1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))));
  c_5.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_13))) * vec3(((1.0 - (0.5 * (tmpvar_18 / (tmpvar_18 + 0.57)))) + (((0.45 * (tmpvar_18 / (tmpvar_18 + 0.09))) * max (0.0, dot ((tmpvar_9 - (tmpvar_7 * dot (tmpvar_9, tmpvar_7))), (tmpvar_8 - (tmpvar_7 * dot (tmpvar_8, tmpvar_7)))))) * (sin(max ((1.5708 - (sign(x_19) * (1.5708 - (sqrt((1.0 - abs(x_19))) * (1.5708 + (abs(x_19) * (-0.214602 + (abs(x_19) * (0.0865667 + (abs(x_19) * -0.0310296)))))))))), (1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))))) * (sin(tmpvar_23) / cos(tmpvar_23))))))) + ((SpecularAniso_6 * tmpvar_4.x) * _LightColor0.xyz)) * 2.0);
  c_5.w = 1.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_3_0
; 32 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c13.x
mov r0.xyz, c8
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
mad r0.xyz, r2, c10.w, -v0
mul r2.xyz, r1, v1.w
dp3 r1.y, r2, r0
dp3 r1.x, v1, r0
dp3 r1.z, v2, r0
dp3 r0.x, r1, r1
rsq r1.w, r0.x
mov r0, c6
dp4 r3.z, c9, r0
mul o3.xyz, r1.w, r1
mov r1, c4
mov r0, c5
dp4 r3.x, c9, r1
dp4 r3.y, c9, r0
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_World2Object]
Vector 465 [unity_Scale]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 27 instructions using 5 registers
[Configuration]
8
0000001b41050500
[Microcode]
432
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c0190600c0686c0c360405ffc
00001c6c0190500c0686c0c360409ffc00001c6c0190400c0686c0c360411ffc
00021c6c01d0600d8286c0c360405ffc00021c6c01d0500d8286c0c360409ffc
00019c6c00800243011842436041dffc00011c6c010002308121826301a1dffc
00019c6c011d100c00bfc0e30041dffc00011c6c00800e0c04bfc0836041dffc
00001c6c0140020c0106034360405ffc00001c6c01400e0c0106034360411ffc
00001c6c0140000c0486034360409ffc00021c6c01d0400d8286c0c360411ffc
00001c6c0140000c0086004360403ffc401f9c6c0140020c0106044360405fa0
401f9c6c21400e0c0886009fe0230020401f9c6c0140000c0886024360409fa0
401f9c6c0080007f808600436041dfa5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD1;
  mediump vec3 lightDir_9;
  lightDir_9 = lightDir_2;
  mediump vec4 c_10;
  mediump vec3 SpecularFinal_11;
  mediump float B_12;
  mediump float A_13;
  highp float rough_sq_14;
  highp vec3 SpecularAniso_15;
  highp float beta_b_16;
  highp float beta_a_17;
  mediump float HdotB_18;
  mediump float HdotT_19;
  mediump vec3 n_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_20 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(lightDir_9);
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = _AnizoX;
  tmpvar_24.y = _AnizoY;
  mediump vec2 tmpvar_25;
  tmpvar_25 = (tmpvar_24 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((n_20.yzx * vec3(0.0, 1.0, 0.0)) - (n_20.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_27;
  tmpvar_27 = clamp (dot (n_20, tmpvar_22), 0.0, 1.0);
  highp float tmpvar_28;
  tmpvar_28 = dot (tmpvar_22, tmpvar_26);
  HdotT_19 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_22, normalize(((n_20.yzx * tmpvar_26.zxy) - (n_20.zxy * tmpvar_26.yzx))));
  HdotB_18 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (HdotT_19 / tmpvar_25.x);
  beta_a_17 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = (beta_a_17 * beta_a_17);
  beta_a_17 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = (HdotB_18 / tmpvar_25.y);
  beta_b_16 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (beta_b_16 * beta_b_16);
  beta_b_16 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (-2.0 * ((tmpvar_31 + tmpvar_33) / (1.0 + tmpvar_27)));
  mediump float tmpvar_35;
  tmpvar_35 = sqrt((tmpvar_27 * clamp (dot (n_20, tmpvar_23), 0.0, 1.0)));
  highp float tmpvar_36;
  tmpvar_36 = (((12.5664 * tmpvar_25.x) * tmpvar_25.y) * tmpvar_35);
  if ((tmpvar_36 != 0.0)) {
    SpecularAniso_15 = (vec3((exp(tmpvar_34) / tmpvar_36)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_15 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_37;
  tmpvar_37 = (orenNayar * orenNayar);
  rough_sq_14 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (1.0 - (0.5 * (rough_sq_14 / (rough_sq_14 + 0.57))));
  A_13 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (0.45 * (rough_sq_14 / (rough_sq_14 + 0.09)));
  B_12 = tmpvar_39;
  mediump float x_40;
  x_40 = dot (tmpvar_23, n_20);
  mediump float x_41;
  x_41 = dot (tmpvar_22, n_20);
  mediump float x_42;
  x_42 = dot (tmpvar_23, n_20);
  mediump float x_43;
  x_43 = dot (tmpvar_22, n_20);
  mediump float tmpvar_44;
  tmpvar_44 = min ((1.5708 - (sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296)))))))))), (1.5708 - (sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296)))))))))));
  SpecularFinal_11 = SpecularAniso_15;
  c_10.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_27))) * vec3((A_13 + ((B_12 * max (0.0, dot ((tmpvar_23 - (n_20 * dot (tmpvar_23, n_20))), (tmpvar_22 - (n_20 * dot (tmpvar_22, n_20)))))) * (sin(max ((1.5708 - (sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296)))))))))), (1.5708 - (sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296)))))))))))) * (sin(tmpvar_44) / cos(tmpvar_44))))))) + ((SpecularFinal_11 * SpecularTex_4.x) * _LightColor0.xyz)) * 2.0);
  c_10.w = 1.0;
  c_1.xyz = c_10.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD1;
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_2;
  mediump vec4 c_11;
  mediump vec3 SpecularFinal_12;
  mediump float B_13;
  mediump float A_14;
  highp float rough_sq_15;
  highp vec3 SpecularAniso_16;
  highp float beta_b_17;
  highp float beta_a_18;
  mediump float HdotB_19;
  mediump float HdotT_20;
  mediump vec3 n_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(normal_6);
  n_21 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(lightDir_10);
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_25;
  tmpvar_25.x = _AnizoX;
  tmpvar_25.y = _AnizoY;
  mediump vec2 tmpvar_26;
  tmpvar_26 = (tmpvar_25 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((n_21.yzx * vec3(0.0, 1.0, 0.0)) - (n_21.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_28;
  tmpvar_28 = clamp (dot (n_21, tmpvar_23), 0.0, 1.0);
  highp float tmpvar_29;
  tmpvar_29 = dot (tmpvar_23, tmpvar_27);
  HdotT_20 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = dot (tmpvar_23, normalize(((n_21.yzx * tmpvar_27.zxy) - (n_21.zxy * tmpvar_27.yzx))));
  HdotB_19 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (HdotT_20 / tmpvar_26.x);
  beta_a_18 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (beta_a_18 * beta_a_18);
  beta_a_18 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = (HdotB_19 / tmpvar_26.y);
  beta_b_17 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (beta_b_17 * beta_b_17);
  beta_b_17 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (-2.0 * ((tmpvar_32 + tmpvar_34) / (1.0 + tmpvar_28)));
  mediump float tmpvar_36;
  tmpvar_36 = sqrt((tmpvar_28 * clamp (dot (n_21, tmpvar_24), 0.0, 1.0)));
  highp float tmpvar_37;
  tmpvar_37 = (((12.5664 * tmpvar_26.x) * tmpvar_26.y) * tmpvar_36);
  if ((tmpvar_37 != 0.0)) {
    SpecularAniso_16 = (vec3((exp(tmpvar_35) / tmpvar_37)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_16 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_38;
  tmpvar_38 = (orenNayar * orenNayar);
  rough_sq_15 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (1.0 - (0.5 * (rough_sq_15 / (rough_sq_15 + 0.57))));
  A_14 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (0.45 * (rough_sq_15 / (rough_sq_15 + 0.09)));
  B_13 = tmpvar_40;
  mediump float x_41;
  x_41 = dot (tmpvar_24, n_21);
  mediump float x_42;
  x_42 = dot (tmpvar_23, n_21);
  mediump float x_43;
  x_43 = dot (tmpvar_24, n_21);
  mediump float x_44;
  x_44 = dot (tmpvar_23, n_21);
  mediump float tmpvar_45;
  tmpvar_45 = min ((1.5708 - (sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296)))))))))), (1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))));
  SpecularFinal_12 = SpecularAniso_16;
  c_11.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_28))) * vec3((A_14 + ((B_13 * max (0.0, dot ((tmpvar_24 - (n_21 * dot (tmpvar_24, n_21))), (tmpvar_23 - (n_21 * dot (tmpvar_23, n_21)))))) * (sin(max ((1.5708 - (sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296)))))))))), (1.5708 - (sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296)))))))))))) * (sin(tmpvar_45) / cos(tmpvar_45))))))) + ((SpecularFinal_12 * SpecularTex_4.x) * _LightColor0.xyz)) * 2.0);
  c_11.w = 1.0;
  c_1.xyz = c_11.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w);
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize(xlv_TEXCOORD1));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c18.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul o3.xyz, r2.w, r2
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 465 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002441050500
[Microcode]
576
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d0f00d8086c0c360403fa8
401f9c6c01d0e00d8086c0c360405fa8401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa800001c6c011d100c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d100c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  mediump vec3 lightDir_14;
  lightDir_14 = lightDir_2;
  mediump float atten_15;
  atten_15 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_10.w) * tmpvar_13.w);
  mediump vec4 c_16;
  mediump vec3 SpecularFinal_17;
  mediump float B_18;
  mediump float A_19;
  highp float rough_sq_20;
  highp vec3 SpecularAniso_21;
  highp float beta_b_22;
  highp float beta_a_23;
  mediump float HdotB_24;
  mediump float HdotT_25;
  mediump vec3 n_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_26 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = normalize(lightDir_14);
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_30;
  tmpvar_30.x = _AnizoX;
  tmpvar_30.y = _AnizoY;
  mediump vec2 tmpvar_31;
  tmpvar_31 = (tmpvar_30 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((n_26.yzx * vec3(0.0, 1.0, 0.0)) - (n_26.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_33;
  tmpvar_33 = clamp (dot (n_26, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_28, tmpvar_32);
  HdotT_25 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (tmpvar_28, normalize(((n_26.yzx * tmpvar_32.zxy) - (n_26.zxy * tmpvar_32.yzx))));
  HdotB_24 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = (HdotT_25 / tmpvar_31.x);
  beta_a_23 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (beta_a_23 * beta_a_23);
  beta_a_23 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = (HdotB_24 / tmpvar_31.y);
  beta_b_22 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (beta_b_22 * beta_b_22);
  beta_b_22 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (-2.0 * ((tmpvar_37 + tmpvar_39) / (1.0 + tmpvar_33)));
  mediump float tmpvar_41;
  tmpvar_41 = sqrt((tmpvar_33 * clamp (dot (n_26, tmpvar_29), 0.0, 1.0)));
  highp float tmpvar_42;
  tmpvar_42 = (((12.5664 * tmpvar_31.x) * tmpvar_31.y) * tmpvar_41);
  if ((tmpvar_42 != 0.0)) {
    SpecularAniso_21 = (vec3((exp(tmpvar_40) / tmpvar_42)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_21 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_43;
  tmpvar_43 = (orenNayar * orenNayar);
  rough_sq_20 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0 - (0.5 * (rough_sq_20 / (rough_sq_20 + 0.57))));
  A_19 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (0.45 * (rough_sq_20 / (rough_sq_20 + 0.09)));
  B_18 = tmpvar_45;
  mediump float x_46;
  x_46 = dot (tmpvar_29, n_26);
  mediump float x_47;
  x_47 = dot (tmpvar_28, n_26);
  mediump float x_48;
  x_48 = dot (tmpvar_29, n_26);
  mediump float x_49;
  x_49 = dot (tmpvar_28, n_26);
  mediump float tmpvar_50;
  tmpvar_50 = min ((1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))), (1.5708 - (sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296)))))))))));
  SpecularFinal_17 = SpecularAniso_21;
  c_16.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_33))) * vec3((A_19 + ((B_18 * max (0.0, dot ((tmpvar_29 - (n_26 * dot (tmpvar_29, n_26))), (tmpvar_28 - (n_26 * dot (tmpvar_28, n_26)))))) * (sin(max ((1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))), (1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))))) * (sin(tmpvar_50) / cos(tmpvar_50))))))) + ((SpecularFinal_17 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_15 * 2.0));
  c_16.w = 1.0;
  c_1.xyz = c_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_2;
  mediump float atten_16;
  atten_16 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_11.w) * tmpvar_14.w);
  mediump vec4 c_17;
  mediump vec3 SpecularFinal_18;
  mediump float B_19;
  mediump float A_20;
  highp float rough_sq_21;
  highp vec3 SpecularAniso_22;
  highp float beta_b_23;
  highp float beta_a_24;
  mediump float HdotB_25;
  mediump float HdotT_26;
  mediump vec3 n_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(normal_6);
  n_27 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(lightDir_15);
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_31;
  tmpvar_31.x = _AnizoX;
  tmpvar_31.y = _AnizoY;
  mediump vec2 tmpvar_32;
  tmpvar_32 = (tmpvar_31 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(((n_27.yzx * vec3(0.0, 1.0, 0.0)) - (n_27.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (n_27, tmpvar_29), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = dot (tmpvar_29, tmpvar_33);
  HdotT_26 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (tmpvar_29, normalize(((n_27.yzx * tmpvar_33.zxy) - (n_27.zxy * tmpvar_33.yzx))));
  HdotB_25 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = (HdotT_26 / tmpvar_32.x);
  beta_a_24 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (beta_a_24 * beta_a_24);
  beta_a_24 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = (HdotB_25 / tmpvar_32.y);
  beta_b_23 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (beta_b_23 * beta_b_23);
  beta_b_23 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (-2.0 * ((tmpvar_38 + tmpvar_40) / (1.0 + tmpvar_34)));
  mediump float tmpvar_42;
  tmpvar_42 = sqrt((tmpvar_34 * clamp (dot (n_27, tmpvar_30), 0.0, 1.0)));
  highp float tmpvar_43;
  tmpvar_43 = (((12.5664 * tmpvar_32.x) * tmpvar_32.y) * tmpvar_42);
  if ((tmpvar_43 != 0.0)) {
    SpecularAniso_22 = (vec3((exp(tmpvar_41) / tmpvar_43)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_22 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_44;
  tmpvar_44 = (orenNayar * orenNayar);
  rough_sq_21 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - (0.5 * (rough_sq_21 / (rough_sq_21 + 0.57))));
  A_20 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (0.45 * (rough_sq_21 / (rough_sq_21 + 0.09)));
  B_19 = tmpvar_46;
  mediump float x_47;
  x_47 = dot (tmpvar_30, n_27);
  mediump float x_48;
  x_48 = dot (tmpvar_29, n_27);
  mediump float x_49;
  x_49 = dot (tmpvar_30, n_27);
  mediump float x_50;
  x_50 = dot (tmpvar_29, n_27);
  mediump float tmpvar_51;
  tmpvar_51 = min ((1.5708 - (sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296)))))))))), (1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))));
  SpecularFinal_18 = SpecularAniso_22;
  c_17.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_34))) * vec3((A_20 + ((B_19 * max (0.0, dot ((tmpvar_30 - (n_27 * dot (tmpvar_30, n_27))), (tmpvar_29 - (n_27 * dot (tmpvar_29, n_27)))))) * (sin(max ((1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))), (1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))))) * (sin(tmpvar_51) / cos(tmpvar_51))))))) + ((SpecularFinal_18 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_16 * 2.0));
  c_17.w = 1.0;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(normalize(xlv_TEXCOORD1));
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c18.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 465 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 35 instructions using 5 registers
[Configuration]
8
0000002341050500
[Microcode]
560
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d0e00d8086c0c360405fa8
401f9c6c01d0d00d8086c0c360409fa8401f9c6c01d0c00d8086c0c360411fa8
00001c6c011d100c02bfc0e30041dffc00009c6c00800e0c04bfc0836041dffc
00011c6c0140020c0106004360405ffc00011c6c01400e0c0106004360411ffc
00011c6c0140000c0286004360409ffc00001c6c011d100c08bfc0e30041dffc
00001c6c0140000c0486024360403ffc401f9c6c0140020c0106004360405fa0
401f9c6c21400e0c0086009fe02300a0401f9c6c0140000c0086014360409fa0
401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTextureB0, vec2(tmpvar_10));
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_13;
  lightDir_13 = lightDir_2;
  mediump float atten_14;
  atten_14 = (tmpvar_11.w * tmpvar_12.w);
  mediump vec4 c_15;
  mediump vec3 SpecularFinal_16;
  mediump float B_17;
  mediump float A_18;
  highp float rough_sq_19;
  highp vec3 SpecularAniso_20;
  highp float beta_b_21;
  highp float beta_a_22;
  mediump float HdotB_23;
  mediump float HdotT_24;
  mediump vec3 n_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_25 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(lightDir_13);
  mediump vec3 tmpvar_28;
  tmpvar_28 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_29;
  tmpvar_29.x = _AnizoX;
  tmpvar_29.y = _AnizoY;
  mediump vec2 tmpvar_30;
  tmpvar_30 = (tmpvar_29 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(((n_25.yzx * vec3(0.0, 1.0, 0.0)) - (n_25.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_32;
  tmpvar_32 = clamp (dot (n_25, tmpvar_27), 0.0, 1.0);
  highp float tmpvar_33;
  tmpvar_33 = dot (tmpvar_27, tmpvar_31);
  HdotT_24 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_27, normalize(((n_25.yzx * tmpvar_31.zxy) - (n_25.zxy * tmpvar_31.yzx))));
  HdotB_23 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = (HdotT_24 / tmpvar_30.x);
  beta_a_22 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (beta_a_22 * beta_a_22);
  beta_a_22 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = (HdotB_23 / tmpvar_30.y);
  beta_b_21 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (beta_b_21 * beta_b_21);
  beta_b_21 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (-2.0 * ((tmpvar_36 + tmpvar_38) / (1.0 + tmpvar_32)));
  mediump float tmpvar_40;
  tmpvar_40 = sqrt((tmpvar_32 * clamp (dot (n_25, tmpvar_28), 0.0, 1.0)));
  highp float tmpvar_41;
  tmpvar_41 = (((12.5664 * tmpvar_30.x) * tmpvar_30.y) * tmpvar_40);
  if ((tmpvar_41 != 0.0)) {
    SpecularAniso_20 = (vec3((exp(tmpvar_39) / tmpvar_41)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_20 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_42;
  tmpvar_42 = (orenNayar * orenNayar);
  rough_sq_19 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (1.0 - (0.5 * (rough_sq_19 / (rough_sq_19 + 0.57))));
  A_18 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (0.45 * (rough_sq_19 / (rough_sq_19 + 0.09)));
  B_17 = tmpvar_44;
  mediump float x_45;
  x_45 = dot (tmpvar_28, n_25);
  mediump float x_46;
  x_46 = dot (tmpvar_27, n_25);
  mediump float x_47;
  x_47 = dot (tmpvar_28, n_25);
  mediump float x_48;
  x_48 = dot (tmpvar_27, n_25);
  mediump float tmpvar_49;
  tmpvar_49 = min ((1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))), (1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))));
  SpecularFinal_16 = SpecularAniso_20;
  c_15.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_32))) * vec3((A_18 + ((B_17 * max (0.0, dot ((tmpvar_28 - (n_25 * dot (tmpvar_28, n_25))), (tmpvar_27 - (n_25 * dot (tmpvar_27, n_25)))))) * (sin(max ((1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))), (1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))))) * (sin(tmpvar_49) / cos(tmpvar_49))))))) + ((SpecularFinal_16 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_14 * 2.0));
  c_15.w = 1.0;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTextureB0, vec2(tmpvar_11));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_14;
  lightDir_14 = lightDir_2;
  mediump float atten_15;
  atten_15 = (tmpvar_12.w * tmpvar_13.w);
  mediump vec4 c_16;
  mediump vec3 SpecularFinal_17;
  mediump float B_18;
  mediump float A_19;
  highp float rough_sq_20;
  highp vec3 SpecularAniso_21;
  highp float beta_b_22;
  highp float beta_a_23;
  mediump float HdotB_24;
  mediump float HdotT_25;
  mediump vec3 n_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = normalize(normal_6);
  n_26 = tmpvar_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = normalize(lightDir_14);
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_30;
  tmpvar_30.x = _AnizoX;
  tmpvar_30.y = _AnizoY;
  mediump vec2 tmpvar_31;
  tmpvar_31 = (tmpvar_30 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((n_26.yzx * vec3(0.0, 1.0, 0.0)) - (n_26.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_33;
  tmpvar_33 = clamp (dot (n_26, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_28, tmpvar_32);
  HdotT_25 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = dot (tmpvar_28, normalize(((n_26.yzx * tmpvar_32.zxy) - (n_26.zxy * tmpvar_32.yzx))));
  HdotB_24 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = (HdotT_25 / tmpvar_31.x);
  beta_a_23 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (beta_a_23 * beta_a_23);
  beta_a_23 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = (HdotB_24 / tmpvar_31.y);
  beta_b_22 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (beta_b_22 * beta_b_22);
  beta_b_22 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (-2.0 * ((tmpvar_37 + tmpvar_39) / (1.0 + tmpvar_33)));
  mediump float tmpvar_41;
  tmpvar_41 = sqrt((tmpvar_33 * clamp (dot (n_26, tmpvar_29), 0.0, 1.0)));
  highp float tmpvar_42;
  tmpvar_42 = (((12.5664 * tmpvar_31.x) * tmpvar_31.y) * tmpvar_41);
  if ((tmpvar_42 != 0.0)) {
    SpecularAniso_21 = (vec3((exp(tmpvar_40) / tmpvar_42)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_21 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_43;
  tmpvar_43 = (orenNayar * orenNayar);
  rough_sq_20 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (1.0 - (0.5 * (rough_sq_20 / (rough_sq_20 + 0.57))));
  A_19 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (0.45 * (rough_sq_20 / (rough_sq_20 + 0.09)));
  B_18 = tmpvar_45;
  mediump float x_46;
  x_46 = dot (tmpvar_29, n_26);
  mediump float x_47;
  x_47 = dot (tmpvar_28, n_26);
  mediump float x_48;
  x_48 = dot (tmpvar_29, n_26);
  mediump float x_49;
  x_49 = dot (tmpvar_28, n_26);
  mediump float tmpvar_50;
  tmpvar_50 = min ((1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))), (1.5708 - (sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296)))))))))));
  SpecularFinal_17 = SpecularAniso_21;
  c_16.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_33))) * vec3((A_19 + ((B_18 * max (0.0, dot ((tmpvar_29 - (n_26 * dot (tmpvar_29, n_26))), (tmpvar_28 - (n_26 * dot (tmpvar_28, n_26)))))) * (sin(max ((1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))), (1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))))) * (sin(tmpvar_50) / cos(tmpvar_50))))))) + ((SpecularFinal_17 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_15 * 2.0));
  c_16.w = 1.0;
  c_1.xyz = c_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c18.w, -v0
mul r2.xyz, r1, v1.w
dp3 r1.y, r2, r0
dp3 r1.x, v1, r0
dp3 r1.z, v2, r0
dp3 r0.x, r1, r1
rsq r1.w, r0.x
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul o3.xyz, r1.w, r1
mov r1, c8
dp4 r3.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 465 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 33 instructions using 5 registers
[Configuration]
8
0000002141050500
[Microcode]
528
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc00009c6c011d100c02bfc0e30041dffc
401f9c6c01d0d00d8086c0c360409fa800011c6c00800e0c04bfc0836041dffc
00019c6c0140020c0106014360405ffc00019c6c01400e0c0106014360411ffc
00019c6c0140000c0486014360409ffc401f9c6c01d0c00d8086c0c360411fa8
00001c6c0140000c0686034360411ffc401f9c6c0140020c0106044360405fa0
401f9c6c21400e0c0886008000310020401f9c6c0140000c0886024360409fa0
401f9c6c00800000008603436041dfa5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_2;
  mediump float atten_11;
  atten_11 = tmpvar_9.w;
  mediump vec4 c_12;
  mediump vec3 SpecularFinal_13;
  mediump float B_14;
  mediump float A_15;
  highp float rough_sq_16;
  highp vec3 SpecularAniso_17;
  highp float beta_b_18;
  highp float beta_a_19;
  mediump float HdotB_20;
  mediump float HdotT_21;
  mediump vec3 n_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_22 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(lightDir_10);
  mediump vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_26;
  tmpvar_26.x = _AnizoX;
  tmpvar_26.y = _AnizoY;
  mediump vec2 tmpvar_27;
  tmpvar_27 = (tmpvar_26 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(((n_22.yzx * vec3(0.0, 1.0, 0.0)) - (n_22.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_29;
  tmpvar_29 = clamp (dot (n_22, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_30;
  tmpvar_30 = dot (tmpvar_24, tmpvar_28);
  HdotT_21 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = dot (tmpvar_24, normalize(((n_22.yzx * tmpvar_28.zxy) - (n_22.zxy * tmpvar_28.yzx))));
  HdotB_20 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = (HdotT_21 / tmpvar_27.x);
  beta_a_19 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (beta_a_19 * beta_a_19);
  beta_a_19 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = (HdotB_20 / tmpvar_27.y);
  beta_b_18 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (beta_b_18 * beta_b_18);
  beta_b_18 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (-2.0 * ((tmpvar_33 + tmpvar_35) / (1.0 + tmpvar_29)));
  mediump float tmpvar_37;
  tmpvar_37 = sqrt((tmpvar_29 * clamp (dot (n_22, tmpvar_25), 0.0, 1.0)));
  highp float tmpvar_38;
  tmpvar_38 = (((12.5664 * tmpvar_27.x) * tmpvar_27.y) * tmpvar_37);
  if ((tmpvar_38 != 0.0)) {
    SpecularAniso_17 = (vec3((exp(tmpvar_36) / tmpvar_38)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_17 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_39;
  tmpvar_39 = (orenNayar * orenNayar);
  rough_sq_16 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (1.0 - (0.5 * (rough_sq_16 / (rough_sq_16 + 0.57))));
  A_15 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (0.45 * (rough_sq_16 / (rough_sq_16 + 0.09)));
  B_14 = tmpvar_41;
  mediump float x_42;
  x_42 = dot (tmpvar_25, n_22);
  mediump float x_43;
  x_43 = dot (tmpvar_24, n_22);
  mediump float x_44;
  x_44 = dot (tmpvar_25, n_22);
  mediump float x_45;
  x_45 = dot (tmpvar_24, n_22);
  mediump float tmpvar_46;
  tmpvar_46 = min ((1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))), (1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))));
  SpecularFinal_13 = SpecularAniso_17;
  c_12.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_29))) * vec3((A_15 + ((B_14 * max (0.0, dot ((tmpvar_25 - (n_22 * dot (tmpvar_25, n_22))), (tmpvar_24 - (n_22 * dot (tmpvar_24, n_22)))))) * (sin(max ((1.5708 - (sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296)))))))))), (1.5708 - (sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296)))))))))))) * (sin(tmpvar_46) / cos(tmpvar_46))))))) + ((SpecularFinal_13 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_11 * 2.0));
  c_12.w = 1.0;
  c_1.xyz = c_12.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_2;
  mediump float atten_12;
  atten_12 = tmpvar_10.w;
  mediump vec4 c_13;
  mediump vec3 SpecularFinal_14;
  mediump float B_15;
  mediump float A_16;
  highp float rough_sq_17;
  highp vec3 SpecularAniso_18;
  highp float beta_b_19;
  highp float beta_a_20;
  mediump float HdotB_21;
  mediump float HdotT_22;
  mediump vec3 n_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = normalize(normal_6);
  n_23 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_11);
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_27;
  tmpvar_27.x = _AnizoX;
  tmpvar_27.y = _AnizoY;
  mediump vec2 tmpvar_28;
  tmpvar_28 = (tmpvar_27 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((n_23.yzx * vec3(0.0, 1.0, 0.0)) - (n_23.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_30;
  tmpvar_30 = clamp (dot (n_23, tmpvar_25), 0.0, 1.0);
  highp float tmpvar_31;
  tmpvar_31 = dot (tmpvar_25, tmpvar_29);
  HdotT_22 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_25, normalize(((n_23.yzx * tmpvar_29.zxy) - (n_23.zxy * tmpvar_29.yzx))));
  HdotB_21 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = (HdotT_22 / tmpvar_28.x);
  beta_a_20 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (beta_a_20 * beta_a_20);
  beta_a_20 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = (HdotB_21 / tmpvar_28.y);
  beta_b_19 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (beta_b_19 * beta_b_19);
  beta_b_19 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (-2.0 * ((tmpvar_34 + tmpvar_36) / (1.0 + tmpvar_30)));
  mediump float tmpvar_38;
  tmpvar_38 = sqrt((tmpvar_30 * clamp (dot (n_23, tmpvar_26), 0.0, 1.0)));
  highp float tmpvar_39;
  tmpvar_39 = (((12.5664 * tmpvar_28.x) * tmpvar_28.y) * tmpvar_38);
  if ((tmpvar_39 != 0.0)) {
    SpecularAniso_18 = (vec3((exp(tmpvar_37) / tmpvar_39)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_18 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_40;
  tmpvar_40 = (orenNayar * orenNayar);
  rough_sq_17 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (1.0 - (0.5 * (rough_sq_17 / (rough_sq_17 + 0.57))));
  A_16 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (0.45 * (rough_sq_17 / (rough_sq_17 + 0.09)));
  B_15 = tmpvar_42;
  mediump float x_43;
  x_43 = dot (tmpvar_26, n_23);
  mediump float x_44;
  x_44 = dot (tmpvar_25, n_23);
  mediump float x_45;
  x_45 = dot (tmpvar_26, n_23);
  mediump float x_46;
  x_46 = dot (tmpvar_25, n_23);
  mediump float tmpvar_47;
  tmpvar_47 = min ((1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))), (1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))));
  SpecularFinal_14 = SpecularAniso_18;
  c_13.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_30))) * vec3((A_16 + ((B_15 * max (0.0, dot ((tmpvar_26 - (n_23 * dot (tmpvar_26, n_23))), (tmpvar_25 - (n_23 * dot (tmpvar_25, n_23)))))) * (sin(max ((1.5708 - (sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296)))))))))), (1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))))) * (sin(tmpvar_47) / cos(tmpvar_47))))))) + ((SpecularFinal_14 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_12 * 2.0));
  c_13.w = 1.0;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  float tmpvar_9;
  if ((tmpvar_8.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_9 = _LightShadowData.x;
  } else {
    tmpvar_9 = 1.0;
  };
  float atten_10;
  atten_10 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_6.w) * tmpvar_7.w) * tmpvar_9);
  vec4 c_11;
  vec3 SpecularAniso_12;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_2);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_5);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_16;
  tmpvar_16.x = _AnizoX;
  tmpvar_16.y = _AnizoY;
  vec2 tmpvar_17;
  tmpvar_17 = (tmpvar_16 + vec2(1e-05, 1e-05));
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_13.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_13.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (tmpvar_13, tmpvar_14), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_14, tmpvar_18) / tmpvar_17.x);
  float tmpvar_21;
  tmpvar_21 = (dot (tmpvar_14, normalize(((tmpvar_13.yzx * tmpvar_18.zxy) - (tmpvar_13.zxy * tmpvar_18.yzx)))) / tmpvar_17.y);
  float tmpvar_22;
  tmpvar_22 = (-2.0 * (((tmpvar_20 * tmpvar_20) + (tmpvar_21 * tmpvar_21)) / (1.0 + tmpvar_19)));
  float tmpvar_23;
  tmpvar_23 = (((12.5664 * tmpvar_17.x) * tmpvar_17.y) * sqrt((tmpvar_19 * clamp (dot (tmpvar_13, tmpvar_15), 0.0, 1.0))));
  if ((tmpvar_23 != 0.0)) {
    SpecularAniso_12 = (vec3((exp(tmpvar_22) / tmpvar_23)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_12 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_24;
  tmpvar_24 = (orenNayar * orenNayar);
  float x_25;
  x_25 = dot (tmpvar_15, tmpvar_13);
  float x_26;
  x_26 = dot (tmpvar_14, tmpvar_13);
  float x_27;
  x_27 = dot (tmpvar_15, tmpvar_13);
  float x_28;
  x_28 = dot (tmpvar_14, tmpvar_13);
  float tmpvar_29;
  tmpvar_29 = min ((1.5708 - (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))))), (1.5708 - (sign(x_28) * (1.5708 - (sqrt((1.0 - abs(x_28))) * (1.5708 + (abs(x_28) * (-0.214602 + (abs(x_28) * (0.0865667 + (abs(x_28) * -0.0310296)))))))))));
  c_11.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_19))) * vec3(((1.0 - (0.5 * (tmpvar_24 / (tmpvar_24 + 0.57)))) + (((0.45 * (tmpvar_24 / (tmpvar_24 + 0.09))) * max (0.0, dot ((tmpvar_15 - (tmpvar_13 * dot (tmpvar_15, tmpvar_13))), (tmpvar_14 - (tmpvar_13 * dot (tmpvar_14, tmpvar_13)))))) * (sin(max ((1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))), (1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))))) * (sin(tmpvar_29) / cos(tmpvar_29))))))) + ((SpecularAniso_12 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_10 * 2.0));
  c_11.w = 1.0;
  c_1.xyz = c_11.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 22 [unity_Scale]
Matrix 16 [_LightMatrix0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 45 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c25.x
mov r0.xyz, c20
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r0.xyz, r2, c22.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mul o3.xyz, r2.w, r2
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [unity_World2Shadow0]
Matrix 264 [_Object2World]
Matrix 268 [_World2Object]
Vector 465 [unity_Scale]
Matrix 272 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 40 instructions using 5 registers
[Configuration]
8
0000002841050500
[Microcode]
640
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0b00d8106c0c360403ffc
00001c6c01d0a00d8106c0c360405ffc00001c6c01d0900d8106c0c360409ffc
00001c6c01d0800d8106c0c360411ffc00021c6c01d0e00d8286c0c360405ffc
00021c6c01d0d00d8286c0c360409ffc00021c6c01d0c00d8286c0c360411ffc
00009c6c0190e00c0686c0c360405ffc00009c6c0190d00c0686c0c360409ffc
00009c6c0190c00c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d1300d8086c0c360403fa8
401f9c6c01d1200d8086c0c360405fa8401f9c6c01d1100d8086c0c360409fa8
401f9c6c01d1000d8086c0c360411fa8401f9c6c01d0700d8086c0c360403fac
401f9c6c01d0600d8086c0c360405fac401f9c6c01d0500d8086c0c360409fac
401f9c6c01d0400d8086c0c360411fac00001c6c011d100c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d100c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  lowp float tmpvar_15;
  mediump float shadow_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_18;
  if ((tmpvar_17.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_18 = _LightShadowData.x;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_16 = tmpvar_18;
  tmpvar_15 = shadow_16;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_2;
  mediump float atten_20;
  atten_20 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_11.w) * tmpvar_14.w) * tmpvar_15);
  mediump vec4 c_21;
  mediump vec3 SpecularFinal_22;
  mediump float B_23;
  mediump float A_24;
  highp float rough_sq_25;
  highp vec3 SpecularAniso_26;
  highp float beta_b_27;
  highp float beta_a_28;
  mediump float HdotB_29;
  mediump float HdotT_30;
  mediump vec3 n_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize(tmpvar_6);
  n_31 = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_19);
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_35;
  tmpvar_35.x = _AnizoX;
  tmpvar_35.y = _AnizoY;
  mediump vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((n_31.yzx * vec3(0.0, 1.0, 0.0)) - (n_31.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (n_31, tmpvar_33), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_33, tmpvar_37);
  HdotT_30 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (tmpvar_33, normalize(((n_31.yzx * tmpvar_37.zxy) - (n_31.zxy * tmpvar_37.yzx))));
  HdotB_29 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = (HdotT_30 / tmpvar_36.x);
  beta_a_28 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (beta_a_28 * beta_a_28);
  beta_a_28 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (HdotB_29 / tmpvar_36.y);
  beta_b_27 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (beta_b_27 * beta_b_27);
  beta_b_27 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (-2.0 * ((tmpvar_42 + tmpvar_44) / (1.0 + tmpvar_38)));
  mediump float tmpvar_46;
  tmpvar_46 = sqrt((tmpvar_38 * clamp (dot (n_31, tmpvar_34), 0.0, 1.0)));
  highp float tmpvar_47;
  tmpvar_47 = (((12.5664 * tmpvar_36.x) * tmpvar_36.y) * tmpvar_46);
  if ((tmpvar_47 != 0.0)) {
    SpecularAniso_26 = (vec3((exp(tmpvar_45) / tmpvar_47)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_26 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_48;
  tmpvar_48 = (orenNayar * orenNayar);
  rough_sq_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - (0.5 * (rough_sq_25 / (rough_sq_25 + 0.57))));
  A_24 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (0.45 * (rough_sq_25 / (rough_sq_25 + 0.09)));
  B_23 = tmpvar_50;
  mediump float x_51;
  x_51 = dot (tmpvar_34, n_31);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_31);
  mediump float x_53;
  x_53 = dot (tmpvar_34, n_31);
  mediump float x_54;
  x_54 = dot (tmpvar_33, n_31);
  mediump float tmpvar_55;
  tmpvar_55 = min ((1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))), (1.5708 - (sign(x_54) * (1.5708 - (sqrt((1.0 - abs(x_54))) * (1.5708 + (abs(x_54) * (-0.214602 + (abs(x_54) * (0.0865667 + (abs(x_54) * -0.0310296)))))))))));
  SpecularFinal_22 = SpecularAniso_26;
  c_21.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_38))) * vec3((A_24 + ((B_23 * max (0.0, dot ((tmpvar_34 - (n_31 * dot (tmpvar_34, n_31))), (tmpvar_33 - (n_31 * dot (tmpvar_33, n_31)))))) * (sin(max ((1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))), (1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))))) * (sin(tmpvar_55) / cos(tmpvar_55))))))) + ((SpecularFinal_22 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_20 * 2.0));
  c_21.w = 1.0;
  c_1.xyz = c_21.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  lowp float tmpvar_15;
  mediump float shadow_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_18;
  if ((tmpvar_17.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_18 = _LightShadowData.x;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_16 = tmpvar_18;
  tmpvar_15 = shadow_16;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_2;
  mediump float atten_20;
  atten_20 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_11.w) * tmpvar_14.w) * tmpvar_15);
  mediump vec4 c_21;
  mediump vec3 SpecularFinal_22;
  mediump float B_23;
  mediump float A_24;
  highp float rough_sq_25;
  highp vec3 SpecularAniso_26;
  highp float beta_b_27;
  highp float beta_a_28;
  mediump float HdotB_29;
  mediump float HdotT_30;
  mediump vec3 n_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize(normal_6);
  n_31 = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_19);
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_35;
  tmpvar_35.x = _AnizoX;
  tmpvar_35.y = _AnizoY;
  mediump vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((n_31.yzx * vec3(0.0, 1.0, 0.0)) - (n_31.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (n_31, tmpvar_33), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_33, tmpvar_37);
  HdotT_30 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (tmpvar_33, normalize(((n_31.yzx * tmpvar_37.zxy) - (n_31.zxy * tmpvar_37.yzx))));
  HdotB_29 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = (HdotT_30 / tmpvar_36.x);
  beta_a_28 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (beta_a_28 * beta_a_28);
  beta_a_28 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (HdotB_29 / tmpvar_36.y);
  beta_b_27 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (beta_b_27 * beta_b_27);
  beta_b_27 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (-2.0 * ((tmpvar_42 + tmpvar_44) / (1.0 + tmpvar_38)));
  mediump float tmpvar_46;
  tmpvar_46 = sqrt((tmpvar_38 * clamp (dot (n_31, tmpvar_34), 0.0, 1.0)));
  highp float tmpvar_47;
  tmpvar_47 = (((12.5664 * tmpvar_36.x) * tmpvar_36.y) * tmpvar_46);
  if ((tmpvar_47 != 0.0)) {
    SpecularAniso_26 = (vec3((exp(tmpvar_45) / tmpvar_47)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_26 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_48;
  tmpvar_48 = (orenNayar * orenNayar);
  rough_sq_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - (0.5 * (rough_sq_25 / (rough_sq_25 + 0.57))));
  A_24 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (0.45 * (rough_sq_25 / (rough_sq_25 + 0.09)));
  B_23 = tmpvar_50;
  mediump float x_51;
  x_51 = dot (tmpvar_34, n_31);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_31);
  mediump float x_53;
  x_53 = dot (tmpvar_34, n_31);
  mediump float x_54;
  x_54 = dot (tmpvar_33, n_31);
  mediump float tmpvar_55;
  tmpvar_55 = min ((1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))), (1.5708 - (sign(x_54) * (1.5708 - (sqrt((1.0 - abs(x_54))) * (1.5708 + (abs(x_54) * (-0.214602 + (abs(x_54) * (0.0865667 + (abs(x_54) * -0.0310296)))))))))));
  SpecularFinal_22 = SpecularAniso_26;
  c_21.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_38))) * vec3((A_24 + ((B_23 * max (0.0, dot ((tmpvar_34 - (n_31 * dot (tmpvar_34, n_31))), (tmpvar_33 - (n_31 * dot (tmpvar_33, n_31)))))) * (sin(max ((1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))), (1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))))) * (sin(tmpvar_55) / cos(tmpvar_55))))))) + ((SpecularFinal_22 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_20 * 2.0));
  c_21.w = 1.0;
  c_1.xyz = c_21.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 22 [unity_Scale]
Matrix 16 [_LightMatrix0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 45 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c25.x
mov r0.xyz, c20
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r0.xyz, r2, c22.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mul o3.xyz, r2.w, r2
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [unity_World2Shadow0]
Matrix 264 [_Object2World]
Matrix 268 [_World2Object]
Vector 465 [unity_Scale]
Matrix 272 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 40 instructions using 5 registers
[Configuration]
8
0000002841050500
[Microcode]
640
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0b00d8106c0c360403ffc
00001c6c01d0a00d8106c0c360405ffc00001c6c01d0900d8106c0c360409ffc
00001c6c01d0800d8106c0c360411ffc00021c6c01d0e00d8286c0c360405ffc
00021c6c01d0d00d8286c0c360409ffc00021c6c01d0c00d8286c0c360411ffc
00009c6c0190e00c0686c0c360405ffc00009c6c0190d00c0686c0c360409ffc
00009c6c0190c00c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d1300d8086c0c360403fa8
401f9c6c01d1200d8086c0c360405fa8401f9c6c01d1100d8086c0c360409fa8
401f9c6c01d1000d8086c0c360411fa8401f9c6c01d0700d8086c0c360403fac
401f9c6c01d0600d8086c0c360405fac401f9c6c01d0500d8086c0c360409fac
401f9c6c01d0400d8086c0c360411fac00001c6c011d100c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d100c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  lowp float tmpvar_14;
  mediump float shadow_15;
  lowp float tmpvar_16;
  tmpvar_16 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD4);
  shadow_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_LightShadowData.x + (shadow_15 * (1.0 - _LightShadowData.x)));
  shadow_15 = tmpvar_17;
  tmpvar_14 = shadow_15;
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_2;
  mediump float atten_19;
  atten_19 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_10.w) * tmpvar_13.w) * tmpvar_14);
  mediump vec4 c_20;
  mediump vec3 SpecularFinal_21;
  mediump float B_22;
  mediump float A_23;
  highp float rough_sq_24;
  highp vec3 SpecularAniso_25;
  highp float beta_b_26;
  highp float beta_a_27;
  mediump float HdotB_28;
  mediump float HdotT_29;
  mediump vec3 n_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_30 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = normalize(lightDir_18);
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_34;
  tmpvar_34.x = _AnizoX;
  tmpvar_34.y = _AnizoY;
  mediump vec2 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((n_30.yzx * vec3(0.0, 1.0, 0.0)) - (n_30.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_37;
  tmpvar_37 = clamp (dot (n_30, tmpvar_32), 0.0, 1.0);
  highp float tmpvar_38;
  tmpvar_38 = dot (tmpvar_32, tmpvar_36);
  HdotT_29 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_32, normalize(((n_30.yzx * tmpvar_36.zxy) - (n_30.zxy * tmpvar_36.yzx))));
  HdotB_28 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = (HdotT_29 / tmpvar_35.x);
  beta_a_27 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (beta_a_27 * beta_a_27);
  beta_a_27 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (HdotB_28 / tmpvar_35.y);
  beta_b_26 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (beta_b_26 * beta_b_26);
  beta_b_26 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (-2.0 * ((tmpvar_41 + tmpvar_43) / (1.0 + tmpvar_37)));
  mediump float tmpvar_45;
  tmpvar_45 = sqrt((tmpvar_37 * clamp (dot (n_30, tmpvar_33), 0.0, 1.0)));
  highp float tmpvar_46;
  tmpvar_46 = (((12.5664 * tmpvar_35.x) * tmpvar_35.y) * tmpvar_45);
  if ((tmpvar_46 != 0.0)) {
    SpecularAniso_25 = (vec3((exp(tmpvar_44) / tmpvar_46)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_25 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_47;
  tmpvar_47 = (orenNayar * orenNayar);
  rough_sq_24 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - (0.5 * (rough_sq_24 / (rough_sq_24 + 0.57))));
  A_23 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (0.45 * (rough_sq_24 / (rough_sq_24 + 0.09)));
  B_22 = tmpvar_49;
  mediump float x_50;
  x_50 = dot (tmpvar_33, n_30);
  mediump float x_51;
  x_51 = dot (tmpvar_32, n_30);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_30);
  mediump float x_53;
  x_53 = dot (tmpvar_32, n_30);
  mediump float tmpvar_54;
  tmpvar_54 = min ((1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))), (1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))));
  SpecularFinal_21 = SpecularAniso_25;
  c_20.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_37))) * vec3((A_23 + ((B_22 * max (0.0, dot ((tmpvar_33 - (n_30 * dot (tmpvar_33, n_30))), (tmpvar_32 - (n_30 * dot (tmpvar_32, n_30)))))) * (sin(max ((1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))), (1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))))) * (sin(tmpvar_54) / cos(tmpvar_54))))))) + ((SpecularFinal_21 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_19 * 2.0));
  c_20.w = 1.0;
  c_1.xyz = c_20.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_3 = TANGENT.xyz;
  tmpvar_4 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = gl_Normal.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = gl_Normal.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = gl_Normal.z;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_5 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD2 = normalize((tmpvar_5 * (((_World2Object * tmpvar_6).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = o_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c15.x
mov r0.xyz, c8
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
mad r0.xyz, r2, c12.w, -v0
mul r2.xyz, r1, v1.w
dp3 r1.y, r2, r0
dp3 r1.x, v1, r0
dp3 r1.z, v2, r0
dp3 r0.x, r1, r1
rsq r1.w, r0.x
mov r0, c6
dp4 r3.z, c11, r0
mov r0, c5
dp4 r3.y, c11, r0
mul o3.xyz, r1.w, r1
mov r1, c4
dp4 r3.x, c11, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c9.x
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
mad o4.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_ProjectionParams]
Vector 465 [_WorldSpaceLightPos0]
Matrix 260 [_World2Object]
Vector 464 [unity_Scale]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 32 instructions using 5 registers
[Configuration]
8
0000002041050500
[Defaults]
1
461 1
3f000000
[Microcode]
512
00009c6c005d100d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c00001c6c01d0300d8106c0c360403ffc
00001c6c01d0200d8106c0c360405ffc00001c6c01d0100d8106c0c360409ffc
00001c6c01d0000d8106c0c360411ffc00021c6c01d0600d8286c0c360405ffc
00021c6c01d0500d8286c0c360409ffc00021c6c01d0400d8286c0c360411ffc
00009c6c0190600c0686c0c360405ffc00009c6c0190500c0686c0c360409ffc
00009c6c0190400c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c0040000d8086c0836041ff80
401f9c6c004000558086c08360407fa800009c6c011d000c02bfc0e30041dffc
00001c6c009cd00e008000c36041dffc401f9c6c0140020c0106044360405fa0
00011c6c00800e0c04bfc0836041dffc00019c6c0140020c0106014360405ffc
00019c6c01400e0c0106014360411ffc00019c6c0140000c0486014360409ffc
00001c6c009d202a808000c360409ffc00001c6c0140000c0686034360403ffc
401f9c6c00c000080086c09540219fa8401f9c6c21400e0c0886009fe0310020
401f9c6c0140000c0886024360409fa0401f9c6c00800000008603436041dfa5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_9;
  mediump float lightShadowDataX_10;
  highp float dist_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((dist_11 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_10);
  tmpvar_9 = tmpvar_14;
  mediump vec3 lightDir_15;
  lightDir_15 = lightDir_2;
  mediump float atten_16;
  atten_16 = tmpvar_9;
  mediump vec4 c_17;
  mediump vec3 SpecularFinal_18;
  mediump float B_19;
  mediump float A_20;
  highp float rough_sq_21;
  highp vec3 SpecularAniso_22;
  highp float beta_b_23;
  highp float beta_a_24;
  mediump float HdotB_25;
  mediump float HdotT_26;
  mediump vec3 n_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_27 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = normalize(lightDir_15);
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_31;
  tmpvar_31.x = _AnizoX;
  tmpvar_31.y = _AnizoY;
  mediump vec2 tmpvar_32;
  tmpvar_32 = (tmpvar_31 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize(((n_27.yzx * vec3(0.0, 1.0, 0.0)) - (n_27.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (n_27, tmpvar_29), 0.0, 1.0);
  highp float tmpvar_35;
  tmpvar_35 = dot (tmpvar_29, tmpvar_33);
  HdotT_26 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = dot (tmpvar_29, normalize(((n_27.yzx * tmpvar_33.zxy) - (n_27.zxy * tmpvar_33.yzx))));
  HdotB_25 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = (HdotT_26 / tmpvar_32.x);
  beta_a_24 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (beta_a_24 * beta_a_24);
  beta_a_24 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = (HdotB_25 / tmpvar_32.y);
  beta_b_23 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (beta_b_23 * beta_b_23);
  beta_b_23 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (-2.0 * ((tmpvar_38 + tmpvar_40) / (1.0 + tmpvar_34)));
  mediump float tmpvar_42;
  tmpvar_42 = sqrt((tmpvar_34 * clamp (dot (n_27, tmpvar_30), 0.0, 1.0)));
  highp float tmpvar_43;
  tmpvar_43 = (((12.5664 * tmpvar_32.x) * tmpvar_32.y) * tmpvar_42);
  if ((tmpvar_43 != 0.0)) {
    SpecularAniso_22 = (vec3((exp(tmpvar_41) / tmpvar_43)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_22 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_44;
  tmpvar_44 = (orenNayar * orenNayar);
  rough_sq_21 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (1.0 - (0.5 * (rough_sq_21 / (rough_sq_21 + 0.57))));
  A_20 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (0.45 * (rough_sq_21 / (rough_sq_21 + 0.09)));
  B_19 = tmpvar_46;
  mediump float x_47;
  x_47 = dot (tmpvar_30, n_27);
  mediump float x_48;
  x_48 = dot (tmpvar_29, n_27);
  mediump float x_49;
  x_49 = dot (tmpvar_30, n_27);
  mediump float x_50;
  x_50 = dot (tmpvar_29, n_27);
  mediump float tmpvar_51;
  tmpvar_51 = min ((1.5708 - (sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296)))))))))), (1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))));
  SpecularFinal_18 = SpecularAniso_22;
  c_17.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_34))) * vec3((A_20 + ((B_19 * max (0.0, dot ((tmpvar_30 - (n_27 * dot (tmpvar_30, n_27))), (tmpvar_29 - (n_27 * dot (tmpvar_29, n_27)))))) * (sin(max ((1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))), (1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))))) * (sin(tmpvar_51) / cos(tmpvar_51))))))) + ((SpecularFinal_18 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_16 * 2.0));
  c_17.w = 1.0;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (gl_ModelViewProjectionMatrix * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_14;
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_6.zw;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = o_15;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_2;
  mediump float atten_12;
  atten_12 = tmpvar_10;
  mediump vec4 c_13;
  mediump vec3 SpecularFinal_14;
  mediump float B_15;
  mediump float A_16;
  highp float rough_sq_17;
  highp vec3 SpecularAniso_18;
  highp float beta_b_19;
  highp float beta_a_20;
  mediump float HdotB_21;
  mediump float HdotT_22;
  mediump vec3 n_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = normalize(normal_6);
  n_23 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = normalize(lightDir_11);
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_27;
  tmpvar_27.x = _AnizoX;
  tmpvar_27.y = _AnizoY;
  mediump vec2 tmpvar_28;
  tmpvar_28 = (tmpvar_27 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((n_23.yzx * vec3(0.0, 1.0, 0.0)) - (n_23.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_30;
  tmpvar_30 = clamp (dot (n_23, tmpvar_25), 0.0, 1.0);
  highp float tmpvar_31;
  tmpvar_31 = dot (tmpvar_25, tmpvar_29);
  HdotT_22 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_25, normalize(((n_23.yzx * tmpvar_29.zxy) - (n_23.zxy * tmpvar_29.yzx))));
  HdotB_21 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = (HdotT_22 / tmpvar_28.x);
  beta_a_20 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = (beta_a_20 * beta_a_20);
  beta_a_20 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = (HdotB_21 / tmpvar_28.y);
  beta_b_19 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (beta_b_19 * beta_b_19);
  beta_b_19 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (-2.0 * ((tmpvar_34 + tmpvar_36) / (1.0 + tmpvar_30)));
  mediump float tmpvar_38;
  tmpvar_38 = sqrt((tmpvar_30 * clamp (dot (n_23, tmpvar_26), 0.0, 1.0)));
  highp float tmpvar_39;
  tmpvar_39 = (((12.5664 * tmpvar_28.x) * tmpvar_28.y) * tmpvar_38);
  if ((tmpvar_39 != 0.0)) {
    SpecularAniso_18 = (vec3((exp(tmpvar_37) / tmpvar_39)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_18 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_40;
  tmpvar_40 = (orenNayar * orenNayar);
  rough_sq_17 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (1.0 - (0.5 * (rough_sq_17 / (rough_sq_17 + 0.57))));
  A_16 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (0.45 * (rough_sq_17 / (rough_sq_17 + 0.09)));
  B_15 = tmpvar_42;
  mediump float x_43;
  x_43 = dot (tmpvar_26, n_23);
  mediump float x_44;
  x_44 = dot (tmpvar_25, n_23);
  mediump float x_45;
  x_45 = dot (tmpvar_26, n_23);
  mediump float x_46;
  x_46 = dot (tmpvar_25, n_23);
  mediump float tmpvar_47;
  tmpvar_47 = min ((1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))), (1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))));
  SpecularFinal_14 = SpecularAniso_18;
  c_13.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_30))) * vec3((A_16 + ((B_15 * max (0.0, dot ((tmpvar_26 - (n_23 * dot (tmpvar_26, n_23))), (tmpvar_25 - (n_23 * dot (tmpvar_25, n_23)))))) * (sin(max ((1.5708 - (sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296)))))))))), (1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))))) * (sin(tmpvar_47) / cos(tmpvar_47))))))) + ((SpecularFinal_14 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_12 * 2.0));
  c_13.w = 1.0;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_3 = TANGENT.xyz;
  tmpvar_4 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = gl_Normal.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = gl_Normal.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = gl_Normal.z;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  vec4 o_7;
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * 0.5);
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_5 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD2 = normalize((tmpvar_5 * (((_World2Object * tmpvar_6).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD4 = o_7;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  float atten_5;
  atten_5 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x);
  vec4 c_6;
  vec3 SpecularAniso_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(normal_2);
  vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_11;
  tmpvar_11.x = _AnizoX;
  tmpvar_11.y = _AnizoY;
  vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11 + vec2(1e-05, 1e-05));
  vec3 tmpvar_13;
  tmpvar_13 = normalize(((tmpvar_8.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_8.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_14;
  tmpvar_14 = clamp (dot (tmpvar_8, tmpvar_9), 0.0, 1.0);
  float tmpvar_15;
  tmpvar_15 = (dot (tmpvar_9, tmpvar_13) / tmpvar_12.x);
  float tmpvar_16;
  tmpvar_16 = (dot (tmpvar_9, normalize(((tmpvar_8.yzx * tmpvar_13.zxy) - (tmpvar_8.zxy * tmpvar_13.yzx)))) / tmpvar_12.y);
  float tmpvar_17;
  tmpvar_17 = (-2.0 * (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) / (1.0 + tmpvar_14)));
  float tmpvar_18;
  tmpvar_18 = (((12.5664 * tmpvar_12.x) * tmpvar_12.y) * sqrt((tmpvar_14 * clamp (dot (tmpvar_8, tmpvar_10), 0.0, 1.0))));
  if ((tmpvar_18 != 0.0)) {
    SpecularAniso_7 = (vec3((exp(tmpvar_17) / tmpvar_18)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_7 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_19;
  tmpvar_19 = (orenNayar * orenNayar);
  float x_20;
  x_20 = dot (tmpvar_10, tmpvar_8);
  float x_21;
  x_21 = dot (tmpvar_9, tmpvar_8);
  float x_22;
  x_22 = dot (tmpvar_10, tmpvar_8);
  float x_23;
  x_23 = dot (tmpvar_9, tmpvar_8);
  float tmpvar_24;
  tmpvar_24 = min ((1.5708 - (sign(x_22) * (1.5708 - (sqrt((1.0 - abs(x_22))) * (1.5708 + (abs(x_22) * (-0.214602 + (abs(x_22) * (0.0865667 + (abs(x_22) * -0.0310296)))))))))), (1.5708 - (sign(x_23) * (1.5708 - (sqrt((1.0 - abs(x_23))) * (1.5708 + (abs(x_23) * (-0.214602 + (abs(x_23) * (0.0865667 + (abs(x_23) * -0.0310296)))))))))));
  c_6.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_14))) * vec3(((1.0 - (0.5 * (tmpvar_19 / (tmpvar_19 + 0.57)))) + (((0.45 * (tmpvar_19 / (tmpvar_19 + 0.09))) * max (0.0, dot ((tmpvar_10 - (tmpvar_8 * dot (tmpvar_10, tmpvar_8))), (tmpvar_9 - (tmpvar_8 * dot (tmpvar_9, tmpvar_8)))))) * (sin(max ((1.5708 - (sign(x_20) * (1.5708 - (sqrt((1.0 - abs(x_20))) * (1.5708 + (abs(x_20) * (-0.214602 + (abs(x_20) * (0.0865667 + (abs(x_20) * -0.0310296)))))))))), (1.5708 - (sign(x_21) * (1.5708 - (sqrt((1.0 - abs(x_21))) * (1.5708 + (abs(x_21) * (-0.214602 + (abs(x_21) * (0.0865667 + (abs(x_21) * -0.0310296)))))))))))) * (sin(tmpvar_24) / cos(tmpvar_24))))))) + ((SpecularAniso_7 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_5 * 2.0));
  c_6.w = 1.0;
  c_1.xyz = c_6.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 20 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c23.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c20.w, -v0
mul r2.xyz, r1, v1.w
dp3 r1.y, r2, r0
dp3 r1.x, v1, r0
dp3 r1.z, v2, r0
dp3 r0.x, r1, r1
rsq r1.w, r0.x
mov r0, c10
dp4 r3.z, c19, r0
mov r0, c9
dp4 r3.y, c19, r0
mul o3.xyz, r1.w, r1
mov r1, c8
dp4 r3.x, c19, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c17.x
mad o5.xy, r1.z, c18.zwzw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
mov o0, r0
dp4 o4.y, r1, c13
dp4 o4.x, r1, c12
mov o5.zw, r0
mad o1.zw, v3.xyxy, c22.xyxy, c22
mad o1.xy, v3, c21, c21.zwzw
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_ProjectionParams]
Vector 465 [_WorldSpaceLightPos0]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 464 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 38 instructions using 6 registers
[Configuration]
8
0000002641050600
[Defaults]
1
461 1
3f000000
[Microcode]
608
00011c6c005d100d8186c0836041fffc00019c6c00400e0c0106c0836041dffc
00021c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c00009c6c01d0300d8106c0c360403ffc
00009c6c01d0200d8106c0c360405ffc00009c6c01d0100d8106c0c360409ffc
00009c6c01d0000d8106c0c360411ffc00001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00029c6c01d0a00d8486c0c360405ffc
00029c6c01d0900d8486c0c360409ffc00029c6c01d0800d8486c0c360411ffc
00011c6c0190a00c0886c0c360405ffc00011c6c0190900c0886c0c360409ffc
00011c6c0190800c0886c0c360411ffc00021c6c00800243011843436041dffc
00019c6c01000230812183630221dffc401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa8401f9c6c0040000d8286c0836041ff80
401f9c6c004000558286c08360407fac00001c6c011d000c04bfc0e30041dffc
00009c6c009cd00e028000c36041dffc401f9c6c0140020c0106054360405fa0
00011c6c00800e0c06bfc0836041dffc00019c6c0140020c0106004360405ffc
00019c6c01400e0c0106004360411ffc00019c6c0140000c0486004360409ffc
00009c6c009d202a828000c360409ffc00001c6c0140000c0686034360411ffc
401f9c6c00c000080286c09540a19fac401f9c6c21400e0c0a86008000310020
401f9c6c0140000c0a86024360409fa0401f9c6c00800000008603436041dfa5
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  mediump vec3 lightDir_16;
  lightDir_16 = lightDir_2;
  mediump float atten_17;
  atten_17 = (tmpvar_9.w * tmpvar_10);
  mediump vec4 c_18;
  mediump vec3 SpecularFinal_19;
  mediump float B_20;
  mediump float A_21;
  highp float rough_sq_22;
  highp vec3 SpecularAniso_23;
  highp float beta_b_24;
  highp float beta_a_25;
  mediump float HdotB_26;
  mediump float HdotT_27;
  mediump vec3 n_28;
  lowp vec3 tmpvar_29;
  tmpvar_29 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_28 = tmpvar_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(lightDir_16);
  mediump vec3 tmpvar_31;
  tmpvar_31 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_32;
  tmpvar_32.x = _AnizoX;
  tmpvar_32.y = _AnizoY;
  mediump vec2 tmpvar_33;
  tmpvar_33 = (tmpvar_32 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(((n_28.yzx * vec3(0.0, 1.0, 0.0)) - (n_28.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_35;
  tmpvar_35 = clamp (dot (n_28, tmpvar_30), 0.0, 1.0);
  highp float tmpvar_36;
  tmpvar_36 = dot (tmpvar_30, tmpvar_34);
  HdotT_27 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = dot (tmpvar_30, normalize(((n_28.yzx * tmpvar_34.zxy) - (n_28.zxy * tmpvar_34.yzx))));
  HdotB_26 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = (HdotT_27 / tmpvar_33.x);
  beta_a_25 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (beta_a_25 * beta_a_25);
  beta_a_25 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = (HdotB_26 / tmpvar_33.y);
  beta_b_24 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (beta_b_24 * beta_b_24);
  beta_b_24 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (-2.0 * ((tmpvar_39 + tmpvar_41) / (1.0 + tmpvar_35)));
  mediump float tmpvar_43;
  tmpvar_43 = sqrt((tmpvar_35 * clamp (dot (n_28, tmpvar_31), 0.0, 1.0)));
  highp float tmpvar_44;
  tmpvar_44 = (((12.5664 * tmpvar_33.x) * tmpvar_33.y) * tmpvar_43);
  if ((tmpvar_44 != 0.0)) {
    SpecularAniso_23 = (vec3((exp(tmpvar_42) / tmpvar_44)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_23 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_45;
  tmpvar_45 = (orenNayar * orenNayar);
  rough_sq_22 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (1.0 - (0.5 * (rough_sq_22 / (rough_sq_22 + 0.57))));
  A_21 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (0.45 * (rough_sq_22 / (rough_sq_22 + 0.09)));
  B_20 = tmpvar_47;
  mediump float x_48;
  x_48 = dot (tmpvar_31, n_28);
  mediump float x_49;
  x_49 = dot (tmpvar_30, n_28);
  mediump float x_50;
  x_50 = dot (tmpvar_31, n_28);
  mediump float x_51;
  x_51 = dot (tmpvar_30, n_28);
  mediump float tmpvar_52;
  tmpvar_52 = min ((1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))), (1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))));
  SpecularFinal_19 = SpecularAniso_23;
  c_18.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_35))) * vec3((A_21 + ((B_20 * max (0.0, dot ((tmpvar_31 - (n_28 * dot (tmpvar_31, n_28))), (tmpvar_30 - (n_28 * dot (tmpvar_30, n_28)))))) * (sin(max ((1.5708 - (sign(x_48) * (1.5708 - (sqrt((1.0 - abs(x_48))) * (1.5708 + (abs(x_48) * (-0.214602 + (abs(x_48) * (0.0865667 + (abs(x_48) * -0.0310296)))))))))), (1.5708 - (sign(x_49) * (1.5708 - (sqrt((1.0 - abs(x_49))) * (1.5708 + (abs(x_49) * (-0.214602 + (abs(x_49) * (0.0865667 + (abs(x_49) * -0.0310296)))))))))))) * (sin(tmpvar_52) / cos(tmpvar_52))))))) + ((SpecularFinal_19 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_17 * 2.0));
  c_18.w = 1.0;
  c_1.xyz = c_18.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (gl_ModelViewProjectionMatrix * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_14;
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_6.zw;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = o_15;
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, xlv_TEXCOORD3);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  mediump vec3 lightDir_12;
  lightDir_12 = lightDir_2;
  mediump float atten_13;
  atten_13 = (tmpvar_10.w * tmpvar_11.x);
  mediump vec4 c_14;
  mediump vec3 SpecularFinal_15;
  mediump float B_16;
  mediump float A_17;
  highp float rough_sq_18;
  highp vec3 SpecularAniso_19;
  highp float beta_b_20;
  highp float beta_a_21;
  mediump float HdotB_22;
  mediump float HdotT_23;
  mediump vec3 n_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize(normal_6);
  n_24 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = normalize(lightDir_12);
  mediump vec3 tmpvar_27;
  tmpvar_27 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_28;
  tmpvar_28.x = _AnizoX;
  tmpvar_28.y = _AnizoY;
  mediump vec2 tmpvar_29;
  tmpvar_29 = (tmpvar_28 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize(((n_24.yzx * vec3(0.0, 1.0, 0.0)) - (n_24.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_31;
  tmpvar_31 = clamp (dot (n_24, tmpvar_26), 0.0, 1.0);
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_26, tmpvar_30);
  HdotT_23 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = dot (tmpvar_26, normalize(((n_24.yzx * tmpvar_30.zxy) - (n_24.zxy * tmpvar_30.yzx))));
  HdotB_22 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = (HdotT_23 / tmpvar_29.x);
  beta_a_21 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (beta_a_21 * beta_a_21);
  beta_a_21 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = (HdotB_22 / tmpvar_29.y);
  beta_b_20 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (beta_b_20 * beta_b_20);
  beta_b_20 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (-2.0 * ((tmpvar_35 + tmpvar_37) / (1.0 + tmpvar_31)));
  mediump float tmpvar_39;
  tmpvar_39 = sqrt((tmpvar_31 * clamp (dot (n_24, tmpvar_27), 0.0, 1.0)));
  highp float tmpvar_40;
  tmpvar_40 = (((12.5664 * tmpvar_29.x) * tmpvar_29.y) * tmpvar_39);
  if ((tmpvar_40 != 0.0)) {
    SpecularAniso_19 = (vec3((exp(tmpvar_38) / tmpvar_40)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_19 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_41;
  tmpvar_41 = (orenNayar * orenNayar);
  rough_sq_18 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (1.0 - (0.5 * (rough_sq_18 / (rough_sq_18 + 0.57))));
  A_17 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (0.45 * (rough_sq_18 / (rough_sq_18 + 0.09)));
  B_16 = tmpvar_43;
  mediump float x_44;
  x_44 = dot (tmpvar_27, n_24);
  mediump float x_45;
  x_45 = dot (tmpvar_26, n_24);
  mediump float x_46;
  x_46 = dot (tmpvar_27, n_24);
  mediump float x_47;
  x_47 = dot (tmpvar_26, n_24);
  mediump float tmpvar_48;
  tmpvar_48 = min ((1.5708 - (sign(x_46) * (1.5708 - (sqrt((1.0 - abs(x_46))) * (1.5708 + (abs(x_46) * (-0.214602 + (abs(x_46) * (0.0865667 + (abs(x_46) * -0.0310296)))))))))), (1.5708 - (sign(x_47) * (1.5708 - (sqrt((1.0 - abs(x_47))) * (1.5708 + (abs(x_47) * (-0.214602 + (abs(x_47) * (0.0865667 + (abs(x_47) * -0.0310296)))))))))));
  SpecularFinal_15 = SpecularAniso_19;
  c_14.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_31))) * vec3((A_17 + ((B_16 * max (0.0, dot ((tmpvar_27 - (n_24 * dot (tmpvar_27, n_24))), (tmpvar_26 - (n_24 * dot (tmpvar_26, n_24)))))) * (sin(max ((1.5708 - (sign(x_44) * (1.5708 - (sqrt((1.0 - abs(x_44))) * (1.5708 + (abs(x_44) * (-0.214602 + (abs(x_44) * (0.0865667 + (abs(x_44) * -0.0310296)))))))))), (1.5708 - (sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296)))))))))))) * (sin(tmpvar_48) / cos(tmpvar_48))))))) + ((SpecularFinal_15 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_13 * 2.0));
  c_14.w = 1.0;
  c_1.xyz = c_14.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  float tmpvar_7;
  tmpvar_7 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_8;
  tmpvar_8 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_9;
  if ((tmpvar_8 < tmpvar_7)) {
    tmpvar_9 = _LightShadowData.x;
  } else {
    tmpvar_9 = 1.0;
  };
  float atten_10;
  atten_10 = (tmpvar_6.w * tmpvar_9);
  vec4 c_11;
  vec3 SpecularAniso_12;
  vec3 tmpvar_13;
  tmpvar_13 = normalize(normal_2);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_5);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_16;
  tmpvar_16.x = _AnizoX;
  tmpvar_16.y = _AnizoY;
  vec2 tmpvar_17;
  tmpvar_17 = (tmpvar_16 + vec2(1e-05, 1e-05));
  vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_13.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_13.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (tmpvar_13, tmpvar_14), 0.0, 1.0);
  float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_14, tmpvar_18) / tmpvar_17.x);
  float tmpvar_21;
  tmpvar_21 = (dot (tmpvar_14, normalize(((tmpvar_13.yzx * tmpvar_18.zxy) - (tmpvar_13.zxy * tmpvar_18.yzx)))) / tmpvar_17.y);
  float tmpvar_22;
  tmpvar_22 = (-2.0 * (((tmpvar_20 * tmpvar_20) + (tmpvar_21 * tmpvar_21)) / (1.0 + tmpvar_19)));
  float tmpvar_23;
  tmpvar_23 = (((12.5664 * tmpvar_17.x) * tmpvar_17.y) * sqrt((tmpvar_19 * clamp (dot (tmpvar_13, tmpvar_15), 0.0, 1.0))));
  if ((tmpvar_23 != 0.0)) {
    SpecularAniso_12 = (vec3((exp(tmpvar_22) / tmpvar_23)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_12 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_24;
  tmpvar_24 = (orenNayar * orenNayar);
  float x_25;
  x_25 = dot (tmpvar_15, tmpvar_13);
  float x_26;
  x_26 = dot (tmpvar_14, tmpvar_13);
  float x_27;
  x_27 = dot (tmpvar_15, tmpvar_13);
  float x_28;
  x_28 = dot (tmpvar_14, tmpvar_13);
  float tmpvar_29;
  tmpvar_29 = min ((1.5708 - (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))))), (1.5708 - (sign(x_28) * (1.5708 - (sqrt((1.0 - abs(x_28))) * (1.5708 + (abs(x_28) * (-0.214602 + (abs(x_28) * (0.0865667 + (abs(x_28) * -0.0310296)))))))))));
  c_11.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_19))) * vec3(((1.0 - (0.5 * (tmpvar_24 / (tmpvar_24 + 0.57)))) + (((0.45 * (tmpvar_24 / (tmpvar_24 + 0.09))) * max (0.0, dot ((tmpvar_15 - (tmpvar_13 * dot (tmpvar_15, tmpvar_13))), (tmpvar_14 - (tmpvar_13 * dot (tmpvar_14, tmpvar_13)))))) * (sin(max ((1.5708 - (sign(x_25) * (1.5708 - (sqrt((1.0 - abs(x_25))) * (1.5708 + (abs(x_25) * (-0.214602 + (abs(x_25) * (0.0865667 + (abs(x_25) * -0.0310296)))))))))), (1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))))) * (sin(tmpvar_29) / cos(tmpvar_29))))))) + ((SpecularAniso_12 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_10 * 2.0));
  c_11.w = 1.0;
  c_1.xyz = c_11.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c19.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [_LightPositionRange]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 464 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002441050500
[Microcode]
576
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc401f9c6c00dd108c0186c0830021dfac
00019c6c00800243011842436041dffc00011c6c010002308121826301a1dffc
401f9c6c01d0e00d8086c0c360405fa8401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa800001c6c011d000c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d000c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_17;
  if ((tmpvar_16 < tmpvar_13)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_2;
  mediump float atten_19;
  atten_19 = (tmpvar_12.w * tmpvar_17);
  mediump vec4 c_20;
  mediump vec3 SpecularFinal_21;
  mediump float B_22;
  mediump float A_23;
  highp float rough_sq_24;
  highp vec3 SpecularAniso_25;
  highp float beta_b_26;
  highp float beta_a_27;
  mediump float HdotB_28;
  mediump float HdotT_29;
  mediump vec3 n_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize(tmpvar_6);
  n_30 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = normalize(lightDir_18);
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_34;
  tmpvar_34.x = _AnizoX;
  tmpvar_34.y = _AnizoY;
  mediump vec2 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((n_30.yzx * vec3(0.0, 1.0, 0.0)) - (n_30.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_37;
  tmpvar_37 = clamp (dot (n_30, tmpvar_32), 0.0, 1.0);
  highp float tmpvar_38;
  tmpvar_38 = dot (tmpvar_32, tmpvar_36);
  HdotT_29 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_32, normalize(((n_30.yzx * tmpvar_36.zxy) - (n_30.zxy * tmpvar_36.yzx))));
  HdotB_28 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = (HdotT_29 / tmpvar_35.x);
  beta_a_27 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (beta_a_27 * beta_a_27);
  beta_a_27 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (HdotB_28 / tmpvar_35.y);
  beta_b_26 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (beta_b_26 * beta_b_26);
  beta_b_26 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (-2.0 * ((tmpvar_41 + tmpvar_43) / (1.0 + tmpvar_37)));
  mediump float tmpvar_45;
  tmpvar_45 = sqrt((tmpvar_37 * clamp (dot (n_30, tmpvar_33), 0.0, 1.0)));
  highp float tmpvar_46;
  tmpvar_46 = (((12.5664 * tmpvar_35.x) * tmpvar_35.y) * tmpvar_45);
  if ((tmpvar_46 != 0.0)) {
    SpecularAniso_25 = (vec3((exp(tmpvar_44) / tmpvar_46)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_25 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_47;
  tmpvar_47 = (orenNayar * orenNayar);
  rough_sq_24 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - (0.5 * (rough_sq_24 / (rough_sq_24 + 0.57))));
  A_23 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (0.45 * (rough_sq_24 / (rough_sq_24 + 0.09)));
  B_22 = tmpvar_49;
  mediump float x_50;
  x_50 = dot (tmpvar_33, n_30);
  mediump float x_51;
  x_51 = dot (tmpvar_32, n_30);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_30);
  mediump float x_53;
  x_53 = dot (tmpvar_32, n_30);
  mediump float tmpvar_54;
  tmpvar_54 = min ((1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))), (1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))));
  SpecularFinal_21 = SpecularAniso_25;
  c_20.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_37))) * vec3((A_23 + ((B_22 * max (0.0, dot ((tmpvar_33 - (n_30 * dot (tmpvar_33, n_30))), (tmpvar_32 - (n_30 * dot (tmpvar_32, n_30)))))) * (sin(max ((1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))), (1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))))) * (sin(tmpvar_54) / cos(tmpvar_54))))))) + ((SpecularFinal_21 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_19 * 2.0));
  c_20.w = 1.0;
  c_1.xyz = c_20.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(tmpvar_11));
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (packDist_14, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_17;
  if ((tmpvar_16 < tmpvar_13)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_2;
  mediump float atten_19;
  atten_19 = (tmpvar_12.w * tmpvar_17);
  mediump vec4 c_20;
  mediump vec3 SpecularFinal_21;
  mediump float B_22;
  mediump float A_23;
  highp float rough_sq_24;
  highp vec3 SpecularAniso_25;
  highp float beta_b_26;
  highp float beta_a_27;
  mediump float HdotB_28;
  mediump float HdotT_29;
  mediump vec3 n_30;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize(normal_6);
  n_30 = tmpvar_31;
  mediump vec3 tmpvar_32;
  tmpvar_32 = normalize(lightDir_18);
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_34;
  tmpvar_34.x = _AnizoX;
  tmpvar_34.y = _AnizoY;
  mediump vec2 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((n_30.yzx * vec3(0.0, 1.0, 0.0)) - (n_30.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_37;
  tmpvar_37 = clamp (dot (n_30, tmpvar_32), 0.0, 1.0);
  highp float tmpvar_38;
  tmpvar_38 = dot (tmpvar_32, tmpvar_36);
  HdotT_29 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_32, normalize(((n_30.yzx * tmpvar_36.zxy) - (n_30.zxy * tmpvar_36.yzx))));
  HdotB_28 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = (HdotT_29 / tmpvar_35.x);
  beta_a_27 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (beta_a_27 * beta_a_27);
  beta_a_27 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = (HdotB_28 / tmpvar_35.y);
  beta_b_26 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (beta_b_26 * beta_b_26);
  beta_b_26 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (-2.0 * ((tmpvar_41 + tmpvar_43) / (1.0 + tmpvar_37)));
  mediump float tmpvar_45;
  tmpvar_45 = sqrt((tmpvar_37 * clamp (dot (n_30, tmpvar_33), 0.0, 1.0)));
  highp float tmpvar_46;
  tmpvar_46 = (((12.5664 * tmpvar_35.x) * tmpvar_35.y) * tmpvar_45);
  if ((tmpvar_46 != 0.0)) {
    SpecularAniso_25 = (vec3((exp(tmpvar_44) / tmpvar_46)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_25 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_47;
  tmpvar_47 = (orenNayar * orenNayar);
  rough_sq_24 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (1.0 - (0.5 * (rough_sq_24 / (rough_sq_24 + 0.57))));
  A_23 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (0.45 * (rough_sq_24 / (rough_sq_24 + 0.09)));
  B_22 = tmpvar_49;
  mediump float x_50;
  x_50 = dot (tmpvar_33, n_30);
  mediump float x_51;
  x_51 = dot (tmpvar_32, n_30);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_30);
  mediump float x_53;
  x_53 = dot (tmpvar_32, n_30);
  mediump float tmpvar_54;
  tmpvar_54 = min ((1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))), (1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))));
  SpecularFinal_21 = SpecularAniso_25;
  c_20.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_37))) * vec3((A_23 + ((B_22 * max (0.0, dot ((tmpvar_33 - (n_30 * dot (tmpvar_33, n_30))), (tmpvar_32 - (n_30 * dot (tmpvar_32, n_30)))))) * (sin(max ((1.5708 - (sign(x_50) * (1.5708 - (sqrt((1.0 - abs(x_50))) * (1.5708 + (abs(x_50) * (-0.214602 + (abs(x_50) * (0.0865667 + (abs(x_50) * -0.0310296)))))))))), (1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))))) * (sin(tmpvar_54) / cos(tmpvar_54))))))) + ((SpecularFinal_21 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_19 * 2.0));
  c_20.w = 1.0;
  c_1.xyz = c_20.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_7;
  tmpvar_7 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  float tmpvar_8;
  tmpvar_8 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_9;
  tmpvar_9 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_10;
  if ((tmpvar_9 < tmpvar_8)) {
    tmpvar_10 = _LightShadowData.x;
  } else {
    tmpvar_10 = 1.0;
  };
  float atten_11;
  atten_11 = ((tmpvar_6.w * tmpvar_7.w) * tmpvar_10);
  vec4 c_12;
  vec3 SpecularAniso_13;
  vec3 tmpvar_14;
  tmpvar_14 = normalize(normal_2);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_5);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_17;
  tmpvar_17.x = _AnizoX;
  tmpvar_17.y = _AnizoY;
  vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17 + vec2(1e-05, 1e-05));
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((tmpvar_14.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_14.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_20;
  tmpvar_20 = clamp (dot (tmpvar_14, tmpvar_15), 0.0, 1.0);
  float tmpvar_21;
  tmpvar_21 = (dot (tmpvar_15, tmpvar_19) / tmpvar_18.x);
  float tmpvar_22;
  tmpvar_22 = (dot (tmpvar_15, normalize(((tmpvar_14.yzx * tmpvar_19.zxy) - (tmpvar_14.zxy * tmpvar_19.yzx)))) / tmpvar_18.y);
  float tmpvar_23;
  tmpvar_23 = (-2.0 * (((tmpvar_21 * tmpvar_21) + (tmpvar_22 * tmpvar_22)) / (1.0 + tmpvar_20)));
  float tmpvar_24;
  tmpvar_24 = (((12.5664 * tmpvar_18.x) * tmpvar_18.y) * sqrt((tmpvar_20 * clamp (dot (tmpvar_14, tmpvar_16), 0.0, 1.0))));
  if ((tmpvar_24 != 0.0)) {
    SpecularAniso_13 = (vec3((exp(tmpvar_23) / tmpvar_24)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_13 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_25;
  tmpvar_25 = (orenNayar * orenNayar);
  float x_26;
  x_26 = dot (tmpvar_16, tmpvar_14);
  float x_27;
  x_27 = dot (tmpvar_15, tmpvar_14);
  float x_28;
  x_28 = dot (tmpvar_16, tmpvar_14);
  float x_29;
  x_29 = dot (tmpvar_15, tmpvar_14);
  float tmpvar_30;
  tmpvar_30 = min ((1.5708 - (sign(x_28) * (1.5708 - (sqrt((1.0 - abs(x_28))) * (1.5708 + (abs(x_28) * (-0.214602 + (abs(x_28) * (0.0865667 + (abs(x_28) * -0.0310296)))))))))), (1.5708 - (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))))));
  c_12.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_20))) * vec3(((1.0 - (0.5 * (tmpvar_25 / (tmpvar_25 + 0.57)))) + (((0.45 * (tmpvar_25 / (tmpvar_25 + 0.09))) * max (0.0, dot ((tmpvar_16 - (tmpvar_14 * dot (tmpvar_16, tmpvar_14))), (tmpvar_15 - (tmpvar_14 * dot (tmpvar_15, tmpvar_14)))))) * (sin(max ((1.5708 - (sign(x_26) * (1.5708 - (sqrt((1.0 - abs(x_26))) * (1.5708 + (abs(x_26) * (-0.214602 + (abs(x_26) * (0.0865667 + (abs(x_26) * -0.0310296)))))))))), (1.5708 - (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))))))) * (sin(tmpvar_30) / cos(tmpvar_30))))))) + ((SpecularAniso_13 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_11 * 2.0));
  c_12.w = 1.0;
  c_1.xyz = c_12.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c19.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [_LightPositionRange]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 464 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002441050500
[Microcode]
576
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc401f9c6c00dd108c0186c0830021dfac
00019c6c00800243011842436041dffc00011c6c010002308121826301a1dffc
401f9c6c01d0e00d8086c0c360405fa8401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa800001c6c011d000c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d000c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTextureB0, vec2(tmpvar_11));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_14;
  tmpvar_14 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (packDist_15, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_18;
  if ((tmpvar_17 < tmpvar_14)) {
    tmpvar_18 = _LightShadowData.x;
  } else {
    tmpvar_18 = 1.0;
  };
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_2;
  mediump float atten_20;
  atten_20 = ((tmpvar_12.w * tmpvar_13.w) * tmpvar_18);
  mediump vec4 c_21;
  mediump vec3 SpecularFinal_22;
  mediump float B_23;
  mediump float A_24;
  highp float rough_sq_25;
  highp vec3 SpecularAniso_26;
  highp float beta_b_27;
  highp float beta_a_28;
  mediump float HdotB_29;
  mediump float HdotT_30;
  mediump vec3 n_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize(tmpvar_6);
  n_31 = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_19);
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_35;
  tmpvar_35.x = _AnizoX;
  tmpvar_35.y = _AnizoY;
  mediump vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((n_31.yzx * vec3(0.0, 1.0, 0.0)) - (n_31.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (n_31, tmpvar_33), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_33, tmpvar_37);
  HdotT_30 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (tmpvar_33, normalize(((n_31.yzx * tmpvar_37.zxy) - (n_31.zxy * tmpvar_37.yzx))));
  HdotB_29 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = (HdotT_30 / tmpvar_36.x);
  beta_a_28 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (beta_a_28 * beta_a_28);
  beta_a_28 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (HdotB_29 / tmpvar_36.y);
  beta_b_27 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (beta_b_27 * beta_b_27);
  beta_b_27 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (-2.0 * ((tmpvar_42 + tmpvar_44) / (1.0 + tmpvar_38)));
  mediump float tmpvar_46;
  tmpvar_46 = sqrt((tmpvar_38 * clamp (dot (n_31, tmpvar_34), 0.0, 1.0)));
  highp float tmpvar_47;
  tmpvar_47 = (((12.5664 * tmpvar_36.x) * tmpvar_36.y) * tmpvar_46);
  if ((tmpvar_47 != 0.0)) {
    SpecularAniso_26 = (vec3((exp(tmpvar_45) / tmpvar_47)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_26 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_48;
  tmpvar_48 = (orenNayar * orenNayar);
  rough_sq_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - (0.5 * (rough_sq_25 / (rough_sq_25 + 0.57))));
  A_24 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (0.45 * (rough_sq_25 / (rough_sq_25 + 0.09)));
  B_23 = tmpvar_50;
  mediump float x_51;
  x_51 = dot (tmpvar_34, n_31);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_31);
  mediump float x_53;
  x_53 = dot (tmpvar_34, n_31);
  mediump float x_54;
  x_54 = dot (tmpvar_33, n_31);
  mediump float tmpvar_55;
  tmpvar_55 = min ((1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))), (1.5708 - (sign(x_54) * (1.5708 - (sqrt((1.0 - abs(x_54))) * (1.5708 + (abs(x_54) * (-0.214602 + (abs(x_54) * (0.0865667 + (abs(x_54) * -0.0310296)))))))))));
  SpecularFinal_22 = SpecularAniso_26;
  c_21.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_38))) * vec3((A_24 + ((B_23 * max (0.0, dot ((tmpvar_34 - (n_31 * dot (tmpvar_34, n_31))), (tmpvar_33 - (n_31 * dot (tmpvar_33, n_31)))))) * (sin(max ((1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))), (1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))))) * (sin(tmpvar_55) / cos(tmpvar_55))))))) + ((SpecularFinal_22 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_20 * 2.0));
  c_21.w = 1.0;
  c_1.xyz = c_21.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTextureB0, vec2(tmpvar_11));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_14;
  tmpvar_14 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (packDist_15, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_18;
  if ((tmpvar_17 < tmpvar_14)) {
    tmpvar_18 = _LightShadowData.x;
  } else {
    tmpvar_18 = 1.0;
  };
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_2;
  mediump float atten_20;
  atten_20 = ((tmpvar_12.w * tmpvar_13.w) * tmpvar_18);
  mediump vec4 c_21;
  mediump vec3 SpecularFinal_22;
  mediump float B_23;
  mediump float A_24;
  highp float rough_sq_25;
  highp vec3 SpecularAniso_26;
  highp float beta_b_27;
  highp float beta_a_28;
  mediump float HdotB_29;
  mediump float HdotT_30;
  mediump vec3 n_31;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize(normal_6);
  n_31 = tmpvar_32;
  mediump vec3 tmpvar_33;
  tmpvar_33 = normalize(lightDir_19);
  mediump vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_35;
  tmpvar_35.x = _AnizoX;
  tmpvar_35.y = _AnizoY;
  mediump vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((n_31.yzx * vec3(0.0, 1.0, 0.0)) - (n_31.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_38;
  tmpvar_38 = clamp (dot (n_31, tmpvar_33), 0.0, 1.0);
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_33, tmpvar_37);
  HdotT_30 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = dot (tmpvar_33, normalize(((n_31.yzx * tmpvar_37.zxy) - (n_31.zxy * tmpvar_37.yzx))));
  HdotB_29 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = (HdotT_30 / tmpvar_36.x);
  beta_a_28 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = (beta_a_28 * beta_a_28);
  beta_a_28 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = (HdotB_29 / tmpvar_36.y);
  beta_b_27 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = (beta_b_27 * beta_b_27);
  beta_b_27 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (-2.0 * ((tmpvar_42 + tmpvar_44) / (1.0 + tmpvar_38)));
  mediump float tmpvar_46;
  tmpvar_46 = sqrt((tmpvar_38 * clamp (dot (n_31, tmpvar_34), 0.0, 1.0)));
  highp float tmpvar_47;
  tmpvar_47 = (((12.5664 * tmpvar_36.x) * tmpvar_36.y) * tmpvar_46);
  if ((tmpvar_47 != 0.0)) {
    SpecularAniso_26 = (vec3((exp(tmpvar_45) / tmpvar_47)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_26 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_48;
  tmpvar_48 = (orenNayar * orenNayar);
  rough_sq_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (1.0 - (0.5 * (rough_sq_25 / (rough_sq_25 + 0.57))));
  A_24 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (0.45 * (rough_sq_25 / (rough_sq_25 + 0.09)));
  B_23 = tmpvar_50;
  mediump float x_51;
  x_51 = dot (tmpvar_34, n_31);
  mediump float x_52;
  x_52 = dot (tmpvar_33, n_31);
  mediump float x_53;
  x_53 = dot (tmpvar_34, n_31);
  mediump float x_54;
  x_54 = dot (tmpvar_33, n_31);
  mediump float tmpvar_55;
  tmpvar_55 = min ((1.5708 - (sign(x_53) * (1.5708 - (sqrt((1.0 - abs(x_53))) * (1.5708 + (abs(x_53) * (-0.214602 + (abs(x_53) * (0.0865667 + (abs(x_53) * -0.0310296)))))))))), (1.5708 - (sign(x_54) * (1.5708 - (sqrt((1.0 - abs(x_54))) * (1.5708 + (abs(x_54) * (-0.214602 + (abs(x_54) * (0.0865667 + (abs(x_54) * -0.0310296)))))))))));
  SpecularFinal_22 = SpecularAniso_26;
  c_21.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_38))) * vec3((A_24 + ((B_23 * max (0.0, dot ((tmpvar_34 - (n_31 * dot (tmpvar_34, n_31))), (tmpvar_33 - (n_31 * dot (tmpvar_33, n_31)))))) * (sin(max ((1.5708 - (sign(x_51) * (1.5708 - (sqrt((1.0 - abs(x_51))) * (1.5708 + (abs(x_51) * (-0.214602 + (abs(x_51) * (0.0865667 + (abs(x_51) * -0.0310296)))))))))), (1.5708 - (sign(x_52) * (1.5708 - (sqrt((1.0 - abs(x_52))) * (1.5708 + (abs(x_52) * (-0.214602 + (abs(x_52) * (0.0865667 + (abs(x_52) * -0.0310296)))))))))))) * (sin(tmpvar_55) / cos(tmpvar_55))))))) + ((SpecularFinal_22 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_20 * 2.0));
  c_21.w = 1.0;
  c_1.xyz = c_21.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 shadowVals_8;
  vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  shadowVals_8.x = texture2D (_ShadowMapTexture, (tmpvar_9.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_8.y = texture2D (_ShadowMapTexture, (tmpvar_9.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_8.z = texture2D (_ShadowMapTexture, (tmpvar_9.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_8.w = texture2D (_ShadowMapTexture, (tmpvar_9.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (shadowVals_8, tmpvar_9.zzzz);
  vec4 tmpvar_11;
  tmpvar_11 = _LightShadowData.xxxx;
  float tmpvar_12;
  if (tmpvar_10.x) {
    tmpvar_12 = tmpvar_11.x;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_10.y) {
    tmpvar_13 = tmpvar_11.y;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_10.z) {
    tmpvar_14 = tmpvar_11.z;
  } else {
    tmpvar_14 = 1.0;
  };
  float tmpvar_15;
  if (tmpvar_10.w) {
    tmpvar_15 = tmpvar_11.w;
  } else {
    tmpvar_15 = 1.0;
  };
  vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_13;
  tmpvar_16.z = tmpvar_14;
  tmpvar_16.w = tmpvar_15;
  float atten_17;
  atten_17 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_6.w) * tmpvar_7.w) * dot (tmpvar_16, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_18;
  vec3 SpecularAniso_19;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(normal_2);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_5);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_23;
  tmpvar_23.x = _AnizoX;
  tmpvar_23.y = _AnizoY;
  vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + vec2(1e-05, 1e-05));
  vec3 tmpvar_25;
  tmpvar_25 = normalize(((tmpvar_20.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_20.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_20, tmpvar_21), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = (dot (tmpvar_21, tmpvar_25) / tmpvar_24.x);
  float tmpvar_28;
  tmpvar_28 = (dot (tmpvar_21, normalize(((tmpvar_20.yzx * tmpvar_25.zxy) - (tmpvar_20.zxy * tmpvar_25.yzx)))) / tmpvar_24.y);
  float tmpvar_29;
  tmpvar_29 = (-2.0 * (((tmpvar_27 * tmpvar_27) + (tmpvar_28 * tmpvar_28)) / (1.0 + tmpvar_26)));
  float tmpvar_30;
  tmpvar_30 = (((12.5664 * tmpvar_24.x) * tmpvar_24.y) * sqrt((tmpvar_26 * clamp (dot (tmpvar_20, tmpvar_22), 0.0, 1.0))));
  if ((tmpvar_30 != 0.0)) {
    SpecularAniso_19 = (vec3((exp(tmpvar_29) / tmpvar_30)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_19 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_31;
  tmpvar_31 = (orenNayar * orenNayar);
  float x_32;
  x_32 = dot (tmpvar_22, tmpvar_20);
  float x_33;
  x_33 = dot (tmpvar_21, tmpvar_20);
  float x_34;
  x_34 = dot (tmpvar_22, tmpvar_20);
  float x_35;
  x_35 = dot (tmpvar_21, tmpvar_20);
  float tmpvar_36;
  tmpvar_36 = min ((1.5708 - (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))))), (1.5708 - (sign(x_35) * (1.5708 - (sqrt((1.0 - abs(x_35))) * (1.5708 + (abs(x_35) * (-0.214602 + (abs(x_35) * (0.0865667 + (abs(x_35) * -0.0310296)))))))))));
  c_18.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_26))) * vec3(((1.0 - (0.5 * (tmpvar_31 / (tmpvar_31 + 0.57)))) + (((0.45 * (tmpvar_31 / (tmpvar_31 + 0.09))) * max (0.0, dot ((tmpvar_22 - (tmpvar_20 * dot (tmpvar_22, tmpvar_20))), (tmpvar_21 - (tmpvar_20 * dot (tmpvar_21, tmpvar_20)))))) * (sin(max ((1.5708 - (sign(x_32) * (1.5708 - (sqrt((1.0 - abs(x_32))) * (1.5708 + (abs(x_32) * (-0.214602 + (abs(x_32) * (0.0865667 + (abs(x_32) * -0.0310296)))))))))), (1.5708 - (sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296)))))))))))) * (sin(tmpvar_36) / cos(tmpvar_36))))))) + ((SpecularAniso_19 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_17 * 2.0));
  c_18.w = 1.0;
  c_1.xyz = c_18.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 22 [unity_Scale]
Matrix 16 [_LightMatrix0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 45 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c25.x
mov r0.xyz, c20
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r0.xyz, r2, c22.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mul o3.xyz, r2.w, r2
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [unity_World2Shadow0]
Matrix 264 [_Object2World]
Matrix 268 [_World2Object]
Vector 465 [unity_Scale]
Matrix 272 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 40 instructions using 5 registers
[Configuration]
8
0000002841050500
[Microcode]
640
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0b00d8106c0c360403ffc
00001c6c01d0a00d8106c0c360405ffc00001c6c01d0900d8106c0c360409ffc
00001c6c01d0800d8106c0c360411ffc00021c6c01d0e00d8286c0c360405ffc
00021c6c01d0d00d8286c0c360409ffc00021c6c01d0c00d8286c0c360411ffc
00009c6c0190e00c0686c0c360405ffc00009c6c0190d00c0686c0c360409ffc
00009c6c0190c00c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d1300d8086c0c360403fa8
401f9c6c01d1200d8086c0c360405fa8401f9c6c01d1100d8086c0c360409fa8
401f9c6c01d1000d8086c0c360411fa8401f9c6c01d0700d8086c0c360403fac
401f9c6c01d0600d8086c0c360405fac401f9c6c01d0500d8086c0c360409fac
401f9c6c01d0400d8086c0c360411fac00001c6c011d100c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d100c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  lowp float tmpvar_15;
  mediump vec4 shadows_16;
  highp vec4 shadowVals_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_19;
  P_19 = (tmpvar_18.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, P_19).x;
  shadowVals_17.x = tmpvar_20;
  highp vec2 P_21;
  P_21 = (tmpvar_18.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, P_21).x;
  shadowVals_17.y = tmpvar_22;
  highp vec2 P_23;
  P_23 = (tmpvar_18.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, P_23).x;
  shadowVals_17.z = tmpvar_24;
  highp vec2 P_25;
  P_25 = (tmpvar_18.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, P_25).x;
  shadowVals_17.w = tmpvar_26;
  bvec4 tmpvar_27;
  tmpvar_27 = lessThan (shadowVals_17, tmpvar_18.zzzz);
  highp vec4 tmpvar_28;
  tmpvar_28 = _LightShadowData.xxxx;
  highp float tmpvar_29;
  if (tmpvar_27.x) {
    tmpvar_29 = tmpvar_28.x;
  } else {
    tmpvar_29 = 1.0;
  };
  highp float tmpvar_30;
  if (tmpvar_27.y) {
    tmpvar_30 = tmpvar_28.y;
  } else {
    tmpvar_30 = 1.0;
  };
  highp float tmpvar_31;
  if (tmpvar_27.z) {
    tmpvar_31 = tmpvar_28.z;
  } else {
    tmpvar_31 = 1.0;
  };
  highp float tmpvar_32;
  if (tmpvar_27.w) {
    tmpvar_32 = tmpvar_28.w;
  } else {
    tmpvar_32 = 1.0;
  };
  highp vec4 tmpvar_33;
  tmpvar_33.x = tmpvar_29;
  tmpvar_33.y = tmpvar_30;
  tmpvar_33.z = tmpvar_31;
  tmpvar_33.w = tmpvar_32;
  shadows_16 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = dot (shadows_16, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_15 = tmpvar_34;
  mediump vec3 lightDir_35;
  lightDir_35 = lightDir_2;
  mediump float atten_36;
  atten_36 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_11.w) * tmpvar_14.w) * tmpvar_15);
  mediump vec4 c_37;
  mediump vec3 SpecularFinal_38;
  mediump float B_39;
  mediump float A_40;
  highp float rough_sq_41;
  highp vec3 SpecularAniso_42;
  highp float beta_b_43;
  highp float beta_a_44;
  mediump float HdotB_45;
  mediump float HdotT_46;
  mediump vec3 n_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = normalize(tmpvar_6);
  n_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = normalize(lightDir_35);
  mediump vec3 tmpvar_50;
  tmpvar_50 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_51;
  tmpvar_51.x = _AnizoX;
  tmpvar_51.y = _AnizoY;
  mediump vec2 tmpvar_52;
  tmpvar_52 = (tmpvar_51 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(((n_47.yzx * vec3(0.0, 1.0, 0.0)) - (n_47.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_54;
  tmpvar_54 = clamp (dot (n_47, tmpvar_49), 0.0, 1.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (tmpvar_49, tmpvar_53);
  HdotT_46 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (tmpvar_49, normalize(((n_47.yzx * tmpvar_53.zxy) - (n_47.zxy * tmpvar_53.yzx))));
  HdotB_45 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotT_46 / tmpvar_52.x);
  beta_a_44 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_a_44 * beta_a_44);
  beta_a_44 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotB_45 / tmpvar_52.y);
  beta_b_43 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_b_43 * beta_b_43);
  beta_b_43 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (-2.0 * ((tmpvar_58 + tmpvar_60) / (1.0 + tmpvar_54)));
  mediump float tmpvar_62;
  tmpvar_62 = sqrt((tmpvar_54 * clamp (dot (n_47, tmpvar_50), 0.0, 1.0)));
  highp float tmpvar_63;
  tmpvar_63 = (((12.5664 * tmpvar_52.x) * tmpvar_52.y) * tmpvar_62);
  if ((tmpvar_63 != 0.0)) {
    SpecularAniso_42 = (vec3((exp(tmpvar_61) / tmpvar_63)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_42 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_64;
  tmpvar_64 = (orenNayar * orenNayar);
  rough_sq_41 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (1.0 - (0.5 * (rough_sq_41 / (rough_sq_41 + 0.57))));
  A_40 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (0.45 * (rough_sq_41 / (rough_sq_41 + 0.09)));
  B_39 = tmpvar_66;
  mediump float x_67;
  x_67 = dot (tmpvar_50, n_47);
  mediump float x_68;
  x_68 = dot (tmpvar_49, n_47);
  mediump float x_69;
  x_69 = dot (tmpvar_50, n_47);
  mediump float x_70;
  x_70 = dot (tmpvar_49, n_47);
  mediump float tmpvar_71;
  tmpvar_71 = min ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))));
  SpecularFinal_38 = SpecularAniso_42;
  c_37.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_54))) * vec3((A_40 + ((B_39 * max (0.0, dot ((tmpvar_50 - (n_47 * dot (tmpvar_50, n_47))), (tmpvar_49 - (n_47 * dot (tmpvar_49, n_47)))))) * (sin(max ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))))) * (sin(tmpvar_71) / cos(tmpvar_71))))))) + ((SpecularFinal_38 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_36 * 2.0));
  c_37.w = 1.0;
  c_1.xyz = c_37.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  lowp float tmpvar_15;
  mediump vec4 shadows_16;
  highp vec4 shadowVals_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_19;
  P_19 = (tmpvar_18.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, P_19).x;
  shadowVals_17.x = tmpvar_20;
  highp vec2 P_21;
  P_21 = (tmpvar_18.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, P_21).x;
  shadowVals_17.y = tmpvar_22;
  highp vec2 P_23;
  P_23 = (tmpvar_18.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, P_23).x;
  shadowVals_17.z = tmpvar_24;
  highp vec2 P_25;
  P_25 = (tmpvar_18.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, P_25).x;
  shadowVals_17.w = tmpvar_26;
  bvec4 tmpvar_27;
  tmpvar_27 = lessThan (shadowVals_17, tmpvar_18.zzzz);
  highp vec4 tmpvar_28;
  tmpvar_28 = _LightShadowData.xxxx;
  highp float tmpvar_29;
  if (tmpvar_27.x) {
    tmpvar_29 = tmpvar_28.x;
  } else {
    tmpvar_29 = 1.0;
  };
  highp float tmpvar_30;
  if (tmpvar_27.y) {
    tmpvar_30 = tmpvar_28.y;
  } else {
    tmpvar_30 = 1.0;
  };
  highp float tmpvar_31;
  if (tmpvar_27.z) {
    tmpvar_31 = tmpvar_28.z;
  } else {
    tmpvar_31 = 1.0;
  };
  highp float tmpvar_32;
  if (tmpvar_27.w) {
    tmpvar_32 = tmpvar_28.w;
  } else {
    tmpvar_32 = 1.0;
  };
  highp vec4 tmpvar_33;
  tmpvar_33.x = tmpvar_29;
  tmpvar_33.y = tmpvar_30;
  tmpvar_33.z = tmpvar_31;
  tmpvar_33.w = tmpvar_32;
  shadows_16 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = dot (shadows_16, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_15 = tmpvar_34;
  mediump vec3 lightDir_35;
  lightDir_35 = lightDir_2;
  mediump float atten_36;
  atten_36 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_11.w) * tmpvar_14.w) * tmpvar_15);
  mediump vec4 c_37;
  mediump vec3 SpecularFinal_38;
  mediump float B_39;
  mediump float A_40;
  highp float rough_sq_41;
  highp vec3 SpecularAniso_42;
  highp float beta_b_43;
  highp float beta_a_44;
  mediump float HdotB_45;
  mediump float HdotT_46;
  mediump vec3 n_47;
  lowp vec3 tmpvar_48;
  tmpvar_48 = normalize(normal_6);
  n_47 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = normalize(lightDir_35);
  mediump vec3 tmpvar_50;
  tmpvar_50 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_51;
  tmpvar_51.x = _AnizoX;
  tmpvar_51.y = _AnizoY;
  mediump vec2 tmpvar_52;
  tmpvar_52 = (tmpvar_51 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(((n_47.yzx * vec3(0.0, 1.0, 0.0)) - (n_47.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_54;
  tmpvar_54 = clamp (dot (n_47, tmpvar_49), 0.0, 1.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (tmpvar_49, tmpvar_53);
  HdotT_46 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (tmpvar_49, normalize(((n_47.yzx * tmpvar_53.zxy) - (n_47.zxy * tmpvar_53.yzx))));
  HdotB_45 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = (HdotT_46 / tmpvar_52.x);
  beta_a_44 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (beta_a_44 * beta_a_44);
  beta_a_44 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotB_45 / tmpvar_52.y);
  beta_b_43 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_b_43 * beta_b_43);
  beta_b_43 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (-2.0 * ((tmpvar_58 + tmpvar_60) / (1.0 + tmpvar_54)));
  mediump float tmpvar_62;
  tmpvar_62 = sqrt((tmpvar_54 * clamp (dot (n_47, tmpvar_50), 0.0, 1.0)));
  highp float tmpvar_63;
  tmpvar_63 = (((12.5664 * tmpvar_52.x) * tmpvar_52.y) * tmpvar_62);
  if ((tmpvar_63 != 0.0)) {
    SpecularAniso_42 = (vec3((exp(tmpvar_61) / tmpvar_63)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_42 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_64;
  tmpvar_64 = (orenNayar * orenNayar);
  rough_sq_41 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (1.0 - (0.5 * (rough_sq_41 / (rough_sq_41 + 0.57))));
  A_40 = tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = (0.45 * (rough_sq_41 / (rough_sq_41 + 0.09)));
  B_39 = tmpvar_66;
  mediump float x_67;
  x_67 = dot (tmpvar_50, n_47);
  mediump float x_68;
  x_68 = dot (tmpvar_49, n_47);
  mediump float x_69;
  x_69 = dot (tmpvar_50, n_47);
  mediump float x_70;
  x_70 = dot (tmpvar_49, n_47);
  mediump float tmpvar_71;
  tmpvar_71 = min ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))));
  SpecularFinal_38 = SpecularAniso_42;
  c_37.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_54))) * vec3((A_40 + ((B_39 * max (0.0, dot ((tmpvar_50 - (n_47 * dot (tmpvar_50, n_47))), (tmpvar_49 - (n_47 * dot (tmpvar_49, n_47)))))) * (sin(max ((1.5708 - (sign(x_67) * (1.5708 - (sqrt((1.0 - abs(x_67))) * (1.5708 + (abs(x_67) * (-0.214602 + (abs(x_67) * (0.0865667 + (abs(x_67) * -0.0310296)))))))))), (1.5708 - (sign(x_68) * (1.5708 - (sqrt((1.0 - abs(x_68))) * (1.5708 + (abs(x_68) * (-0.214602 + (abs(x_68) * (0.0865667 + (abs(x_68) * -0.0310296)))))))))))) * (sin(tmpvar_71) / cos(tmpvar_71))))))) + ((SpecularFinal_38 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_36 * 2.0));
  c_37.w = 1.0;
  c_1.xyz = c_37.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 22 [unity_Scale]
Matrix 16 [_LightMatrix0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 45 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c25.x
mov r0.xyz, c20
dp4 r2.z, r0, c14
dp4 r2.x, r0, c12
dp4 r2.y, r0, c13
mad r0.xyz, r2, c22.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c14
dp4 r4.z, c21, r0
mov r0, c13
dp4 r4.y, c21, r0
mov r1, c12
dp4 r4.x, c21, r1
mad r0.xyz, r4, c22.w, -v0
dp4 r0.w, v0, c11
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mul o3.xyz, r2.w, r2
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Matrix 260 [unity_World2Shadow0]
Matrix 264 [_Object2World]
Matrix 268 [_World2Object]
Vector 465 [unity_Scale]
Matrix 272 [_LightMatrix0]
Vector 464 [_MainTex_ST]
Vector 463 [_BumpMap_ST]
"sce_vp_rsx // 40 instructions using 5 registers
[Configuration]
8
0000002841050500
[Microcode]
640
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011cf800810040d560607f9c
401f9c6c011d0808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0b00d8106c0c360403ffc
00001c6c01d0a00d8106c0c360405ffc00001c6c01d0900d8106c0c360409ffc
00001c6c01d0800d8106c0c360411ffc00021c6c01d0e00d8286c0c360405ffc
00021c6c01d0d00d8286c0c360409ffc00021c6c01d0c00d8286c0c360411ffc
00009c6c0190e00c0686c0c360405ffc00009c6c0190d00c0686c0c360409ffc
00009c6c0190c00c0686c0c360411ffc00019c6c00800243011842436041dffc
00011c6c010002308121826301a1dffc401f9c6c01d1300d8086c0c360403fa8
401f9c6c01d1200d8086c0c360405fa8401f9c6c01d1100d8086c0c360409fa8
401f9c6c01d1000d8086c0c360411fa8401f9c6c01d0700d8086c0c360403fac
401f9c6c01d0600d8086c0c360405fac401f9c6c01d0500d8086c0c360409fac
401f9c6c01d0400d8086c0c360411fac00001c6c011d100c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d100c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  lowp float tmpvar_14;
  mediump vec4 shadows_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec3 coord_17;
  coord_17 = (tmpvar_16 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, coord_17);
  shadows_15.x = tmpvar_18;
  highp vec3 coord_19;
  coord_19 = (tmpvar_16 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_20;
  tmpvar_20 = shadow2DEXT (_ShadowMapTexture, coord_19);
  shadows_15.y = tmpvar_20;
  highp vec3 coord_21;
  coord_21 = (tmpvar_16 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_22;
  tmpvar_22 = shadow2DEXT (_ShadowMapTexture, coord_21);
  shadows_15.z = tmpvar_22;
  highp vec3 coord_23;
  coord_23 = (tmpvar_16 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_24;
  tmpvar_24 = shadow2DEXT (_ShadowMapTexture, coord_23);
  shadows_15.w = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (_LightShadowData.xxxx + (shadows_15 * (1.0 - _LightShadowData.xxxx)));
  shadows_15 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_14 = tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = lightDir_2;
  mediump float atten_28;
  atten_28 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_10.w) * tmpvar_13.w) * tmpvar_14);
  mediump vec4 c_29;
  mediump vec3 SpecularFinal_30;
  mediump float B_31;
  mediump float A_32;
  highp float rough_sq_33;
  highp vec3 SpecularAniso_34;
  highp float beta_b_35;
  highp float beta_a_36;
  mediump float HdotB_37;
  mediump float HdotT_38;
  mediump vec3 n_39;
  lowp vec3 tmpvar_40;
  tmpvar_40 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0));
  n_39 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41 = normalize(lightDir_27);
  mediump vec3 tmpvar_42;
  tmpvar_42 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_43;
  tmpvar_43.x = _AnizoX;
  tmpvar_43.y = _AnizoY;
  mediump vec2 tmpvar_44;
  tmpvar_44 = (tmpvar_43 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(((n_39.yzx * vec3(0.0, 1.0, 0.0)) - (n_39.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (n_39, tmpvar_41), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_41, tmpvar_45);
  HdotT_38 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = dot (tmpvar_41, normalize(((n_39.yzx * tmpvar_45.zxy) - (n_39.zxy * tmpvar_45.yzx))));
  HdotB_37 = tmpvar_48;
  mediump float tmpvar_49;
  tmpvar_49 = (HdotT_38 / tmpvar_44.x);
  beta_a_36 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (beta_a_36 * beta_a_36);
  beta_a_36 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = (HdotB_37 / tmpvar_44.y);
  beta_b_35 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = (beta_b_35 * beta_b_35);
  beta_b_35 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = (-2.0 * ((tmpvar_50 + tmpvar_52) / (1.0 + tmpvar_46)));
  mediump float tmpvar_54;
  tmpvar_54 = sqrt((tmpvar_46 * clamp (dot (n_39, tmpvar_42), 0.0, 1.0)));
  highp float tmpvar_55;
  tmpvar_55 = (((12.5664 * tmpvar_44.x) * tmpvar_44.y) * tmpvar_54);
  if ((tmpvar_55 != 0.0)) {
    SpecularAniso_34 = (vec3((exp(tmpvar_53) / tmpvar_55)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_34 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_56;
  tmpvar_56 = (orenNayar * orenNayar);
  rough_sq_33 = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = (1.0 - (0.5 * (rough_sq_33 / (rough_sq_33 + 0.57))));
  A_32 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = (0.45 * (rough_sq_33 / (rough_sq_33 + 0.09)));
  B_31 = tmpvar_58;
  mediump float x_59;
  x_59 = dot (tmpvar_42, n_39);
  mediump float x_60;
  x_60 = dot (tmpvar_41, n_39);
  mediump float x_61;
  x_61 = dot (tmpvar_42, n_39);
  mediump float x_62;
  x_62 = dot (tmpvar_41, n_39);
  mediump float tmpvar_63;
  tmpvar_63 = min ((1.5708 - (sign(x_61) * (1.5708 - (sqrt((1.0 - abs(x_61))) * (1.5708 + (abs(x_61) * (-0.214602 + (abs(x_61) * (0.0865667 + (abs(x_61) * -0.0310296)))))))))), (1.5708 - (sign(x_62) * (1.5708 - (sqrt((1.0 - abs(x_62))) * (1.5708 + (abs(x_62) * (-0.214602 + (abs(x_62) * (0.0865667 + (abs(x_62) * -0.0310296)))))))))));
  SpecularFinal_30 = SpecularAniso_34;
  c_29.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_46))) * vec3((A_32 + ((B_31 * max (0.0, dot ((tmpvar_42 - (n_39 * dot (tmpvar_42, n_39))), (tmpvar_41 - (n_39 * dot (tmpvar_41, n_39)))))) * (sin(max ((1.5708 - (sign(x_59) * (1.5708 - (sqrt((1.0 - abs(x_59))) * (1.5708 + (abs(x_59) * (-0.214602 + (abs(x_59) * (0.0865667 + (abs(x_59) * -0.0310296)))))))))), (1.5708 - (sign(x_60) * (1.5708 - (sqrt((1.0 - abs(x_60))) * (1.5708 + (abs(x_60) * (-0.214602 + (abs(x_60) * (0.0865667 + (abs(x_60) * -0.0310296)))))))))))) * (sin(tmpvar_63) / cos(tmpvar_63))))))) + ((SpecularFinal_30 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_28 * 2.0));
  c_29.w = 1.0;
  c_1.xyz = c_29.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 shadowVals_7;
  shadowVals_7.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_7.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_7.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_7.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (shadowVals_7, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_9;
  tmpvar_9 = _LightShadowData.xxxx;
  float tmpvar_10;
  if (tmpvar_8.x) {
    tmpvar_10 = tmpvar_9.x;
  } else {
    tmpvar_10 = 1.0;
  };
  float tmpvar_11;
  if (tmpvar_8.y) {
    tmpvar_11 = tmpvar_9.y;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_8.z) {
    tmpvar_12 = tmpvar_9.z;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_8.w) {
    tmpvar_13 = tmpvar_9.w;
  } else {
    tmpvar_13 = 1.0;
  };
  vec4 tmpvar_14;
  tmpvar_14.x = tmpvar_10;
  tmpvar_14.y = tmpvar_11;
  tmpvar_14.z = tmpvar_12;
  tmpvar_14.w = tmpvar_13;
  float atten_15;
  atten_15 = (tmpvar_6.w * dot (tmpvar_14, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_16;
  vec3 SpecularAniso_17;
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normal_2);
  vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_5);
  vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_21;
  tmpvar_21.x = _AnizoX;
  tmpvar_21.y = _AnizoY;
  vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21 + vec2(1e-05, 1e-05));
  vec3 tmpvar_23;
  tmpvar_23 = normalize(((tmpvar_18.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_18.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_24;
  tmpvar_24 = clamp (dot (tmpvar_18, tmpvar_19), 0.0, 1.0);
  float tmpvar_25;
  tmpvar_25 = (dot (tmpvar_19, tmpvar_23) / tmpvar_22.x);
  float tmpvar_26;
  tmpvar_26 = (dot (tmpvar_19, normalize(((tmpvar_18.yzx * tmpvar_23.zxy) - (tmpvar_18.zxy * tmpvar_23.yzx)))) / tmpvar_22.y);
  float tmpvar_27;
  tmpvar_27 = (-2.0 * (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) / (1.0 + tmpvar_24)));
  float tmpvar_28;
  tmpvar_28 = (((12.5664 * tmpvar_22.x) * tmpvar_22.y) * sqrt((tmpvar_24 * clamp (dot (tmpvar_18, tmpvar_20), 0.0, 1.0))));
  if ((tmpvar_28 != 0.0)) {
    SpecularAniso_17 = (vec3((exp(tmpvar_27) / tmpvar_28)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_17 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_29;
  tmpvar_29 = (orenNayar * orenNayar);
  float x_30;
  x_30 = dot (tmpvar_20, tmpvar_18);
  float x_31;
  x_31 = dot (tmpvar_19, tmpvar_18);
  float x_32;
  x_32 = dot (tmpvar_20, tmpvar_18);
  float x_33;
  x_33 = dot (tmpvar_19, tmpvar_18);
  float tmpvar_34;
  tmpvar_34 = min ((1.5708 - (sign(x_32) * (1.5708 - (sqrt((1.0 - abs(x_32))) * (1.5708 + (abs(x_32) * (-0.214602 + (abs(x_32) * (0.0865667 + (abs(x_32) * -0.0310296)))))))))), (1.5708 - (sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296)))))))))));
  c_16.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_24))) * vec3(((1.0 - (0.5 * (tmpvar_29 / (tmpvar_29 + 0.57)))) + (((0.45 * (tmpvar_29 / (tmpvar_29 + 0.09))) * max (0.0, dot ((tmpvar_20 - (tmpvar_18 * dot (tmpvar_20, tmpvar_18))), (tmpvar_19 - (tmpvar_18 * dot (tmpvar_19, tmpvar_18)))))) * (sin(max ((1.5708 - (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))))), (1.5708 - (sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296)))))))))))) * (sin(tmpvar_34) / cos(tmpvar_34))))))) + ((SpecularAniso_17 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_15 * 2.0));
  c_16.w = 1.0;
  c_1.xyz = c_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c19.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [_LightPositionRange]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 464 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002441050500
[Microcode]
576
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc401f9c6c00dd108c0186c0830021dfac
00019c6c00800243011842436041dffc00011c6c010002308121826301a1dffc
401f9c6c01d0e00d8086c0c360405fa8401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa800001c6c011d000c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d000c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(tmpvar_11));
  highp float tmpvar_13;
  mediump vec4 shadows_14;
  highp vec4 shadowVals_15;
  highp float tmpvar_16;
  tmpvar_16 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_17;
  vec_17 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = textureCube (_ShadowMapTexture, vec_17);
  packDist_18 = tmpvar_19;
  shadowVals_15.x = dot (packDist_18, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_20;
  vec_20 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = textureCube (_ShadowMapTexture, vec_20);
  packDist_21 = tmpvar_22;
  shadowVals_15.y = dot (packDist_21, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_23;
  vec_23 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, vec_23);
  packDist_24 = tmpvar_25;
  shadowVals_15.z = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_26;
  vec_26 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = textureCube (_ShadowMapTexture, vec_26);
  packDist_27 = tmpvar_28;
  shadowVals_15.w = dot (packDist_27, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_29;
  tmpvar_29 = lessThan (shadowVals_15, vec4(tmpvar_16));
  highp vec4 tmpvar_30;
  tmpvar_30 = _LightShadowData.xxxx;
  highp float tmpvar_31;
  if (tmpvar_29.x) {
    tmpvar_31 = tmpvar_30.x;
  } else {
    tmpvar_31 = 1.0;
  };
  highp float tmpvar_32;
  if (tmpvar_29.y) {
    tmpvar_32 = tmpvar_30.y;
  } else {
    tmpvar_32 = 1.0;
  };
  highp float tmpvar_33;
  if (tmpvar_29.z) {
    tmpvar_33 = tmpvar_30.z;
  } else {
    tmpvar_33 = 1.0;
  };
  highp float tmpvar_34;
  if (tmpvar_29.w) {
    tmpvar_34 = tmpvar_30.w;
  } else {
    tmpvar_34 = 1.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35.x = tmpvar_31;
  tmpvar_35.y = tmpvar_32;
  tmpvar_35.z = tmpvar_33;
  tmpvar_35.w = tmpvar_34;
  shadows_14 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = dot (shadows_14, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_13 = tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = lightDir_2;
  mediump float atten_38;
  atten_38 = (tmpvar_12.w * tmpvar_13);
  mediump vec4 c_39;
  mediump vec3 SpecularFinal_40;
  mediump float B_41;
  mediump float A_42;
  highp float rough_sq_43;
  highp vec3 SpecularAniso_44;
  highp float beta_b_45;
  highp float beta_a_46;
  mediump float HdotB_47;
  mediump float HdotT_48;
  mediump vec3 n_49;
  lowp vec3 tmpvar_50;
  tmpvar_50 = normalize(tmpvar_6);
  n_49 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = normalize(lightDir_37);
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_53;
  tmpvar_53.x = _AnizoX;
  tmpvar_53.y = _AnizoY;
  mediump vec2 tmpvar_54;
  tmpvar_54 = (tmpvar_53 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(((n_49.yzx * vec3(0.0, 1.0, 0.0)) - (n_49.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (n_49, tmpvar_51), 0.0, 1.0);
  highp float tmpvar_57;
  tmpvar_57 = dot (tmpvar_51, tmpvar_55);
  HdotT_48 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_51, normalize(((n_49.yzx * tmpvar_55.zxy) - (n_49.zxy * tmpvar_55.yzx))));
  HdotB_47 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotT_48 / tmpvar_54.x);
  beta_a_46 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_a_46 * beta_a_46);
  beta_a_46 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = (HdotB_47 / tmpvar_54.y);
  beta_b_45 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = (beta_b_45 * beta_b_45);
  beta_b_45 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (-2.0 * ((tmpvar_60 + tmpvar_62) / (1.0 + tmpvar_56)));
  mediump float tmpvar_64;
  tmpvar_64 = sqrt((tmpvar_56 * clamp (dot (n_49, tmpvar_52), 0.0, 1.0)));
  highp float tmpvar_65;
  tmpvar_65 = (((12.5664 * tmpvar_54.x) * tmpvar_54.y) * tmpvar_64);
  if ((tmpvar_65 != 0.0)) {
    SpecularAniso_44 = (vec3((exp(tmpvar_63) / tmpvar_65)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_44 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_66;
  tmpvar_66 = (orenNayar * orenNayar);
  rough_sq_43 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (1.0 - (0.5 * (rough_sq_43 / (rough_sq_43 + 0.57))));
  A_42 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (0.45 * (rough_sq_43 / (rough_sq_43 + 0.09)));
  B_41 = tmpvar_68;
  mediump float x_69;
  x_69 = dot (tmpvar_52, n_49);
  mediump float x_70;
  x_70 = dot (tmpvar_51, n_49);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_49);
  mediump float x_72;
  x_72 = dot (tmpvar_51, n_49);
  mediump float tmpvar_73;
  tmpvar_73 = min ((1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))), (1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))));
  SpecularFinal_40 = SpecularAniso_44;
  c_39.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_56))) * vec3((A_42 + ((B_41 * max (0.0, dot ((tmpvar_52 - (n_49 * dot (tmpvar_52, n_49))), (tmpvar_51 - (n_49 * dot (tmpvar_51, n_49)))))) * (sin(max ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))))) * (sin(tmpvar_73) / cos(tmpvar_73))))))) + ((SpecularFinal_40 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_38 * 2.0));
  c_39.w = 1.0;
  c_1.xyz = c_39.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(tmpvar_11));
  highp float tmpvar_13;
  mediump vec4 shadows_14;
  highp vec4 shadowVals_15;
  highp float tmpvar_16;
  tmpvar_16 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_17;
  vec_17 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = textureCube (_ShadowMapTexture, vec_17);
  packDist_18 = tmpvar_19;
  shadowVals_15.x = dot (packDist_18, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_20;
  vec_20 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = textureCube (_ShadowMapTexture, vec_20);
  packDist_21 = tmpvar_22;
  shadowVals_15.y = dot (packDist_21, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_23;
  vec_23 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, vec_23);
  packDist_24 = tmpvar_25;
  shadowVals_15.z = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_26;
  vec_26 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = textureCube (_ShadowMapTexture, vec_26);
  packDist_27 = tmpvar_28;
  shadowVals_15.w = dot (packDist_27, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_29;
  tmpvar_29 = lessThan (shadowVals_15, vec4(tmpvar_16));
  highp vec4 tmpvar_30;
  tmpvar_30 = _LightShadowData.xxxx;
  highp float tmpvar_31;
  if (tmpvar_29.x) {
    tmpvar_31 = tmpvar_30.x;
  } else {
    tmpvar_31 = 1.0;
  };
  highp float tmpvar_32;
  if (tmpvar_29.y) {
    tmpvar_32 = tmpvar_30.y;
  } else {
    tmpvar_32 = 1.0;
  };
  highp float tmpvar_33;
  if (tmpvar_29.z) {
    tmpvar_33 = tmpvar_30.z;
  } else {
    tmpvar_33 = 1.0;
  };
  highp float tmpvar_34;
  if (tmpvar_29.w) {
    tmpvar_34 = tmpvar_30.w;
  } else {
    tmpvar_34 = 1.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35.x = tmpvar_31;
  tmpvar_35.y = tmpvar_32;
  tmpvar_35.z = tmpvar_33;
  tmpvar_35.w = tmpvar_34;
  shadows_14 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = dot (shadows_14, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_13 = tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = lightDir_2;
  mediump float atten_38;
  atten_38 = (tmpvar_12.w * tmpvar_13);
  mediump vec4 c_39;
  mediump vec3 SpecularFinal_40;
  mediump float B_41;
  mediump float A_42;
  highp float rough_sq_43;
  highp vec3 SpecularAniso_44;
  highp float beta_b_45;
  highp float beta_a_46;
  mediump float HdotB_47;
  mediump float HdotT_48;
  mediump vec3 n_49;
  lowp vec3 tmpvar_50;
  tmpvar_50 = normalize(normal_6);
  n_49 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = normalize(lightDir_37);
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_53;
  tmpvar_53.x = _AnizoX;
  tmpvar_53.y = _AnizoY;
  mediump vec2 tmpvar_54;
  tmpvar_54 = (tmpvar_53 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize(((n_49.yzx * vec3(0.0, 1.0, 0.0)) - (n_49.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_56;
  tmpvar_56 = clamp (dot (n_49, tmpvar_51), 0.0, 1.0);
  highp float tmpvar_57;
  tmpvar_57 = dot (tmpvar_51, tmpvar_55);
  HdotT_48 = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_51, normalize(((n_49.yzx * tmpvar_55.zxy) - (n_49.zxy * tmpvar_55.yzx))));
  HdotB_47 = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = (HdotT_48 / tmpvar_54.x);
  beta_a_46 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = (beta_a_46 * beta_a_46);
  beta_a_46 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = (HdotB_47 / tmpvar_54.y);
  beta_b_45 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = (beta_b_45 * beta_b_45);
  beta_b_45 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (-2.0 * ((tmpvar_60 + tmpvar_62) / (1.0 + tmpvar_56)));
  mediump float tmpvar_64;
  tmpvar_64 = sqrt((tmpvar_56 * clamp (dot (n_49, tmpvar_52), 0.0, 1.0)));
  highp float tmpvar_65;
  tmpvar_65 = (((12.5664 * tmpvar_54.x) * tmpvar_54.y) * tmpvar_64);
  if ((tmpvar_65 != 0.0)) {
    SpecularAniso_44 = (vec3((exp(tmpvar_63) / tmpvar_65)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_44 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_66;
  tmpvar_66 = (orenNayar * orenNayar);
  rough_sq_43 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (1.0 - (0.5 * (rough_sq_43 / (rough_sq_43 + 0.57))));
  A_42 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (0.45 * (rough_sq_43 / (rough_sq_43 + 0.09)));
  B_41 = tmpvar_68;
  mediump float x_69;
  x_69 = dot (tmpvar_52, n_49);
  mediump float x_70;
  x_70 = dot (tmpvar_51, n_49);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_49);
  mediump float x_72;
  x_72 = dot (tmpvar_51, n_49);
  mediump float tmpvar_73;
  tmpvar_73 = min ((1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))), (1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))));
  SpecularFinal_40 = SpecularAniso_44;
  c_39.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_56))) * vec3((A_42 + ((B_41 * max (0.0, dot ((tmpvar_52 - (n_49 * dot (tmpvar_52, n_49))), (tmpvar_51 - (n_49 * dot (tmpvar_51, n_49)))))) * (sin(max ((1.5708 - (sign(x_69) * (1.5708 - (sqrt((1.0 - abs(x_69))) * (1.5708 + (abs(x_69) * (-0.214602 + (abs(x_69) * (0.0865667 + (abs(x_69) * -0.0310296)))))))))), (1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))))) * (sin(tmpvar_73) / cos(tmpvar_73))))))) + ((SpecularFinal_40 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_38 * 2.0));
  c_39.w = 1.0;
  c_1.xyz = c_39.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = normalize((tmpvar_4 * (((_World2Object * tmpvar_5).xyz * unity_Scale.w) - gl_Vertex.xyz)));
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _AnizoY;
uniform float _AnizoX;
uniform float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 AnisoSpecular;
uniform vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _LightShadowData;
uniform vec4 _LightPositionRange;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_2.z = sqrt(((1.0 - (normal_2.x * normal_2.x)) - (normal_2.y * normal_2.y)));
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * _Color).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_7;
  tmpvar_7 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  vec4 shadowVals_8;
  shadowVals_8.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_8.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_8.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_8.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (shadowVals_8, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_10;
  tmpvar_10 = _LightShadowData.xxxx;
  float tmpvar_11;
  if (tmpvar_9.x) {
    tmpvar_11 = tmpvar_10.x;
  } else {
    tmpvar_11 = 1.0;
  };
  float tmpvar_12;
  if (tmpvar_9.y) {
    tmpvar_12 = tmpvar_10.y;
  } else {
    tmpvar_12 = 1.0;
  };
  float tmpvar_13;
  if (tmpvar_9.z) {
    tmpvar_13 = tmpvar_10.z;
  } else {
    tmpvar_13 = 1.0;
  };
  float tmpvar_14;
  if (tmpvar_9.w) {
    tmpvar_14 = tmpvar_10.w;
  } else {
    tmpvar_14 = 1.0;
  };
  vec4 tmpvar_15;
  tmpvar_15.x = tmpvar_11;
  tmpvar_15.y = tmpvar_12;
  tmpvar_15.z = tmpvar_13;
  tmpvar_15.w = tmpvar_14;
  float atten_16;
  atten_16 = ((tmpvar_6.w * tmpvar_7.w) * dot (tmpvar_15, vec4(0.25, 0.25, 0.25, 0.25)));
  vec4 c_17;
  vec3 SpecularAniso_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(normal_2);
  vec3 tmpvar_20;
  tmpvar_20 = normalize(tmpvar_5);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD2);
  vec2 tmpvar_22;
  tmpvar_22.x = _AnizoX;
  tmpvar_22.y = _AnizoY;
  vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_22 + vec2(1e-05, 1e-05));
  vec3 tmpvar_24;
  tmpvar_24 = normalize(((tmpvar_19.yzx * vec3(0.0, 1.0, 0.0)) - (tmpvar_19.zxy * vec3(0.0, 0.0, 1.0))));
  float tmpvar_25;
  tmpvar_25 = clamp (dot (tmpvar_19, tmpvar_20), 0.0, 1.0);
  float tmpvar_26;
  tmpvar_26 = (dot (tmpvar_20, tmpvar_24) / tmpvar_23.x);
  float tmpvar_27;
  tmpvar_27 = (dot (tmpvar_20, normalize(((tmpvar_19.yzx * tmpvar_24.zxy) - (tmpvar_19.zxy * tmpvar_24.yzx)))) / tmpvar_23.y);
  float tmpvar_28;
  tmpvar_28 = (-2.0 * (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) / (1.0 + tmpvar_25)));
  float tmpvar_29;
  tmpvar_29 = (((12.5664 * tmpvar_23.x) * tmpvar_23.y) * sqrt((tmpvar_25 * clamp (dot (tmpvar_19, tmpvar_21), 0.0, 1.0))));
  if ((tmpvar_29 != 0.0)) {
    SpecularAniso_18 = (vec3((exp(tmpvar_28) / tmpvar_29)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_18 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_30;
  tmpvar_30 = (orenNayar * orenNayar);
  float x_31;
  x_31 = dot (tmpvar_21, tmpvar_19);
  float x_32;
  x_32 = dot (tmpvar_20, tmpvar_19);
  float x_33;
  x_33 = dot (tmpvar_21, tmpvar_19);
  float x_34;
  x_34 = dot (tmpvar_20, tmpvar_19);
  float tmpvar_35;
  tmpvar_35 = min ((1.5708 - (sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296)))))))))), (1.5708 - (sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296)))))))))));
  c_17.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_25))) * vec3(((1.0 - (0.5 * (tmpvar_30 / (tmpvar_30 + 0.57)))) + (((0.45 * (tmpvar_30 / (tmpvar_30 + 0.09))) * max (0.0, dot ((tmpvar_21 - (tmpvar_19 * dot (tmpvar_21, tmpvar_19))), (tmpvar_20 - (tmpvar_19 * dot (tmpvar_20, tmpvar_19)))))) * (sin(max ((1.5708 - (sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296)))))))))), (1.5708 - (sign(x_32) * (1.5708 - (sqrt((1.0 - abs(x_32))) * (1.5708 + (abs(x_32) * (-0.214602 + (abs(x_32) * (0.0865667 + (abs(x_32) * -0.0310296)))))))))))) * (sin(tmpvar_35) / cos(tmpvar_35))))))) + ((SpecularAniso_18 * tmpvar_4.x) * _LightColor0.xyz)) * (atten_16 * 2.0));
  c_17.w = 1.0;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 19 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0.w, c22.x
mov r0.xyz, c16
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c19.w, -v0
mul r3.xyz, r1, v1.w
dp3 r2.y, r3, r0
dp3 r2.x, v1, r0
dp3 r2.z, v2, r0
dp3 r1.x, r2, r2
rsq r2.w, r1.x
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c19.w, -v0
dp3 o2.y, r0, r3
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
mul o3.xyz, r2.w, r2
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c18
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 256 [glstate_matrix_mvp]
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 467 [_WorldSpaceCameraPos]
Vector 466 [_WorldSpaceLightPos0]
Vector 465 [_LightPositionRange]
Matrix 260 [_Object2World]
Matrix 264 [_World2Object]
Vector 464 [unity_Scale]
Matrix 268 [_LightMatrix0]
Vector 463 [_MainTex_ST]
Vector 462 [_BumpMap_ST]
"sce_vp_rsx // 36 instructions using 5 registers
[Configuration]
8
0000002441050500
[Microcode]
576
00009c6c005d200d8186c0836041fffc00011c6c00400e0c0106c0836041dffc
00019c6c005d300c0186c0836041dffc401f9c6c011ce800810040d560607f9c
401f9c6c011cf808010400d740619f9c401f9c6c01d0300d8106c0c360403f80
401f9c6c01d0200d8106c0c360405f80401f9c6c01d0100d8106c0c360409f80
401f9c6c01d0000d8106c0c360411f8000001c6c01d0700d8106c0c360403ffc
00001c6c01d0600d8106c0c360405ffc00001c6c01d0500d8106c0c360409ffc
00001c6c01d0400d8106c0c360411ffc00021c6c01d0a00d8286c0c360405ffc
00021c6c01d0900d8286c0c360409ffc00021c6c01d0800d8286c0c360411ffc
00009c6c0190a00c0686c0c360405ffc00009c6c0190900c0686c0c360409ffc
00009c6c0190800c0686c0c360411ffc401f9c6c00dd108c0186c0830021dfac
00019c6c00800243011842436041dffc00011c6c010002308121826301a1dffc
401f9c6c01d0e00d8086c0c360405fa8401f9c6c01d0d00d8086c0c360409fa8
401f9c6c01d0c00d8086c0c360411fa800001c6c011d000c02bfc0e30041dffc
00009c6c00800e0c04bfc0836041dffc00011c6c0140020c0106004360405ffc
00011c6c01400e0c0106004360411ffc00011c6c0140000c0286004360409ffc
00001c6c011d000c08bfc0e30041dffc00001c6c0140000c0486024360403ffc
401f9c6c0140020c0106004360405fa0401f9c6c21400e0c0086009fe02300a0
401f9c6c0140000c0086014360409fa0401f9c6c0080007f828602436041dfa5
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTextureB0, vec2(tmpvar_11));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_14;
  mediump vec4 shadows_15;
  highp vec4 shadowVals_16;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureCube (_ShadowMapTexture, vec_18);
  packDist_19 = tmpvar_20;
  shadowVals_16.x = dot (packDist_19, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_21;
  vec_21 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = textureCube (_ShadowMapTexture, vec_21);
  packDist_22 = tmpvar_23;
  shadowVals_16.y = dot (packDist_22, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_24;
  vec_24 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = textureCube (_ShadowMapTexture, vec_24);
  packDist_25 = tmpvar_26;
  shadowVals_16.z = dot (packDist_25, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_27;
  vec_27 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = textureCube (_ShadowMapTexture, vec_27);
  packDist_28 = tmpvar_29;
  shadowVals_16.w = dot (packDist_28, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_30;
  tmpvar_30 = lessThan (shadowVals_16, vec4(tmpvar_17));
  highp vec4 tmpvar_31;
  tmpvar_31 = _LightShadowData.xxxx;
  highp float tmpvar_32;
  if (tmpvar_30.x) {
    tmpvar_32 = tmpvar_31.x;
  } else {
    tmpvar_32 = 1.0;
  };
  highp float tmpvar_33;
  if (tmpvar_30.y) {
    tmpvar_33 = tmpvar_31.y;
  } else {
    tmpvar_33 = 1.0;
  };
  highp float tmpvar_34;
  if (tmpvar_30.z) {
    tmpvar_34 = tmpvar_31.z;
  } else {
    tmpvar_34 = 1.0;
  };
  highp float tmpvar_35;
  if (tmpvar_30.w) {
    tmpvar_35 = tmpvar_31.w;
  } else {
    tmpvar_35 = 1.0;
  };
  highp vec4 tmpvar_36;
  tmpvar_36.x = tmpvar_32;
  tmpvar_36.y = tmpvar_33;
  tmpvar_36.z = tmpvar_34;
  tmpvar_36.w = tmpvar_35;
  shadows_15 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_14 = tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = lightDir_2;
  mediump float atten_39;
  atten_39 = ((tmpvar_12.w * tmpvar_13.w) * tmpvar_14);
  mediump vec4 c_40;
  mediump vec3 SpecularFinal_41;
  mediump float B_42;
  mediump float A_43;
  highp float rough_sq_44;
  highp vec3 SpecularAniso_45;
  highp float beta_b_46;
  highp float beta_a_47;
  mediump float HdotB_48;
  mediump float HdotT_49;
  mediump vec3 n_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = normalize(tmpvar_6);
  n_50 = tmpvar_51;
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(lightDir_38);
  mediump vec3 tmpvar_53;
  tmpvar_53 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_54;
  tmpvar_54.x = _AnizoX;
  tmpvar_54.y = _AnizoY;
  mediump vec2 tmpvar_55;
  tmpvar_55 = (tmpvar_54 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize(((n_50.yzx * vec3(0.0, 1.0, 0.0)) - (n_50.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (n_50, tmpvar_52), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_52, tmpvar_56);
  HdotT_49 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = dot (tmpvar_52, normalize(((n_50.yzx * tmpvar_56.zxy) - (n_50.zxy * tmpvar_56.yzx))));
  HdotB_48 = tmpvar_59;
  mediump float tmpvar_60;
  tmpvar_60 = (HdotT_49 / tmpvar_55.x);
  beta_a_47 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (beta_a_47 * beta_a_47);
  beta_a_47 = tmpvar_61;
  mediump float tmpvar_62;
  tmpvar_62 = (HdotB_48 / tmpvar_55.y);
  beta_b_46 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (beta_b_46 * beta_b_46);
  beta_b_46 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (-2.0 * ((tmpvar_61 + tmpvar_63) / (1.0 + tmpvar_57)));
  mediump float tmpvar_65;
  tmpvar_65 = sqrt((tmpvar_57 * clamp (dot (n_50, tmpvar_53), 0.0, 1.0)));
  highp float tmpvar_66;
  tmpvar_66 = (((12.5664 * tmpvar_55.x) * tmpvar_55.y) * tmpvar_65);
  if ((tmpvar_66 != 0.0)) {
    SpecularAniso_45 = (vec3((exp(tmpvar_64) / tmpvar_66)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_45 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_67;
  tmpvar_67 = (orenNayar * orenNayar);
  rough_sq_44 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (1.0 - (0.5 * (rough_sq_44 / (rough_sq_44 + 0.57))));
  A_43 = tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = (0.45 * (rough_sq_44 / (rough_sq_44 + 0.09)));
  B_42 = tmpvar_69;
  mediump float x_70;
  x_70 = dot (tmpvar_53, n_50);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_50);
  mediump float x_72;
  x_72 = dot (tmpvar_53, n_50);
  mediump float x_73;
  x_73 = dot (tmpvar_52, n_50);
  mediump float tmpvar_74;
  tmpvar_74 = min ((1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))), (1.5708 - (sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296)))))))))));
  SpecularFinal_41 = SpecularAniso_45;
  c_40.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_57))) * vec3((A_43 + ((B_42 * max (0.0, dot ((tmpvar_53 - (n_50 * dot (tmpvar_53, n_50))), (tmpvar_52 - (n_50 * dot (tmpvar_52, n_50)))))) * (sin(max ((1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))), (1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))))) * (sin(tmpvar_74) / cos(tmpvar_74))))))) + ((SpecularFinal_41 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_39 * 2.0));
  c_40.w = 1.0;
  c_1.xyz = c_40.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;

uniform highp vec4 _LightPositionRange;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  tmpvar_3.zw = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz)));
  tmpvar_5 = tmpvar_13;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_ARB_shader_texture_lod : enable
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD0;
uniform mediump float _AnizoY;
uniform mediump float _AnizoX;
uniform mediump float orenNayar;
uniform sampler2D _SpecularMap;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 AnisoSpecular;
uniform lowp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform samplerCube _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  mediump vec4 SpecularTex_4;
  mediump vec4 mainTex_5;
  lowp vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt(((1.0 - (normal_6.x * normal_6.x)) - (normal_6.y * normal_6.y)));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex_5 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (mainTex_5 * _Color).xyz;
  tmpvar_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_SpecularMap, xlv_TEXCOORD0.xy);
  SpecularTex_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_LightTextureB0, vec2(tmpvar_11));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_14;
  mediump vec4 shadows_15;
  highp vec4 shadowVals_16;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_18;
  vec_18 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureCube (_ShadowMapTexture, vec_18);
  packDist_19 = tmpvar_20;
  shadowVals_16.x = dot (packDist_19, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_21;
  vec_21 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = textureCube (_ShadowMapTexture, vec_21);
  packDist_22 = tmpvar_23;
  shadowVals_16.y = dot (packDist_22, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_24;
  vec_24 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = textureCube (_ShadowMapTexture, vec_24);
  packDist_25 = tmpvar_26;
  shadowVals_16.z = dot (packDist_25, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_27;
  vec_27 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = textureCube (_ShadowMapTexture, vec_27);
  packDist_28 = tmpvar_29;
  shadowVals_16.w = dot (packDist_28, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_30;
  tmpvar_30 = lessThan (shadowVals_16, vec4(tmpvar_17));
  highp vec4 tmpvar_31;
  tmpvar_31 = _LightShadowData.xxxx;
  highp float tmpvar_32;
  if (tmpvar_30.x) {
    tmpvar_32 = tmpvar_31.x;
  } else {
    tmpvar_32 = 1.0;
  };
  highp float tmpvar_33;
  if (tmpvar_30.y) {
    tmpvar_33 = tmpvar_31.y;
  } else {
    tmpvar_33 = 1.0;
  };
  highp float tmpvar_34;
  if (tmpvar_30.z) {
    tmpvar_34 = tmpvar_31.z;
  } else {
    tmpvar_34 = 1.0;
  };
  highp float tmpvar_35;
  if (tmpvar_30.w) {
    tmpvar_35 = tmpvar_31.w;
  } else {
    tmpvar_35 = 1.0;
  };
  highp vec4 tmpvar_36;
  tmpvar_36.x = tmpvar_32;
  tmpvar_36.y = tmpvar_33;
  tmpvar_36.z = tmpvar_34;
  tmpvar_36.w = tmpvar_35;
  shadows_15 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = dot (shadows_15, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_14 = tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = lightDir_2;
  mediump float atten_39;
  atten_39 = ((tmpvar_12.w * tmpvar_13.w) * tmpvar_14);
  mediump vec4 c_40;
  mediump vec3 SpecularFinal_41;
  mediump float B_42;
  mediump float A_43;
  highp float rough_sq_44;
  highp vec3 SpecularAniso_45;
  highp float beta_b_46;
  highp float beta_a_47;
  mediump float HdotB_48;
  mediump float HdotT_49;
  mediump vec3 n_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = normalize(normal_6);
  n_50 = tmpvar_51;
  mediump vec3 tmpvar_52;
  tmpvar_52 = normalize(lightDir_38);
  mediump vec3 tmpvar_53;
  tmpvar_53 = normalize(xlv_TEXCOORD2);
  mediump vec2 tmpvar_54;
  tmpvar_54.x = _AnizoX;
  tmpvar_54.y = _AnizoY;
  mediump vec2 tmpvar_55;
  tmpvar_55 = (tmpvar_54 + vec2(1e-05, 1e-05));
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize(((n_50.yzx * vec3(0.0, 1.0, 0.0)) - (n_50.zxy * vec3(0.0, 0.0, 1.0))));
  mediump float tmpvar_57;
  tmpvar_57 = clamp (dot (n_50, tmpvar_52), 0.0, 1.0);
  highp float tmpvar_58;
  tmpvar_58 = dot (tmpvar_52, tmpvar_56);
  HdotT_49 = tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = dot (tmpvar_52, normalize(((n_50.yzx * tmpvar_56.zxy) - (n_50.zxy * tmpvar_56.yzx))));
  HdotB_48 = tmpvar_59;
  mediump float tmpvar_60;
  tmpvar_60 = (HdotT_49 / tmpvar_55.x);
  beta_a_47 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = (beta_a_47 * beta_a_47);
  beta_a_47 = tmpvar_61;
  mediump float tmpvar_62;
  tmpvar_62 = (HdotB_48 / tmpvar_55.y);
  beta_b_46 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = (beta_b_46 * beta_b_46);
  beta_b_46 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = (-2.0 * ((tmpvar_61 + tmpvar_63) / (1.0 + tmpvar_57)));
  mediump float tmpvar_65;
  tmpvar_65 = sqrt((tmpvar_57 * clamp (dot (n_50, tmpvar_53), 0.0, 1.0)));
  highp float tmpvar_66;
  tmpvar_66 = (((12.5664 * tmpvar_55.x) * tmpvar_55.y) * tmpvar_65);
  if ((tmpvar_66 != 0.0)) {
    SpecularAniso_45 = (vec3((exp(tmpvar_64) / tmpvar_66)) * AnisoSpecular.xyz);
  } else {
    SpecularAniso_45 = vec3(0.0, 0.0, 0.0);
  };
  mediump float tmpvar_67;
  tmpvar_67 = (orenNayar * orenNayar);
  rough_sq_44 = tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = (1.0 - (0.5 * (rough_sq_44 / (rough_sq_44 + 0.57))));
  A_43 = tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = (0.45 * (rough_sq_44 / (rough_sq_44 + 0.09)));
  B_42 = tmpvar_69;
  mediump float x_70;
  x_70 = dot (tmpvar_53, n_50);
  mediump float x_71;
  x_71 = dot (tmpvar_52, n_50);
  mediump float x_72;
  x_72 = dot (tmpvar_53, n_50);
  mediump float x_73;
  x_73 = dot (tmpvar_52, n_50);
  mediump float tmpvar_74;
  tmpvar_74 = min ((1.5708 - (sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296)))))))))), (1.5708 - (sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296)))))))))));
  SpecularFinal_41 = SpecularAniso_45;
  c_40.xyz = (((((tmpvar_3 * _LightColor0.xyz) * vec3(max (0.0, tmpvar_57))) * vec3((A_43 + ((B_42 * max (0.0, dot ((tmpvar_53 - (n_50 * dot (tmpvar_53, n_50))), (tmpvar_52 - (n_50 * dot (tmpvar_52, n_50)))))) * (sin(max ((1.5708 - (sign(x_70) * (1.5708 - (sqrt((1.0 - abs(x_70))) * (1.5708 + (abs(x_70) * (-0.214602 + (abs(x_70) * (0.0865667 + (abs(x_70) * -0.0310296)))))))))), (1.5708 - (sign(x_71) * (1.5708 - (sqrt((1.0 - abs(x_71))) * (1.5708 + (abs(x_71) * (-0.214602 + (abs(x_71) * (0.0865667 + (abs(x_71) * -0.0310296)))))))))))) * (sin(tmpvar_74) / cos(tmpvar_74))))))) + ((SpecularFinal_41 * SpecularTex_4.x) * _LightColor0.xyz)) * (atten_39 * 2.0));
  c_40.w = 1.0;
  c_1.xyz = c_40.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 135 to 158, TEX: 3 to 9
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 140 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
mul r2.w, r0.y, c10.y
mul_pp r3.w, r1, r0.x
pow r0, c10.z, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6.w, c6.z
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mul_pp r0.yzw, r0.xxyz, c0.xxyz
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.x, r1, r3
mad_pp r1.xyz, -r1, r0.x, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
rsq_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c8
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0
cmp_pp r1.y, r2.w, c6.w, c6.z
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c6.x, r1
add_pp r2.z, -r2.x, c6
mad_pp r2.y, r2.x, c7.z, c7.w
mad_pp r2.y, r2, r2.x, c8.x
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c8.z, r1.z
mad_pp r2.x, r2.y, r2, c8.y
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0, c6.w, c6.z
mul_pp r0.x, r2, r2.y
mad_pp r1.z, -r0.x, c6.x, r2.y
mad_pp r2.x, r2, c8.z, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.x, c3, c3
add r1.z, r0.x, c7.y
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.x, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.x, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.x, r0, r1
mul r1.y, r1.z, c8.w
mad r0.x, -r0, c9.y, r1.y
add r2.x, r0, c6.z
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
max r0.x, r1.w, c6.w
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r0.x
dp3 r0.x, v3, v3
mad_pp r1.xyz, r1, r2.x, r0.yzww
texld r0.x, r0.x, s3
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
"sce_fp_rsx // 135 instructions using 4 registers
[Configuration]
24
ffffffff0003c020000ffff0000000000000840004000000
[Offsets]
6
_LightColor0 2 0
00000850000005a0
_Color 1 0
00000400
AnisoSpecular 1 0
00000690
orenNayar 1 0
00000040
_AnizoX 1 0
00000490
_AnizoY 1 0
000004b0
[Microcode]
2160
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108a024000021c9c00020000c8000001
00000000000000000000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e843940c9041c9dc8000029c800000108803b40c9003c9d55000001c8000001
0e803940c9001c9dc8000029c800000110800540c9001c9dc9080001c8000001
ce863940c8011c9dc8000029c800bfe110820540c9001c9dc90c0001c8000001
0e820440c9001c9fff040001c90c000102868540c9001c9dc90c0001c8000001
0e040200a5001c9fa0020000c80000010000000000003f800000000000000000
108e0340c9043c9faa020000c80000010000000000003f800000000000000000
0e06040093001c9d08020000c80800010000000000003f800000000000000000
0e880440c9001c9fff000001c908000104820540c9041c9dc9100001c8000001
02821b40ff1c1c9dc8000001c800000108820440ff043c9d00020000aa020000
6000bc9920003d98000000000000000002040500c80c1c9dc80c0001c8000001
0e043b00c80c1c9dc8080001c800000110060300c9141c9d00020000c8000001
51ec3db800000000000000000000000004063a00ff141c9dfe0c0001c8000001
028c0340ff003c9f00020000c800000100003f80000000000000000000000000
10060900ab041c9caa020000c800000100000000000000000000000000000000
10060200aa0c1c9cc80c0001c800000108820440ff043c9dc904000100020000
4000be59000000000000000000000000108c0440c9003c9d00020000aa020000
6000bc9920003d98000000000000000008820440ff043c9dc9040001c8020001
000000000000000000003fc90000000004820440ff003c9dff18000100020000
4000be5900000000000000000000000010841b40c9181c9dc8000001c8000001
04820440ff003c9dc90400010002000000003fc9000000000000000000000000
10800a40c9001c9daa020000c800000100000000000000000000000000000000
04823a40c9041c9dff080001c800000110840a40c9041c9d00020000c8000001
0000000000000000000000000000000010820240c9001c9dab041000c8000001
10863a4055041c9dc9040001c800000102820240ff081c9dff0c1001c8000001
10820340ab041c9cc9040003c800000110860340c90c1c9d01040002c8000001
10840440c9081c9d00020000c90c000100004049000000000000000000000000
8e061702c8011c9dc8000001c8003fe10e820240c80c1c9dc8020001c8000001
000000000000000000000000000000000e060200a5001c9d92080001c8000001
0e06040093001c9da4080001c80c00030e040100c8081c9dc8000001c8000001
02880500c9081c9dc8080001c8000001088a0500c9081c9dc80c0001c8000001
08808540c9001c9dc9080001c80000011086024055001c9d010c0000c8000001
0284014000021c9cc8000001c800000100000000000000000000000000000000
0484014000021c9cc8000001c800000100000000000000000000000000000000
08040300c9001c9daa020000c80000010000000000003f800000000000000000
08841b40ff0c1c9dc8000001c800000102060500c80c1c9dc80c0001c8000001
02803b0055141c9dc80c0001c80000011802030081081c9c00020000c8000001
c5ac372700000000000000000000000002803a40c9001c9dfe040001c8000001
0480014001001c9cc8000001c800000102803a40c9101c9d54040001c8000001
08020200c8041c9dfe040001c800000102003800c9001c9dc9000001c8000001
02023a00c8001c9d54080001c80000010e820240c9041c9dc8020001c8000001
0000000000000000000000000000000002043a0054041c9d55080001c8000001
0802020000041c9c00021000c8000001aa3a3fb8000000000000000000000000
1002020000081c9c00020000c80000010fd04149000000000000000000000000
0e840140aa021c9cc8000001c800000100000000000000000000000000000000
82001704c8011c9dc8000001c8003fe108021c0054041c9fc8000001c8000001
037e4180fe041c9dc8000001c800000108023a00c8041c9dfe040001c8000001
10860440c9001c9dc8020001c904000100000000000000000000000000004049
0e84020054040015c8020001c800000100000000000000000000000000000000
10880940c9081c9dc90c0001c80000010e840240c9081c9d00000000c8000001
088a2340ff101c9dc8000001c8000001ee040100c8011c9dc8000001c8003fe1
10800840c9081c9dc90c0001c800000110822340ff001c9dc8000001c8000001
02000500c8081c9dc8080001c800000108040300ff141c9d00020000c8000001
eb853f110000000000000000000000000200170600001c9cc8000001c8000001
10802240ff001c9dc8000001c800000110803a40c9041c9dff000001c8000001
08800100c9001c9dc8000001c80000010288024055141c9dff000001c8000001
1080090055001c9d00020000c800000100000000000000000000000000000000
02040200fe0c1c9dc9100001c800000110043a00c9141c9d54085001c8000001
02040400c8081c9d00020000fe08000366663ee6000000000000000000000000
0e820240c9041c9dff000001c80000011080030000081c9c00020000c8000001
00003f800000000000000000000000000e820240c9041c9dff000001c8000001
1080014000021c9cc8000001c800000100000000000000000000000000000000
0e820440c9081c9dc8020001c904000100000000000000000000000000000000
0e81024000001c9cc9041001c8000001
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
"ps_3_0
; 135 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r2
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.y
pow r0, c10.z, r2.w
dp3_pp r2.w, r1, r2
rsq_pp r0.z, r3.w
mov r0.y, c4.x
mad_pp r2.xyz, -r1, r2.w, r2
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
rcp r0.z, r0.y
abs r0.x, r0.y
mul r0.y, r0.w, r0.z
cmp r0.w, -r0.x, c6, c6.z
abs_pp r0.w, r0
mul r0.xyz, r0.y, c2
cmp r0.xyz, -r0.w, c6.w, r0
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r0.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
texld r4.x, v0, s2
mul_pp r0.xyz, r0, r4.x
rsq_pp r2.x, r2.x
cmp_pp r0.w, r0, c6, c6.z
rcp_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c8
mul_pp r1.y, r1, r2.x
abs_pp r2.x, r2.w
mul_pp r1.z, r0.w, r1.y
mad_pp r1.y, -r1.z, c6.x, r1
mad_pp r1.y, r0.w, c8.z, r1
add_pp r2.y, -r2.x, c6.z
mad_pp r1.z, r2.x, c7, c7.w
mad_pp r1.z, r1, r2.x, c8.x
rsq_pp r2.y, r2.y
mad_pp r1.z, r1, r2.x, c8.y
rcp_pp r2.y, r2.y
mul_pp r2.x, r1.z, r2.y
cmp_pp r1.z, r2.w, c6.w, c6
mul_pp r2.y, r1.z, r2.x
mad_pp r2.x, -r2.y, c6, r2
mad_pp r2.x, r1.z, c8.z, r2
min_pp r2.y, r1, r2.x
mul_pp r0.w, c3.x, c3.x
max_pp r1.y, r1, r2.x
add r1.z, r0.w, c7.y
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c8.w
mad r0.w, -r0, c9.y, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
mul_pp r0.xyz, r0, c0
add r0.w, r0, c6.z
max r1.w, r1, c6
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r0.xyz, r1, r0.w, r0
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
"sce_fp_rsx // 132 instructions using 4 registers
[Configuration]
24
ffffffff0001c0200007fff8000000000000840004000000
[Offsets]
6
_LightColor0 2 0
0000083000000790
_Color 1 0
000003e0
AnisoSpecular 1 0
000006e0
orenNayar 1 0
00000040
_AnizoX 1 0
000004a0
_AnizoY 1 0
00000460
[Microcode]
2112
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ce883940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c800000110060300c9181c9d00020000c8000001
51ec3db80000000000000000000000000e8a3940c9001c9dc8000029c8000001
0e000200a5141c9fa0020000c80000010000000000003f800000000000000000
0e00040093141c9d08020000c80000010000000000003f800000000000000000
10000500c8001c9dc8000001c8000001ae8c3940c8011c9dc8000029c800bfe1
108a0540c9141c9dc9100001c80000010e023b00c8001c9dfe000001c8000001
10860a40c9141c9d00020000c800000100000000000000000000000000000000
10880540c9141c9dc9180001c80000010e820440c9141c9fff100001c9180001
10800340c9143c9f00020000c800000100003f80000000000000000000000000
0e800440c9141c9fff140001c9100001048e0540c9001c9dc9040001c8000001
08801b40ff001c9dc8000001c8000001028e0340ff103c9f00020000c8000001
00003f8000000000000000000000000010800440c9143c9daa02000054020001
000000006000bc9920003d980000000010000900ab1c1c9c00020000c8000001
0000000000000000000000000000000002003a00ff181c9dfe0c0001c8000001
1000020000001c9cc8000001c8000001108e0440c9103c9d00020000aa020000
6000bc9920003d98000000000000000006000100c8001c9dc8000001c8000001
02800440ff103c9dff1c0001000200004000be59000000000000000000000000
10800440c9143c9dc9000001000200004000be59000000000000000000000000
04801b40c91c1c9dc8000001c800000102800440ff103c9dc900000100020000
00003fc900000000000000000000000002803a40c9001c9dab000000c8000001
04800440ff143c9dff0000010002000000003fc9000000000000000000000000
108a0a40c9101c9daa020000c800000100000000000000000000000000000000
10880240c9141c9d01001000c800000108863a40ab001c9c55000001c8000001
1088034001001c9cc9100003c80000011e7e7d00c8001c9dc8000001c8000001
02820240ff0c1c9d550c1001c800000108860340c90c1c9d01040002c8000001
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
000000000000000000000000000000000e000200a5141c9d92040001c8000001
10880440c9141c9d00020000c910000100004049000000000000000000000000
0e00040093141c9da4040001c8000003108e0500c9181c9dc8000001c8000001
02000500c8001c9dc8000001c80000011080014000021c9cc8000001c8000001
0000000000000000000000000000000004828540c9141c9dc9100001c8000001
04888540c9141c9dc9180001c80000010880014000021c9cc8000001c8000001
0000000000000000000000000000000004820240c9101c9dc9040001c8000001
02883b00ff1c1c9dc8000001c800000118800100c9001c9dc8000001c8000001
060003005d001c9d00020000c8000001c5ac3727000000000000000000000000
08880440ff0c1c9daa020000c90c000100000000000040490000000000000000
02820500c9181c9dc8040001c800000102020300ab101c9c00020000c8000001
00003f8000000000000000000000000002823a40c9041c9dc8000001c8000001
02000200c8001c9daa000000c800000102863a40c9101c9daa000000c8000001
1080094055101c9dc9100001c800000108842340ff001c9dc8000001c8000001
028a1b40ab041c9cc8000001c800000104820140010c1c9cc8000001c8000001
0288084055101c9dff100001c800000110023a0000001c9cc9140001c8000001
08023800c9041c9dc9040001c800000110842340c9101c9dc8000001c8000001
0e80014000021c9cc8000001c800000100000000000000000000000000000000
10043a0054041c9dc8040001c800000104040200fe041c9d00020000c8000001
0fd0414900000000000000000000000002882240c9101c9dc8000001c8000001
02863a40ff081c9dc9100001c800000110020200c8081c9d00021000c8000001
aa3a3fb800000000000000000000000002021c00fe041c9fc8000001c8000001
037e4180aa081c9cc8000001c800000102023a00c8041c9daa080000c8000001
1080024055081c9d010c0000c80000010e80020000040014c8020001c8000001
0000000000000000000000000000000010840900ab101c9cc8020001c8000001
0000000000000000000000000000000008000300ff181c9d00020000c8000001
eb853f1100000000000000000000000082061704c8011c9dc8000001c8003fe1
0e800240c9001c9d000c0000c800000110000200c8001c9dc9000001c8000001
10043a00c9181c9d54005001c80000010e8e0100c91c1c9dc8000001c8000001
1a880240291c1c9d28020001c800000100000000000000000000000000000000
02020400fe001c9d00020000fe08000366663ee6000000000000000000000000
10800140aa021c9cc8000001c800000100000000000000000000000000000000
0e860240f1101c9dff080001c80000011084030000041c9c00020000c8000001
00003f800000000000000000000000000e820240c90c1c9dff080001c8000001
0e810440c9001c9dc8021001c904000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_3_0
; 145 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 0.00000000, 1.00000000, 0.50000000, 0.56999999
def c7, 2.00000000, -1.00000000, 0.09000000, -0.21215820
def c8, -0.01872253, 0.07427979, 1.57031250, 3.14062500
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 0.44999999, 12.56636047, -2.00000000, 2.71828198
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.xxyw
mad_pp r0.xyz, r1.yzxw, c6.xyxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6.y
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.z
pow r0, c10.w, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6, c6.y
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.x, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c6.y
mad_pp r1.z, r1.y, c8.x, c8.y
mad_pp r1.z, r1, r1.y, c7.w
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c0
mad_pp r1.y, r1.z, r1, c8.z
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c6.x, c6
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c7.x, r1
add_pp r2.z, -r2.x, c6.y
mad_pp r2.y, r2.x, c8.x, c8
mad_pp r2.y, r2, r2.x, c7.w
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c8.w, r1.z
mad_pp r2.x, r2.y, r2, c8.z
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c6, c6.y
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c7.x, r2.y
mad_pp r2.x, r2, c8.w, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c3.x, c3.x
add r1.z, r0.w, c7
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c6.w
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c10.x
mad r0.w, -r0, c6.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, c0
max r1.w, r1, c6.x
mul_pp r2.xyz, r1, r1.w
add r0.w, r0, c6.y
mad_pp r2.xyz, r2, r0.w, r0
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c6.z
dp3 r0.x, v3, v3
texld r0.w, r1, s3
cmp r0.y, -v3.z, c6.x, c6
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c7.x
mov_pp oC0.w, c6.x
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"sce_fp_rsx // 142 instructions using 4 registers
[Configuration]
24
ffffffff0003c020000ffff0000000000000840004000000
[Offsets]
6
_LightColor0 2 0
000008a000000460
_Color 1 0
000003d0
AnisoSpecular 1 0
00000740
orenNayar 1 0
00000040
_AnizoX 1 0
00000480
_AnizoY 1 0
00000440
[Microcode]
2272
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108a024000021c9c00020000c8000001
00000000000000000000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e8c3940c9041c9dc8000029c800000108803b40c9003c9d55000001c8000001
0e883940c9001c9dc8000029c80000010e000200a5101c9fa0020000c8000001
0000000000003f800000000000000000ce8a3940c8011c9dc8000029c800bfe1
10880540c9101c9dc9140001c80000010e00040093101c9d08020000c8000001
0000000000003f80000000000000000010840340c9103c9faa020000c8000001
0000000000003f80000000000000000010000500c8001c9dc8000001c8000001
0e840440c9101c9fff100001c9140001028e1b40ff081c9dc8000001c8000001
108c0540c9101c9dc9180001c80000010e860440c9101c9fff180001c9180001
108e0440c9103c9d00020000aa0200006000bc9920003d980000000000000000
048e0540c9081c9dc90c0001c80000010e023b00c8001c9dfe000001c8000001
10020300c9141c9d00020000c800000151ec3db8000000000000000000000000
02003a00ff141c9dfe040001c800000110820a40c9101c9d00020000c8000001
0000000000000000000000000000000010800440c9183c9d00020000aa020000
6000bc9920003d980000000000000000088e0340ff183c9fc8020001c8000001
000000000000000000003f800000000010020900ab1c1c9c00020000c8000001
000000000000000000000000000000001002020000001c9cc8040001c8000001
02800440ff183c9dff000001000200004000be59000000000000000000000000
088e1b40551c1c9dc8000001c8000001048e0440ff183c9d0100000000020000
00003fc9000000000000000000000000108e0440c9103c9dc91c000100020000
4000be59000000000000000000000000048e3a40c91c1c9d551c0001c8000001
088e0440ff103c9dff1c00010002000000003fc9000000000000000000000000
108e0a40c9181c9d00020000c800000100000000000000000000000000000000
10803a40551c1c9dc91c0001c800000102800240ff041c9dff001001c8000001
108c0240c91c1c9dab1c1000c800000108820340ff001c9d01000002c8000001
108c0340ab1c1c9cc9180003c80000018e001702c8011c9dc8000001c8003fe1
0e8e0240c8001c9dc8020001c800000100000000000000000000000000000000
0e000200a5101c9d92040001c80000010e00040093101c9da4040001c8000003
10880500c9181c9dc8000001c800000102000500c8001c9dc8000001c8000001
08800500c9181c9dc8040001c80000011084014000021c9cc8000001c8000001
000000000000000000000000000000000e8e0240c91c1c9dc8020001c8000001
000000000000000000000000000000000884014000021c9cc8000001c8000001
0000000000000000000000000000000002860440ff041c9daa02000055040001
0000000000004049000000000000000004863b00ff101c9dc8000001c8000001
060203005d081c9d00020000c8000001c5ac3727000000000000000000000000
10803a40ab0c1c9caa040000c800000104860440ff1c1c9d00020000ff180001
0000404900000000000000000000000004800140ff001c9dc8000001c8000001
02803a4055001c9dc8040001c8000001108c0840010c1c9cab0c0000c8000001
028c8540c9101c9dc9180001c80000011000030001181c9c00020000c8000001
00003f80000000000000000000000000048c8540c9101c9dc9140001c8000001
02003800c9001c9dc9000001c800000108003a0000001c9cfe000001c8000001
f6000100c8011c9dc8000001c8003fe106003a00c8001c9dfe000001c8000001
06000300c8001c9d00020000c800000100003f00000000000000000000000000
10001706c8001c9dc8000001c800000102000200c8041c9daa040000c8000001
0880024001181c9cab180000c8000001ee040100c8011c9dc8000001c8003fe1
10840940010c1c9cab0c0000c800000110842340ff081c9dc8000001c8000001
08020300ff141c9d00020000c8000001eb853f11000000000000000000000000
02841b4055001c9dc8000001c80000010400020054001c9d00021000c8000001
aa3a3fb800000000000000000000000004001c00aa001c9ec8000001c8000001
02003a00c8001c9dc9080001c800000102000200c8001c9d00020000c8000001
0fd04149000000000000000000000000048c2340ff181c9dc8000001c8000001
037e4180c8001c9dc8000001c800000108003a00aa001c9cc8000001c8000001
0e84014000021c9cc8000001c800000100000000000000000000000000000000
82001704c8011c9dc8000001c8003fe10e84020054000015c8020001c8000001
000000000000000000000000000000000e840240c9081c9d00000000c8000001
02000500c8081c9dc8080001c80000010200170800001c9cc8000001c8000001
02882240ff181c9dc8000001c800000102820d0054081c9d00020000c8000001
00000000000000000000000000000000108c3a40ab181c9cc9100001c8000001
10840240c9081c9dc9180001c800000102040200fe041c9dff080001c8000001
10043a00c9141c9d54045001c800000102040400c8081c9d00020000fe080003
66663ee60000000000000000000000001088090001181c9caa020000c8000001
000000000000000000000000000000000e860240c91c1c9dff100001c8000001
1080030000081c9c00020000c800000100003f80000000000000000000000000
0e860240c90c1c9dff000001c80000011084024001041c9cc8000001c8000001
10800240c9081c9d00000000c80000010e800440c9081c9dc8020001c90c0001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 141 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.y
pow r0, c10.z, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6.w, c6.z
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c0
mad_pp r1.y, r1.z, r1, c8
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c6.w, c6.z
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c6.x, r1
add_pp r2.z, -r2.x, c6
mad_pp r2.y, r2.x, c7.z, c7.w
mad_pp r2.y, r2, r2.x, c8.x
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c8.z, r1.z
mad_pp r2.x, r2.y, r2, c8.y
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c6.w, c6.z
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c6.x, r2.y
mad_pp r2.x, r2, c8.z, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c3.x, c3.x
add r1.z, r0.w, c7.y
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c8.w
mad r0.w, -r0, c9.y, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
add r0.w, r0, c6.z
max r1.w, r1, c6
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
dp3 r0.x, v3, v3
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"sce_fp_rsx // 139 instructions using 5 registers
[Configuration]
24
ffffffff0003c020000ffff0000000000000840005000000
[Offsets]
6
_LightColor0 2 0
0000087000000770
_Color 1 0
000003f0
AnisoSpecular 1 0
00000700
orenNayar 1 0
00000040
_AnizoX 1 0
000000b0
_AnizoY 1 0
00000410
[Microcode]
2224
940017005c011c9dc8000001c8003fe106820440ce001c9daa02000054020001
00000000000040000000bf8000000000108e024000021c9c00020000c8000001
00000000000000000000000000000000ae803940c8011c9dc8000029c800bfe1
10800240ab041c9cab040000c800000108060300ff1c1c9d00020000c8000001
51ec3db80000000000000000000000001080044001041c9e01040000c9000003
0890014000021c9cc8000001c800000100000000000000000000000000000000
10800340c9001c9d00020000c800000100003f80000000000000000000000000
0e883940c9001c9dc8000029c800000108823b40ff003c9dff000001c8000001
0e8a3940c9041c9dc8000029c80000010e000200a5141c9fa0020000c8000001
0000000000003f800000000000000000108a0540c9141c9dc9100001c8000001
0e860440c9141c9fff140001c9100001ce8c3940c8011c9dc8000029c800bfe1
10880540c9141c9dc9180001c80000010e00040093141c9d08020000c8000001
0000000000003f80000000000000000010840340c9103c9faa020000c8000001
0000000000003f80000000000000000010000500c8001c9dc8000001c8000001
0e840440c9141c9fff100001c9180001088e0540c9081c9dc90c0001c8000001
108c1b40ff081c9dc8000001c80000010e023b00c8001c9dfe000001c8000001
10800440c9143c9d00020000aa0200006000bc9920003d980000000000000000
02820340ff143c9f00020000c800000100003f80000000000000000000000000
02003a00ff1c1c9d540c0001c800000110020900551c1c9d00020000c8000001
000000000000000000000000000000001002020000001c9cc8040001c8000001
02800440ff143c9dff000001000200004000be59000000000000000000000000
04801b40c9041c9dc8000001c800000102800440ff143c9dc900000100020000
00003fc900000000000000000000000010800440c9103c9d00020000aa020000
6000bc9920003d98000000000000000010800440c9103c9dc900000100020000
4000be5900000000000000000000000002803a40c9001c9dab000000c8000001
028e0440ff103c9dff0000010002000000003fc9000000000000000000000000
10903a40011c1c9cff180001c800000102900a40ff101c9d00020000c8000001
0000000000000000000000000000000002920240c9201c9dff201001c8000001
108a0a40c9141c9d00020000c800000100000000000000000000000000000000
10880240c9141c9d01001000c80000011088034001001c9cc9100003c8000001
8e001702c8011c9dc8000001c8003fe1108c0340c9201c9d01240002c8000001
0e8e0240c8001c9dc8020001c800000100000000000000000000000000000000
1090014000021c9cc8000001c800000100000000000000000000000000000000
02900440c9201c9daa020000ff18000100000000000040490000000000000000
02920500c9101c9dc8040001c800000110920440c9141c9d00020000c9100001
000040490000000000000000000000000e000200a5141c9d92040001c8000001
0e00040093141c9da4040001c800000382021704c8011c9dc8000001c8003fe1
1088094001201c9cc9240001c800000102860840c9201c9dff240001c8000001
10000500c8001c9dc8000001c800000104900500c9101c9dc8000001c8000001
ee000100c8011c9dc8000001c8003fe102000500c8001c9dc8000001c8000001
04828540c9141c9dc9180001c8000001060603005d201c9d00020000c8000001
c5ac372700000000000000000000000004923b00c9201c9dfe000001c8000001
04908540c9141c9dc9100001c800000108000100c8001c9dc8000001c8000001
0200170600001c9cc8000001c800000102880240ab201c9cab040000c8000001
04000200000c1c9cc80c0001c800000110903a40ab241c9caa0c0000c8000001
04820140ff201c9dc8000001c800000102823a40c9241c9dc80c0001c8000001
0e8c014000021c9cc8000001c800000100000000000000000000000000000000
108c2340ff101c9dc8000001c800000108881b40c9101c9dc8000001c8000001
08083800c9041c9dc9040001c800000104080300c9201c9d00020000c8000001
00003f8000000000000000000000000002043a0054101c9daa100000c8000001
08020100c8041c9dc8000001c800000108842340c90c1c9dc8000001c8000001
1e7e7d00c8001c9dc8000001c80000010800020000081c9c00021000c8000001
aa3a3fb800000000000000000000000004003a00c8001c9d55100001c8000001
04000200c8001c9d00020000c80000010fd04149000000000000000000000000
08001c0054001c9fc8000001c800000110043a0054001c9daa000000c8000001
037e4180aa001c9cc8000001c80000010e8c0200fe080015c8020001c8000001
000000000000000000000000000000000e8c0240c9181c9d00040000c8000001
02842240c90c1c9dc8000001c800000108020300ff1c1c9d00020000c8000001
eb853f1100000000000000000000000010843a4055081c9dc9080001c8000001
0e920240c91c1c9dc8020001c800000100000000000000000000000000000000
02840240ff181c9dff080001c800000102020200fe041c9dc9080001c8000001
10023a00c91c1c9d54045001c800000102020400c8041c9d00020000fe040003
66663ee600000000000000000000000010840900ab201c9caa020000c8000001
00000000000000000000000000000000f0001708c8011c9dc8000001c8003fe1
0e860240c9241c9dff080001c80000011084030000041c9c00020000c8000001
00003f800000000000000000000000001e020100c8041c9dc8000001c8000001
1080020000001c9cc8000001c80000010e800240c90c1c9dff080001c8000001
0e800440c9181c9dc8020001c900000100000000000000000000000000000000
0e800240ff001c9dc9001001c80000011081014000021c9cc8000001c8000001
00000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 136 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r2
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.y
pow r0, c10.z, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6.w, c6.z
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r0.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
rsq_pp r2.x, r2.x
cmp_pp r0.w, r0, c6, c6.z
rcp_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c8
mul_pp r1.y, r1, r2.x
abs_pp r2.x, r2.w
mul_pp r1.z, r0.w, r1.y
mad_pp r1.y, -r1.z, c6.x, r1
mad_pp r1.y, r0.w, c8.z, r1
add_pp r2.y, -r2.x, c6.z
mad_pp r1.z, r2.x, c7, c7.w
mad_pp r1.z, r1, r2.x, c8.x
rsq_pp r2.y, r2.y
mad_pp r1.z, r1, r2.x, c8.y
rcp_pp r2.y, r2.y
mul_pp r2.x, r1.z, r2.y
cmp_pp r1.z, r2.w, c6.w, c6
mul_pp r2.y, r1.z, r2.x
mad_pp r2.x, -r2.y, c6, r2
mad_pp r2.x, r1.z, c8.z, r2
min_pp r2.y, r1, r2.x
mul_pp r0.w, c3.x, c3.x
max_pp r1.y, r1, r2.x
add r1.z, r0.w, c7.y
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c8.w
mad r0.w, -r0, c9.y, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
add r0.w, r0, c6.z
mul_pp r0.xyz, r0, c0
max r1.w, r1, c6
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r0.xyz, r1, r0.w, r0
texld r0.w, v3, s3
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
"sce_fp_rsx // 131 instructions using 4 registers
[Configuration]
24
ffffffff0003c020000ffff8000000000000840004000000
[Offsets]
6
_LightColor0 2 0
00000810000006c0
_Color 1 0
000003c0
AnisoSpecular 1 0
00000660
orenNayar 1 0
00000040
_AnizoX 1 0
00000450
_AnizoY 1 0
00000420
[Microcode]
2096
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ce8c3940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c800000110060300c9181c9d00020000c8000001
51ec3db80000000000000000000000000e883940c9001c9dc8000029c8000001
108a0540c9101c9dc9180001c8000001ae8a3940c8011c9dc8000029c800bfe1
0e000200a5101c9fa0020000c80000010000000000003f800000000000000000
0e00040093101c9d08020000c80000010000000000003f800000000000000000
10000500c8001c9dc8000001c80000010e023b00c8001c9dfe000001c8000001
10800340c9143c9f00020000c800000100003f80000000000000000000000000
0e800440c9101c9fff140001c918000110820a40c9141c9d00020000c8000001
0000000000000000000000000000000010880540c9101c9dc9140001c8000001
0e820440c9101c9fff100001c9140001048e0540c9001c9dc9040001c8000001
08801b40ff001c9dc8000001c8000001028e0340ff103c9f00020000c8000001
00003f8000000000000000000000000010800440c9103c9daa02000054020001
000000006000bc9920003d980000000010020900ab1c1c9c00020000c8000001
0000000000000000000000000000000002003a00ff181c9dfe0c0001c8000001
1002020000001c9cc8040001c800000102800440ff103c9dff00000100020000
4000be5900000000000000000000000002800440ff103c9dc900000100020000
00003fc900000000000000000000000010800440c9143c9daa02000054020001
000000006000bc9920003d980000000010800440c9143c9dc900000100020000
4000be5900000000000000000000000004801b40c91c1c9dc8000001c8000001
02803a40c9001c9dab000000c800000104800440ff143c9dff00000100020000
00003fc9000000000000000000000000108a0a40c9101c9daa020000c8000001
0000000000000000000000000000000010803a40ab001c9c55000001c8000001
02820240ff041c9dff001001c800000110880240c9141c9d01001000c8000001
08820340ff001c9d01040002c80000011088034001001c9cc9100003c8000001
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
000000000000000000000000000000000e000200a5101c9d92040001c8000001
0e00040093101c9da4040001c8000003108e0500c9141c9dc8000001c8000001
02000500c8001c9dc8000001c80000011080014000021c9cc8000001c8000001
0000000000000000000000000000000002820500c9141c9dc8040001c8000001
0880014000021c9cc8000001c800000100000000000000000000000000000000
04868540c9101c9dc9180001c800000102868540c9101c9dc9140001c8000001
060203005d001c9d00020000c8000001c5ac3727000000000000000000000000
028c3b00ff1c1c9dc8000001c8000001108e0440c9041c9d0002000055040001
000040490000000000000000000000000400020000041c9cc8040001c8000001
02823a40c9041c9dc8040001c800000102840240c90c1c9dab0c0000c8000001
10843a4001181c9caa040000c800000104820140ff081c9dc8000001c8000001
04860440ff141c9d00020000ff10000100004049000000000000000000000000
02881b40c9081c9dc8000001c800000102020300c90c1c9d00020000c8000001
00003f8000000000000000000000000004023800c9041c9dc9040001c8000001
02023a00aa041c9cc8040001c80000010e8c014000021c9cc8000001c8000001
0000000000000000000000000000000002043a00aa001c9cc9100001c8000001
1004020000041c9c00021000c8000001aa3a3fb8000000000000000000000000
02820840ff1c1c9dab0c0000c800000182001704c8011c9dc8000001c8003fe1
04041c00fe081c9fc8000001c800000102040200c8081c9d00020000c8000001
0fd0414900000000000000000000000010043a00aa081c9cc8080001c8000001
037e4180c8081c9dc8000001c80000010e8c0200fe080015c8020001c8000001
000000000000000000000000000000001e7e7d00c8001c9dc8000001c8000001
10840940c91c1c9dab0c0000c800000108842340ff081c9dc8000001c8000001
0e8c0240c9181c9d00000000c80000010e800240c91c1c9dc8020001c8000001
0000000000000000000000000000000010060300c9181c9dc8020001c8000001
000000000000000000000000eb853f1110802340c9041c9dc8000001c8000001
f0001706c8011c9dc8000001c8003fe102822240c9041c9dc8000001c8000001
10803a40c9001c9dc9040001c8000001028e024055081c9dff000001c8000001
10800900010c1c9c00020000c800000100000000000000000000000000000000
02020200fe041c9dc91c0001c800000110023a00c9181c9dfe0c5001c8000001
02020400c8041c9d00020000fe04000366663ee6000000000000000000000000
0e800240c9001c9dff000001c80000011080030000041c9c00020000c8000001
00003f800000000000000000000000000e800240c9001c9dff000001c8000001
1080014000021c9cc8000001c800000100000000000000000000000000000000
0e800440c9181c9dc8020001c900000100000000000000000000000000000000
0e810240fe001c9dc9001001c8000001
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [AnisoSpecular]
Float 4 [orenNayar]
Float 5 [_AnizoX]
Float 6 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 150 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 0.00000000, 1.00000000, 0.50000000, 0.56999999
def c8, 2.00000000, -1.00000000, 0.09000000, -0.21215820
def c9, -0.01872253, 0.07427979, 1.57031250, 3.14062500
def c10, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c11, 0.44999999, 12.56636047, -2.00000000, 2.71828198
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c8.x, c8.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c7.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c7.xxyw
mad_pp r0.xyz, r1.yzxw, c7.xyxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c6.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c5.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c7.y
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c11.z
pow r0, c11.w, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c5.x
rcp_pp r0.z, r0.z
mul r0.y, c6.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c11
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c7, c7.y
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c3.xxyz
cmp r0.yzw, -r2.w, c7.x, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c7.y
mad_pp r1.z, r1.y, c9.x, c9.y
mad_pp r1.z, r1, r1.y, c8.w
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c1
mad_pp r1.y, r1.z, r1, c9.z
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c7.x, c7
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c8.x, r1
add_pp r2.z, -r2.x, c7.y
mad_pp r2.y, r2.x, c9.x, c9
mad_pp r2.y, r2, r2.x, c8.w
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c9.w, r1.z
mad_pp r2.x, r2.y, r2, c9.z
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c7, c7.y
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c8.x, r2.y
mad_pp r2.x, r2, c9.w, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c4.x, c4.x
add r1.z, r0.w, c8
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c10.x, c10
frc_pp r1.y, r1
mad_pp r1.y, r1, c10.z, c10.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c7
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c10.x, c10
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c10, c10.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.w
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c11.x
mad r0.w, -r0, c7.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c2
add r0.w, r0, c7.y
max r1.w, r1, c7.x
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
texldp r0.x, v4, s5
rcp r0.y, v4.w
mad r0.y, -v4.z, r0, r0.x
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c7.z
mov r0.z, c0.x
cmp r0.z, r0.y, c7.y, r0
dp3 r0.x, v3, v3
texld r0.w, r2, s3
cmp r0.y, -v3.z, c7.x, c7
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c8.x
mov_pp oC0.w, c7.x
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [AnisoSpecular]
Float 4 [orenNayar]
Float 5 [_AnizoX]
Float 6 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"sce_fp_rsx // 156 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
7
_LightShadowData 1 0
000008e0
_LightColor0 2 0
0000098000000500
_Color 1 0
00000400
AnisoSpecular 1 0
00000780
orenNayar 1 0
00000040
_AnizoX 1 0
00000460
_AnizoY 1 0
00000440
[Microcode]
2496
940017005c011c9dc8000001c8003fe106820440ce001c9daa02000054020001
00000000000040000000bf8000000000108a024000021c9c00020000c8000001
00000000000000000000000000000000ae843940c8011c9dc8000029c800bfe1
10800240ab041c9cab040000c80000011080044001041c9e01040000c9000003
10800340c9001c9d00020000c800000100003f80000000000000000000000000
08823b40ff003c9dff000001c800000110060300c9141c9d00020000c8000001
51ec3db80000000000000000000000000e823940c9041c9dc8000029c8000001
0e040200a5041c9fa0020000c80000010000000000003f800000000000000000
ce803940c8011c9dc8000029c800bfe110800540c9041c9dc9000001c8000001
0e863940c9081c9dc8000029c80000010e04040093041c9d08020000c8080001
0000000000003f8000000000000000000e8c0440c9041c9fff000001c9000001
108c0340c9003c9f00020000c800000100003f80000000000000000000000000
10820540c9041c9dc90c0001c80000010e840440c9041c9fff040001c90c0001
088a0540c9181c9dc9080001c800000102841b40ff181c9dc8000001c8000001
028e0340ff043c9f00020000c800000100003f80000000000000000000000000
04020500c8081c9dc8080001c800000102063a00ff141c9dfe0c0001c8000001
1006090055141c9d00020000c800000100000000000000000000000000000000
02060200c80c1c9dfe0c0001c80000010e043b00c8081c9daa040000c8000001
10840440c9003c9d00020000aa0200006000bc9920003d980000000000000000
10860500c90c1c9dc8080001c8000001108c0440c9043c9d00020000aa020000
6000bc9920003d98000000000000000002808540c9041c9dc9000001c8000001
1e7e7d00c8001c9dc8000001c800000102900440ff043c9dff18000100020000
4000be5900000000000000000000000004841b40c91c1c9dc8000001c8000001
08840440ff043c9d012000000002000000003fc9000000000000000000000000
02903a4055081c9dab080000c800000110840440c9003c9dc908000100020000
4000be5900000000000000000000000004840440ff003c9dff08000100020000
00003fc9000000000000000000000000108c3a40ab081c9cc9080001c8000001
028e0a40ff001c9d00020000c800000100000000000000000000000000000000
048e0240011c1c9cff181001c800000110800a40c9041c9d00020000c8000001
0000000000000000000000000000000010820240c9001c9d01201000c8000001
048e0340ff181c9dc91c0003c80000011082034001201c9cc9040003c8000001
8e081702c8011c9dc8000001c8003fe10e840240c8101c9dc8020001c8000001
000000000000000000000000000000000e080200a5041c9d92080001c8000001
0e08040093041c9da4080001c81000031088014000021c9cc8000001c8000001
000000000000000000000000000000000888014000021c9cc8000001c8000001
0000000000000000000000000000000010840500c90c1c9dc8100001c8000001
04060500c8101c9dc8100001c8000001028a0440c91c1c9d00020000ab1c0000
00004049000000000000000000000000048a3b00ff081c9daa0c0000c8000001
060403005d101c9d00020000c8000001c5ac3727000000000000000000000000
108c3a40ab141c9caa080000c80000010e840240c9081c9dc8020001c8000001
0000000000000000000000000000000010848540c9041c9dc90c0001c8000001
f6080100c8011c9dc8000001c8003fe102863a40ff0c1c9dc8080001c8000001
10840100c9081c9dc8000001c800000102800240ff081c9dc9000001c8000001
10020300c9081c9d00020000c800000100003f80000000000000000000000000
18063a0080101c9cfe100001c800000118060300c80c1c9d00020000c8000001
00003f0000000000000000000000000002040200c8081c9daa080000c8000001
04860140ff181c9dc8000001c8000001e8080100c8011c9dc8000001c8003fe1
08023800c90c1c9dc90c0001c800000102900d0054101c9d00020000c8000001
0000000000000000000000000000000008023a00c8041c9dfe040001c8000001
100217065c0c1c9dc8000001c800000110840900c9081c9d00020000c8000001
000000000000000000000000000000001092024001201c9cc8040001c8000001
ee080100c8011c9dc8000001c8003fe110880440c9001c9d00020000c9040001
0000404900000000000000000000000008861b40c9001c9dc8000001c8000001
02000500c8101c9dc8100001c80000011080094001141c9cc9100001c8000001
0e840240c9081c9dff080001c800000102043a00c8081c9d550c0001c8000001
1002020054041c9d00021000c8000001aa3a3fb8000000000000000000000000
08021c00fe041c9fc8000001c800000102040200c8081c9d00020000c8000001
0fd04149000000000000000000000000037e4180c8081c9dc8000001c8000001
10023a0054041c9dc8080001c80000010e88014000021c9cc8000001c8000001
000000000000000000000000000000000e880200fe040015c8020001c8000001
0000000000000000000000000000000010060300c9141c9dc8020001c8000001
000000000000000000000000eb853f11028a0840c9141c9dff100001c8000001
18020101c8011c9dc8000001c8003fe10200170800001c9cc8000001c8000001
02820240ff241c9dc8000001c800000182001704c8011c9dc8000001c8003fe1
0e800240c9101c9d00000000c800000102882340ff001c9dc8000001c8000001
1608180bc8011c9dc8000001c8003fe104040500a6101c9dc8020001c8000001
00013f7f00013b7f0001377f0000000004882340c9141c9dc8000001c8000001
10003a0054041c9dfe040001c8000001037e4a00aa081c9cfe000001c8000001
02862240c9141c9dc8000001c800000110863a40ab101c9cc90c0001c8000001
028e0240c9101c9dff0c0001c800000102040200c80c1c9dc91c0001c8000001
10043a00c9141c9dfe0c5001c80000011080014000021c9cc8000001c8000001
0000000000000000000000000000000002040400c8081c9daa020000fe080003
0000000066663ee600000000000000001082030000081c9c00020000c8000001
00003f800000000000000000000000000e840240c9081c9dff040001c8000001
1080014000020008c8000001c800000100003f80000000000000000000000000
1080024001041c9cc9000001c80000010e800440c9001c9dc8020001c9080001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [AnisoSpecular]
Float 4 [orenNayar]
Float 5 [_AnizoX]
Float 6 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 149 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 0.00000000, 1.00000000, 0.50000000, 0.56999999
def c8, 2.00000000, -1.00000000, 0.09000000, -0.21215820
def c9, -0.01872253, 0.07427979, 1.57031250, 3.14062500
def c10, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c11, 0.44999999, 12.56636047, -2.00000000, 2.71828198
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c8.x, c8.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c7.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c7.xxyw
mad_pp r0.xyz, r1.yzxw, c7.xyxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c6.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c5.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c7.y
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c11.z
pow r0, c11.w, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c5.x
rcp_pp r0.z, r0.z
mul r0.y, c6.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c11
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c7, c7.y
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c3.xxyz
cmp r0.yzw, -r2.w, c7.x, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c7.y
mad_pp r1.z, r1.y, c9.x, c9.y
mad_pp r1.z, r1, r1.y, c8.w
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c1
mad_pp r1.y, r1.z, r1, c9.z
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c7.x, c7
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c8.x, r1
add_pp r2.z, -r2.x, c7.y
mad_pp r2.y, r2.x, c9.x, c9
mad_pp r2.y, r2, r2.x, c8.w
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c9.w, r1.z
mad_pp r2.x, r2.y, r2, c9.z
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c7, c7.y
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c8.x, r2.y
mad_pp r2.x, r2, c9.w, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c4.x, c4.x
add r1.z, r0.w, c8
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c10.x, c10
frc_pp r1.y, r1
mad_pp r1.y, r1, c10.z, c10.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c7
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c10.x, c10
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c10, c10.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.w
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c11.x
mad r0.w, -r0, c7.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c2
add r0.w, r0, c7.y
max r1.w, r1, c7.x
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
mov r0.x, c0
rcp r0.y, v3.w
mad r2.xy, v3, r0.y, c7.z
add r0.z, c7.y, -r0.x
texldp r0.x, v4, s5
mad r0.z, r0.x, r0, c0.x
dp3 r0.x, v3, v3
texld r0.w, r2, s3
cmp r0.y, -v3.z, c7.x, c7
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c8.x
mov_pp oC0.w, c7.x
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [AnisoSpecular]
Float 4 [orenNayar]
Float 5 [_AnizoX]
Float 6 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"sce_fp_rsx // 151 instructions using 4 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840004000000
[Offsets]
7
_LightShadowData 2 0
0000090000000800
_LightColor0 2 0
0000093000000820
_Color 1 0
000000d0
AnisoSpecular 1 0
00000780
orenNayar 1 0
00000040
_AnizoX 1 0
00000580
_AnizoY 1 0
000005b0
[Microcode]
2416
940017005c011c9dc8000001c8003fe106820440ce001c9daa02000054020001
00000000000040000000bf8000000000108a024000021c9c00020000c8000001
000000000000000000000000000000008e041702c8011c9dc8000001c8003fe1
ae803940c8011c9dc8000029c800bfe110800240ab041c9cab040000c8000001
1080044001041c9e01040000c900000302840340ff001c9d00020000c8000001
00003f800000000000000000000000000e8e3940c9001c9dc8000029c8000001
0e8c0240c8081c9dc8020001c800000100000000000000000000000000000000
08823b4001083c9cc9080001c80000010e843940c9041c9dc8000029c8000001
108c0540c9081c9dc91c0001c80000010e000200a5081c9fa0020000c8000001
0000000000003f800000000000000000108e0440c9183c9d54020001c8020001
00000000000000006000bc9920003d980e00040093081c9d08020000c8000001
0000000000003f80000000000000000010820340c9183c9faa020000c8000001
0000000000003f800000000000000000ce863940c8011c9dc8000029c800bfe1
0e8a0440c9081c9fff180001c91c000110840a40c9181c9d00020000c8000001
0000000000000000000000000000000008820540c9081c9dc90c0001c8000001
0e880440c9081c9f55040001c90c0001088a0540c9101c9dc9140001c8000001
02040500c8001c9dc8000001c80000010e043b00c8001c9dc8080001c8000001
0e000200a5081c9d92080001c800000106020100c8041c9dc8000001c8000001
0e00040093081c9da4080001c8000003028a0500c91c1c9dc8080001c8000001
02040300ff141c9d00020000c800000151ec3db8000000000000000000000000
048a0440ff183c9dff1c0001000200004000be59000000000000000000000000
04043a00ff141c9dc8080001c80000010204090055141c9d00020000c8000001
0000000000000000000000000000000002040200aa081c9cc8080001c8000001
08881b40ff041c9dc8000001c800000110880440c9183c9dab14000000020000
00003fc900000000000000000000000010863a40c9101c9d55100001c8000001
108c0240c9081c9dc90c1001c80000011088044055043c9d00020000aa020000
6000bc9920003d9800000000000000001082034055043c9f00020000c8000001
00003f80000000000000000000000000048a044055043c9dff100001aa020000
000000004000be59000000000000000008881b40ff041c9dc8000001c8000001
048a044055043c9dc91400010002000000003fc9000000000000000000000000
10820a4055041c9d00020000c800000100000000000000000000000000000000
08823a40ab141c9c55100001c800000110860340c90c1c9dc9180003c8000001
1e7e7d00c8001c9dc8000001c8000001088a8540c9081c9dc91c0001c8000001
108c0240c9041c9d55041001c8000001048a0500c91c1c9dc8000001c8000001
108c034055041c9dc9180003c800000104040500c8001c9dc8000001c8000001
108c0440c9041c9d00020000c918000100004049000000000000000000000000
028e0440ff081c9d00020000ff0c000100004049000000000000000000000000
fe000100c8011c9dc8000001c8003fe108000500c8001c9dc8000001c8000001
06003a00c8001c9dfe000001c800000106000300c8001c9d00020000c8000001
00003f0000000000000000000000000010001706c8001c9dc8000001c8000001
e400010054011c9dc8000001c8003fe102800d00aa001c9c00020000c8000001
0000000000000000000000000000000008808540c9081c9dc90c0001c8000001
10803b00ab141c9caa080000c8000001108e024001001c9cc8000001c8000001
0200170854001c9dc8000001c80000010282014000021c9cc8000001c8000001
000000000000000000000000000000001082024055141c9d55000001c8000001
0482014000021c9cc8000001c800000100000000000000000000000000000000
08841b40ff041c9dc8000001c80000011800030081041c9c00020000c8000001
c5ac37270000000000000000000000000202030055141c9daa020000c8000001
0000000000003f80000000000000000008803a40ff001c9dfe000001c8000001
1080014055001c9dc8000001c800000108020200c8001c9dfe000001c8000001
1088090055141c9d00020000c800000100000000000000000000000000000000
08803a4001141c9c54000001c8000001040038005d001c9d5d000001c8000001
04003a00c8001c9dc8040001c80000010e82014000021c9cc8000001c8000001
0000000000000000000000000000000010020200aa001c9caa021000c8000001
00000000aa3a3fb8000000000000000002023a0054041c9d55080001c8000001
10800940c9181c9d011c0000c800000102020200c8041c9d00020000c8000001
0fd0414900000000000000000000000004021c00fe041c9fc8000001c8000001
04023a00c8041c9dc8040001c800000110800100c9001c9dc8000001c8000001
037e4180c8041c9dc8000001c800000102842340ff001c9dc8000001c8000001
10800840c9181c9d011c0000c80000010e820200aa040014c8020001c8000001
00000000000000000000000000000000108e0240c91c1c9d00000000c8000001
82001704c8011c9dc8000001c8003fe10e820240c9041c9d00000000c8000001
10822340ff001c9dc8000001c80000010200180bc8011c9dc8000001c8003fe1
10802240ff001c9dc8000001c80000010806040000001c9c0002000200000000
000000000000000000000000000000000e800240c9181c9dc8020001c8000001
0000000000000000000000000000000010803a40c9041c9dff000001c8000001
02840240c9081c9dff000001c800000110020300c9141c9d00020000c8000001
eb853f1100000000000000000000000010023a00c9141c9dfe045001c8000001
02020200c8081c9dc9080001c800000102040400c8041c9d00020000fe040003
66663ee60000000000000000000000001080030000081c9c00020000c8000001
00003f800000000000000000000000000e800240c9001c9dff100001c8000001
0e800240c9001c9dff000001c800000110800300540c1c9d00020000c8000001
0000000000000000000000000000000010800240c91c1c9dc9000001c8000001
0e800440c9041c9dc8020001c900000100000000000000000000000000000000
0e800240ff001c9dc9001001c80000011081014000021c9cc8000001c8000001
00000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 136 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r2
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.y
pow r0, c10.z, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6.w, c6.z
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r0.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c0
cmp_pp r0.w, r0, c6, c6.z
rcp_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c8
mul_pp r1.y, r1, r2.x
abs_pp r2.x, r2.w
mul_pp r1.z, r0.w, r1.y
mad_pp r1.y, -r1.z, c6.x, r1
mad_pp r1.y, r0.w, c8.z, r1
add_pp r2.y, -r2.x, c6.z
mad_pp r1.z, r2.x, c7, c7.w
mad_pp r1.z, r1, r2.x, c8.x
rsq_pp r2.y, r2.y
mad_pp r1.z, r1, r2.x, c8.y
rcp_pp r2.y, r2.y
mul_pp r2.x, r1.z, r2.y
cmp_pp r1.z, r2.w, c6.w, c6
mul_pp r2.y, r1.z, r2.x
mad_pp r2.x, -r2.y, c6, r2
mad_pp r2.x, r1.z, c8.z, r2
min_pp r2.y, r1, r2.x
mul_pp r0.w, c3.x, c3.x
max_pp r1.y, r1, r2.x
add r1.z, r0.w, c7.y
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c8.w
mad r0.w, -r0, c9.y, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
add r0.w, r0, c6.z
max r1.w, r1, c6
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
texldp r0.x, v3, s3
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"sce_fp_rsx // 133 instructions using 4 registers
[Configuration]
24
ffffffff0003c020000ffff0000000000000840004000000
[Offsets]
6
_LightColor0 2 0
0000083000000740
_Color 1 0
000003d0
AnisoSpecular 1 0
000006a0
orenNayar 1 0
00000040
_AnizoX 1 0
00000480
_AnizoY 1 0
000004d0
[Microcode]
2128
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf80000000000886024000021c9c00020000c8000001
00000000000000000000000000000000ce8a3940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c80000010e883940c9001c9dc8000029c8000001
0e000200a5101c9fa0020000c80000010000000000003f800000000000000000
0e00040093101c9d08020000c80000010000000000003f800000000000000000
10000500c8001c9dc8000001c80000010e023b00c8001c9dfe000001c8000001
108a0540c9101c9dc9140001c8000001ae8c3940c8011c9dc8000029c800bfe1
10880540c9101c9dc9180001c80000010e820440c9101c9fff100001c9180001
10820340c9143c9f00020000c800000100003f80000000000000000000000000
0e800440c9101c9fff140001c914000110800540c9001c9dc9040001c8000001
08801b40ff041c9dc8000001c800000110000300550c1c9d00020000c8000001
51ec3db800000000000000000000000002003a00550c1c9dfe000001c8000001
10000900c9001c9d00020000c800000100000000000000000000000000000000
02820340ff103c9f00020000c800000100003f80000000000000000000000000
10800440c9103c9daa02000054020001000000006000bc9920003d9800000000
1000020000001c9cc8000001c800000102800440ff103c9dff00000100020000
4000be5900000000000000000000000002800440ff103c9dc900000100020000
00003fc900000000000000000000000010800440c9143c9daa02000054020001
000000006000bc9920003d980000000004801b40c9041c9dc8000001c8000001
108c0a40c9141c9d00020000c800000100000000000000000000000000000000
02803a40c9001c9dab000000c800000110800440c9143c9dc900000100020000
4000be5900000000000000000000000004800440ff143c9dff00000100020000
00003fc900000000000000000000000010880a40c9101c9daa020000c8000001
0000000000000000000000000000000010860240c9101c9d01001000c8000001
1086034001001c9cc90c0003c8000001108e3a40ab001c9c55000001c8000001
028e0240ff181c9dff1c1001c80000018e001702c8011c9dc8000001c8003fe1
108a0340c91c1c9d011c0002c80000011e7e7d00c8001c9dc8000001c8000001
0e8e0240c8001c9dc8020001c800000100000000000000000000000000000000
108c0100c9181c9dc8000001c8000001108a0440c9181c9d00020000c9140001
000040490000000000000000000000001e7e7d00c8001c9dc8000001c8000001
0e000200a5101c9d92040001c80000010e00040093101c9da4040001c8000003
108e0500c9181c9dc8000001c800000102000500c8001c9dc8000001c8000001
02860500c9181c9dc8040001c80000010284014000021c9cc8000001c8000001
0000000000000000000000000000000008808540c9101c9dc9140001c8000001
02828540c9101c9dc9180001c80000011084024001041c9c55000001c8000001
0484014000021c9cc8000001c800000100000000000000000000000000000000
08881b40ff081c9dc8000001c800000106020300c9081c9d00020000c8000001
c5ac372700000000000000000000000002040200c8041c9daa040000c8000001
10803b00c91c1c9dc8000001c800000108803a40ff001c9daa040000c8000001
1080014055001c9dc8000001c800000110840440c9101c9d00020000c90c0001
0000404900000000000000000000000008803a40010c1c9cc8040001c8000001
040038005d001c9d5d000001c80000010802030001041c9c00020000c8000001
00003f8000000000000000000000000008023a00aa001c9c54040001c8000001
0e84014000021c9cc8000001c800000100000000000000000000000000000000
10800940c9141c9dc9080001c800000108040200c8041c9d00021000c8000001
aa3a3fb800000000000000000000000002043a00c8081c9d55100001c8000001
02040200c8081c9d00020000c80000010fd04149000000000000000000000000
04041c0054081c9fc8000001c800000104043a00c8081c9dc8080001c8000001
10840840c9141c9dc9080001c8000001037e4180c8081c9dc8000001c8000001
02862340ff081c9dc8000001c80000010e840200aa080014c8020001c8000001
0000000000000000000000000000000008802340ff001c9dc8000001c8000001
82001704c8011c9dc8000001c8003fe10e840240c9081c9d00000000c8000001
10802240ff081c9dc8000001c800000110803a40010c1c9cff000001c8000001
08020300c90c1c9d00020000c8000001eb853f11000000000000000000000000
0482024055001c9dff000001c80000010e880240c91c1c9dc8020001c8000001
0000000000000000000000000000000010063a00550c1c9d54045001c8000001
02060200fe001c9dab040000c800000104000400000c1c9c00020000fe0c0003
66663ee60000000000000000000000001082090001041c9caa020000c8000001
000000000000000000000000000000000e820240c9101c9dff040001c8000001
10800300aa001c9c00020000c800000100003f80000000000000000000000000
0e820240c9041c9dff000001c80000011080014000021c9cc8000001c8000001
00000000000000000000000000000000e2001806c8011c9dc8000001c8003fe1
0e820440c9081c9dc8020001c904000100000000000000000000000000000000
0e81024000001c9cc9041001c8000001
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 137 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c7, 0.56999999, 0.09000000, -0.01872253, 0.07427979
def c8, -0.21215820, 1.57031250, 3.14062500, 0.44999999
def c9, 0.15917969, 0.50000000, 6.28125000, -3.14062500
def c10, 12.56636047, -2.00000000, 2.71828198, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c6.wwzw
mad_pp r0.xyz, r1.yzxw, c6.wzww, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r2, r2
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r2
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c5.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c4.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c6
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c10.y
pow r0, c10.z, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c4.x
rcp_pp r0.z, r0.z
mul r0.y, c5.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c10.x
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c6.w, c6.z
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c2.xxyz
cmp r0.yzw, -r2.w, c6.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r0.w
add_pp r2.x, -r1.y, c6.z
mad_pp r1.z, r1.y, c7, c7.w
mad_pp r1.z, r1, r1.y, c8.x
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c0
cmp_pp r0.w, r0, c6, c6.z
rcp_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c8
mul_pp r1.y, r1, r2.x
abs_pp r2.x, r2.w
mul_pp r1.z, r0.w, r1.y
mad_pp r1.y, -r1.z, c6.x, r1
mad_pp r1.y, r0.w, c8.z, r1
add_pp r2.y, -r2.x, c6.z
mad_pp r1.z, r2.x, c7, c7.w
mad_pp r1.z, r1, r2.x, c8.x
rsq_pp r2.y, r2.y
mad_pp r1.z, r1, r2.x, c8.y
rcp_pp r2.y, r2.y
mul_pp r2.x, r1.z, r2.y
cmp_pp r1.z, r2.w, c6.w, c6
mul_pp r2.y, r1.z, r2.x
mad_pp r2.x, -r2.y, c6, r2
mad_pp r2.x, r1.z, c8.z, r2
min_pp r2.y, r1, r2.x
mul_pp r0.w, c3.x, c3.x
max_pp r1.y, r1, r2.x
add r1.z, r0.w, c7.y
rcp r1.z, r1.z
mad_pp r1.y, r1, c9.x, c9
frc_pp r1.y, r1
mad_pp r1.y, r1, c9.z, c9.w
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c6.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c9.x, c9
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c9, c9.w
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c7.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c8.w
mad r0.w, -r0, c9.y, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c1
add r0.w, r0, c6.z
max r1.w, r1, c6
mul_pp r1.xyz, r1, c0
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
texldp r0.x, v4, s3
texld r0.w, v3, s4
mul r0.x, r0.w, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c6.x
mov_pp oC0.w, c6
"
}

SubProgram "ps3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [AnisoSpecular]
Float 3 [orenNayar]
Float 4 [_AnizoX]
Float 5 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [_LightTexture0] 2D
"sce_fp_rsx // 137 instructions using 4 registers
[Configuration]
24
ffffffff0007c020001fffe8000000000000840004000000
[Offsets]
6
_LightColor0 2 0
00000850000006c0
_Color 1 0
000003e0
AnisoSpecular 1 0
00000700
orenNayar 1 0
00000040
_AnizoX 1 0
000004d0
_AnizoY 1 0
000004a0
[Microcode]
2192
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108e024000021c9c00020000c8000001
00000000000000000000000000000000ce8c3940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c800000108060300ff1c1c9d00020000c8000001
51ec3db80000000000000000000000000e883940c9001c9dc8000029c8000001
108a0540c9101c9dc9180001c8000001ae8a3940c8011c9dc8000029c800bfe1
0e000200a5101c9fa0020000c80000010000000000003f800000000000000000
0e00040093101c9d08020000c80000010000000000003f800000000000000000
10000500c8001c9dc8000001c80000010e023b00c8001c9dfe000001c8000001
10800340c9143c9f00020000c800000100003f80000000000000000000000000
0e800440c9101c9fff140001c918000110820a40c9141c9d00020000c8000001
0000000000000000000000000000000010880540c9101c9dc9140001c8000001
0e820440c9101c9fff100001c9140001108c0540c9001c9dc9040001c8000001
08801b40ff001c9dc8000001c800000102820340ff103c9f00020000c8000001
00003f8000000000000000000000000010800440c9103c9daa02000054020001
000000006000bc9920003d980000000010020900c9181c9d00020000c8000001
0000000000000000000000000000000002003a00ff1c1c9d540c0001c8000001
1002020000001c9cc8040001c800000102800440ff103c9dff00000100020000
4000be5900000000000000000000000004801b40c9041c9dc8000001c8000001
02800440ff103c9dc90000010002000000003fc9000000000000000000000000
10800440c9143c9d00020000aa0200006000bc9920003d980000000000000000
10800440c9143c9dc9000001000200004000be59000000000000000000000000
02803a40c9001c9dab000000c800000104800440ff143c9dff00000100020000
00003fc9000000000000000000000000108a0a40c9101c9daa020000c8000001
0000000000000000000000000000000010803a40ab001c9c55000001c8000001
02820240ff041c9dff001001c800000110880240c9141c9d01001000c8000001
1088034001001c9cc9100003c800000108820340ff001c9d01040002c8000001
10880440c9141c9d00020000c910000100004049000000000000000000000000
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
000000000000000000000000000000000e000200a5101c9d92040001c8000001
0e00040093101c9da4040001c8000003108c0500c9141c9dc8000001c8000001
02000500c8001c9dc8000001c800000110000100c8001c9dc8000001c8000001
02820500c9141c9dc8040001c800000110840440c9041c9d0002000055040001
0000404900000000000000000000000082021704c8011c9dc8000001c8003fe1
02868540c9101c9dc9180001c80000011080014000021c9cc8000001c8000001
0000000000000000000000000000000008848540c9101c9dc9140001c8000001
0880014000021c9cc8000001c800000100000000000000000000000000000000
04863b00ff181c9dc8000001c8000001060603005d001c9d00020000c8000001
c5ac372700000000000000000000000002823a40c9041c9dc80c0001c8000001
04000200000c1c9cc80c0001c800000108883a40ab0c1c9caa0c0000c8000001
0288024055081c9dc90c0001c80000010482014055101c9dc8000001c8000001
108a0940c9081c9dc9100001c800000108881b40c9101c9dc8000001c8000001
0e8c014000021c9cc8000001c800000100000000000000000000000000000000
108c2340ff141c9dc8000001c80000011e7e7d00c8001c9dc8000001c8000001
08003800c9041c9dc9040001c800000104003a00c8001c9d55100001c8000001
08020300c9081c9d00020000c800000100003f80000000000000000000000000
04000200c8001c9daa020000c8000001000000000fd041490000000000000000
02043a0054001c9d54040001c800000102860840ff081c9dff100001c8000001
1e7e7d00c8001c9dc8000001c80000010800020000081c9c00021000c8000001
aa3a3fb800000000000000000000000002001807c8011c9dc8000001c8003fe1
08001c0054001c9fc8000001c8000001037e4180aa001c9cc8000001c8000001
10043a0054001c9daa000000c80000010e880240c91c1c9dc8020001c8000001
0000000000000000000000000000000010842340c90c1c9dc8000001c8000001
1e7e7d00c8001c9dc8000001c80000010e8c0200fe080015c8020001c8000001
000000000000000000000000000000000e8c0240c9181c9d00040000c8000001
02842240c90c1c9dc8000001c800000110843a40c9081c9dc9080001c8000001
08020300ff1c1c9d00020000c8000001eb853f11000000000000000000000000
02840240ff181c9dff080001c80000011084090055081c9d00020000c8000001
0000000000000000000000000000000002020200fe041c9dc9080001c8000001
10023a00c91c1c9d54045001c800000102020400c8041c9d00020000fe040003
66663ee6000000000000000000000000f0001708c8011c9dc8000001c8003fe1
0e860240c9101c9dff080001c80000011084030000041c9c00020000c8000001
00003f800000000000000000000000001e020100c8041c9dc8000001c8000001
10800200c8001c9d00000000c80000010e800240c90c1c9dff080001c8000001
0e800440c9181c9dc8020001c900000100000000000000000000000000000000
0e800240ff001c9dc9001001c80000011081014000021c9cc8000001c8000001
00000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 149 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.97000003, 2.00000000, -1.00000000, 0.00000000
def c10, 0.56999999, 0.09000000, 0.00000000, 1.00000000
def c11, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c12, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c13, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c14, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c8.x
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c10.zzww
mad_pp r0.xyz, r1.yzxw, c10.zwzw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c7.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c6.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c8.x
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c13
pow r0, c14.x, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c6.x
rcp_pp r0.z, r0.z
mul r0.y, c7.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c13.z
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c10.z, c10.w
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c4.xxyz
cmp r0.yzw, -r2.w, c9.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c8
mad_pp r1.z, r1.y, c11.x, c11.y
mad_pp r1.z, r1, r1.y, c11
rsq_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c11.w
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c10.z, c10.w
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c9.y, r1
add_pp r2.z, -r2.x, c8.x
mad_pp r2.y, r2.x, c11.x, c11
mad_pp r2.y, r2, r2.x, c11.z
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c12.x, r1.z
mad_pp r2.x, r2.y, r2, c11.w
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c10.z, c10.w
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c9.y, r2.y
mad_pp r2.x, r2, c12, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c5.x, c5.x
add r1.z, r0.w, c10.y
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c12, c12.z
frc_pp r1.y, r1
mad_pp r1.y, r1, c13.x, c13
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c9.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c12, c12.z
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c13.x, c13.y
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c10.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c12.w
mad r0.w, -r0, c12.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c3
mul_pp r0.xyz, r0, c2
add r0.w, r0, c8.x
max r1.w, r1, c9
mul_pp r1.xyz, r1, c2
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
texld r0, v4, s3
dp4 r0.y, r0, c8
dp3 r1.w, v4, v4
rsq r1.w, r1.w
rcp r1.w, r1.w
mul r0.x, r1.w, c0.w
mad r0.y, -r0.x, c9.x, r0
mov r0.z, c1.x
dp3 r0.x, v3, v3
cmp r0.y, r0, c8.x, r0.z
texld r0.x, r0.x, s4
mul r0.x, r0, r0.y
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c9.y
mov_pp oC0.w, c9
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"sce_fp_rsx // 152 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
8
_LightPositionRange 1 0
00000720
_LightShadowData 1 0
00000770
_LightColor0 2 0
0000094000000850
_Color 1 0
00000260
AnisoSpecular 1 0
000006e0
orenNayar 1 0
00000040
_AnizoX 1 0
00000520
_AnizoY 1 0
00000500
[Microcode]
2432
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e8a3940c9041c9dc8000029c800000108060300ff181c9d00020000c8000001
51ec3db800000000000000000000000008803b40c9003c9d55000001c8000001
0e883940c9001c9dc8000029c80000010e000200a5101c9fa0020000c8000001
0000000000003f800000000000000000ce8c3940c8011c9dc8000029c800bfe1
10880540c9101c9dc9140001c80000010e00040093101c9d08020000c8000001
0000000000003f800000000000000000108a0540c9101c9dc9180001c8000001
0e840440c9101c9fff140001c918000110000500c8001c9dc8000001c8000001
0e003b00c8001c9dfe000001c800000102900500c9141c9dc8000001c8000001
0e860440c9101c9fff100001c914000108820540c9081c9dc90c0001c8000001
1002090055041c9d00020000c800000100000000000000000000000000000000
1e7e7d00c8001c9dc8000001c80000010e020200a5101c9d92000001c8000001
0e02040093101c9da4000001c80400031e7e7e00c8001c9dc8000001c8000001
02003a00ff181c9d540c0001c80000011002020000001c9cc8040001c8000001
8e001702c8011c9dc8000001c8003fe10e8e0240c8001c9dc8020001c8000001
0000000000000000000000000000000002800440ff103c9d00020000aa020000
6000bc9920003d98000000000000000010800340c9103c9f54020001c8000001
000000000000000000003f800000000002800440ff103c9dc900000100020000
4000be5900000000000000000000000002800440ff103c9dc900000100020000
00003fc900000000000000000000000004801b40ff001c9dc8000001c8000001
02820340ff143c9f00020000c800000100003f80000000000000000000000000
02803a40c9001c9dab000000c8000001108e0a40c9101c9d00020000c8000001
0000000000000000000000000000000004800240ff1c1c9d01001000c8000001
1088034001001c9cab000002c800000102800440ff143c9d00020000aa020000
6000bc9920003d98000000000000000002800440ff143c9dc900000100020000
4000be5900000000000000000000000004801b40c9041c9dc8000001c8000001
02800440ff143c9dc90000010002000000003fc9000000000000000000000000
10903a4001001c9cab000000c800000102920a40ff141c9d00020000c8000001
00000000000000000000000000000000108a024001241c9cc9201001c8000001
10900340c9201c9dc9140003c8000001108a8540c9101c9dc9180001c8000001
10880440c91c1c9d00020000c910000100004049000000000000000000000000
1e001707c8011c9dc8000001c8003fe110000600c8001c9dc8020001c8000001
00003f8080813b8001823781f88c31d508888540c9101c9dc9140001c8000001
028a0500c9141c9dc8040001c8000001108a024055101c9dc9140001c8000001
ee000100c8011c9dc8000001c8003fe102040500c8001c9dc8000001c8000001
02000500c8041c9dc8040001c80000011084014000021c9cc8000001c8000001
000000000000000000000000000000000884014000021c9cc8000001c8000001
0000000000000000000000000000000002803b00c9141c9dc8000001c8000001
060203005d081c9d00020000c8000001c5ac3727000000000000000000000000
02803a40c9001c9daa040000c80000010480014001001c9cc8000001c8000001
02803a40c9201c9dc8040001c800000102003800c9001c9dc9000001c8000001
08040300c9101c9d00020000c800000100003f80000000000000000000000000
08023a0000001c9c54080001c8000001028c0440c9241c9d00020000ff200001
000040490000000000000000000000000e000101c8011c9dc8000001c8003fe1
04000500c8001c9dc8000001c800000102000200c8041c9daa040000c8000001
02821b40ff141c9dc8000001c80000010e84014000021c9cc8000001c8000001
0000000000000000000000000000000002003a00c8001c9dc9040001c8000001
08000200c8041c9d00021000c8000001aa3a3fb8000000000000000000000000
08001c0054001c9fc8000001c800000102000200c8001c9d00020000c8000001
0fd04149000000000000000000000000037e4180c8001c9dc8000001c8000001
10043a0054001c9dc8000001c80000010e840200fe080015c8020001c8000001
0000000000000000000000000000000008041b00aa001c9cc8000001c8000001
02860940c9181c9dff100001c800000110043a00c8021c9d54080001c8000001
00000000000000000000000000000000028a0840c9181c9dff100001c8000001
028c2340c9141c9dc8000001c80000011e7e7d00c8001c9dc8000001c8000001
0800010000021c9cc8000001c800000100000000000000000000000000000000
82001704c8011c9dc8000001c8003fe10e840240c9081c9d00000000c8000001
10842340c90c1c9dc8000001c800000104000200fe081c9d00020000c8000001
51ec3f78000000000000000000000000037e4a00fe001c9daa000000c8000001
1080090055101c9d00020000c800000100000000000000000000000000000000
0800010000020008c8000001c800000100003f80000000000000000000000000
0200170800081c9cc8000001c800000102882240c9141c9dc8000001c8000001
0e8a0240c91c1c9dc8020001c800000100000000000000000000000000000000
08803a4001181c9cc9100001c8000001028c0240ff081c9d55000001c8000001
10060300c9181c9d00020000c8000001eb853f11000000000000000000000000
10003a00c9181c9dfe0c5001c800000102040200fe041c9dc9180001c8000001
02040400c8081c9d00020000fe00000366663ee6000000000000000000000000
0e860240c9141c9dff000001c80000011080030000081c9c00020000c8000001
00003f800000000000000000000000000e860240c90c1c9dff000001c8000001
1080020000001c9c54000001c80000010e800440c9081c9dc8020001c90c0001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 150 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.97000003, 2.00000000, -1.00000000, 0.00000000
def c10, 0.56999999, 0.09000000, 0.00000000, 1.00000000
def c11, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c12, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c13, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c14, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c8.x
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c10.zzww
mad_pp r0.xyz, r1.yzxw, c10.zwzw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c7.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c6.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c8.x
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c13
pow r0, c14.x, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c6.x
rcp_pp r0.z, r0.z
mul r0.y, c7.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c13.z
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c10.z, c10.w
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c4.xxyz
cmp r0.yzw, -r2.w, c9.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c8
mad_pp r1.z, r1.y, c11.x, c11.y
mad_pp r1.z, r1, r1.y, c11
rsq_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c11.w
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c10.z, c10.w
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c9.y, r1
add_pp r2.z, -r2.x, c8.x
mad_pp r2.y, r2.x, c11.x, c11
mad_pp r2.y, r2, r2.x, c11.z
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c12.x, r1.z
mad_pp r2.x, r2.y, r2, c11.w
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c10.z, c10.w
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c9.y, r2.y
mad_pp r2.x, r2, c12, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c5.x, c5.x
add r1.z, r0.w, c10.y
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c12, c12.z
frc_pp r1.y, r1
mad_pp r1.y, r1, c13.x, c13
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c9.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c12, c12.z
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c13.x, c13.y
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c10.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c12.w
mad r0.w, -r0, c12.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c3
mul_pp r0.xyz, r0, c2
add r0.w, r0, c8.x
max r1.w, r1, c9
mul_pp r1.xyz, r1, c2
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r0.w, r0
texld r0, v4, s3
dp4 r0.y, r0, c8
dp3 r1.w, v4, v4
rsq r1.w, r1.w
rcp r0.x, r1.w
mul r0.x, r0, c0.w
mad r0.x, -r0, c9, r0.y
mov r0.z, c1.x
cmp r0.y, r0.x, c8.x, r0.z
dp3 r0.x, v3, v3
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c9.y
mov_pp oC0.w, c9
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"sce_fp_rsx // 150 instructions using 4 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840004000000
[Offsets]
8
_LightPositionRange 1 0
000007a0
_LightShadowData 1 0
00000820
_LightColor0 2 0
0000092000000720
_Color 1 0
000003d0
AnisoSpecular 1 0
000006b0
orenNayar 1 0
00000040
_AnizoX 1 0
000004b0
_AnizoY 1 0
000004e0
[Microcode]
2400
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf8000000000108c024000021c9c00020000c8000001
00000000000000000000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e8a3940c9041c9dc8000029c800000110060300c9181c9d00020000c8000001
51ec3db800000000000000000000000008803b40c9003c9d55000001c8000001
0e883940c9001c9dc8000029c8000001108a0540c9101c9dc9140001c8000001
0e000200a5101c9fa0020000c80000010000000000003f800000000000000000
0e00040093101c9d08020000c80000010000000000003f800000000000000000
ce8c3940c8011c9dc8000029c800bfe110880540c9101c9dc9180001c8000001
0e840440c9101c9fff100001c918000110840340c9103c9f00020000c8000001
00003f800000000000000000000000000e860440c9101c9fff140001c9140001
048e0540c9081c9dc90c0001c8000001028e1b40ff081c9dc8000001c8000001
10000500c8001c9dc8000001c80000010e023b00c8001c9dfe000001c8000001
10800440c9143c9d00020000aa0200006000bc9920003d980000000000000000
02820340ff143c9f00020000c800000100003f80000000000000000000000000
10820a40c9101c9daa020000c800000100000000000000000000000000000000
02003a00ff181c9dfe0c0001c800000110020900ab1c1c9c00020000c8000001
000000000000000000000000000000001002020000001c9cc8040001c8000001
02800440ff143c9dff000001000200004000be59000000000000000000000000
04801b40c9041c9dc8000001c800000102800440ff143c9dc900000100020000
00003fc900000000000000000000000010800440c9103c9d00020000aa020000
6000bc9920003d98000000000000000010800440c9103c9dc900000100020000
4000be5900000000000000000000000002803a40c9001c9dab000000c8000001
048e0440ff103c9dff0000010002000000003fc9000000000000000000000000
10803a40ab1c1c9cc91c0001c800000102820240ff041c9dff001001c8000001
108a0a40c9141c9d00020000c800000100000000000000000000000000000000
10880240c9141c9d01001000c800000108820340ff001c9d01040002c8000001
1088034001001c9cc9100003c80000018e001702c8011c9dc8000001c8003fe1
0e8e0240c8001c9dc8020001c800000100000000000000000000000000000000
0e000200a5101c9d92040001c80000010e00040093101c9da4040001c8000003
108e0500c9141c9dc8000001c800000102000500c8001c9dc8000001c8000001
08808540c9101c9dc9180001c800000108888540c9101c9dc9140001c8000001
02820500c9141c9dc8040001c8000001028a0440ff141c9d00020000ff100001
0000404900000000000000000000000010840440c9041c9d0002000055040001
0000404900000000000000000000000010823b00c91c1c9dc8000001c8000001
0280014000021c9cc8000001c800000100000000000000000000000000000000
1080024055101c9d55000001c80000010480014000021c9cc8000001c8000001
0000000000000000000000000000000008841b40ff001c9dc8000001c8000001
06000300c9001c9d00020000c8000001c5ac3727000000000000000000000000
02020200c8001c9daa000000c800000102823a40c9041c9dc8000001c8000001
028c0940ff081c9dc9140001c800000102003a00c8041c9d55080001c8000001
10880840c9081c9d01140000c800000102000200c8001c9d00020000c8000001
0fd04149000000000000000000000000028a2340ff101c9dc8000001c8000001
04823a40ff041c9daa000000c80000011000030055101c9d00020000c8000001
00003f8000000000000000000000000008003800c9041c9dc9040001c8000001
037e4180c8001c9dc8000001c80000011084090055101c9d00020000c8000001
0000000000000000000000000000000008023a00c8001c9dfe000001c8000001
10882240ff101c9dc8000001c800000108020200c8041c9d00021000c8000001
aa3a3fb80000000000000000000000000e82014000021c9cc8000001c8000001
00000000000000000000000000000000108e3a4001141c9cff100001c8000001
04001c0054041c9fc8000001c800000108023a00aa001c9cc8000001c8000001
0e82020054040015c8020001c800000100000000000000000000000000000000
82001704c8011c9dc8000001c8003fe10e840240c9041c9d00000000c8000001
0e000101c8011c9dc8000001c8003fe108020500c8001c9dc8000001c8000001
02041b0054041c9dc8000001c80000010e8a0240c91c1c9dc8020001c8000001
000000000000000000000000000000001e001707c8011c9dc8000001c8003fe1
08020600c8001c9dc8020001c800000100003f8080813b8001823781f88c31d5
ee000100c8011c9dc8000001c8003fe102000500c8001c9dc8000001c8000001
02822340c9181c9dc8000001c800000102043a00fe021c9dc8080001c8000001
0000000000000000000000000000000002040200c8081c9d00020000c8000001
51ec3f78000000000000000000000000037e4a0054041c9dc8080001c8000001
02860240c9041c9dff1c0001c800000108000300ff181c9d00020000c8000001
eb853f110000000000000000000000000400010000021c9cc8000001c8000001
0000000000000000000000000000000002040200fe041c9dc90c0001c8000001
f000170ac8011c9dc8000001c8003fe10400010000020008c8000001c8000001
00003f8000000000000000000000000010023a00c9181c9d54005001c8000001
02040400c8081c9d00020000fe04000366663ee6000000000000000000000000
0e860240c9141c9dff080001c80000011084030000081c9c00020000c8000001
00003f800000000000000000000000000e860240c90c1c9dff080001c8000001
0200170800001c9cc8000001c800000102000200c8001c9daa000000c8000001
1080020000001c9cc8000001c80000010e800440c9081c9dc8020001c90c0001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_Color]
Vector 7 [AnisoSpecular]
Float 8 [orenNayar]
Float 9 [_AnizoX]
Float 10 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 158 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c11, 0.00000000, 1.00000000, 0.50000000, 0.25000000
def c12, 2.00000000, -1.00000000, 0.56999999, 0.09000000
def c13, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c14, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c15, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c16, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c12.x, c12.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c11.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c11.xxyw
mad_pp r0.xyz, r1.yzxw, c11.xyxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c10.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c9.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c11.y
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c15
pow r0, c16.x, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c9.x
rcp_pp r0.z, r0.z
mul r0.y, c10.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c15.z
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c11, c11.y
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c7.xxyz
cmp r0.yzw, -r2.w, c11.x, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c11.y
mad_pp r1.z, r1.y, c13.x, c13.y
mad_pp r1.z, r1, r1.y, c13
rsq_pp r2.x, r2.x
mul_pp r0.xyz, r0, c1
mad_pp r1.y, r1.z, r1, c13.w
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c11.x, c11
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c12.x, r1
add_pp r2.z, -r2.x, c11.y
mad_pp r2.y, r2.x, c13.x, c13
mad_pp r2.y, r2, r2.x, c13.z
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c14.x, r1.z
mad_pp r2.x, r2.y, r2, c13.w
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c11, c11.y
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c12.x, r2.y
mad_pp r2.x, r2, c14, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c8.x, c8.x
add r1.z, r0.w, c12.w
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c14, c14.z
frc_pp r1.y, r1
mad_pp r1.y, r1, c15.x, c15
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c11
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c14, c14.z
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c15.x, c15.y
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
max r2.x, r1.w, c11
rcp r1.w, v4.w
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c12.z
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c14.w
mad r0.w, -r0, c11.z, r1.y
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c6
mul_pp r1.xyz, r1, c1
mul_pp r1.xyz, r1, r2.x
add r0.w, r0, c11.y
mad_pp r1.xyz, r1, r0.w, r0
mad r2.xy, v4, r1.w, c5
texld r0.x, r2, s5
mad r2.xy, v4, r1.w, c4
mov r0.w, r0.x
texld r0.x, r2, s5
mad r2.xy, v4, r1.w, c3
mov r0.z, r0.x
texld r0.x, r2, s5
mad r2.xy, v4, r1.w, c2
mov r0.y, r0.x
texld r0.x, r2, s5
mad r0, -v4.z, r1.w, r0
mov r2.x, c0
cmp r0, r0, c11.y, r2.x
dp4_pp r0.z, r0, c11.w
rcp r1.w, v3.w
mad r2.xy, v3, r1.w, c11.z
dp3 r0.x, v3, v3
texld r0.w, r2, s3
cmp r0.y, -v3.z, c11.x, c11
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c12.x
mov_pp oC0.w, c11.x
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_Color]
Vector 7 [AnisoSpecular]
Float 8 [orenNayar]
Float 9 [_AnizoX]
Float 10 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"sce_fp_rsx // 172 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
11
_LightShadowData 1 0
00000700
_LightColor0 2 0
00000a7000000910
_ShadowOffsets[0] 1 0
000006a0
_ShadowOffsets[1] 1 0
00000610
_ShadowOffsets[2] 1 0
000005c0
_ShadowOffsets[3] 1 0
00000570
_Color 1 0
00000410
AnisoSpecular 1 0
00000860
orenNayar 1 0
000001d0
_AnizoX 1 0
00000390
_AnizoY 1 0
00000440
[Microcode]
2752
940017005c011c9dc8000001c8003fe106820440ce001c9d00020000aa020000
000040000000bf800000000000000000ae843940c8011c9dc8000029c800bfe1
10800240ab041c9cab040000c80000011080044001041c9e01040000c9000003
10800340c9001c9d00020000c800000100003f80000000000000000000000000
08823b40ff003c9dff000001c80000010e823940c9041c9dc8000029c8000001
0e040200a5041c9fa0020000c80000010000000000003f800000000000000000
ce803940c8011c9dc8000029c800bfe110800540c9041c9dc9000001c8000001
0e863940c9081c9dc8000029c80000010e04040093041c9d08020000c8080001
0000000000003f8000000000000000000e8c0440c9041c9fff000001c9000001
108c0340c9003c9f00020000c800000100003f80000000000000000000000000
10860540c9041c9dc90c0001c80000010e840440c9041c9fff0c0001c90c0001
02840540c9181c9dc9080001c800000104020500c8081c9dc8080001c8000001
10821b40ff181c9dc8000001c800000104840340ff0c3c9f00020000c8000001
00003f800000000000000000000000000e063b00c8081c9daa040000c8000001
1084024000021c9c00020000c800000100000000000000000000000000000000
10060300c9081c9d00020000c800000151ec3db8000000000000000000000000
02043a00ff081c9dfe0c0001c80000011004090001081c9c00020000c8000001
0000000000000000000000000000000002040200c8081c9dfe080001c8000001
10880440c90c3c9d00020000aa0200006000bc9920003d980000000000000000
028a0440ff0c3c9dff100001000200004000be59000000000000000000000000
02841b40ab081c9cc8000001c800000104840440ff0c3c9d0114000000020000
00003fc900000000000000000000000008840440ff003c9daa020000c8020001
000000006000bc9920003d980000000010880440c9003c9d5508000100020000
4000be5900000000000000000000000002843a40ab081c9cc9080001c8000001
04840440ff003c9dff1000010002000000003fc9000000000000000000000000
10860a40c90c1c9daa020000c800000100000000000000000000000000000000
10883a40ab081c9cff040001c8000001028a0a40ff001c9d00020000c8000001
000000000000000000000000000000000484024001141c9cff101001c8000001
088a014000021c9cc8000001c800000100000000000000000000000000000000
048a0340ff101c9dc9080003c800000110800240c90c1c9d01081000c8000001
0888034001081c9cff000003c8000001028a0440c9141c9d00020000ab140000
000040490000000000000000000000008e081702c8011c9dc8000001c8003fe1
0e840240c8101c9dc8020001c800000100000000000000000000000000000000
0e080200a5041c9d920c0001c8000001108a014000021c9cc8000001c8000001
000000000000000000000000000000000e08040093041c9da40c0001c8100003
048a8540c9041c9dc9000001c8000001088e0500c90c1c9dc8100001c8000001
02080500c8101c9dc8100001c800000110800500c90c1c9dc80c0001c8000001
0e063a01c8011c9dfe010001c800bfe102923b00551c1c9dc8100001c8000001
10888540c9041c9dc90c0001c8000001060803005d141c9d00020000c8000001
c5ac372700000000000000000000000010060300c9101c9daa020000c8000001
0000000000003f80000000000000000010823a4001241c9caa100000c8000001
02860240ff101c9dab140000c80000011e7e7d00c8001c9dc8000001c8000001
108a0140c9041c9dc8000001c8000001088a3a40ff001c9dc8100001c8000001
06000300c80c1c9d08020000c800000100000000000000000000000000000000
1600170ac8001c9dc8000001c800000110080500a6001c9dc8020001c8000001
00013f7f00013b7f0001377f0000000006000300c80c1c9d08020000c8000001
000000000000000000000000000000001600170ac8001c9dc8000001c8000001
08080500a6001c9dc8020001c800000100013f7f00013b7f0001377f00000000
06000300c80c1c9d08020000c800000100000000000000000000000000000000
1600170ac8001c9dc8000001c8000001100438005d141c9d5d140001c8000001
10043a00c8081c9dfe0c0001c80000011006020000101c9caa100000c8000001
02861b40c90c1c9dc8000001c800000104080500a6001c9dc8020001c8000001
00013f7f00013b7f0001377f0000000006000300c80c1c9d08020000c8000001
000000000000000000000000000000001600170ac8001c9dc8000001c8000001
02080500a6001c9dc8020001c800000100013f7f00013b7f0001377f00000000
1f7e4a00c8101c9d540c0001c80000011e00010000021c9cc8000001c8000001
000000000000000000000000000000001e00010000021c88c8000001c8000001
00003f80000000000000000000000000028c0600c8001c9d00020000c8000001
00003e80000000000000000000000000fe000100c8011c9dc8000001c8003fe1
04060200fe081c9d00021000c8000001aa3a3fb8000000000000000000000000
06083a00c8001c9dfe000001c800000106080300c8101c9d00020000c8000001
00003f0000000000000000000000000004061c00aa0c1c9ec8000001c8000001
08023a00fe0c1c9dc90c0001c80000011006020054041c9d00020000c8000001
0fd041490000000000000000000000000e860140aa021c9cc8000001c8000001
00000000000000000000000000000000037e4180fe0c1c9dc8000001c8000001
10043a00aa0c1c9cfe0c0001c800000102000500c8001c9dc8000001c8000001
10001706c8101c9dc8000001c80000010e860200fe080015c8020001c8000001
0000000000000000000000000000000010860440c90c1c9dc802000155100001
00000000000000000000000000004049108a094001141c9cc90c0001c8000001
028a0840c9141c9dff0c0001c800000110802340c9141c9dc8000001c8000001
02820d0054001c9d00020000c800000100000000000000000000000000000000
0880024001041c9cfe000001c800000102822240c9141c9dc8000001c8000001
0e8a0240c9081c9dc8020001c800000100000000000000000000000000000000
18020100c8041c9dc8000001c800000182081704c8011c9dc8000001c8003fe1
0e860240c90c1c9d00100000c800000110862340ff141c9dc8000001c8000001
10803a40c9001c9dc9040001c800000108840240ff0c1c9dff000001c8000001
02020300ff081c9d00020000c8000001eb853f11000000000000000000000000
10003a00c9081c9dc8045001c800000102040200c8081c9d55080001c8000001
02040400c8081c9d00020000fe00000366663ee6000000000000000000000000
10800900c9101c9daa020000c800000100000000000000000000000000000000
0200170800001c9cc8000001c80000010e820240c9141c9dff000001c8000001
1082030000081c9c00020000c800000100003f80000000000000000000000000
1080024055001c9d00000000c80000010e800240c9041c9dff040001c8000001
0e800440c90c1c9dc8020001c900000100000000000000000000000000000000
10800240c9001c9d01180000c80000010e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_Color]
Vector 7 [AnisoSpecular]
Float 8 [orenNayar]
Float 9 [_AnizoX]
Float 10 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"ps_3_0
; 158 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c11, 0.00000000, 1.00000000, 0.50000000, 0.25000000
def c12, 2.00000000, -1.00000000, 0.56999999, 0.09000000
def c13, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c14, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c15, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c16, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c12.x, c12.y
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c11.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c11.xxyw
mad_pp r0.xyz, r1.yzxw, c11.xyxw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c10.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c9.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c11.y
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c15
pow r0, c16.x, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c9.x
rcp_pp r0.z, r0.z
mul r0.y, c10.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c15.z
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c11, c11.y
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c7.xxyz
cmp r0.yzw, -r2.w, c11.x, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c11.y
mad_pp r1.z, r1.y, c13.x, c13.y
mad_pp r1.z, r1, r1.y, c13
rsq_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c13.w
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c11.x, c11
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c12.x, r1
add_pp r2.z, -r2.x, c11.y
mad_pp r2.y, r2.x, c13.x, c13
mad_pp r2.y, r2, r2.x, c13.z
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c14.x, r1.z
mad_pp r2.x, r2.y, r2, c13.w
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c11, c11.y
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c12.x, r2.y
mad_pp r2.x, r2, c14, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c8.x, c8.x
add r1.z, r0.w, c12.w
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c14, c14.z
frc_pp r1.y, r1
mad_pp r1.y, r1, c15.x, c15
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c11
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c14, c14.z
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c15.x, c15.y
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
max r2.w, r1, c11.x
rcp r1.w, v4.w
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c12.z
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c14.w
mad r0.w, -r0, c11.z, r1.y
mul_pp r1.xyz, r0, c1
texld r0.xyz, v0, s1
mul_pp r2.xyz, r0, c6
mad r0.xyz, v4, r1.w, c5
mul_pp r2.xyz, r2, c1
add r0.w, r0, c11.y
mul_pp r2.xyz, r2, r2.w
mad_pp r2.xyz, r2, r0.w, r1
mad r1.xyz, v4, r1.w, c3
texld r0.x, r0, s5
mov_pp r0.w, r0.x
mad r0.xyz, v4, r1.w, c4
texld r0.x, r0, s5
texld r1.x, r1, s5
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v4, r1.w, c2
mov r0.x, c0
add r1.w, c11.y, -r0.x
texld r0.x, r1, s5
mad r0, r0, r1.w, c0.x
dp4_pp r0.z, r0, c11.w
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c11.z
dp3 r0.x, v3, v3
texld r0.w, r1, s3
cmp r0.y, -v3.z, c11.x, c11
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c12.x
mov_pp oC0.w, c11.x
"
}

SubProgram "ps3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_LightShadowData]
Vector 1 [_LightColor0]
Vector 2 [_ShadowOffsets0]
Vector 3 [_ShadowOffsets1]
Vector 4 [_ShadowOffsets2]
Vector 5 [_ShadowOffsets3]
Vector 6 [_Color]
Vector 7 [AnisoSpecular]
Float 8 [orenNayar]
Float 9 [_AnizoX]
Float 10 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_ShadowMapTexture] 2D
"sce_fp_rsx // 169 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
11
_LightShadowData 2 0
000006d0000006b0
_LightColor0 2 0
00000a5000000950
_ShadowOffsets[0] 1 0
00000660
_ShadowOffsets[1] 1 0
00000620
_ShadowOffsets[2] 1 0
000005e0
_ShadowOffsets[3] 1 0
000005b0
_Color 1 0
000003d0
AnisoSpecular 1 0
000008e0
orenNayar 1 0
000001b0
_AnizoX 1 0
00000040
_AnizoY 1 0
00000460
[Microcode]
2704
940017005c011c9dc8000001c8003fe106800440ce001c9daa02000054020001
00000000000040000000bf80000000000892014000021c9cc8000001c8000001
00000000000000000000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e843940c9041c9dc8000029c800000108803b40c9003c9d55000001c8000001
0e8c3940c9001c9dc8000029c8000001108c0540c9181c9dc9080001c8000001
ce8e3940c8011c9dc8000029c800bfe110840540c9181c9dc91c0001c8000001
0e000200a5181c9fa0020000c80000010000000000003f800000000000000000
0e860440c9181c9fff080001c91c000110860340c9083c9f00020000c8000001
00003f800000000000000000000000000e880440c9181c9fff180001c9080001
108e0540c90c1c9dc9100001c800000108861b40ff0c1c9dc8000001c8000001
0e00040093181c9db2020001c8000001000000000000000000003f8000000000
1086024000021c9c00020000c800000100000000000000000000000000000000
10000500c8001c9dc8000001c800000108020300ff0c1c9d00020000c8000001
51ec3db80000000000000000000000000e043b00c8001c9dfe000001c8000001
10040900c91c1c9d00020000c800000100000000000000000000000000000000
02920a40ff081c9d00020000c800000100000000000000000000000000000000
02003a00ff0c1c9d54040001c8000001108e0440c9083c9d00020000aa020000
6000bc9920003d98000000000000000002820340ff183c9f00020000c8000001
00003f8000000000000000000000000010800440c9183c9daa02000054020001
000000006000bc9920003d980000000002860440ff183c9dff00000100020000
4000be5900000000000000000000000004861b40c9041c9dc8000001c8000001
1004020000001c9cc8080001c80000011e7e7d00c8001c9dc8000001c8000001
02860440ff183c9dc90c00010002000000003fc9000000000000000000000000
04903a40010c1c9cab0c0000c800000110900440c9083c9dc91c000100020000
4000be5900000000000000000000000002800440ff083c9dff20000100020000
00003fc900000000000000000000000010923a4001001c9c550c0001c8000001
02900240c9241c9dff241001c800000110900a40c9181c9d00020000c8000001
000000000000000000000000000000008e001702c8011c9dc8000001c8003fe1
0e860240c8001c9dc8020001c800000100000000000000000000000000000000
0e000200a5181c9d92080001c80000010e00040093181c9da4080001c8000003
1e7e7d00c8001c9dc8000001c8000001108c0240c9201c9dab201000c8000001
02900340ff241c9dc9200003c800000102900440c9241c9daa020000c9200001
000000000000404900000000000000001092014000021c9cc8000001c8000001
0000000000000000000000000000000008820500c9081c9dc8000001c8000001
02000500c8001c9dc8000001c800000108800500c9081c9dc8080001c8000001
048a8540c9181c9dc91c0001c8000001028a3b0055041c9dc8000001c8000001
108c0100c9181c9dc8000001c8000001108e0340ab201c9cc9180003c8000001
060403005d241c9d00020000c8000001c5ac3727000000000000000000000000
10803a4001141c9caa080000c8000001028a8540c9181c9dc9080001c8000001
0e063a01c8011c9dfe010001c800bfe104800140ff001c9dc8000001c8000001
1000030001141c9c00020000c800000100003f80000000000000000000000000
02803a4055001c9dc8080001c8000001088e024001141c9cab140000c8000001
02003800c9001c9dc9000001c800000104023a0000001c9cfe000001c8000001
0e000300c80c1c9dc8020001c800000100000000000000000000000000000000
0200170ac8001c9dc8000001c80000011c000300200c1c9d20020001c8000001
000000000000000000000000000000000202170af2001c9dc8000001c8000001
0892014000041c9cc8000001c80000011c000300200c1c9d20020001c8000001
000000000000000000000000000000001092014000001c9cc8000001c8000001
0202170af2001c9dc8000001c80000010e000300c80c1c9dc8020001c8000001
000000000000000000000000000000000200170ac8001c9dc8000001c8000001
0492014000041c9cc8000001c800000102920140c8001c9dc8000001c8000001
1e000400c9241c9d00020002c924000100000000000000000000000000000000
1e000300c8001c9d00020000c800000100000000000000000000000000000000
02820600c8001c9d00020000c800000100003e80000000000000000000000000
f6000100c8011c9dc8000001c8003fe11008020000081c9caa080000c8000001
06003a00c8001c9dfe000001c80000011088090001141c9c00020000c8000001
0000000000000000000000000000000006000300c8001c9d00020000c8000001
00003f0000000000000000000000000010001706c8001c9dc8000001c8000001
ee060100c8011c9dc8000001c8003fe110800440c9201c9d00020000c91c0001
000040490000000000000000000000000482084001201c9cff000001c8000001
02801b40551c1c9dc8000001c800000104080500c80c1c9dc80c0001c8000001
02003a00fe101c9dc9000001c80000011008020000001c9c00020000c8000001
0fd0414900000000000000000000000002000200aa041c9caa021000c8000001
00000000aa3a3fb80000000000000000028c0d00540c1c9d00020000c8000001
00000000000000000000000000000000037e4180fe101c9dc8000001c8000001
02001c00c8001c9fc8000001c800000102003a00c8001c9dfe100001c8000001
1084094001201c9cc9000001c800000110842340ff081c9dc8000001c8000001
0880024001181c9cfe000001c80000010e92014000021c9cc8000001c8000001
000000000000000000000000000000000e92020000000014c8020001c8000001
0000000000000000000000000000000010802340ab041c9cc8000001c8000001
82001704c8011c9dc8000001c8003fe10e840240c9241c9d00000000c8000001
04822240ab041c9cc8000001c800000102001708aa101c9cc8000001c8000001
0e880240c90c1c9dc8020001c800000100000000000000000000000000000000
02863a40ff001c9dab040000c8000001048a0240ff081c9d010c0000c8000001
08020300ff0c1c9d00020000c8000001eb853f11000000000000000000000000
10063a00c90c1c9d54045001c800000102060200fe081c9dab140000c8000001
02060400c80c1c9d00020000fe0c000366663ee6000000000000000000000000
10840300000c1c9c00020000c800000100003f80000000000000000000000000
0e860240c9101c9dff100001c80000010e860240c90c1c9dff080001c8000001
1080024055001c9d00000000c800000110800240c9001c9d01040000c8000001
0e800440c9081c9dc8020001c90c000100000000000000000000000000000000
0e800240ff001c9dc9001001c80000011081014000021c9cc8000001c8000001
00000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"ps_3_0
; 157 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
def c8, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c9, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c10, 0.25000000, 2.00000000, -1.00000000, 0.00000000
def c11, 0.56999999, 0.09000000, 0.00000000, 1.00000000
def c12, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c13, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c14, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c15, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c10.y, c10.z
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c8.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c11.zzww
mad_pp r0.xyz, r1.yzxw, c11.zwzw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r2, r0
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c7.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c6.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
dp3_pp_sat r1.w, r1, r2
add r0.z, r1.w, c8.w
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul_pp r3.w, r1, r0.x
mul r2.w, r0.y, c14
pow r0, c15.x, r2.w
rsq_pp r0.z, r3.w
mov r0.y, c6.x
rcp_pp r0.z, r0.z
mul r0.y, c7.x, r0
mul r0.y, r0, r0.z
mul r0.y, r0, c14.z
mov r0.w, r0.x
abs r0.x, r0.y
rcp r0.z, r0.y
cmp r0.x, -r0, c11.z, c11.w
abs_pp r2.w, r0.x
mul r0.y, r0.w, r0.z
mul r0.yzw, r0.y, c4.xxyz
cmp r0.yzw, -r2.w, c10.w, r0
dp3_pp r2.w, r1, r2
texld r0.x, v0, s2
mul_pp r0.xyz, r0.yzww, r0.x
mad_pp r2.xyz, -r1, r2.w, r2
dp3_pp r0.w, r1, r3
mad_pp r1.xyz, -r1, r0.w, r3
dp3_pp r1.x, r1, r2
abs_pp r1.y, r2.w
add_pp r2.x, -r1.y, c8.w
mad_pp r1.z, r1.y, c12.x, c12.y
mad_pp r1.z, r1, r1.y, c12
rsq_pp r2.x, r2.x
mad_pp r1.y, r1.z, r1, c12.w
rcp_pp r2.x, r2.x
mul_pp r1.z, r1.y, r2.x
abs_pp r2.x, r0.w
cmp_pp r1.y, r2.w, c11.z, c11.w
mul_pp r2.y, r1, r1.z
mad_pp r1.z, -r2.y, c10.y, r1
add_pp r2.z, -r2.x, c8.w
mad_pp r2.y, r2.x, c12.x, c12
mad_pp r2.y, r2, r2.x, c12.z
rsq_pp r2.z, r2.z
mad_pp r1.y, r1, c13.x, r1.z
mad_pp r2.x, r2.y, r2, c12.w
rcp_pp r2.z, r2.z
mul_pp r2.y, r2.x, r2.z
cmp_pp r2.x, r0.w, c11.z, c11.w
mul_pp r0.w, r2.x, r2.y
mad_pp r1.z, -r0.w, c10.y, r2.y
mad_pp r2.x, r2, c13, r1.z
min_pp r2.y, r2.x, r1
mul_pp r0.w, c5.x, c5.x
add r1.z, r0.w, c11.y
max_pp r1.y, r2.x, r1
rcp r1.z, r1.z
mad_pp r1.y, r1, c13, c13.z
frc_pp r1.y, r1
mad_pp r1.y, r1, c14.x, c14
sincos_pp r3.xy, r1.y
mul r1.z, r0.w, r1
max r1.x, r1, c10.w
mul r1.x, r1.z, r1
mad_pp r2.y, r2, c13, c13.z
frc_pp r1.z, r2.y
mad_pp r1.z, r1, c14.x, c14.y
sincos_pp r2.xy, r1.z
rcp_pp r1.z, r2.x
mul_pp r1.y, r2, r1.z
mul_pp r1.z, r3.y, r1.y
add r1.y, r0.w, c11.x
mul r1.z, r1.x, r1
rcp r1.x, r1.y
mul r0.w, r0, r1.x
mul r1.y, r1.z, c13.w
mad r0.w, -r0, c13.z, r1.y
mul_pp r1.xyz, r0, c2
add r2.w, r0, c8
texld r0.xyz, v0, s1
mul_pp r2.xyz, r0, c3
max r0.w, r1, c10
mul_pp r2.xyz, r2, c2
mul_pp r2.xyz, r2, r0.w
mad_pp r2.xyz, r2, r2.w, r1
add r0.xyz, v4, c8.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c9
add r0.xyz, v4, c8.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c9
add r1.xyz, v4, c8.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c9
add r0.xyz, v4, c8.x
texld r0, r0, s3
dp3 r1.x, v4, v4
rsq r1.x, r1.x
dp4 r3.x, r0, c9
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c8.z, r3
mov r1.x, c1
cmp r1, r0, c8.w, r1.x
dp3 r0.x, v3, v3
dp4_pp r0.y, r1, c10.x
texld r0.x, r0.x, s4
mul r0.x, r0, r0.y
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "ps3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] 2D
"sce_fp_rsx // 172 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
8
_LightPositionRange 1 0
00000860
_LightShadowData 1 0
00000930
_LightColor0 2 0
00000a8000000440
_Color 1 0
00000400
AnisoSpecular 1 0
00000780
orenNayar 1 0
000001e0
_AnizoX 1 0
000004f0
_AnizoY 1 0
000005f0
[Microcode]
2752
940017005c011c9dc8000001c8003fe106800440ce001c9d00020000aa020000
000040000000bf800000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
0e843940c9041c9dc8000029c800000108803b40c9003c9d55000001c8000001
0e803940c9001c9dc8000029c800000110820540c9001c9dc9080001c8000001
0e040200a5001c9fa0020000c80000010000000000003f800000000000000000
0e06040093001c9d08020000c80800010000000000003f800000000000000000
ce863940c8011c9dc8000029c800bfe110840540c9001c9dc90c0001c8000001
10900a40c9041c9d00020000c800000100000000000000000000000000000000
0e820440c9001c9fff080001c90c000110800340c9083c9f00020000c8000001
00003f8000000000000000000000000002868540c9001c9dc90c0001c8000001
0e880440c9001c9fff040001c908000102820540c9041c9dc9100001c8000001
02040500c80c1c9dc80c0001c800000110861b40ff001c9dc8000001c8000001
1e7e7d00c8001c9dc8000001c80000011080024000021c9c00020000c8000001
000000000000000000000000000000000e043b00c80c1c9dc8080001c8000001
04820340ff043c9f00020000c800000100003f80000000000000000000000000
10040300c9001c9daa020000c80000010000000051ec3db80000000000000000
02083a00ff001c9dfe080001c80000011008090001041c9c00020000c8000001
00000000000000000000000000000000108a0440c9043c9d00020000aa020000
6000bc9920003d98000000000000000002820440ff043c9dff14000100020000
4000be5900000000000000000000000004821b40ab041c9cc8000001c8000001
02820440ff043c9dc90400010002000000003fc9000000000000000000000000
08820440ff083c9daa020000c8020001000000006000bc9920003d9800000000
08820440ff083c9dc9040001000200004000be59000000000000000000000000
02823a40c9041c9dab040000c800000104820440ff083c9d5504000100020000
00003fc900000000000000000000000008903a40ab041c9cff0c0001c8000001
06020100c8041c9dc8000001c80000011008020000101c9cc8100001c8000001
02900a40ff081c9d00020000c800000100000000000000000000000000000000
02920240c9201c9d55201001c800000110820240c9201c9d01041000c8000001
0490034001041c9cff040003c80000018e061702c8011c9dc8000001c8003fe1
0292034055201c9dc9240003c80000010e820240c80c1c9dc8020001c8000001
000000000000000000000000000000001084044001201c9cc802000101240000
000000000000000000000000000040490e820240c9041c9dc8020001c8000001
000000000000000000000000000000000e060200a5001c9d92080001c8000001
0e06040093001c9da4080001c80c000310820500c9081c9dc80c0001c8000001
02060500c80c1c9dc80c0001c8000001088c0500c9081c9dc8080001c8000001
0e040101c8011c9dc8000001c8003fe10e040300c8081c9d28020000c8000001
00003c000000bc000000000000000000108c3b00c9041c9dc80c0001c8000001
028c014000021c9cc8000001c800000100000000000000000000000000000000
10860440c9201c9d00020000ab20000000004049000000000000000000000000
1e041706c8081c9dc8000001c800000110060600c8081c9dc8020001c8000001
00003f8080813b8001823781f88c31d510820840c9081c9dc90c0001c8000001
08808540c9001c9dc9080001c8000001048c2340ff041c9dc8000001c8000001
0280024055001c9dc90c0001c800000102801b40c9001c9dc8000001c8000001
0e84014000021c9cc8000001c800000100000000000000000000000000000000
10822240ff041c9dc8000001c800000110823a40ab181c9cff040001c8000001
048c014000021c9cc8000001c800000100000000000000000000000000000000
0a060300a1181c9c00020000c8000001c5ac3727000000000000000000000000
10040200000c1c9c540c0001c80000010e080101c8011c9dc8000001c8003fe1
02043a00fe081c9dc9000001c80000011004030055001c9d00020000c8000001
00003f8000000000000000000000000010840940c9081c9dc90c0001c8000001
02040200c8081c9d00020000c80000010fd04149000000000000000000000000
08883a40c9181c9dc80c0001c800000106020100c8041c9dc8000001c8000001
08020500c8101c9dc8100001c800000110842340ff081c9dc8000001c8000001
10883a40c9181c9d540c0001c8000001020038005d101c9d5d100001c8000001
10043a0000001c9cfe080001c8000001037e4180c8081c9dc8000001c8000001
10040200c8081c9d00021000c8000001aa3a3fb8000000000000000000000000
08021b0054041c9dc8000001c800000102001c00fe081c9fc8000001c8000001
10043a0000001c9cc8080001c80000010e840200fe080015c8020001c8000001
0000000000000000000000000000000082001704c8011c9dc8000001c8003fe1
0e040300c8101c9d08020000c80000010000bc0000003c000000000000000000
1e041706c8081c9dc8000001c800000108060600c8081c9dc8020001c8000001
00003f8080813b8001823781f88c31d50e840240c9081c9d00000000c8000001
0e040300c8101c9da0020000c80000010000bc0000003c000000000000000000
1e041706c8081c9dc8000001c800000104060600c8081c9dc8020001c8000001
00003f8080813b8001823781f88c31d508023a00fe021c9d54040001c8000001
000000000000000000000000000000000e040300c8101c9d00020000c8000001
00003c000000000000000000000000001e041706c8081c9dc8000001c8000001
02060600c8081c9dc8020001c800000100003f8080813b8001823781f88c31d5
ee040100c8011c9dc8000001c8003fe102000500c8081c9dc8080001c8000001
08020200c8041c9d00020000c800000151ec3f78000000000000000000000000
0200170800001c9cc8000001c80000011f7e4a00c80c1c9d54040001c8000001
1e04010000021c9cc8000001c800000100000000000000000000000000000000
1e04010000021c88c8000001c800000100003f80000000000000000000000000
08020600c8081c9d00020000c800000100003e80000000000000000000000000
1e7e7d00c8001c9dc8000001c800000102880240ff081c9dff040001c8000001
02040200fe101c9dc9100001c800000110080300c9001c9d00020000c8000001
eb853f1100000000000000000000000010043a00c9001c9dfe105001c8000001
02040400c8081c9d00020000fe08000366663ee6000000000000000000000000
1080090055001c9daa020000c800000100000000000000000000000000000000
0e820240c9041c9dff000001c80000011080030000081c9c00020000c8000001
00003f800000000000000000000000000e820240c9041c9dff000001c8000001
1080020000001c9c54040001c80000010e800440c9081c9dc8020001c9040001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_3_0
; 157 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_2d s4
dcl_cube s5
def c8, 0.00781250, -0.00781250, 0.97000003, 1.00000000
def c9, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c10, 0.25000000, 2.00000000, -1.00000000, 0.00000000
def c11, 0.56999999, 0.09000000, 0.00000000, 1.00000000
def c12, -0.01872253, 0.07427979, -0.21215820, 1.57031250
def c13, 3.14062500, 0.15917969, 0.50000000, 0.44999999
def c14, 6.28125000, -3.14062500, 12.56636047, -2.00000000
def c15, 2.71828198, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s0
mad_pp r0.xy, r0.wyzw, c10.y, c10.z
mul_pp r0.z, r0.y, r0.y
mad_pp r0.z, -r0.x, r0.x, -r0
add_pp r0.z, r0, c8.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mul_pp r0.xyz, -r1.zxyw, c11.zzww
mad_pp r0.xyz, r1.yzxw, c11.zwzw, r0
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.zxyw, r0.yzxw
mad_pp r3.xyz, r1.yzxw, r0.zxyw, -r2
dp3_pp r1.w, r3, r3
rsq_pp r1.w, r1.w
mul_pp r3.xyz, r1.w, r3
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp_sat r2.w, r1, r2
dp3_pp r0.x, r2, r0
add r0.z, r2.w, c8.w
dp3_pp r0.w, r2, r3
rcp_pp r1.w, c7.x
mul_pp r0.w, r0, r1
mul r1.w, r0, r0
rcp_pp r0.w, c6.x
mul_pp r0.x, r0, r0.w
mad r0.y, r0.x, r0.x, r1.w
rcp r0.z, r0.z
mul r0.y, r0, r0.z
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r3.xyz, r0.x, v2
dp3_pp_sat r0.x, r1, r3
mul r3.w, r0.y, c14
mul_pp r0.x, r2.w, r0
rsq_pp r0.y, r0.x
mov r0.x, c6
rcp_pp r0.y, r0.y
mul r0.x, c7, r0
mul r1.w, r0.x, r0.y
pow r0, c15.x, r3.w
mul r0.w, r1, c14.z
rcp r0.y, r0.w
abs r0.w, r0
cmp r1.w, -r0, c11.z, c11
dp3_pp r3.w, r1, r2
mul r0.x, r0, r0.y
abs_pp r0.w, r3
mul r0.xyz, r0.x, c4
abs_pp r1.w, r1
cmp r4.xyz, -r1.w, c10.w, r0
add_pp r0.y, -r0.w, c8.w
mad_pp r0.x, r0.w, c12, c12.y
mad_pp r0.x, r0, r0.w, c12.z
rsq_pp r0.y, r0.y
dp3_pp r1.w, r1, r3
mad_pp r0.x, r0, r0.w, c12.w
abs_pp r0.w, r1
add_pp r5.x, -r0.w, c8.w
mad_pp r4.w, r0, c12.x, c12.y
mad_pp r4.w, r4, r0, c12.z
mad_pp r0.w, r4, r0, c12
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.x, r0
cmp_pp r0.x, r3.w, c11.z, c11.w
mul_pp r0.z, r0.x, r0.y
rsq_pp r5.x, r5.x
rcp_pp r5.x, r5.x
mul_pp r0.w, r0, r5.x
cmp_pp r4.w, r1, c11.z, c11
mul_pp r5.x, r4.w, r0.w
mad_pp r0.z, -r0, c10.y, r0.y
mad_pp r0.y, -r5.x, c10, r0.w
mad_pp r0.w, r0.x, c13.x, r0.z
mad_pp r4.w, r4, c13.x, r0.y
texld r0.x, v0, s2
mul_pp r0.xyz, r4, r0.x
min_pp r5.x, r4.w, r0.w
mad_pp r4.x, r5, c13.y, c13.z
mul_pp r5.xyz, r0, c2
frc_pp r0.y, r4.x
max_pp r0.x, r4.w, r0.w
mad_pp r4.y, r0, c14.x, c14
mad_pp r4.x, r0, c13.y, c13.z
sincos_pp r0.xy, r4.y
frc_pp r0.z, r4.x
mad_pp r0.z, r0, c14.x, c14.y
sincos_pp r4.xy, r0.z
rcp_pp r0.x, r0.x
mul_pp r0.w, c5.x, c5.x
mul_pp r0.x, r0.y, r0
mul_pp r4.x, r4.y, r0
mad_pp r0.xyz, -r1, r3.w, r2
mad_pp r1.xyz, -r1, r1.w, r3
dp3_pp r0.y, r1, r0
add r1.w, r0, c11.y
rcp r0.x, r1.w
max r0.y, r0, c10.w
mul r0.x, r0.w, r0
mul r0.x, r0, r0.y
mul r0.y, r0.x, r4.x
add r0.x, r0.w, c11
rcp r1.x, r0.x
mul r1.y, r0, c13.w
mul r0.w, r0, r1.x
mad r1.x, -r0.w, c13.z, r1.y
add r2.x, r1, c8.w
add r0.xyz, v4, c8.xyyw
texld r0, r0, s3
dp4 r3.w, r0, c9
add r0.xyz, v4, c8.yxyw
texld r0, r0, s3
dp4 r3.z, r0, c9
add r1.xyz, v4, c8.yyxw
texld r1, r1, s3
dp4 r3.y, r1, c9
dp3 r0.w, v4, v4
rsq r1.x, r0.w
add r0.xyz, v4, c8.x
texld r0, r0, s3
rcp r1.x, r1.x
dp4 r3.x, r0, c9
mul r0.x, r1, c0.w
texld r1.xyz, v0, s1
mul_pp r1.xyz, r1, c3
mov r1.w, c1.x
mad r0, -r0.x, c8.z, r3
cmp r0, r0, c8.w, r1.w
dp4_pp r0.y, r0, c10.x
dp3 r0.x, v3, v3
max r1.w, r2, c10
mul_pp r1.xyz, r1, c2
mul_pp r1.xyz, r1, r1.w
mad_pp r1.xyz, r1, r2.x, r5
texld r0.w, v3, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul r0.x, r0, r0.y
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "ps3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightShadowData]
Vector 2 [_LightColor0]
Vector 3 [_Color]
Vector 4 [AnisoSpecular]
Float 5 [orenNayar]
Float 6 [_AnizoX]
Float 7 [_AnizoY]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_SpecularMap] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"sce_fp_rsx // 172 instructions using 5 registers
[Configuration]
24
ffffffff0007c020001fffe0000000000000840005000000
[Offsets]
8
_LightPositionRange 1 0
000008f0
_LightShadowData 1 0
00000940
_LightColor0 2 0
00000a8000000790
_Color 1 0
000003f0
AnisoSpecular 1 0
00000730
orenNayar 1 0
000001f0
_AnizoX 1 0
000004f0
_AnizoY 1 0
00000550
[Microcode]
2752
940017005c011c9dc8000001c8003fe106800440ce001c9d00020000aa020000
000040000000bf800000000000000000ae823940c8011c9dc8000029c800bfe1
08800240ab001c9cab000000c80000010880044001001c9e01000000c9000003
08800340c9001c9d00020000c800000100003f80000000000000000000000000
08803b40c9003c9d55000001c80000010e823940c9041c9dc8000029c8000001
0e803940c9001c9dc8000029c800000110860540c9001c9dc9040001c8000001
0e040200a5001c9fa0020000c80000010000000000003f800000000000000000
0e06040093001c9d08020000c80800010000000000003f800000000000000000
ce863940c8011c9dc8000029c800bfe110800540c9001c9dc90c0001c8000001
0e840440c9001c9fff000001c90c000110840340c9003c9f00020000c8000001
00003f8000000000000000000000000002900a40ff001c9d00020000c8000001
0000000000000000000000000000000010900a40c90c1c9d00020000c8000001
000000000000000000000000000000000e880440c9001c9fff0c0001c9040001
02840540c9081c9dc9100001c800000110821b40ff081c9dc8000001c8000001
04020500c80c1c9dc80c0001c80000010e043b00c80c1c9daa040000c8000001
1084024000021c9c00020000c800000100000000000000000000000000000000
10040300c9081c9d00020000c800000151ec3db8000000000000000000000000
04840340ff0c3c9faa020000c80000010000000000003f800000000000000000
02063a00ff081c9dfe080001c80000011006090001081c9c00020000c8000001
00000000000000000000000000000000108a0440c90c3c9d00020000aa020000
6000bc9920003d98000000000000000002840440ff0c3c9dff14000100020000
4000be5900000000000000000000000004841b40ab081c9cc8000001c8000001
02840440ff0c3c9dc90800010002000000003fc9000000000000000000000000
08840440ff003c9daa020000c8020001000000006000bc9920003d9800000000
08840440ff003c9dc9080001000200004000be59000000000000000000000000
02843a40c9081c9dab080000c800000104840440ff003c9d5508000100020000
00003fc900000000000000000000000010923a40ab081c9cff040001c8000001
10060200000c1c9cc80c0001c800000102920240c9201c9dff241001c8000001
02920340ff241c9dc9240003c800000110900100c9201c9dc8000001c8000001
10800240c9201c9d01081000c80000010490034001081c9cff000003c8000001
10820500c9041c9dc8080001c80000018e061702c8011c9dc8000001c8003fe1
0e840240c80c1c9dc8020001c800000100000000000000000000000000000000
0e060200a5001c9d92080001c80000010e06040093001c9da4080001c80c0003
0e040101c8011c9dc8000001c8003fe10e040300c8081c9d28020000c8000001
00003c000000bc0000000000000000001e041706c8081c9dc8000001c8000001
10040600c8081c9dc8020001c800000100003f8080813b8001823781f88c31d5
10800500c9041c9dc80c0001c800000102880440ff201c9d00020000ab200000
000040490000000000000000000000001088044001201c9c0002000001240000
0000404900000000000000000000000010920840c9101c9d01100000c8000001
0290014000021c9cc8000001c800000100000000000000000000000000000000
04902340ff241c9dc8000001c800000110908540c9001c9dc90c0001c8000001
02862240ff241c9dc8000001c800000110863a40ab201c9cc90c0001c8000001
0490014000021c9cc8000001c800000100000000000000000000000000000000
1808030081201c9c00020000c8000001c5ac3727000000000000000000000000
08903a40ff041c9d54100001c800000102060500c80c1c9dc80c0001c8000001
10803b00c9001c9dc80c0001c800000102908540c9001c9dc9040001c8000001
1000020054101c9dc8100001c800000102800240c9201c9dff200001c8000001
10803a40c9001c9dfe100001c800000110900140c9001c9dc8000001c8000001
02801b40c9001c9dc8000001c8000001040038005d201c9d5d200001c8000001
10900940c9101c9d01100000c800000102003a00fe001c9dc9000001c8000001
1000030001201c9c00020000c800000100003f80000000000000000000000000
02000200c8001c9daa020000c8000001000000000fd041490000000000000000
10003a00aa001c9cfe000001c8000001037e4180c8001c9dc8000001c8000001
04902340ff201c9dc8000001c80000010e060101c8011c9dc8000001c8003fe1
10000200c8001c9d00021000c8000001aa3a3fb8000000000000000000000000
04001c00fe001c9fc8000001c80000010e82014000021c9cc8000001c8000001
0000000000000000000000000000000010083a00aa001c9cc8000001c8000001
0e820200fe100015c8020001c800000100000000000000000000000000000000
82001704c8011c9dc8000001c8003fe10e860240c9041c9d00000000c8000001
0e000300c80c1c9d08020000c80000010000bc0000003c000000000000000000
0e920240c9081c9dc8020001c800000100000000000000000000000000000000
1e001706c8001c9dc8000001c800000108040600c8001c9dc8020001c8000001
00003f8080813b8001823781f88c31d50e000300c80c1c9da0020000c8000001
0000bc0000003c0000000000000000001e001706c8001c9dc8000001c8000001
04040600c8001c9dc8020001c800000100003f8080813b8001823781f88c31d5
0e000300c80c1c9d00020000c800000100003c00000000000000000000000000
1e001706c8001c9dc8000001c800000102040600c8001c9dc8020001c8000001
00003f8080813b8001823781f88c31d5ee000100c8011c9dc8000001c8003fe1
10000500c80c1c9dc80c0001c800000102000500c8001c9dc8000001c8000001
04001b00fe001c9dc8000001c8000001028c0240ab201c9cff0c0001c8000001
f000170ac8011c9dc8000001c8003fe104080200fe0c1c9d01180000c8000001
04003a00fe021c9daa000000c800000100000000000000000000000000000000
04000200c8001c9d00020000c800000151ec3f78000000000000000000000000
1f7e4a00c8081c9daa000000c80000011e04010000021c9cc8000001c8000001
000000000000000000000000000000001e04010000021c88c8000001c8000001
00003f8000000000000000000000000004000600c8081c9d00020000c8000001
00003e800000000000000000000000000200170800001c9cc8000001c8000001
10060300c9081c9d00020000c8000001eb853f11000000000000000000000000
10043a00c9081c9dfe0c5001c800000104080400c8101c9d00020000fe080003
66663ee60000000000000000000000001088090001201c9caa020000c8000001
000000000000000000000000000000000e840240c9241c9dff100001c8000001
10840300aa101c9c00020000c800000100003f80000000000000000000000000
0e840240c9081c9dff080001c800000102000200c8001c9daa000000c8000001
1080020000001c9cc8000001c80000010e800440c90c1c9dc8020001c9080001
000000000000000000000000000000000e800240ff001c9dc9001001c8000001
1081014000021c9cc8000001c800000100000000000000000000000000000000
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}

}
	}

#LINE 177

	}
	FallBack "Diffuse"
}
