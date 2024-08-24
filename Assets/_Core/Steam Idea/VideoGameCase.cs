using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class VideoGameCase : MonoBehaviour, IInteractable
{
    [SerializeField] private Image gameImage;
    [SerializeField] private TextMeshProUGUI _title;
    [SerializeField] private TextMeshProUGUI _description;

    public Vector3 initPosition { get; private set; }

    void Start()
    {
        initPosition = transform.position;
    }

    public void PopulateGameCaseText(string title, string description)
    {
        _title.text = title;
        _description.text = description;
    }

    public void PopulateGameCaseImage(Sprite img)
    {
        gameImage.sprite = img;
    }

    public void Interact(PlayerInteractor interactor)
    {
        interactor.ToggleMovement(false);
        interactor.TweenObjectIn(gameObject);
    }

    public string GetInteractText(PlayerInteractor interactor)
    {
        return "Inspect " + _title.text;
    }

    public void DeInteract(PlayerInteractor interactor)
    {
        interactor.TweenObjectOut(gameObject, initPosition);
        interactor.ToggleMovement(true);
    }
}
