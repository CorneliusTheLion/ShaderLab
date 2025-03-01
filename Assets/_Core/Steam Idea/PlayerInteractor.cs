using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using DG.Tweening;
using Cinemachine;
using UnityEngine.InputSystem;
using DW;

interface IInteractable
{
    public void Interact(PlayerInteractor interactor);
    public string GetInteractText(PlayerInteractor interactor);
    public void DeInteract(PlayerInteractor interactor);
}

public class PlayerInteractor : MonoBehaviour
{
    public Transform InteractorSource;
    public float InteractRange;

    public string interactTextPrefix = "Press <noparse>\"E</noparse> to <br>";
    public TextMeshProUGUI interactText;
    public TextMeshProUGUI uninteractText;

    private bool canInteract = true;
    private bool isInteracting = false;
    private IInteractable currentInteractable = null;
    public DW.FirstPersonController player;

    public Transform objectTargetLocation;
    private GameObject currentInspectedGO;
    private Vector3 originalObjectPosition;
    private Quaternion originalObjectRotation;

    public CinemachineVirtualCamera playerCam;

    public LayerMask interactRaycastMask;   //what the interact ray will hit

    private Vector2 _lookInput;
    public float distToFace = .5f;
    public float rotationSpeed = 0.01f;

    void Update()
    {
        if (!isInteracting)
        {
            Ray r = new Ray(InteractorSource.position, InteractorSource.forward);
            if (Physics.Raycast(r, out RaycastHit hitInfo, InteractRange, interactRaycastMask))
            {
                if (hitInfo.collider.gameObject.TryGetComponent(out IInteractable interactObj))
                {
                    //display "interact" on UI
                    if (interactObj.GetInteractText(this) != "")
                        interactText.text = interactTextPrefix + interactObj.GetInteractText(this);

                    if (Input.GetKeyDown(KeyCode.E))
                    {
                        interactObj.Interact(this);
                        isInteracting = true;
                        currentInteractable = interactObj;
                        player.ToggleMovement(false); // Disable player movement
                        player.ToggleCamera(false); // Disable camera movement
                        originalObjectPosition = hitInfo.collider.gameObject.transform.position; // Store original position
                        originalObjectRotation = hitInfo.collider.gameObject.transform.rotation; // Store original position
                        TweenObjectToScreenCenter(hitInfo.collider.gameObject); // Tween object to screen center
                        interactText.text = "";
                        uninteractText.text = "Press E to exit";
                    }
                }
                else
                    interactText.text = "";
            }       //else if pressing E, then tell player something?
            else
                interactText.text = "";
        }
        else
        {
            if (Input.GetKeyDown(KeyCode.E))
            {
                currentInteractable.DeInteract(this);
                isInteracting = false;
                currentInteractable = null;
                player.ToggleMovement(true); // Enable player movement
                player.ToggleCamera(true); // Enable camera movement
                TweenObjectBack(currentInspectedGO); // Tween object back to its original position
                uninteractText.text = "";
            }
            else if (Input.GetKeyDown(KeyCode.Space))
            {
                RecenterInteractedObject();
            }
            else
            {
                RotateInteractedObject();
            }
        }

    }

    private void RotateInteractedObject()
    {
        if (currentInspectedGO != null)
        {
            _lookInput.x = player.playerInputActions.Player.MouseX.ReadValue<float>();
            _lookInput.y = player.playerInputActions.Player.MouseY.ReadValue<float>();

            float maxRotationAngle = 20f;

            Vector3 currentRotation = currentInspectedGO.transform.localEulerAngles;
            float newRotationX = Mathf.Clamp(currentRotation.x - _lookInput.y * rotationSpeed, currentRotation.x - maxRotationAngle, currentRotation.x + maxRotationAngle);
            float newRotationY = Mathf.Clamp(currentRotation.y + _lookInput.x * rotationSpeed, currentRotation.y - maxRotationAngle, currentRotation.y + maxRotationAngle);

            currentInspectedGO.transform.localEulerAngles = Vector3.Lerp(currentRotation, new Vector3(newRotationX, newRotationY, currentRotation.z), Time.deltaTime * 5f);
        }
    }

    private void RecenterInteractedObject()
    {
        if (currentInspectedGO != null)
        {
            //currentInspectedGO.transform.DOLocalRotate(Vector3.zero, 0.5f).SetEase(Ease.OutBack);
            currentInspectedGO.transform.DOLookAt(playerCam.transform.position, 0.5f).SetEase(Ease.OutBack); // Make the object look at the player's camera
        }
    }

    private void TweenObjectToScreenCenter(GameObject target)
    {
        currentInspectedGO = target;
        Vector3 targetPosition = playerCam.transform.position + playerCam.transform.forward * distToFace; // Fixed distance in front of the camera
        target.transform.DOMove(targetPosition, 0.5f).SetEase(Ease.OutBack);
        target.transform.DOLookAt(playerCam.transform.position, 0.5f).SetEase(Ease.OutBack); // Make the object look at the player's camera
    }

    private void TweenObjectBack(GameObject target)
    {
        if (target != null)
        {
            target.transform.DOMove(originalObjectPosition, 0.5f).SetEase(Ease.OutBack);
            target.transform.DORotate(originalObjectRotation.eulerAngles, 0.5f).SetEase(Ease.OutBack);
        }
    }

    public void TweenObjectIn(GameObject go)
    {
        go.transform.DOMove(objectTargetLocation.position, 0.2f).SetEase(Ease.OutBack);
    }

    public void TweenObjectOut(GameObject go, Vector3 initPOS)
    {
        go.transform.DOMove(initPOS, 0.1f).SetEase(Ease.OutBack);
    }

    public void ToggleMovement(bool enableMovement)
    {
        player.ToggleMovement(enableMovement);
        player.ToggleCamera(enableMovement);
    }

    private void OnDrawGizmos()
    {
        Debug.DrawRay(InteractorSource.position, InteractorSource.forward);
    }
}
