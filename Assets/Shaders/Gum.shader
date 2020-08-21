// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Gum"
{
	Properties
	{
		_Texture("Texture", 2D) = "white" {}
		_MaxVertexoffset("Max Vertex offset", Range( 0 , 2)) = 0.1120346
		_Smoothrenge("Smooth renge", Range( 0 , 1)) = 0.2324715
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float _MaxVertexoffset;
			uniform float _Smoothrenge;
			uniform float4 _collidedObjects[16];
			uniform sampler2D _Texture;
			uniform float4 _Texture_ST;
			float4 forech111( float4 array , float range , float3 vertPos , int arrayLen )
			{
				 for(int i = 0; i < arrayLen; i++)
				{
				float dis = distance(_collidedObjects[i].xyz, vertPos);	
				if(dis < range)
				{
				return _collidedObjects[i];
				}
				}
				return float4(vertPos,0);
			}
			
			float3 outxyz( float4 xyzw )
			{
				return xyzw.xyz;
			}
			
			float outw108( float4 xyzw )
			{
				return xyzw.w;
			}
			
			float3 HightMul100( float max , float min , float dis , float3 normal )
			{
				if(dis > max)
				{
				return float3(0,0,0);
				}
				if(dis < min)
				{
				return normal;
				}
				float val = (max - dis) / (max - min);
				return lerp(float3(0,0,0), normal, val);
			}
			
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float temp_output_69_0 = ( _MaxVertexoffset + _Smoothrenge );
				float max100 = temp_output_69_0;
				float min100 = _MaxVertexoffset;
				float4 array111 = _collidedObjects[0];
				float range111 = temp_output_69_0;
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 vertPos111 = ase_worldPos;
				int arrayLen111 = 16;
				float4 localforech111 = forech111( array111 , range111 , vertPos111 , arrayLen111 );
				float4 xyzw106 = localforech111;
				float3 localoutxyz106 = outxyz( xyzw106 );
				float dis100 = distance( localoutxyz106 , ase_worldPos );
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				float4 xyzw108 = localforech111;
				float localoutw108 = outw108( xyzw108 );
				float3 normal100 = ( ase_worldNormal * localoutw108 );
				float3 localHightMul100 = HightMul100( max100 , min100 , dis100 , normal100 );
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = localHightMul100;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float2 uv_Texture = i.ase_texcoord.xy * _Texture_ST.xy + _Texture_ST.zw;
				
				
				finalColor = tex2D( _Texture, uv_Texture );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17101
366;662;1553;337;4513.245;757.5754;1.333945;True;True
Node;AmplifyShaderEditor.IntNode;110;-4167.677,-380.8226;Inherit;False;Constant;_Arraylen;Array len;3;0;Create;True;0;0;False;0;16;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-3905.314,-609.1888;Inherit;False;Property;_MaxVertexoffset;Max Vertex offset;1;0;Create;True;0;0;False;0;0.1120346;0.2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-3952.279,-710.6054;Inherit;False;Property;_Smoothrenge;Smooth renge;2;0;Create;True;0;0;False;0;0.2324715;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-3584.771,-737.5159;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;52;-3900.139,15.232;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GlobalArrayNode;104;-3874.127,-501.166;Inherit;False;_collidedObjects;0;16;2;False;False;0;1;False;Object;-1;4;0;INT;0;False;2;INT;0;False;1;INT;0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;111;-3596.867,-334.8274;Inherit;False; for(int i = 0@ i < arrayLen@ i++)${$float dis = distance(_collidedObjects[i].xyz, vertPos)@	$if(dis < range)${$return _collidedObjects[i]@$}$$}$return float4(vertPos,0)@;4;False;4;True;array;FLOAT4;0,0,0,0;In;;Float;False;True;range;FLOAT;0;In;;Float;False;True;vertPos;FLOAT3;0,0,0;In;;Float;False;True;arrayLen;INT;0;In;;Float;False;forech;True;False;0;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;INT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;106;-3290.316,-197.753;Float;False;return xyzw.xyz@;3;False;1;True;xyzw;FLOAT4;0,0,0,0;In;;Float;False;out xyz;False;False;1;-1;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;108;-3288.535,-95.8877;Inherit;False;return xyzw.w@;1;False;1;True;xyzw;FLOAT4;0,0,0,0;In;;Float;False;out w;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;45;-2956.405,462.5495;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;51;-2546.769,113.2363;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2577.416,455.42;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;100;-2174.965,-19.78632;Inherit;False;if(dis > max)${$return float3(0,0,0)@$}$$if(dis < min)${$return normal@$}$float val = (max - dis) / (max - min)@$$return lerp(float3(0,0,0), normal, val)@$$$$$$$$$;3;False;4;True;max;FLOAT;0;In;;Float;False;True;min;FLOAT;0;In;;Float;False;True;dis;FLOAT;0;In;;Float;False;True;normal;FLOAT3;0,0,0;In;;Float;False;Hight Mul;True;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;44;-2251.583,-381.1821;Inherit;True;Property;_Texture;Texture;0;0;Create;True;0;0;False;0;None;34685b7c2d8997347906dccf3f45db7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-1646.173,-48.33809;Float;False;True;2;ASEMaterialInspector;0;1;Gum;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;0
WireConnection;69;0;46;0
WireConnection;69;1;101;0
WireConnection;104;1;110;0
WireConnection;111;0;104;0
WireConnection;111;1;69;0
WireConnection;111;2;52;0
WireConnection;111;3;110;0
WireConnection;106;0;111;0
WireConnection;108;0;111;0
WireConnection;51;0;106;0
WireConnection;51;1;52;0
WireConnection;47;0;45;0
WireConnection;47;1;108;0
WireConnection;100;0;69;0
WireConnection;100;1;46;0
WireConnection;100;2;51;0
WireConnection;100;3;47;0
WireConnection;0;0;44;0
WireConnection;0;1;100;0
ASEEND*/
//CHKSM=0888DF7EE46D8ECE14DC1DB26B969FE4EE8CE35C