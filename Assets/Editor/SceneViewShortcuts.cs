using UnityEngine;
using UnityEditor;
using UnityEditor.ShortcutManagement;

public static class SceneViewShortcuts
{
    [Shortcut("Scene View Camera - Top view", KeyCode.Keypad7)]
    public static void TopView()
    {
        MakeSceneViewCameraLookAtPivot(Quaternion.Euler(90, 0, 0));
    }

    [Shortcut("Scene View Camera - Right view", KeyCode.Keypad3)]
    public static void RightView()
    {
        MakeSceneViewCameraLookAtPivot(Quaternion.Euler(0, -90, 0));
    }


    [Shortcut("Scene View Camera - Front view", KeyCode.Keypad1)]
    public static void FrontView()
    {
        MakeSceneViewCameraLookAtPivot(Quaternion.Euler(0, 0, 0));
    }

    [Shortcut("Scene View Camera - Opposite view", KeyCode.Keypad9)]
    public static void ToggleView()
    {
        SceneView sceneView = SceneView.lastActiveSceneView;
        Camera camera = SceneView.lastActiveSceneView.camera;
        Vector3 currentView = camera.transform.rotation.eulerAngles;
        if (currentView == new Vector3(0, 0, 0))
        {
            MakeSceneViewCameraLookAtPivot(Quaternion.Euler(0, 180, 0));
        }

        else
        {
            MakeSceneViewCameraLookAtPivot(Quaternion.Euler(-currentView));
        }
    }



    private static void MakeSceneViewCameraLookAtPivot(Quaternion direction)
    {
        //introduce the scene window that we want to do sth to
        SceneView sceneView = SceneView.lastActiveSceneView;

        //if there is no scene window do nothing
        if (sceneView == null) return;

        //not a camera on the scene but the scene window camera
        Camera camera = sceneView.camera;

        //Get the pivot
        Vector3 pivot = sceneView.pivot;


        sceneView.LookAt(pivot, direction);
    }
}