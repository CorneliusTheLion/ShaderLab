// Made with Amplify Shader Editor v1.9.6.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AmplifyShaderPack/Community/Physical Based Rendering"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 2
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		_AlphaCutoffBiasShadow("Alpha Cutoff Bias Shadow", Range( 0.01 , 1)) = 0.5
		[Header(COLOR)]_BaseColor("Base Color", Color) = (1,1,1)
		_Saturation("Saturation", Range( 0 , 1)) = 0
		_Brightness("Brightness", Range( 0 , 2)) = 1
		[Header(SURFACE INPUTS)][SingleLineTexture]_MainTex("BaseColor Map", 2D) = "white" {}
		[SingleLineTexture]_SpecularMap("Specular Map", 2D) = "white" {}
		_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[Enum(MSO,0,MRO,1)]_MainMaskType("Main Mask Type", Float) = 0
		[SingleLineTexture]_MainMaskMap("Main Mask Map", 2D) = "white" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0.15
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0.5
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[Normal][SingleLineTexture][Space(10)]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		[Header(GEOMETRIC SHADOWING)]_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 0.1
		_ShadowOffset("Shadow Offset", Range( -1 , 1)) = -0.05
		_ShadowFalloff("Shadow Falloff", Range( 1 , 10)) = 1
		[Header(SHADOW COLOR)][ToggleUI][Space(5)]_ShadowColorEnable("Enable Shadow Color", Float) = 0
		[HDR]_ShadowColor("Shadow Color", Color) = (0.3113208,0.3113208,0.3113208,0)
		[HDR][Header(INDIRECT LIGHTING)]_IndirectSpecularColor("Indirect Specular Color", Color) = (1,0.9568627,0.8392157)
		_IndirectSpecular("Indirect Specular ", Range( 0 , 1)) = 0.85
		_IndirectSpecularSmoothness("Indirect Specular Smoothness", Range( 0 , 1)) = 1
		_IndirectDiffuse("Indirect Diffuse", Range( 0 , 1)) = 0


		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Unlit" }

		Cull [_Cull]
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM
            #pragma shader_feature_local _RECEIVE_SHADOWS_OFF
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #define ASE_FOG 1
            #define _ALPHATEST_SHADOW_ON 1
            #define _ALPHATEST_ON 1
            #define ASE_SRP_VERSION 101001

            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS


			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif
				#ifdef ASE_FOG
					float fogFactor : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_color : COLOR;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainUVs;
			float4 _ShadowColor;
			float3 _IndirectSpecularColor;
			half3 _BaseColor;
			int _Cull;
			float _ShadowColorEnable;
			float _ShadowFalloff;
			half _ShadowOffset;
			half _ShadowStrength;
			float _IndirectDiffuse;
			half _SmoothnessStrength;
			float _MetallicStrength;
			half _AlphaCutoffBias;
			half _Brightness;
			float _Saturation;
			half _IndirectSpecular;
			half _OcclusionStrengthAO;
			half _IndirectSpecularSmoothness;
			half _NormalStrength;
			float _MainMaskType;
			half _AlphaCutoffBiasShadow;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _BumpMap;
			sampler2D _MainMaskMap;
			sampler2D _MainTex;
			sampler2D _SpecularMap;


			float3 AdditionalLightsSpecular10x12x( float3 WorldPosition, float3 WorldNormal, float3 WorldView, float3 SpecColor, float Smoothness )
			{
				float3 Color = 0;
				#ifdef _ADDITIONAL_LIGHTS
					Smoothness = exp2(10 * Smoothness + 1);
					uint lightCount = GetAdditionalLightsCount();
					for (uint lightIndex = 0u; lightIndex < lightCount; ++lightIndex)
					{
						Light light = GetAdditionalLight(lightIndex, WorldPosition);
						half3 AttLightColor = light.color *(light.distanceAttenuation * light.shadowAttenuation);
						Color += LightingSpecular(AttLightColor, light.direction, WorldNormal, WorldView, half4(SpecColor, 0), Smoothness);	
					}
				#endif
				return Color;
			}
			
			float3 ASESafeNormalize(float3 inVec)
			{
				float dp3 = max(1.175494351e-38, dot(inVec, inVec));
				return inVec* rsqrt(dp3);
			}
			
			float3 GetMainLightColorNode766_g1( out float3 Color )
			{
				Light light = GetMainLight();
				return Color = light.color;
			}
			
			float3 AdditionalLightsHalfLambert10x( float3 WorldPosition, float3 WorldNormal )
			{
				float3 Color = 0;
				#ifdef _ADDITIONAL_LIGHTS
					uint lightCount = GetAdditionalLightsCount();
					for (uint lightIndex = 0u; lightIndex < lightCount; ++lightIndex)
					{
						Light light = GetAdditionalLight(lightIndex, WorldPosition);
						half3 AttLightColor = light.color *(light.distanceAttenuation * light.shadowAttenuation);
						Color +=(dot(light.direction, WorldNormal)*0.5+0.5 )* AttLightColor;
					}
				#endif
				return Color;
			}
			
			float3 ASEBakedGI( float3 normalWS, float2 uvStaticLightmap, bool applyScaling )
			{
			#ifdef LIGHTMAP_ON
				if( applyScaling )
					uvStaticLightmap = uvStaticLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
				return SampleLightmap( uvStaticLightmap, normalWS );
			#else
				return SampleSH(normalWS);
			#endif
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 vertexToFrag795_g1 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord4.xy = vertexToFrag795_g1;
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord5.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normalOS);
				o.ase_texcoord6.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord7.xyz = ase_worldBitangent;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord4.zw = v.ase_texcoord1.xy;
				o.ase_texcoord8.xy = v.ase_texcoord2.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#ifdef ASE_FOG
					o.fogFactor = ComputeFogFactor( vertexInput.positionCS.z );
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				o.ase_color = v.ase_color;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float3 worldPosValue184_g61277 = WorldPosition;
				float3 WorldPosition156_g61277 = worldPosValue184_g61277;
				float2 vertexToFrag795_g1 = IN.ase_texcoord4.xy;
				float3 unpack12_g1 = UnpackNormalScale( tex2D( _BumpMap, vertexToFrag795_g1 ), _NormalStrength );
				unpack12_g1.z = lerp( 1, unpack12_g1.z, saturate(_NormalStrength) );
				float3 ase_worldTangent = IN.ase_texcoord5.xyz;
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord7.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal1159_g1 = unpack12_g1;
				float3 worldNormal1159_g1 = normalize( float3(dot(tanToWorld0,tanNormal1159_g1), dot(tanToWorld1,tanNormal1159_g1), dot(tanToWorld2,tanNormal1159_g1)) );
				float3 WorldNormalTangent1160_g1 = worldNormal1159_g1;
				float3 worldNormalValue185_g61277 = WorldNormalTangent1160_g1;
				float3 WorldNormal156_g61277 = worldNormalValue185_g61277;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 temp_output_15_0_g61277 = ase_worldViewDir;
				float3 WorldView156_g61277 = temp_output_15_0_g61277;
				float3 temp_output_14_0_g61277 = _IndirectSpecularColor;
				float3 SpecColor156_g61277 = temp_output_14_0_g61277;
				float temp_output_18_0_g61277 = _IndirectSpecularSmoothness;
				float Smoothness156_g61277 = temp_output_18_0_g61277;
				float3 localAdditionalLightsSpecular10x12x156_g61277 = AdditionalLightsSpecular10x12x( WorldPosition156_g61277 , WorldNormal156_g61277 , WorldView156_g61277 , SpecColor156_g61277 , Smoothness156_g61277 );
				float3 temp_output_230_0_g61328 = WorldNormalTangent1160_g1;
				float3 Normal_Space282_g61328 = temp_output_230_0_g61328;
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 normalizeResult447_g61328 = ASESafeNormalize( ( ase_worldViewDir + SafeNormalize(_MainLightPosition.xyz) ) );
				float3 Half_Vector288_g61328 = normalizeResult447_g61328;
				float dotResult178_g61328 = dot( Normal_Space282_g61328 , Half_Vector288_g61328 );
				float _NdotH655_g1 = max( dotResult178_g61328 , 0.0 );
				float3 Color766_g1 = float3( 0,0,0 );
				float3 localGetMainLightColorNode766_g1 = GetMainLightColorNode766_g1( Color766_g1 );
				float3 temp_output_574_0_g1 = ( _IndirectSpecularColor * ( _NdotH655_g1 * Color766_g1 ) * pow( _NdotH655_g1 , exp2( (_IndirectSpecularSmoothness*10.0 + 1.0) ) ) );
				float3 temp_output_575_0_g1 = ( localAdditionalLightsSpecular10x12x156_g61277 + temp_output_574_0_g1 );
				float3 temp_cast_1 = (1.0).xxx;
				float4 tex2DNode473_g1 = tex2D( _MainMaskMap, vertexToFrag795_g1 );
				float lerpResult428_g1 = lerp( 1.0 , min( tex2DNode473_g1.b , IN.ase_color.a ) , ( 1.0 - _OcclusionStrengthAO ));
				float Occlusion435_g1 = saturate( lerpResult428_g1 );
				half3 reflectVector647_g1 = reflect( -ase_worldViewDir, WorldNormalTangent1160_g1 );
				float3 indirectSpecular647_g1 = GlossyEnvironmentReflection( reflectVector647_g1, 1.0 - _IndirectSpecularSmoothness, Occlusion435_g1 );
				float3 lerpResult594_g1 = lerp( temp_cast_1 , indirectSpecular647_g1 , _IndirectSpecular);
				float3 Indirect_Specular600_g1 = ( temp_output_575_0_g1 + lerpResult594_g1 );
				float3 Indirect_Specular600_g61195 = Indirect_Specular600_g1;
				float4 tex2DNode35_g1 = tex2D( _MainTex, vertexToFrag795_g1 );
				float3 temp_output_39_0_g1 = (tex2DNode35_g1).rgb;
				float dotResult537_g1 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_39_0_g1 );
				float3 temp_cast_2 = (dotResult537_g1).xxx;
				float3 lerpResult538_g1 = lerp( temp_cast_2 , temp_output_39_0_g1 , ( 1.0 - _Saturation ));
				float3 BaseColor_Map63_g1 = ( _BaseColor * lerpResult538_g1 * _Brightness );
				float3 _Color98_g61195 = BaseColor_Map63_g1;
				float3 Specular_Map64_g1 = (tex2D( _SpecularMap, vertexToFrag795_g1 )).rgb;
				float3 specRGB168_g61195 = Specular_Map64_g1;
				float temp_output_400_0_g1 = ( _MetallicStrength * tex2DNode473_g1.r );
				float Metallic403_g1 = temp_output_400_0_g1;
				float _Metallic711_g61195 = Metallic403_g1;
				float3 lerpResult654_g61195 = lerp( _Color98_g61195 , specRGB168_g61195 , ( _Metallic711_g61195 * 0.5 ));
				float3 specColor651_g61195 = lerpResult654_g61195;
				float lerpResult750_g1 = lerp( tex2DNode473_g1.g , ( 1.0 - tex2DNode473_g1.g ) , _MainMaskType);
				float temp_output_414_0_g1 = ( lerpResult750_g1 * _SmoothnessStrength );
				float Smoothness_417_g1 = temp_output_414_0_g1;
				float temp_output_708_0_g61195 = Smoothness_417_g1;
				float temp_output_706_0_g61195 = ( 1.0 - ( temp_output_708_0_g61195 * temp_output_708_0_g61195 ) );
				float _Roughness707_g61195 = ( temp_output_706_0_g61195 * temp_output_706_0_g61195 );
				float grazingTerm703_g61195 = saturate( ( _Metallic711_g61195 + _Roughness707_g61195 ) );
				float3 temp_cast_3 = (grazingTerm703_g61195).xxx;
				float3 temp_output_230_0_g61191 = WorldNormalTangent1160_g1;
				float dotResult151_g61191 = dot( temp_output_230_0_g61191 , ase_worldViewDir );
				float _NdotV210_g1 = max( dotResult151_g61191 , 0.0 );
				float NdotV372_g61195 = _NdotV210_g1;
				float temp_output_676_0_g61195 = saturate( ( 1.0 - NdotV372_g61195 ) );
				float3 lerpResult670_g61195 = lerp( specColor651_g61195 , temp_cast_3 , ( temp_output_676_0_g61195 * temp_output_676_0_g61195 * temp_output_676_0_g61195 * temp_output_676_0_g61195 * temp_output_676_0_g61195 ));
				float3 finalSpec683_g61195 = ( Indirect_Specular600_g61195 * lerpResult670_g61195 * max( _Metallic711_g61195 , 0.15 ) * ( 1.0 - ( _Roughness707_g61195 * _Roughness707_g61195 * _Roughness707_g61195 ) ) );
				float3 temp_output_230_0_g61189 = WorldNormalTangent1160_g1;
				float3 Normal_Space282_g61189 = temp_output_230_0_g61189;
				float3 Light_Dir267_g61189 = SafeNormalize(_MainLightPosition.xyz);
				float dotResult152_g61189 = dot( Normal_Space282_g61189 , Light_Dir267_g61189 );
				float _NdotL208_g1 = max( dotResult152_g61189 , 0.0 );
				float NdotL373_g61195 = _NdotL208_g1;
				float NdotL287_g61199 = NdotL373_g61195;
				float NdotV286_g61199 = NdotV372_g61195;
				float2 appendResult44_g61199 = (float2(NdotL287_g61199 , NdotV286_g61199));
				float2 temp_output_330_0_g61199 = saturate( ( 1.0 - appendResult44_g61199 ) );
				float2 temp_output_331_0_g61199 = ( temp_output_330_0_g61199 * temp_output_330_0_g61199 * temp_output_330_0_g61199 * temp_output_330_0_g61199 * temp_output_330_0_g61199 );
				float3 Light_Dir267_g61185 = SafeNormalize(_MainLightPosition.xyz);
				float3 View_Dir274_g61185 = ase_worldViewDir;
				float3 normalizeResult176_g61185 = normalize( ( Light_Dir267_g61185 + View_Dir274_g61185 ) );
				float dotResult159_g61185 = dot( Light_Dir267_g61185 , normalizeResult176_g61185 );
				float _LdotH972_g1 = max( dotResult159_g61185 , 0.0 );
				float LdotH643_g61195 = _LdotH972_g1;
				float LdotH288_g61199 = LdotH643_g61195;
				float2 break335_g61199 = ( ( 1.0 - temp_output_331_0_g61199 ) + ( temp_output_331_0_g61199 * ( ( LdotH288_g61199 * LdotH288_g61199 * _Roughness707_g61195 * 2.0 ) + 0.5 ) ) );
				float3 worldPosValue184_g61278 = WorldPosition;
				float3 WorldPosition147_g61278 = worldPosValue184_g61278;
				float3 worldNormalValue185_g61278 = WorldNormalTangent1160_g1;
				float3 WorldNormal147_g61278 = worldNormalValue185_g61278;
				float3 localAdditionalLightsHalfLambert10x147_g61278 = AdditionalLightsHalfLambert10x( WorldPosition147_g61278 , WorldNormal147_g61278 );
				float4 ase_screenPosNorm = ScreenPos / ScreenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float3 bakedGI607_g1 = ASEBakedGI( WorldNormalTangent1160_g1, (IN.ase_texcoord4.zw*(unity_LightmapST).xy + (unity_LightmapST).zw), true);
				float3 Indirect_Diffuse644_g1 = ( ( ( ( localAdditionalLightsHalfLambert10x147_g61278 + bakedGI607_g1 ) * _IndirectDiffuse ) * Occlusion435_g1 ) * ( 1.0 ) );
				float MetallicHalf743_g1 = ( 0.5 - ( 0.5 * temp_output_400_0_g1 ) );
				float3 lerpResult739_g1 = lerp( BaseColor_Map63_g1 , Indirect_Diffuse644_g1 , MetallicHalf743_g1);
				float3 Indirect_Diffuse592_g61195 = lerpResult739_g1;
				float3 diffuseColor77_g61195 = ( ( _Color98_g61195 * ( 1.0 - _Metallic711_g61195 ) * ( break335_g61199.x * break335_g61199.y ) ) + Indirect_Diffuse592_g61195 );
				float NdotL300_g61228 = _NdotL208_g1;
				float NdotV458_g61228 = _NdotV210_g1;
				float temp_output_53_0_g1 = ( temp_output_414_0_g1 * temp_output_414_0_g1 );
				float temp_output_47_0_g1 = ( 1.0 - temp_output_53_0_g1 );
				float NDF_Rough730_g1 = ( temp_output_47_0_g1 * temp_output_47_0_g1 );
				float temp_output_242_0_g61228 = NDF_Rough730_g1;
				float temp_output_238_0_g61228 = ( temp_output_242_0_g61228 * temp_output_242_0_g61228 * sqrt( ( 2.0 / PI ) ) );
				float temp_output_190_0_g61228 = ( ( NdotV458_g61228 * temp_output_238_0_g61228 ) + ( 1.0 - temp_output_238_0_g61228 ) );
				float Shadow_65_g1 = pow( saturate( ( ( ( NdotL300_g61228 * temp_output_190_0_g61228 * temp_output_190_0_g61228 ) * ( 1.0 - _ShadowStrength ) ) - _ShadowOffset ) ) , _ShadowFalloff );
				float geoShadow142_g61195 = Shadow_65_g1;
				float saferPower14_g61283 = abs( 2.0 );
				float LdotH71_g61283 = _LdotH972_g1;
				float2 _GaussianApprox = float2(-5.55473,6.98316);
				float Fresnel_Term201_g1 = pow( saferPower14_g61283 , ( LdotH71_g61283 * ( ( LdotH71_g61283 * _GaussianApprox.x ) - _GaussianApprox.y ) ) );
				float fresnel104_g61195 = Fresnel_Term201_g1;
				float3 SpecFresnel431_g61195 = ( specColor651_g61195 + ( ( 1.0 - specColor651_g61195 ) * fresnel104_g61195 ) );
				float temp_output_290_0_g61265 = NDF_Rough730_g1;
				float temp_output_113_0_g61265 = ( temp_output_290_0_g61265 * temp_output_290_0_g61265 );
				float NdotH515_g61265 = _NdotH655_g1;
				float temp_output_116_0_g61265 = ( ( NdotH515_g61265 * NdotH515_g61265 * ( temp_output_113_0_g61265 - 1.0 ) ) + 1.0 );
				float Specular200_g1 = ( max( temp_output_113_0_g61265 , 0.0001 ) / ( temp_output_116_0_g61265 * temp_output_116_0_g61265 * PI ) );
				float specularDistr105_g61195 = Specular200_g1;
				float3 specularity657_g61195 = ( ( geoShadow142_g61195 * ( SpecFresnel431_g61195 * lerpResult654_g61195 ) * ( specularDistr105_g61195 * lerpResult654_g61195 ) ) / ( max( NdotV372_g61195 , 0.1 ) * max( NdotL373_g61195 , 0.1 ) * 4.0 ) );
				float3 temp_output_686_0_g61195 = ( finalSpec683_g61195 + diffuseColor77_g61195 + specularity657_g61195 );
				float3 temp_output_836_0_g61195 = ( temp_output_686_0_g61195 * NdotL373_g61195 );
				float3 temp_output_883_0_g1 = temp_output_836_0_g61195;
				float3 lerpResult898_g1 = lerp( ( BaseColor_Map63_g1 * _ShadowColor.rgb ) , _ShadowColor.rgb , _ShadowColor.a);
				float3 lerpResult905_g1 = lerp( temp_output_883_0_g1 , ( lerpResult898_g1 * Occlusion435_g1 ) , ( ( 1.0 - Shadow_65_g1 ) * _ShadowColorEnable ));
				
				float Alpha79_g1 = tex2DNode35_g1.a;
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = lerpResult905_g1;
				float Alpha = Alpha79_g1;
				float AlphaClipThreshold = _AlphaCutoffBias;
				float AlphaClipThresholdShadow = _AlphaCutoffBiasShadow;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #define ASE_FOG 1
            #define _ALPHATEST_SHADOW_ON 1
            #define _ALPHATEST_ON 1
            #define ASE_SRP_VERSION 101001

            #pragma multi_compile _ DOTS_INSTANCING_ON

			

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainUVs;
			float4 _ShadowColor;
			float3 _IndirectSpecularColor;
			half3 _BaseColor;
			int _Cull;
			float _ShadowColorEnable;
			float _ShadowFalloff;
			half _ShadowOffset;
			half _ShadowStrength;
			float _IndirectDiffuse;
			half _SmoothnessStrength;
			float _MetallicStrength;
			half _AlphaCutoffBias;
			half _Brightness;
			float _Saturation;
			half _IndirectSpecular;
			half _OcclusionStrengthAO;
			half _IndirectSpecularSmoothness;
			half _NormalStrength;
			float _MainMaskType;
			half _AlphaCutoffBiasShadow;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;


			
			float3 _LightDirection;
			#if ASE_SRP_VERSION >= 110000
				float3 _LightPosition;
			#endif

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float2 vertexToFrag795_g1 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag795_g1;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				float3 positionWS = TransformObjectToWorld( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = positionWS;
				#endif

				float3 normalWS = TransformObjectToWorldDir( v.normalOS );

			#if ASE_SRP_VERSION >= 110000
				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#endif
			#else
				float4 positionCS = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
				#endif
			#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag795_g1 = IN.ase_texcoord2.xy;
				float4 tex2DNode35_g1 = tex2D( _MainTex, vertexToFrag795_g1 );
				float Alpha79_g1 = tex2DNode35_g1.a;
				

				float Alpha = Alpha79_g1;
				float AlphaClipThreshold = _AlphaCutoffBias;
				float AlphaClipThresholdShadow = _AlphaCutoffBiasShadow;

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #define ASE_FOG 1
            #define _ALPHATEST_SHADOW_ON 1
            #define _ALPHATEST_ON 1
            #define ASE_SRP_VERSION 101001

            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			

			struct VertexInput
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 positionWS : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainUVs;
			float4 _ShadowColor;
			float3 _IndirectSpecularColor;
			half3 _BaseColor;
			int _Cull;
			float _ShadowColorEnable;
			float _ShadowFalloff;
			half _ShadowOffset;
			half _ShadowStrength;
			float _IndirectDiffuse;
			half _SmoothnessStrength;
			float _MetallicStrength;
			half _AlphaCutoffBias;
			half _Brightness;
			float _Saturation;
			half _IndirectSpecular;
			half _OcclusionStrengthAO;
			half _IndirectSpecularSmoothness;
			half _NormalStrength;
			float _MainMaskType;
			half _AlphaCutoffBiasShadow;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 vertexToFrag795_g1 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord3.xy = vertexToFrag795_g1;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.positionOS.xyz = vertexValue;
				#else
					v.positionOS.xyz += vertexValue;
				#endif

				v.normalOS = v.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( v.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.positionCS = vertexInput.positionCS;
				o.clipPosV = vertexInput.positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].vertex.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag795_g1 = IN.ase_texcoord3.xy;
				float4 tex2DNode35_g1 = tex2D( _MainTex, vertexToFrag795_g1 );
				float Alpha79_g1 = tex2DNode35_g1.a;
				

				float Alpha = Alpha79_g1;
				float AlphaClipThreshold = _AlphaCutoffBias;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.positionCS.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback Off
	
}
/*ASEBEGIN
Version=19603
Node;AmplifyShaderEditor.IntNode;461;1280,-848;Inherit;False;Property;_Cull;Render Face;0;1;[Enum];Create;False;0;0;1;Front,2,Back,1,Both,0;True;0;False;2;2;False;0;1;INT;0
Node;AmplifyShaderEditor.StickyNoteNode;788;1600,-768;Inherit;False;546.5441;676.9099;PBR Light Model;;0,0,0,1;For additional details on what each mode is doing visit: https://www.jordanstevenstechart.com/physically-based-rendering$$GEOMETRIC SHADOWING FUNCTION:$-- GSF Ashikhmin Premoze$-- GSF Ashikhmin Shirley$-- GSF CookTorrance$-- GSF Duer$-- GSF GGX$-- GSF Implicit$-- GSF Kelemen Modified$-- GSF Kelemen$-- GSF Kurt$-- GSF Neumann$-- GSF Schlick Beckman$-- GSF Schlick GGX$-- GSF Schlick$-- GSF Smith Beckman$-- GSF Smith GGX$-- GSF Walter et all$-- GSF Ward$$NORMAL DISTRIBUTION FUNCTION:$-- NDF Beckman$-- NDF Phong$-- NDF BlinnPhong$-- NDF Gaussian$-- NDF GGX$-- NDF Trowbridge Reitz Anisotropic$-- NDF Trowbridge Reitz$-- NDF Ward Anisotropic$$FRESNEL TERM:$-- Diffuse Fresnel$-- Gaussian Fresnel$-- Schlick IOR Fresnel$$$;0;0
Node;AmplifyShaderEditor.FunctionNode;787;896,-768;Inherit;False;PBR Core;1;;1;d226ce46eb9ddb04ba9f0a949b5fddfe;9,255,0,213,6,254,0,240,6,215,1,536,0,545,1,908,1,1279,1;0;4;FLOAT3;0;FLOAT;156;FLOAT;159;FLOAT;158
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;768;1280,-768;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;770;1280,-768;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;771;1280,-768;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;772;1280,-768;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;769;1280,-768;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;AmplifyShaderPack/Community/Physical Based Rendering;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_Cull;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForwardOnly;False;False;0;;0;0;Standard;21;Surface;0;0;  Blend;0;0;Two Sided;1;0;Cast Shadows;1;0;  Use Shadow Threshold;1;638531561065389605;Receive Shadows;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;5;False;True;True;True;False;False;;False;0
WireConnection;769;2;787;0
WireConnection;769;3;787;156
WireConnection;769;4;787;159
WireConnection;769;7;787;158
ASEEND*/
//CHKSM=9CD9D4B943A1421347DE2B8D2C73D6B53C70F27A