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
    [SerializeField] private TextMeshProUGUI _ogPrice;
    [SerializeField] private TextMeshProUGUI _currentPrice;
    [SerializeField] private Transform galleryParent; // Parent transform to hold gallery images
    [SerializeField] private GameObject galleryImagePrefab; // Prefab for gallery images

    private List<Sprite> galleryImages = new List<Sprite>();
    private int currentImageIndex = 0;
    private string steamLink;
    private Coroutine imageCycleCoroutine;

    public Vector3 initPosition { get; private set; }

    void Start()
    {
        initPosition = transform.position;
    }

    public void PopulateGameCaseText(string title, string description, string originalPrice, string currentPrice, string steamLink)
    {
        _title.text = title;
        _description.text = description;
        _ogPrice.text = originalPrice;
        _currentPrice.text = currentPrice;
        this.steamLink = steamLink;
    }

    public void PopulateGameCaseImage(Sprite img)
    {
        gameImage.sprite = img;
    }

    public void AddGalleryImage(Sprite img)
    {
        galleryImages.Add(img);
        if (galleryImages.Count == 1)
        {
            // Display the first image immediately
            gameImage.sprite = img;
        }
    }

    public void Interact(PlayerInteractor interactor)
    {
        interactor.ToggleMovement(false);
        interactor.TweenObjectIn(gameObject);
        StartImageCycle();
    }

    public string GetInteractText(PlayerInteractor interactor)
    {
        return "Inspect " + _title.text;
    }

    public void DeInteract(PlayerInteractor interactor)
    {
        interactor.TweenObjectOut(gameObject, initPosition);
        interactor.ToggleMovement(true);
        StopImageCycle();
    }

    public void ShowNextImage()
    {
        if (galleryImages.Count > 0)
        {
            currentImageIndex = (currentImageIndex + 1) % galleryImages.Count;
            gameImage.sprite = galleryImages[currentImageIndex];
        }
    }

    public void ShowPreviousImage()
    {
        if (galleryImages.Count > 0)
        {
            currentImageIndex = (currentImageIndex - 1 + galleryImages.Count) % galleryImages.Count;
            gameImage.sprite = galleryImages[currentImageIndex];
        }
    }

    public void OpenSteamLink()
    {
        if (!string.IsNullOrEmpty(steamLink))
        {
            Application.OpenURL(steamLink);
        }
    }

    private void StartImageCycle()
    {
        if (imageCycleCoroutine == null)
        {
            imageCycleCoroutine = StartCoroutine(CycleImages());
        }
    }

    private void StopImageCycle()
    {
        if (imageCycleCoroutine != null)
        {
            StopCoroutine(imageCycleCoroutine);
            imageCycleCoroutine = null;
        }
    }

    private IEnumerator CycleImages()
    {
        while (true)
        {
            yield return new WaitForSeconds(3f); // Change image every 3 seconds
            ShowNextImage();
        }
    }
}
