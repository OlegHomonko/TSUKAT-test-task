// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Depth test"
{
	Properties
	{
		_Texture("Texture", 2D) = "white" {}
		_MaxVertexoffset("Max Vertex offset", Range( 0 , 2)) = 2
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
			uniform sampler2D _Texture;
			uniform float4 _Texture_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 _Vector0 = float4(-0.38,-0.723,-1.906,0.3);
				float4 appendResult63 = (float4(_Vector0.x , _Vector0.y , _Vector0.z , 0.0));
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float temp_output_51_0 = distance( appendResult63 , float4( ase_worldPos , 0.0 ) );
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				float3 temp_output_47_0 = ( ase_worldNormal * _MaxVertexoffset );
				float3 lerpResult75 = lerp( float3( 0,0,0 ) , temp_output_47_0 , float3( 0,0,0 ));
				float temp_output_69_0 = ( _Vector0.w + ( _Vector0.w / 2.0 ) );
				float3 ifLocalVar50 = 0;
				if( temp_output_51_0 < temp_output_69_0 )
				ifLocalVar50 = temp_output_47_0;
				float3 ifLocalVar74 = 0;
				if( temp_output_51_0 <= _Vector0.w )
				ifLocalVar74 = ifLocalVar50;
				else
				ifLocalVar74 = lerpResult75;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = ifLocalVar74;
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
366;519;1553;480;3228.292;428.4198;1.604023;True;True
Node;AmplifyShaderEditor.Vector4Node;42;-2865.627,-519.1288;Inherit;True;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;-0.38,-0.723,-1.906,0.3;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;63;-3067.695,-254.6261;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldPosInputsNode;52;-3153.359,51.25475;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;70;-2582.486,-357.1034;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;45;-2958.056,273.8728;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;46;-2987.746,481.2609;Inherit;False;Property;_MaxVertexoffset;Max Vertex offset;1;0;Create;True;0;0;False;0;2;0.2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-2417.617,-400.4572;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;51;-2810.062,-184.6305;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2711.689,309.788;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;50;-2379.167,-43.55625;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;75;-2065.129,-219.691;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;78;-2186.36,-327.9909;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;74;-1898.509,-70.16064;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;44;-1518.811,-407.9617;Inherit;True;Property;_Texture;Texture;0;0;Create;True;0;0;False;0;None;34685b7c2d8997347906dccf3f45db7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-1103.135,-129.3885;Float;False;True;2;ASEMaterialInspector;0;1;Depth test;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;0
WireConnection;63;0;42;1
WireConnection;63;1;42;2
WireConnection;63;2;42;3
WireConnection;70;0;42;4
WireConnection;69;0;42;4
WireConnection;69;1;70;0
WireConnection;51;0;63;0
WireConnection;51;1;52;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;50;0;51;0
WireConnection;50;1;69;0
WireConnection;50;4;47;0
WireConnection;75;1;47;0
WireConnection;78;0;69;0
WireConnection;78;1;51;0
WireConnection;74;0;51;0
WireConnection;74;1;42;4
WireConnection;74;2;75;0
WireConnection;74;3;50;0
WireConnection;74;4;50;0
WireConnection;0;0;44;0
WireConnection;0;1;74;0
ASEEND*/
//CHKSM=9B6C0484C85952573B8DF0642DF62093BB037B8B