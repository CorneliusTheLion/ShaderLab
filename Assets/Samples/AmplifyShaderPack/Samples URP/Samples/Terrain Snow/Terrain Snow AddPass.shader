// Made with Amplify Shader Editor v1.9.6.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/AmplifyShaderPack/Terrain/Snow AddPass"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector]_TerrainHolesTexture("_TerrainHolesTexture", 2D) = "white" {}
		[HideInInspector]_Control("Control", 2D) = "white" {}
		[HideInInspector]_Splat0("Splat0", 2D) = "white" {}
		[HideInInspector]_Normal0("Normal0", 2D) = "bump" {}
		[HideInInspector]_NormalScale0("NormalScale0", Float) = 1
		[HideInInspector]_Mask0("Mask0", 2D) = "gray" {}
		[HideInInspector]_Metallic0("Metallic0", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness0("Smoothness 0", Range( 0 , 1)) = 0
		[HideInInspector]_Splat1("Splat1", 2D) = "white" {}
		[HideInInspector]_Normal1("Normal1", 2D) = "bump" {}
		[HideInInspector]_NormalScale1("NormalScale1", Float) = 1
		[HideInInspector]_Mask1("Mask1", 2D) = "gray" {}
		[HideInInspector]_Metallic1("Metallic1", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness1("Smoothness1", Range( 0 , 1)) = 0
		[HideInInspector]_Splat2("Splat2", 2D) = "white" {}
		[HideInInspector]_Normal2("Normal2", 2D) = "bump" {}
		[HideInInspector]_NormalScale2("NormalScale2", Float) = 1
		[HideInInspector]_Mask2("Mask2", 2D) = "gray" {}
		[HideInInspector]_Metallic2("Metallic2", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness2("Smoothness2", Range( 0 , 1)) = 0
		[HideInInspector]_Splat3("Splat3", 2D) = "white" {}
		[HideInInspector]_Normal3("Normal3", 2D) = "bump" {}
		[HideInInspector]_NormalScale3("_NormalScale3", Float) = 1
		[HideInInspector]_Mask3("Mask3", 2D) = "gray" {}
		[HideInInspector]_Metallic3("Metallic3", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness3("Smoothness3", Range( 0 , 1)) = 0
		[Header(SNOW)][ToggleUI]_SnowEnable("ENABLE", Float) = 0
		[SingleLineTexture]_SnowMapSplat("Splat Mask", 2D) = "white" {}
		_SnowColor("Tint", Color) = (1,1,1,0)
		_SnowBrightness("Brightness", Range( 0 , 1)) = 1
		[Space(5)]_SnowSaturation("Saturation", Range( 0 , 1)) = 0
		[SingleLineTexture]_SnowMapBaseColor("BaseColor", 2D) = "white" {}
		_SnowMainUVs("Main UVs", Vector) = (0.002,0.002,0,0)
		[Normal][SingleLineTexture]_SnowMapNormal("Normal Map", 2D) = "bump" {}
		_SnowNormalStrength("Normal Strength", Float) = 2
		[ToggleUI][Space(10)]_SnowSplatREnable("ENABLE CHANNEL RED", Float) = 0
		_SnowSplatRSplatBias("Splat Bias", Float) = 1
		_SnowSplatRMin("Min", Float) = -0.5
		_SnowSplatRMax("Max", Float) = 1
		_SnowSplatRBlendStrength("Blend Strength", Range( 0 , 5)) = 0
		_SnowSplatRBlendFalloff("Blend Falloff", Range( 0 , 10)) = 0
		_SnowSplatRBlendFactor("Blend Factor", Range( 0 , 10)) = 0
		[ToggleUI][Space(10)]_SnowSplatGEnable("ENABLE CHANNEL GREEN", Float) = 0
		_SnowSplatGSplatBias("Splat Bias", Float) = 1
		_SnowSplatGMin("Min", Float) = -0.5
		_SnowSplatGMax("Max", Float) = 1
		_SnowSplatGBlendStrength("Blend Strength", Range( 0 , 5)) = 0
		_SnowSplatGBlendFalloff("Blend Falloff", Range( 0 , 10)) = 0
		_SnowSplatGBlendFactor("Blend Factor", Range( 0 , 10)) = 0
		[ToggleUI][Space(10)]_SnowSplatBEnable("ENABLE CHANNEL BLUE", Float) = 0
		_SnowSplatBSplatBias("Splat Bias", Float) = 1
		_SnowSplatBMin("Min", Float) = -0.5
		_SnowSplatBMax("Max", Float) = 1
		_SnowSplatBBlendStrength("Blend Strength", Range( 0 , 5)) = 0
		_SnowSplatBBlendFalloff("Blend Falloff", Range( 0 , 10)) = 0
		_SnowSplatBBlendFactor("Blend Factor", Range( 0 , 10)) = 0
		[ToggleUI][Space(10)]_SnowSplatAEnable("ENABLE CHANNEL ALPHA", Float) = 0
		_SnowSplatASplatBias("Splat Bias", Float) = 1
		_SnowSplatAMin("Min", Float) = -0.5
		_SnowSplatAMax("Max", Float) = 1
		_SnowSplatABlendStrength("Blend Strength", Range( 0 , 5)) = 0
		_SnowSplatABlendFalloff("Blend Falloff", Range( 0 , 10)) = 0
		_SnowSplatABlendFactor("Blend Factor", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent-99" "UniversalMaterialType"="Lit" "TerrainCompatible"="True" "IgnoreProjector"="True" }

		Cull Back
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
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

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" "TerrainCompatible"="True" "IgnoreProjector"="True" }

			Blend One One, One OneMinusSrcAlpha
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM
            #define _NORMAL_DROPOFF_TS 1
            #pragma shader_feature_local _RECEIVE_SHADOWS_OFF
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
            #define _ALPHATEST_ON 1
            #define _NORMALMAP 1
            #define ASE_SRP_VERSION 101001
            #define ASE_USING_SAMPLING_MACROS 1

            #pragma multi_compile _ DOTS_INSTANCING_ON

			
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
		

			

			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _SHADOWS_SOFT

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap
			#define TERRAIN_SPLAT_ADDPASS 1


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				half4 fogFactorAndVertexLight : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Control_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _SnowMapSplat_ST;
			float4 _SnowMainUVs;
			half4 _SnowColor;
			half _SnowSplatAEnable;
			half _SnowSplatAMax;
			half _SnowSplatAMin;
			half _SnowSplatABlendFactor;
			half _SnowSplatABlendFalloff;
			half _SnowEnable;
			half _SnowSplatBEnable;
			half _SnowSplatABlendStrength;
			half _NormalScale0;
			float _Metallic0;
			half _NormalScale2;
			half _NormalScale3;
			half _SnowNormalStrength;
			half _SnowSplatBMax;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Smoothness0;
			float _Smoothness1;
			half _NormalScale1;
			half _SnowSplatBMin;
			half _SnowSplatGEnable;
			half _SnowSplatBBlendFalloff;
			half _SnowSplatRSplatBias;
			half _SnowSplatGSplatBias;
			half _SnowSplatBSplatBias;
			half _SnowSplatASplatBias;
			half _SnowSaturation;
			half _SnowBrightness;
			half _SnowSplatRBlendFactor;
			half _SnowSplatRBlendFalloff;
			half _SnowSplatRBlendStrength;
			half _SnowSplatRMin;
			half _SnowSplatRMax;
			half _SnowSplatREnable;
			half _SnowSplatGBlendFactor;
			half _SnowSplatGBlendFalloff;
			half _SnowSplatGBlendStrength;
			half _SnowSplatGMin;
			half _SnowSplatGMax;
			float _Smoothness2;
			half _SnowSplatBBlendFactor;
			half _SnowSplatBBlendStrength;
			float _Smoothness3;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Control);
			SAMPLER(sampler_Control);
			TEXTURE2D(_Splat0);
			SAMPLER(sampler_Splat0);
			float4 _DiffuseRemapScale0;
			TEXTURE2D(_Splat1);
			float4 _DiffuseRemapScale1;
			TEXTURE2D(_Splat2);
			float4 _DiffuseRemapScale2;
			TEXTURE2D(_Splat3);
			float4 _DiffuseRemapScale3;
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);
			TEXTURE2D(_SnowMapSplat);
			SAMPLER(sampler_SnowMapSplat);
			TEXTURE2D(_SnowMapBaseColor);
			SAMPLER(sampler_SnowMapBaseColor);
			TEXTURE2D(_Normal0);
			SAMPLER(sampler_Normal0);
			TEXTURE2D(_Normal1);
			TEXTURE2D(_Normal2);
			TEXTURE2D(_Normal3);
			TEXTURE2D(_SnowMapNormal);
			SAMPLER(sampler_SnowMapNormal);
			TEXTURE2D(_Mask0);
			SAMPLER(sampler_Mask0);
			TEXTURE2D(_Mask1);
			TEXTURE2D(_Mask2);
			TEXTURE2D(_Mask3);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


			VertexInput ApplyMeshModification( VertexInput v )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = v.vertex.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				v.vertex.xz = sampleCoords* _TerrainHeightmapScale.xz;
				v.vertex.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					v.ase_normal = float3(0, 1, 0);
				#else
					v.ase_normal = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				v.texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return v;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				v = ApplyMeshModification(v);
				float4 appendResult704_g16 = (float4(cross( v.ase_normal , float3(0,0,1) ) , -1.0));
				
				float2 break291_g16 = _Control_ST.zw;
				float2 appendResult293_g16 = (float2(( break291_g16.x + 0.001 ) , ( break291_g16.y + 0.0001 )));
				float2 vertexToFrag286_g16 = ( ( v.texcoord.xy * _Control_ST.xy ) + appendResult293_g16 );
				o.ase_texcoord7.xy = vertexToFrag286_g16;
				float2 vertexToFrag851_g16 = ( ( v.texcoord.xy * (_SnowMainUVs).xy ) + (_SnowMainUVs).zw );
				o.ase_texcoord8.xy = vertexToFrag851_g16;
				
				o.ase_texcoord7.zw = v.texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;
				v.ase_tangent = appendResult704_g16;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );

				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif

				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				
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
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				
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
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
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

			half4 frag ( VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				float4 ClipPos = IN.clipPosV;
				float4 ScreenPos = ComputeScreenPos( IN.clipPosV );

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif

				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 vertexToFrag286_g16 = IN.ase_texcoord7.xy;
				float4 tex2DNode283_g16 = SAMPLE_TEXTURE2D( _Control, sampler_Control, vertexToFrag286_g16 );
				float dotResult278_g16 = dot( tex2DNode283_g16 , half4(1,1,1,1) );
				float localSplatClip276_g16 = ( dotResult278_g16 );
				float SplatWeight276_g16 = dotResult278_g16;
				{
				#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight276_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float4 Control26_g16 = ( tex2DNode283_g16 / ( localSplatClip276_g16 + 0.001 ) );
				float2 uv_Splat0 = IN.ase_texcoord7.zw * _Splat0_ST.xy + _Splat0_ST.zw;
				float4 tex2DNode414_g16 = SAMPLE_TEXTURE2D( _Splat0, sampler_Splat0, uv_Splat0 );
				float3 Splat0342_g16 = (tex2DNode414_g16).rgb;
				float2 uv_Splat1 = IN.ase_texcoord7.zw * _Splat1_ST.xy + _Splat1_ST.zw;
				float4 tex2DNode420_g16 = SAMPLE_TEXTURE2D( _Splat1, sampler_Splat0, uv_Splat1 );
				float3 Splat1379_g16 = (tex2DNode420_g16).rgb;
				float2 uv_Splat2 = IN.ase_texcoord7.zw * _Splat2_ST.xy + _Splat2_ST.zw;
				float4 tex2DNode417_g16 = SAMPLE_TEXTURE2D( _Splat2, sampler_Splat0, uv_Splat2 );
				float3 Splat2357_g16 = (tex2DNode417_g16).rgb;
				float2 uv_Splat3 = IN.ase_texcoord7.zw * _Splat3_ST.xy + _Splat3_ST.zw;
				float4 tex2DNode423_g16 = SAMPLE_TEXTURE2D( _Splat3, sampler_Splat0, uv_Splat3 );
				float3 Splat3390_g16 = (tex2DNode423_g16).rgb;
				float4 weightedBlendVar9_g16 = Control26_g16;
				float3 weightedBlend9_g16 = ( weightedBlendVar9_g16.x*( Splat0342_g16 * (_DiffuseRemapScale0).rgb ) + weightedBlendVar9_g16.y*( Splat1379_g16 * (_DiffuseRemapScale1).rgb ) + weightedBlendVar9_g16.z*( Splat2357_g16 * (_DiffuseRemapScale2).rgb ) + weightedBlendVar9_g16.w*( Splat3390_g16 * (_DiffuseRemapScale3).rgb ) );
				float3 localClipHoles453_g16 = ( weightedBlend9_g16 );
				float2 uv_TerrainHolesTexture = IN.ase_texcoord7.zw * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				float Hole453_g16 = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				{
				#ifdef _ALPHATEST_ON
				clip(Hole453_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float2 uv_SnowMapSplat = IN.ase_texcoord7.zw * _SnowMapSplat_ST.xy + _SnowMapSplat_ST.zw;
				float4 tex2DNode717_g16 = SAMPLE_TEXTURE2D( _SnowMapSplat, sampler_SnowMapSplat, uv_SnowMapSplat );
				float4 appendResult723_g16 = (float4(( tex2DNode717_g16.r * _SnowSplatRSplatBias ) , ( tex2DNode717_g16.g * _SnowSplatGSplatBias ) , ( tex2DNode717_g16.b * _SnowSplatBSplatBias ) , ( tex2DNode717_g16.a * _SnowSplatASplatBias )));
				float4 SnowSplatRGBA728_g16 = appendResult723_g16;
				float2 vertexToFrag851_g16 = IN.ase_texcoord8.xy;
				float2 temp_output_850_0_g16 = ( vertexToFrag851_g16 * 100.0 );
				float3 temp_output_12_0_g17 = (SAMPLE_TEXTURE2D( _SnowMapBaseColor, sampler_SnowMapBaseColor, temp_output_850_0_g16 )).rgb;
				float dotResult28_g17 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g17 );
				float3 temp_cast_1 = (dotResult28_g17).xxx;
				float3 lerpResult31_g17 = lerp( temp_cast_1 , temp_output_12_0_g17 , ( 1.0 - _SnowSaturation ));
				float3 SnowBaseColor842_g16 = ( (_SnowColor).rgb * lerpResult31_g17 * _SnowBrightness );
				float4 break727_g16 = appendResult723_g16;
				float SnowSplatR732_g16 = break727_g16.x;
				float saferPower802_g16 = abs( max( ( SnowSplatR732_g16 * ( 1.0 + _SnowSplatRBlendFactor ) ) , 0.0 ) );
				float lerpResult804_g16 = lerp( 0.0 , pow( saferPower802_g16 , ( 1.0 - _SnowSplatRBlendFalloff ) ) , (-1.0 + (_SnowSplatRBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float3 WorldPosition812_g16 = WorldPosition;
				float smoothstepResult823_g16 = smoothstep( _SnowSplatRMin , _SnowSplatRMax , WorldPosition812_g16.y);
				float lerpResult817_g16 = lerp( 0.0 , saturate( lerpResult804_g16 ) , smoothstepResult823_g16);
				float SnowSplatRMask818_g16 = lerpResult817_g16;
				float3 lerpResult912_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatRMask818_g16);
				float3 lerpResult894_g16 = lerp( localClipHoles453_g16 , lerpResult912_g16 , _SnowSplatREnable);
				float SnowSplatG733_g16 = break727_g16.y;
				float saferPower782_g16 = abs( max( ( SnowSplatG733_g16 * ( 1.0 + _SnowSplatGBlendFactor ) ) , 0.0 ) );
				float lerpResult783_g16 = lerp( 0.0 , pow( saferPower782_g16 , ( 1.0 - _SnowSplatGBlendFalloff ) ) , (-1.0 + (_SnowSplatGBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult832_g16 = smoothstep( _SnowSplatGMin , _SnowSplatGMax , WorldPosition812_g16.y);
				float lerpResult794_g16 = lerp( 0.0 , saturate( lerpResult783_g16 ) , smoothstepResult832_g16);
				float SnowSplatGMask800_g16 = lerpResult794_g16;
				float3 lerpResult910_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatGMask800_g16);
				float3 lerpResult892_g16 = lerp( localClipHoles453_g16 , lerpResult910_g16 , _SnowSplatGEnable);
				float SnowSplatB734_g16 = break727_g16.z;
				float saferPower759_g16 = abs( max( ( SnowSplatB734_g16 * ( 1.0 + _SnowSplatBBlendFactor ) ) , 0.0 ) );
				float lerpResult760_g16 = lerp( 0.0 , pow( saferPower759_g16 , ( 1.0 - _SnowSplatBBlendFalloff ) ) , (-1.0 + (_SnowSplatBBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult834_g16 = smoothstep( _SnowSplatBMin , _SnowSplatBMax , WorldPosition812_g16.y);
				float lerpResult793_g16 = lerp( 0.0 , saturate( lerpResult760_g16 ) , smoothstepResult834_g16);
				float SnowSplatBMask799_g16 = lerpResult793_g16;
				float3 lerpResult917_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatBMask799_g16);
				float3 lerpResult918_g16 = lerp( localClipHoles453_g16 , lerpResult917_g16 , _SnowSplatBEnable);
				float SnowSplatA735_g16 = break727_g16.w;
				float saferPower729_g16 = abs( max( ( SnowSplatA735_g16 * ( 1.0 + _SnowSplatABlendFactor ) ) , 0.0 ) );
				float lerpResult747_g16 = lerp( 0.0 , pow( saferPower729_g16 , ( 1.0 - _SnowSplatABlendFalloff ) ) , (-1.0 + (_SnowSplatABlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult836_g16 = smoothstep( _SnowSplatAMin , _SnowSplatAMax , WorldPosition812_g16.y);
				float lerpResult776_g16 = lerp( 0.0 , saturate( lerpResult747_g16 ) , smoothstepResult836_g16);
				float SnowSplatAMask777_g16 = lerpResult776_g16;
				float3 lerpResult916_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatAMask777_g16);
				float3 lerpResult898_g16 = lerp( localClipHoles453_g16 , lerpResult916_g16 , _SnowSplatAEnable);
				float4 weightedBlendVar900_g16 = SnowSplatRGBA728_g16;
				float3 weightedBlend900_g16 = ( weightedBlendVar900_g16.x*lerpResult894_g16 + weightedBlendVar900_g16.y*lerpResult892_g16 + weightedBlendVar900_g16.z*lerpResult918_g16 + weightedBlendVar900_g16.w*lerpResult898_g16 );
				float3 lerpResult924_g16 = lerp( localClipHoles453_g16 , weightedBlend900_g16 , _SnowEnable);
				
				float4 Normal0341_g16 = SAMPLE_TEXTURE2D( _Normal0, sampler_Normal0, uv_Splat0 );
				float3 unpack490_g16 = UnpackNormalScale( Normal0341_g16, _NormalScale0 );
				unpack490_g16.z = lerp( 1, unpack490_g16.z, saturate(_NormalScale0) );
				float4 Normal1378_g16 = SAMPLE_TEXTURE2D( _Normal1, sampler_Normal0, uv_Splat1 );
				float3 unpack496_g16 = UnpackNormalScale( Normal1378_g16, _NormalScale1 );
				unpack496_g16.z = lerp( 1, unpack496_g16.z, saturate(_NormalScale1) );
				float4 Normal2356_g16 = SAMPLE_TEXTURE2D( _Normal2, sampler_Normal0, uv_Splat2 );
				float3 unpack494_g16 = UnpackNormalScale( Normal2356_g16, _NormalScale2 );
				unpack494_g16.z = lerp( 1, unpack494_g16.z, saturate(_NormalScale2) );
				float4 Normal3398_g16 = SAMPLE_TEXTURE2D( _Normal3, sampler_Normal0, uv_Splat3 );
				float3 unpack491_g16 = UnpackNormalScale( Normal3398_g16, _NormalScale3 );
				unpack491_g16.z = lerp( 1, unpack491_g16.z, saturate(_NormalScale3) );
				float4 weightedBlendVar473_g16 = Control26_g16;
				float3 weightedBlend473_g16 = ( weightedBlendVar473_g16.x*unpack490_g16 + weightedBlendVar473_g16.y*unpack496_g16 + weightedBlendVar473_g16.z*unpack494_g16 + weightedBlendVar473_g16.w*unpack491_g16 );
				float3 break513_g16 = weightedBlend473_g16;
				float3 appendResult514_g16 = (float3(break513_g16.x , break513_g16.y , ( break513_g16.z + 0.001 )));
				float3 unpack856_g16 = UnpackNormalScale( SAMPLE_TEXTURE2D( _SnowMapNormal, sampler_SnowMapNormal, temp_output_850_0_g16 ), _SnowNormalStrength );
				unpack856_g16.z = lerp( 1, unpack856_g16.z, saturate(_SnowNormalStrength) );
				float3 SnowNormal858_g16 = unpack856_g16;
				float SnowEnableRChannel925_g16 = _SnowSplatREnable;
				float3 lerpResult976_g16 = lerp( appendResult514_g16 , SnowNormal858_g16 , SnowEnableRChannel925_g16);
				float SnowEnableGChannel896_g16 = _SnowSplatGEnable;
				float3 lerpResult978_g16 = lerp( appendResult514_g16 , SnowNormal858_g16 , SnowEnableGChannel896_g16);
				float SnowEnableBChannel897_g16 = _SnowSplatBEnable;
				float3 lerpResult979_g16 = lerp( appendResult514_g16 , SnowNormal858_g16 , SnowEnableBChannel897_g16);
				float SnowEnableAChannel899_g16 = _SnowSplatAEnable;
				float3 lerpResult982_g16 = lerp( appendResult514_g16 , SnowNormal858_g16 , SnowEnableAChannel899_g16);
				float4 weightedBlendVar975_g16 = SnowSplatRGBA728_g16;
				float3 weightedBlend975_g16 = ( weightedBlendVar975_g16.x*lerpResult976_g16 + weightedBlendVar975_g16.y*lerpResult978_g16 + weightedBlendVar975_g16.z*lerpResult979_g16 + weightedBlendVar975_g16.w*lerpResult982_g16 );
				float SnowEnable932_g16 = _SnowEnable;
				float3 lerpResult1005_g16 = lerp( appendResult514_g16 , weightedBlend975_g16 , SnowEnable932_g16);
				
				float4 tex2DNode416_g16 = SAMPLE_TEXTURE2D( _Mask0, sampler_Mask0, uv_Splat0 );
				float Mask0R334_g16 = tex2DNode416_g16.r;
				float4 tex2DNode422_g16 = SAMPLE_TEXTURE2D( _Mask1, sampler_Mask0, uv_Splat1 );
				float Mask1R370_g16 = tex2DNode422_g16.r;
				float4 tex2DNode419_g16 = SAMPLE_TEXTURE2D( _Mask2, sampler_Mask0, uv_Splat2 );
				float Mask2R359_g16 = tex2DNode419_g16.r;
				float4 tex2DNode425_g16 = SAMPLE_TEXTURE2D( _Mask3, sampler_Mask0, uv_Splat3 );
				float Mask3R388_g16 = tex2DNode425_g16.r;
				float4 weightedBlendVar536_g16 = Control26_g16;
				float weightedBlend536_g16 = ( weightedBlendVar536_g16.x*max( _Metallic0 , Mask0R334_g16 ) + weightedBlendVar536_g16.y*max( _Metallic1 , Mask1R370_g16 ) + weightedBlendVar536_g16.z*max( _Metallic2 , Mask2R359_g16 ) + weightedBlendVar536_g16.w*max( _Metallic3 , Mask3R388_g16 ) );
				
				float4 appendResult1168_g16 = (float4(_Smoothness0 , _Smoothness1 , _Smoothness2 , _Smoothness3));
				float Splat0A435_g16 = tex2DNode414_g16.a;
				float Mask1A369_g16 = tex2DNode422_g16.a;
				float Mask2A360_g16 = tex2DNode419_g16.a;
				float Mask3A391_g16 = tex2DNode425_g16.a;
				float4 appendResult1169_g16 = (float4(Splat0A435_g16 , Mask1A369_g16 , Mask2A360_g16 , Mask3A391_g16));
				float dotResult1166_g16 = dot( ( appendResult1168_g16 * appendResult1169_g16 ) , Control26_g16 );
				
				float Mask0G409_g16 = tex2DNode416_g16.g;
				float Mask1G371_g16 = tex2DNode422_g16.g;
				float Mask2G358_g16 = tex2DNode419_g16.g;
				float Mask3G389_g16 = tex2DNode425_g16.g;
				float4 weightedBlendVar602_g16 = Control26_g16;
				float weightedBlend602_g16 = ( weightedBlendVar602_g16.x*saturate( ( ( ( Mask0G409_g16 - 0.5 ) * 0.25 ) + ( 1.0 - 0.25 ) ) ) + weightedBlendVar602_g16.y*saturate( ( ( ( Mask1G371_g16 - 0.5 ) * 0.25 ) + ( 1.0 - 0.25 ) ) ) + weightedBlendVar602_g16.z*saturate( ( ( ( Mask2G358_g16 - 0.5 ) * 0.25 ) + ( 1.0 - 0.25 ) ) ) + weightedBlendVar602_g16.w*saturate( ( ( ( Mask3G389_g16 - 0.5 ) * 0.25 ) + ( 1.0 - 0.25 ) ) ) );
				

				float3 BaseColor = lerpResult924_g16;
				float3 Normal = lerpResult1005_g16;
				float3 Emission = 0;
				float3 Specular = 0.5;
				float Metallic = weightedBlend536_g16;
				float Smoothness = dotResult1166_g16;
				float Occlusion = saturate( weightedBlend602_g16 );
				float Alpha = dotResult278_g16;
				float AlphaClipThreshold = 0.0;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent, WorldBiTangent, WorldNormal));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif
					inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				half4 color = UniversalFragmentPBR(
					inputData,
					BaseColor,
					Metallic,
					Specular,
					Smoothness,
					Occlusion,
					Emission,
					Alpha);

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += BaseColor * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += BaseColor * transmission;
						}
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += BaseColor * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += BaseColor * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return color;
			}

			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
            #define _NORMAL_DROPOFF_TS 1
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
            #define _ALPHATEST_ON 1
            #define _NORMALMAP 1
            #define ASE_SRP_VERSION 101001
            #define ASE_USING_SAMPLING_MACROS 1

            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap
			#define TERRAIN_SPLAT_ADDPASS 1


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD1;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Control_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _SnowMapSplat_ST;
			float4 _SnowMainUVs;
			half4 _SnowColor;
			half _SnowSplatAEnable;
			half _SnowSplatAMax;
			half _SnowSplatAMin;
			half _SnowSplatABlendFactor;
			half _SnowSplatABlendFalloff;
			half _SnowEnable;
			half _SnowSplatBEnable;
			half _SnowSplatABlendStrength;
			half _NormalScale0;
			float _Metallic0;
			half _NormalScale2;
			half _NormalScale3;
			half _SnowNormalStrength;
			half _SnowSplatBMax;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Smoothness0;
			float _Smoothness1;
			half _NormalScale1;
			half _SnowSplatBMin;
			half _SnowSplatGEnable;
			half _SnowSplatBBlendFalloff;
			half _SnowSplatRSplatBias;
			half _SnowSplatGSplatBias;
			half _SnowSplatBSplatBias;
			half _SnowSplatASplatBias;
			half _SnowSaturation;
			half _SnowBrightness;
			half _SnowSplatRBlendFactor;
			half _SnowSplatRBlendFalloff;
			half _SnowSplatRBlendStrength;
			half _SnowSplatRMin;
			half _SnowSplatRMax;
			half _SnowSplatREnable;
			half _SnowSplatGBlendFactor;
			half _SnowSplatGBlendFalloff;
			half _SnowSplatGBlendStrength;
			half _SnowSplatGMin;
			half _SnowSplatGMax;
			float _Smoothness2;
			half _SnowSplatBBlendFactor;
			half _SnowSplatBBlendStrength;
			float _Smoothness3;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Control);
			SAMPLER(sampler_Control);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


			VertexInput ApplyMeshModification( VertexInput v )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = v.vertex.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				v.vertex.xz = sampleCoords* _TerrainHeightmapScale.xz;
				v.vertex.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					v.ase_normal = float3(0, 1, 0);
				#else
					v.ase_normal = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				v.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return v;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				v = ApplyMeshModification(v);
				float2 break291_g16 = _Control_ST.zw;
				float2 appendResult293_g16 = (float2(( break291_g16.x + 0.001 ) , ( break291_g16.y + 0.0001 )));
				float2 vertexToFrag286_g16 = ( ( v.ase_texcoord.xy * _Control_ST.xy ) + appendResult293_g16 );
				o.ase_texcoord3.xy = vertexToFrag286_g16;
				
				o.ase_texcoord4 = v.ase_texcoord;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
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
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
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
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
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

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
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

				float2 vertexToFrag286_g16 = IN.ase_texcoord3.xy;
				float4 tex2DNode283_g16 = SAMPLE_TEXTURE2D( _Control, sampler_Control, vertexToFrag286_g16 );
				float dotResult278_g16 = dot( tex2DNode283_g16 , half4(1,1,1,1) );
				

				float Alpha = dotResult278_g16;
				float AlphaClipThreshold = 0.0;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 101001
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap
			#define TERRAIN_SPLAT_ADDPASS 1


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Control_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _SnowMapSplat_ST;
			float4 _SnowMainUVs;
			half4 _SnowColor;
			half _SnowSplatAEnable;
			half _SnowSplatAMax;
			half _SnowSplatAMin;
			half _SnowSplatABlendFactor;
			half _SnowSplatABlendFalloff;
			half _SnowEnable;
			half _SnowSplatBEnable;
			half _SnowSplatABlendStrength;
			half _NormalScale0;
			float _Metallic0;
			half _NormalScale2;
			half _NormalScale3;
			half _SnowNormalStrength;
			half _SnowSplatBMax;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Smoothness0;
			float _Smoothness1;
			half _NormalScale1;
			half _SnowSplatBMin;
			half _SnowSplatGEnable;
			half _SnowSplatBBlendFalloff;
			half _SnowSplatRSplatBias;
			half _SnowSplatGSplatBias;
			half _SnowSplatBSplatBias;
			half _SnowSplatASplatBias;
			half _SnowSaturation;
			half _SnowBrightness;
			half _SnowSplatRBlendFactor;
			half _SnowSplatRBlendFalloff;
			half _SnowSplatRBlendStrength;
			half _SnowSplatRMin;
			half _SnowSplatRMax;
			half _SnowSplatREnable;
			half _SnowSplatGBlendFactor;
			half _SnowSplatGBlendFalloff;
			half _SnowSplatGBlendStrength;
			half _SnowSplatGMin;
			half _SnowSplatGMax;
			float _Smoothness2;
			half _SnowSplatBBlendFactor;
			half _SnowSplatBBlendStrength;
			float _Smoothness3;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Control);
			SAMPLER(sampler_Control);
			TEXTURE2D(_Splat0);
			SAMPLER(sampler_Splat0);
			float4 _DiffuseRemapScale0;
			TEXTURE2D(_Splat1);
			float4 _DiffuseRemapScale1;
			TEXTURE2D(_Splat2);
			float4 _DiffuseRemapScale2;
			TEXTURE2D(_Splat3);
			float4 _DiffuseRemapScale3;
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);
			TEXTURE2D(_SnowMapSplat);
			SAMPLER(sampler_SnowMapSplat);
			TEXTURE2D(_SnowMapBaseColor);
			SAMPLER(sampler_SnowMapBaseColor);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


			VertexInput ApplyMeshModification( VertexInput v )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = v.vertex.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				v.vertex.xz = sampleCoords* _TerrainHeightmapScale.xz;
				v.vertex.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					v.ase_normal = float3(0, 1, 0);
				#else
					v.ase_normal = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				v.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return v;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				v = ApplyMeshModification(v);
				float2 break291_g16 = _Control_ST.zw;
				float2 appendResult293_g16 = (float2(( break291_g16.x + 0.001 ) , ( break291_g16.y + 0.0001 )));
				float2 vertexToFrag286_g16 = ( ( v.ase_texcoord.xy * _Control_ST.xy ) + appendResult293_g16 );
				o.ase_texcoord2.xy = vertexToFrag286_g16;
				float2 vertexToFrag851_g16 = ( ( v.ase_texcoord.xy * (_SnowMainUVs).xy ) + (_SnowMainUVs).zw );
				o.ase_texcoord3.xy = vertexToFrag851_g16;
				
				o.ase_texcoord2.zw = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
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
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
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
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
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
					float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag286_g16 = IN.ase_texcoord2.xy;
				float4 tex2DNode283_g16 = SAMPLE_TEXTURE2D( _Control, sampler_Control, vertexToFrag286_g16 );
				float dotResult278_g16 = dot( tex2DNode283_g16 , half4(1,1,1,1) );
				float localSplatClip276_g16 = ( dotResult278_g16 );
				float SplatWeight276_g16 = dotResult278_g16;
				{
				#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight276_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float4 Control26_g16 = ( tex2DNode283_g16 / ( localSplatClip276_g16 + 0.001 ) );
				float2 uv_Splat0 = IN.ase_texcoord2.zw * _Splat0_ST.xy + _Splat0_ST.zw;
				float4 tex2DNode414_g16 = SAMPLE_TEXTURE2D( _Splat0, sampler_Splat0, uv_Splat0 );
				float3 Splat0342_g16 = (tex2DNode414_g16).rgb;
				float2 uv_Splat1 = IN.ase_texcoord2.zw * _Splat1_ST.xy + _Splat1_ST.zw;
				float4 tex2DNode420_g16 = SAMPLE_TEXTURE2D( _Splat1, sampler_Splat0, uv_Splat1 );
				float3 Splat1379_g16 = (tex2DNode420_g16).rgb;
				float2 uv_Splat2 = IN.ase_texcoord2.zw * _Splat2_ST.xy + _Splat2_ST.zw;
				float4 tex2DNode417_g16 = SAMPLE_TEXTURE2D( _Splat2, sampler_Splat0, uv_Splat2 );
				float3 Splat2357_g16 = (tex2DNode417_g16).rgb;
				float2 uv_Splat3 = IN.ase_texcoord2.zw * _Splat3_ST.xy + _Splat3_ST.zw;
				float4 tex2DNode423_g16 = SAMPLE_TEXTURE2D( _Splat3, sampler_Splat0, uv_Splat3 );
				float3 Splat3390_g16 = (tex2DNode423_g16).rgb;
				float4 weightedBlendVar9_g16 = Control26_g16;
				float3 weightedBlend9_g16 = ( weightedBlendVar9_g16.x*( Splat0342_g16 * (_DiffuseRemapScale0).rgb ) + weightedBlendVar9_g16.y*( Splat1379_g16 * (_DiffuseRemapScale1).rgb ) + weightedBlendVar9_g16.z*( Splat2357_g16 * (_DiffuseRemapScale2).rgb ) + weightedBlendVar9_g16.w*( Splat3390_g16 * (_DiffuseRemapScale3).rgb ) );
				float3 localClipHoles453_g16 = ( weightedBlend9_g16 );
				float2 uv_TerrainHolesTexture = IN.ase_texcoord2.zw * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				float Hole453_g16 = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				{
				#ifdef _ALPHATEST_ON
				clip(Hole453_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float2 uv_SnowMapSplat = IN.ase_texcoord2.zw * _SnowMapSplat_ST.xy + _SnowMapSplat_ST.zw;
				float4 tex2DNode717_g16 = SAMPLE_TEXTURE2D( _SnowMapSplat, sampler_SnowMapSplat, uv_SnowMapSplat );
				float4 appendResult723_g16 = (float4(( tex2DNode717_g16.r * _SnowSplatRSplatBias ) , ( tex2DNode717_g16.g * _SnowSplatGSplatBias ) , ( tex2DNode717_g16.b * _SnowSplatBSplatBias ) , ( tex2DNode717_g16.a * _SnowSplatASplatBias )));
				float4 SnowSplatRGBA728_g16 = appendResult723_g16;
				float2 vertexToFrag851_g16 = IN.ase_texcoord3.xy;
				float2 temp_output_850_0_g16 = ( vertexToFrag851_g16 * 100.0 );
				float3 temp_output_12_0_g17 = (SAMPLE_TEXTURE2D( _SnowMapBaseColor, sampler_SnowMapBaseColor, temp_output_850_0_g16 )).rgb;
				float dotResult28_g17 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g17 );
				float3 temp_cast_1 = (dotResult28_g17).xxx;
				float3 lerpResult31_g17 = lerp( temp_cast_1 , temp_output_12_0_g17 , ( 1.0 - _SnowSaturation ));
				float3 SnowBaseColor842_g16 = ( (_SnowColor).rgb * lerpResult31_g17 * _SnowBrightness );
				float4 break727_g16 = appendResult723_g16;
				float SnowSplatR732_g16 = break727_g16.x;
				float saferPower802_g16 = abs( max( ( SnowSplatR732_g16 * ( 1.0 + _SnowSplatRBlendFactor ) ) , 0.0 ) );
				float lerpResult804_g16 = lerp( 0.0 , pow( saferPower802_g16 , ( 1.0 - _SnowSplatRBlendFalloff ) ) , (-1.0 + (_SnowSplatRBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float3 WorldPosition812_g16 = WorldPosition;
				float smoothstepResult823_g16 = smoothstep( _SnowSplatRMin , _SnowSplatRMax , WorldPosition812_g16.y);
				float lerpResult817_g16 = lerp( 0.0 , saturate( lerpResult804_g16 ) , smoothstepResult823_g16);
				float SnowSplatRMask818_g16 = lerpResult817_g16;
				float3 lerpResult912_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatRMask818_g16);
				float3 lerpResult894_g16 = lerp( localClipHoles453_g16 , lerpResult912_g16 , _SnowSplatREnable);
				float SnowSplatG733_g16 = break727_g16.y;
				float saferPower782_g16 = abs( max( ( SnowSplatG733_g16 * ( 1.0 + _SnowSplatGBlendFactor ) ) , 0.0 ) );
				float lerpResult783_g16 = lerp( 0.0 , pow( saferPower782_g16 , ( 1.0 - _SnowSplatGBlendFalloff ) ) , (-1.0 + (_SnowSplatGBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult832_g16 = smoothstep( _SnowSplatGMin , _SnowSplatGMax , WorldPosition812_g16.y);
				float lerpResult794_g16 = lerp( 0.0 , saturate( lerpResult783_g16 ) , smoothstepResult832_g16);
				float SnowSplatGMask800_g16 = lerpResult794_g16;
				float3 lerpResult910_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatGMask800_g16);
				float3 lerpResult892_g16 = lerp( localClipHoles453_g16 , lerpResult910_g16 , _SnowSplatGEnable);
				float SnowSplatB734_g16 = break727_g16.z;
				float saferPower759_g16 = abs( max( ( SnowSplatB734_g16 * ( 1.0 + _SnowSplatBBlendFactor ) ) , 0.0 ) );
				float lerpResult760_g16 = lerp( 0.0 , pow( saferPower759_g16 , ( 1.0 - _SnowSplatBBlendFalloff ) ) , (-1.0 + (_SnowSplatBBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult834_g16 = smoothstep( _SnowSplatBMin , _SnowSplatBMax , WorldPosition812_g16.y);
				float lerpResult793_g16 = lerp( 0.0 , saturate( lerpResult760_g16 ) , smoothstepResult834_g16);
				float SnowSplatBMask799_g16 = lerpResult793_g16;
				float3 lerpResult917_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatBMask799_g16);
				float3 lerpResult918_g16 = lerp( localClipHoles453_g16 , lerpResult917_g16 , _SnowSplatBEnable);
				float SnowSplatA735_g16 = break727_g16.w;
				float saferPower729_g16 = abs( max( ( SnowSplatA735_g16 * ( 1.0 + _SnowSplatABlendFactor ) ) , 0.0 ) );
				float lerpResult747_g16 = lerp( 0.0 , pow( saferPower729_g16 , ( 1.0 - _SnowSplatABlendFalloff ) ) , (-1.0 + (_SnowSplatABlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult836_g16 = smoothstep( _SnowSplatAMin , _SnowSplatAMax , WorldPosition812_g16.y);
				float lerpResult776_g16 = lerp( 0.0 , saturate( lerpResult747_g16 ) , smoothstepResult836_g16);
				float SnowSplatAMask777_g16 = lerpResult776_g16;
				float3 lerpResult916_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatAMask777_g16);
				float3 lerpResult898_g16 = lerp( localClipHoles453_g16 , lerpResult916_g16 , _SnowSplatAEnable);
				float4 weightedBlendVar900_g16 = SnowSplatRGBA728_g16;
				float3 weightedBlend900_g16 = ( weightedBlendVar900_g16.x*lerpResult894_g16 + weightedBlendVar900_g16.y*lerpResult892_g16 + weightedBlendVar900_g16.z*lerpResult918_g16 + weightedBlendVar900_g16.w*lerpResult898_g16 );
				float3 lerpResult924_g16 = lerp( localClipHoles453_g16 , weightedBlend900_g16 , _SnowEnable);
				

				float3 BaseColor = lerpResult924_g16;
				float3 Emission = 0;
				float Alpha = dotResult278_g16;
				float AlphaClipThreshold = 0.0;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;

				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One One, One OneMinusSrcAlpha
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#define _NORMAL_DROPOFF_TS 1
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
			#define _ALPHATEST_ON 1
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 101001
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_POSITION
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap
			#define TERRAIN_SPLAT_ADDPASS 1


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Control_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _SnowMapSplat_ST;
			float4 _SnowMainUVs;
			half4 _SnowColor;
			half _SnowSplatAEnable;
			half _SnowSplatAMax;
			half _SnowSplatAMin;
			half _SnowSplatABlendFactor;
			half _SnowSplatABlendFalloff;
			half _SnowEnable;
			half _SnowSplatBEnable;
			half _SnowSplatABlendStrength;
			half _NormalScale0;
			float _Metallic0;
			half _NormalScale2;
			half _NormalScale3;
			half _SnowNormalStrength;
			half _SnowSplatBMax;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Smoothness0;
			float _Smoothness1;
			half _NormalScale1;
			half _SnowSplatBMin;
			half _SnowSplatGEnable;
			half _SnowSplatBBlendFalloff;
			half _SnowSplatRSplatBias;
			half _SnowSplatGSplatBias;
			half _SnowSplatBSplatBias;
			half _SnowSplatASplatBias;
			half _SnowSaturation;
			half _SnowBrightness;
			half _SnowSplatRBlendFactor;
			half _SnowSplatRBlendFalloff;
			half _SnowSplatRBlendStrength;
			half _SnowSplatRMin;
			half _SnowSplatRMax;
			half _SnowSplatREnable;
			half _SnowSplatGBlendFactor;
			half _SnowSplatGBlendFalloff;
			half _SnowSplatGBlendStrength;
			half _SnowSplatGMin;
			half _SnowSplatGMax;
			float _Smoothness2;
			half _SnowSplatBBlendFactor;
			half _SnowSplatBBlendStrength;
			float _Smoothness3;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Control);
			SAMPLER(sampler_Control);
			TEXTURE2D(_Splat0);
			SAMPLER(sampler_Splat0);
			float4 _DiffuseRemapScale0;
			TEXTURE2D(_Splat1);
			float4 _DiffuseRemapScale1;
			TEXTURE2D(_Splat2);
			float4 _DiffuseRemapScale2;
			TEXTURE2D(_Splat3);
			float4 _DiffuseRemapScale3;
			TEXTURE2D(_TerrainHolesTexture);
			SAMPLER(sampler_TerrainHolesTexture);
			TEXTURE2D(_SnowMapSplat);
			SAMPLER(sampler_SnowMapSplat);
			TEXTURE2D(_SnowMapBaseColor);
			SAMPLER(sampler_SnowMapBaseColor);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


			VertexInput ApplyMeshModification( VertexInput v )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = v.vertex.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				v.vertex.xz = sampleCoords* _TerrainHeightmapScale.xz;
				v.vertex.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					v.ase_normal = float3(0, 1, 0);
				#else
					v.ase_normal = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				v.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return v;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				v = ApplyMeshModification(v);
				float2 break291_g16 = _Control_ST.zw;
				float2 appendResult293_g16 = (float2(( break291_g16.x + 0.001 ) , ( break291_g16.y + 0.0001 )));
				float2 vertexToFrag286_g16 = ( ( v.ase_texcoord.xy * _Control_ST.xy ) + appendResult293_g16 );
				o.ase_texcoord2.xy = vertexToFrag286_g16;
				float2 vertexToFrag851_g16 = ( ( v.ase_texcoord.xy * (_SnowMainUVs).xy ) + (_SnowMainUVs).zw );
				o.ase_texcoord3.xy = vertexToFrag851_g16;
				
				o.ase_texcoord2.zw = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
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
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
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
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
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
					float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag286_g16 = IN.ase_texcoord2.xy;
				float4 tex2DNode283_g16 = SAMPLE_TEXTURE2D( _Control, sampler_Control, vertexToFrag286_g16 );
				float dotResult278_g16 = dot( tex2DNode283_g16 , half4(1,1,1,1) );
				float localSplatClip276_g16 = ( dotResult278_g16 );
				float SplatWeight276_g16 = dotResult278_g16;
				{
				#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight276_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float4 Control26_g16 = ( tex2DNode283_g16 / ( localSplatClip276_g16 + 0.001 ) );
				float2 uv_Splat0 = IN.ase_texcoord2.zw * _Splat0_ST.xy + _Splat0_ST.zw;
				float4 tex2DNode414_g16 = SAMPLE_TEXTURE2D( _Splat0, sampler_Splat0, uv_Splat0 );
				float3 Splat0342_g16 = (tex2DNode414_g16).rgb;
				float2 uv_Splat1 = IN.ase_texcoord2.zw * _Splat1_ST.xy + _Splat1_ST.zw;
				float4 tex2DNode420_g16 = SAMPLE_TEXTURE2D( _Splat1, sampler_Splat0, uv_Splat1 );
				float3 Splat1379_g16 = (tex2DNode420_g16).rgb;
				float2 uv_Splat2 = IN.ase_texcoord2.zw * _Splat2_ST.xy + _Splat2_ST.zw;
				float4 tex2DNode417_g16 = SAMPLE_TEXTURE2D( _Splat2, sampler_Splat0, uv_Splat2 );
				float3 Splat2357_g16 = (tex2DNode417_g16).rgb;
				float2 uv_Splat3 = IN.ase_texcoord2.zw * _Splat3_ST.xy + _Splat3_ST.zw;
				float4 tex2DNode423_g16 = SAMPLE_TEXTURE2D( _Splat3, sampler_Splat0, uv_Splat3 );
				float3 Splat3390_g16 = (tex2DNode423_g16).rgb;
				float4 weightedBlendVar9_g16 = Control26_g16;
				float3 weightedBlend9_g16 = ( weightedBlendVar9_g16.x*( Splat0342_g16 * (_DiffuseRemapScale0).rgb ) + weightedBlendVar9_g16.y*( Splat1379_g16 * (_DiffuseRemapScale1).rgb ) + weightedBlendVar9_g16.z*( Splat2357_g16 * (_DiffuseRemapScale2).rgb ) + weightedBlendVar9_g16.w*( Splat3390_g16 * (_DiffuseRemapScale3).rgb ) );
				float3 localClipHoles453_g16 = ( weightedBlend9_g16 );
				float2 uv_TerrainHolesTexture = IN.ase_texcoord2.zw * _TerrainHolesTexture_ST.xy + _TerrainHolesTexture_ST.zw;
				float Hole453_g16 = SAMPLE_TEXTURE2D( _TerrainHolesTexture, sampler_TerrainHolesTexture, uv_TerrainHolesTexture ).r;
				{
				#ifdef _ALPHATEST_ON
				clip(Hole453_g16 == 0.0f ? -1 : 1);
				#endif
				}
				float2 uv_SnowMapSplat = IN.ase_texcoord2.zw * _SnowMapSplat_ST.xy + _SnowMapSplat_ST.zw;
				float4 tex2DNode717_g16 = SAMPLE_TEXTURE2D( _SnowMapSplat, sampler_SnowMapSplat, uv_SnowMapSplat );
				float4 appendResult723_g16 = (float4(( tex2DNode717_g16.r * _SnowSplatRSplatBias ) , ( tex2DNode717_g16.g * _SnowSplatGSplatBias ) , ( tex2DNode717_g16.b * _SnowSplatBSplatBias ) , ( tex2DNode717_g16.a * _SnowSplatASplatBias )));
				float4 SnowSplatRGBA728_g16 = appendResult723_g16;
				float2 vertexToFrag851_g16 = IN.ase_texcoord3.xy;
				float2 temp_output_850_0_g16 = ( vertexToFrag851_g16 * 100.0 );
				float3 temp_output_12_0_g17 = (SAMPLE_TEXTURE2D( _SnowMapBaseColor, sampler_SnowMapBaseColor, temp_output_850_0_g16 )).rgb;
				float dotResult28_g17 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g17 );
				float3 temp_cast_1 = (dotResult28_g17).xxx;
				float3 lerpResult31_g17 = lerp( temp_cast_1 , temp_output_12_0_g17 , ( 1.0 - _SnowSaturation ));
				float3 SnowBaseColor842_g16 = ( (_SnowColor).rgb * lerpResult31_g17 * _SnowBrightness );
				float4 break727_g16 = appendResult723_g16;
				float SnowSplatR732_g16 = break727_g16.x;
				float saferPower802_g16 = abs( max( ( SnowSplatR732_g16 * ( 1.0 + _SnowSplatRBlendFactor ) ) , 0.0 ) );
				float lerpResult804_g16 = lerp( 0.0 , pow( saferPower802_g16 , ( 1.0 - _SnowSplatRBlendFalloff ) ) , (-1.0 + (_SnowSplatRBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float3 WorldPosition812_g16 = WorldPosition;
				float smoothstepResult823_g16 = smoothstep( _SnowSplatRMin , _SnowSplatRMax , WorldPosition812_g16.y);
				float lerpResult817_g16 = lerp( 0.0 , saturate( lerpResult804_g16 ) , smoothstepResult823_g16);
				float SnowSplatRMask818_g16 = lerpResult817_g16;
				float3 lerpResult912_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatRMask818_g16);
				float3 lerpResult894_g16 = lerp( localClipHoles453_g16 , lerpResult912_g16 , _SnowSplatREnable);
				float SnowSplatG733_g16 = break727_g16.y;
				float saferPower782_g16 = abs( max( ( SnowSplatG733_g16 * ( 1.0 + _SnowSplatGBlendFactor ) ) , 0.0 ) );
				float lerpResult783_g16 = lerp( 0.0 , pow( saferPower782_g16 , ( 1.0 - _SnowSplatGBlendFalloff ) ) , (-1.0 + (_SnowSplatGBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult832_g16 = smoothstep( _SnowSplatGMin , _SnowSplatGMax , WorldPosition812_g16.y);
				float lerpResult794_g16 = lerp( 0.0 , saturate( lerpResult783_g16 ) , smoothstepResult832_g16);
				float SnowSplatGMask800_g16 = lerpResult794_g16;
				float3 lerpResult910_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatGMask800_g16);
				float3 lerpResult892_g16 = lerp( localClipHoles453_g16 , lerpResult910_g16 , _SnowSplatGEnable);
				float SnowSplatB734_g16 = break727_g16.z;
				float saferPower759_g16 = abs( max( ( SnowSplatB734_g16 * ( 1.0 + _SnowSplatBBlendFactor ) ) , 0.0 ) );
				float lerpResult760_g16 = lerp( 0.0 , pow( saferPower759_g16 , ( 1.0 - _SnowSplatBBlendFalloff ) ) , (-1.0 + (_SnowSplatBBlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult834_g16 = smoothstep( _SnowSplatBMin , _SnowSplatBMax , WorldPosition812_g16.y);
				float lerpResult793_g16 = lerp( 0.0 , saturate( lerpResult760_g16 ) , smoothstepResult834_g16);
				float SnowSplatBMask799_g16 = lerpResult793_g16;
				float3 lerpResult917_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatBMask799_g16);
				float3 lerpResult918_g16 = lerp( localClipHoles453_g16 , lerpResult917_g16 , _SnowSplatBEnable);
				float SnowSplatA735_g16 = break727_g16.w;
				float saferPower729_g16 = abs( max( ( SnowSplatA735_g16 * ( 1.0 + _SnowSplatABlendFactor ) ) , 0.0 ) );
				float lerpResult747_g16 = lerp( 0.0 , pow( saferPower729_g16 , ( 1.0 - _SnowSplatABlendFalloff ) ) , (-1.0 + (_SnowSplatABlendStrength - 0.0) * (0.0 - -1.0) / (1.0 - 0.0)));
				float smoothstepResult836_g16 = smoothstep( _SnowSplatAMin , _SnowSplatAMax , WorldPosition812_g16.y);
				float lerpResult776_g16 = lerp( 0.0 , saturate( lerpResult747_g16 ) , smoothstepResult836_g16);
				float SnowSplatAMask777_g16 = lerpResult776_g16;
				float3 lerpResult916_g16 = lerp( localClipHoles453_g16 , SnowBaseColor842_g16 , SnowSplatAMask777_g16);
				float3 lerpResult898_g16 = lerp( localClipHoles453_g16 , lerpResult916_g16 , _SnowSplatAEnable);
				float4 weightedBlendVar900_g16 = SnowSplatRGBA728_g16;
				float3 weightedBlend900_g16 = ( weightedBlendVar900_g16.x*lerpResult894_g16 + weightedBlendVar900_g16.y*lerpResult892_g16 + weightedBlendVar900_g16.z*lerpResult918_g16 + weightedBlendVar900_g16.w*lerpResult898_g16 );
				float3 lerpResult924_g16 = lerp( localClipHoles453_g16 , weightedBlend900_g16 , _SnowEnable);
				

				float3 BaseColor = lerpResult924_g16;
				float Alpha = dotResult278_g16;
				float AlphaClipThreshold = 0.0;

				half4 color = half4(BaseColor, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM
            #define _NORMAL_DROPOFF_TS 1
            #define _SURFACE_TYPE_TRANSPARENT 1
            #define ASE_FINAL_COLOR_ALPHA_MULTIPLY 1
            #define _ALPHATEST_ON 1
            #define _NORMALMAP 1
            #define ASE_SRP_VERSION 101001
            #define ASE_USING_SAMPLING_MACROS 1

            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap
			#define TERRAIN_SPLAT_ADDPASS 1


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				ASE_SV_POSITION_QUALIFIERS float4 clipPos : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 worldNormal : TEXCOORD1;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD2;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Control_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _TerrainHolesTexture_ST;
			float4 _SnowMapSplat_ST;
			float4 _SnowMainUVs;
			half4 _SnowColor;
			half _SnowSplatAEnable;
			half _SnowSplatAMax;
			half _SnowSplatAMin;
			half _SnowSplatABlendFactor;
			half _SnowSplatABlendFalloff;
			half _SnowEnable;
			half _SnowSplatBEnable;
			half _SnowSplatABlendStrength;
			half _NormalScale0;
			float _Metallic0;
			half _NormalScale2;
			half _NormalScale3;
			half _SnowNormalStrength;
			half _SnowSplatBMax;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Smoothness0;
			float _Smoothness1;
			half _NormalScale1;
			half _SnowSplatBMin;
			half _SnowSplatGEnable;
			half _SnowSplatBBlendFalloff;
			half _SnowSplatRSplatBias;
			half _SnowSplatGSplatBias;
			half _SnowSplatBSplatBias;
			half _SnowSplatASplatBias;
			half _SnowSaturation;
			half _SnowBrightness;
			half _SnowSplatRBlendFactor;
			half _SnowSplatRBlendFalloff;
			half _SnowSplatRBlendStrength;
			half _SnowSplatRMin;
			half _SnowSplatRMax;
			half _SnowSplatREnable;
			half _SnowSplatGBlendFactor;
			half _SnowSplatGBlendFalloff;
			half _SnowSplatGBlendStrength;
			half _SnowSplatGMin;
			half _SnowSplatGMax;
			float _Smoothness2;
			half _SnowSplatBBlendFactor;
			half _SnowSplatBBlendStrength;
			float _Smoothness3;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			TEXTURE2D(_Control);
			SAMPLER(sampler_Control);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


			VertexInput ApplyMeshModification( VertexInput v )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = v.vertex.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				v.vertex.xz = sampleCoords* _TerrainHeightmapScale.xz;
				v.vertex.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					v.ase_normal = float3(0, 1, 0);
				#else
					v.ase_normal = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				v.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return v;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				v = ApplyMeshModification(v);
				float2 break291_g16 = _Control_ST.zw;
				float2 appendResult293_g16 = (float2(( break291_g16.x + 0.001 ) , ( break291_g16.y + 0.0001 )));
				float2 vertexToFrag286_g16 = ( ( v.ase_texcoord.xy * _Control_ST.xy ) + appendResult293_g16 );
				o.ase_texcoord4.xy = vertexToFrag286_g16;
				
				o.ase_texcoord5 = v.ase_texcoord;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal( v.ase_normal );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				o.worldNormal = normalWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				o.clipPosV = positionCS;
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
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
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
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
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
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

			half4 frag(	VertexOutput IN
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.worldPos;
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

				float2 vertexToFrag286_g16 = IN.ase_texcoord4.xy;
				float4 tex2DNode283_g16 = SAMPLE_TEXTURE2D( _Control, sampler_Control, vertexToFrag286_g16 );
				float dotResult278_g16 = dot( tex2DNode283_g16 , half4(1,1,1,1) );
				

				float Alpha = dotResult278_g16;
				float AlphaClipThreshold = 0.0;
				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = IN.clipPos.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#if ASE_SRP_VERSION >= 110000
					return float4(PackNormalOctRectEncode(TransformWorldToViewDir(IN.worldNormal, true)), 0.0, 0.0);
				#elif ASE_SRP_VERSION >= 100900
					return float4(PackNormalOctRectEncode(normalize(IN.worldNormal)), 0.0, 0.0);
				#else
					return float4(PackNormalOctRectEncode(TransformWorldToViewDir(IN.worldNormal, true)), 0.0, 0.0);
				#endif
			}
			ENDHLSL
		}

	
	}
	
	CustomEditor "UnityEditor.Rendering.Universal.TerrainLitShaderGUI"
	Fallback "Hidden/Universal Render Pipeline/FallbackError"
	
}
/*ASEBEGIN
Version=19603
Node;AmplifyShaderEditor.RangedFloatNode;64;320,288;Inherit;False;Constant;_AlphaClipThreshold1;AlphaClipThreshold;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;65;320,48;Inherit;False;Terrain 4 Layer;0;;16;a8a57459582f78d4ca5db58f601fb616;4,504,0,102,1,669,1,668,1;0;8;FLOAT3;0;FLOAT3;14;FLOAT;56;FLOAT;45;FLOAT;200;FLOAT;282;FLOAT3;709;FLOAT4;701
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;54;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;56;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;57;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;58;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;59;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;True;1;1;False;;1;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;60;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormalsOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;61;644.0565,42.11808;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;55;640,48;Float;False;True;-1;2;UnityEditor.Rendering.Universal.TerrainLitShaderGUI;0;12;Hidden/AmplifyShaderPack/Terrain/Snow AddPass;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;19;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;6;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=-99;UniversalMaterialType=Lit;TerrainCompatible=True;IgnoreProjector=True;True;5;True;12;all;0;False;True;1;1;False;;1;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;LightMode=UniversalForwardOnly;TerrainCompatible=True;IgnoreProjector=True;False;False;4;Include;;False;;Native;False;0;0;;Define;TERRAIN_SPLAT_ADDPASS 1;False;;Custom;False;0;0;;Pragma;instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap;False;;Custom;True;0;0;Forward, GBuffer;Pragma;multi_compile_instancing;False;;Custom;True;0;0;Forward,GBuffer,ShadowCaster,DepthOnly,DepthNormals;Hidden/Universal Render Pipeline/FallbackError;0;0;Standard;38;Workflow;1;0;Surface;1;638162443384408054;  Refraction Model;0;0;  Blend;2;638162443425392252;Two Sided;1;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;638162454290526574;  Use Shadow Threshold;0;0;Receive Shadows;1;0;Receive SSAO;1;0;GPU Instancing;0;638162456918797600;LOD CrossFade;0;638162443532656889;Built-in Fog;0;638162443556014694;_FinalColorxAlpha;1;638162443637993649;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;0;8;False;True;False;True;True;True;True;False;True;;True;0
WireConnection;55;0;65;0
WireConnection;55;1;65;14
WireConnection;55;3;65;56
WireConnection;55;4;65;45
WireConnection;55;5;65;200
WireConnection;55;6;65;282
WireConnection;55;7;64;0
WireConnection;55;10;65;709
WireConnection;55;30;65;701
ASEEND*/
//CHKSM=F5A43C059DF2EE2D14FEB1BC5208B11F1823ACAB