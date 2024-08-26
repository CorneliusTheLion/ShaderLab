using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using DG.Tweening;
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

    private bool canInteract = true;
    private bool isInteracting = false;
    private IInteractable currentInteractable = null;
    public DW.FirstPersonController player;

    public Transform objectTargetLocation;
    private GameObject currentInspectedGO;

    public LayerMask interactRaycastMask;   //what the interact ray will hit

    void Update()
    {
        if(!isInteracting)
        {
            Ray r = new Ray(InteractorSource.position, InteractorSource.forward);
            if (Physics.Raycast(r, out RaycastHit hitInfo, InteractRange, interactRaycastMask))
            {
                if (hitInfo.collider.gameObject.TryGetComponent(out IInteractable interactObj))
                {
                    //display "interact" on UI
                    if(interactObj.GetInteractText(this) != "")
                        interactText.text = interactTextPrefix + interactObj.GetInteractText(this);

                    if (Input.GetKeyDown(KeyCode.E))
                    {
                        interactObj.Interact(this);
                        isInteracting = true;
                        currentInteractable = interactObj;
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
            }
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
    }


    private void OnDrawGizmos()
    {
        Debug.DrawRay(InteractorSource.position, InteractorSource.forward);
    }
}
