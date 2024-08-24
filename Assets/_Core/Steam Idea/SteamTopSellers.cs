using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using UnityEngine;
using Newtonsoft.Json.Linq;
using System.Collections;

public class SteamTopSellers : MonoBehaviour
{
    private static readonly string steamFeaturedCategoriesUrl = "https://store.steampowered.com/api/featuredcategories";
    private static readonly string steamStoreUrl = "https://store.steampowered.com/api/appdetails?appids=";

    public GameObject gamePrefab;
    public Transform parentTransform;
    public string stringToGet = "top_sellers";

    public VideoGameCase[] gamesOnDisplay;
    private int gameIterator = 0;

    void Start()
    {
        GetTopSellingGames();
    }

    public async void GetTopSellingGames()
    {
        try
        {
            using (HttpClient client = new HttpClient())
            {
                // Step 1: Get the top selling games from Steam's featured categories
                HttpResponseMessage response = await client.GetAsync(steamFeaturedCategoriesUrl);
                response.EnsureSuccessStatusCode();

                string responseBody = await response.Content.ReadAsStringAsync();
                JObject jsonResponse = JObject.Parse(responseBody);

                List<int> topSellingAppIds = new List<int>();

                // Step 2: Parse the top sellers category and get the first 10 games
                JArray topSellers = (JArray)jsonResponse[stringToGet]["items"];

                for (int i = 0; i < Mathf.Min(gamesOnDisplay.Length, topSellers.Count); i++)
                {
                    int appId = (int)topSellers[i]["id"];
                    topSellingAppIds.Add(appId);
                    Debug.Log("App id: " + appId.ToString());
                }

                // Step 3: Fetch and print game details for each App ID
                foreach (var appId in topSellingAppIds)
                {
                    await GetGameDetails(appId);
                    gameIterator++;
                }
            }
        }
        catch (HttpRequestException e)
        {
            Debug.LogError($"Request error: {e.Message}");
        }
    }

    private async Task GetGameDetails(int appId)
    {
        try
        {
            using (HttpClient client = new HttpClient())
            {
                HttpResponseMessage response = await client.GetAsync(steamStoreUrl + appId);
                response.EnsureSuccessStatusCode();

                string responseBody = await response.Content.ReadAsStringAsync();
                JObject jsonResponse = JObject.Parse(responseBody);

                if (jsonResponse[appId.ToString()] != null && (bool)jsonResponse[appId.ToString()]["success"])
                {
                    JObject gameData = (JObject)jsonResponse[appId.ToString()]["data"];
                    string name = gameData["name"].ToString();
                    string description = gameData["short_description"].ToString();
                    string imageUrl = gameData["header_image"].ToString();

                    //GameObject newGame = GameObject.Instantiate(gamePrefab, parentTransform);
                    //newGame.GetComponent<VideoGameCase>().PopulateGameCaseText(name, description);

                    gamesOnDisplay[gameIterator].PopulateGameCaseText(name, description);


                    // Print the game details
                    //Debug.Log($"Game: {name}");
                    //Debug.Log($"Description: {description}");
                    //Debug.Log($"Image URL: {imageUrl}");

                    // Optionally, you can load the image and display it in Unity
                    StartCoroutine(LoadImage(imageUrl, gamesOnDisplay[gameIterator]));
                }
            }
        }
        catch (HttpRequestException e)
        {
            Debug.LogError($"Request error for App ID {appId}: {e.Message}");
        }
    }

    private IEnumerator LoadImage(string imageUrl, VideoGameCase newGame)
    {
        using (WWW www = new WWW(imageUrl))
        {
            yield return www;
            if (www.texture != null)
            {
                // Create a new GameObject to display the image
                //GameObject imageObject = new GameObject("GameImage");
                //SpriteRenderer renderer = imageObject.AddComponent<SpriteRenderer>();
                //renderer.sprite = Sprite.Create(www.texture, new Rect(0, 0, www.texture.width, www.texture.height), new Vector2(0.5f, 0.5f));


                newGame.PopulateGameCaseImage(Sprite.Create(www.texture, new Rect(0, 0, www.texture.width, www.texture.height), new Vector2(0.5f, 0.5f)));

                // Optionally, position the image in the scene
                //imageObject.transform.position = new Vector3(0, 0, 0); // Adjust as needed
            }
            else
            {
                Debug.LogError("Failed to load image.");
            }
        }
    }
}
