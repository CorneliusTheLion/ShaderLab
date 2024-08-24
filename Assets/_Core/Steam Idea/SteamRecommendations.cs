using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using UnityEngine;
using Newtonsoft.Json.Linq;
using System.Collections;

public class SteamRecommendations : MonoBehaviour
{
    private static readonly string steamRecommenderUrl = "https://store.steampowered.com/api/recommender?steamid={0}&key={1}&count=10";
    private static readonly string steamStoreUrl = "https://store.steampowered.com/api/appdetails?appids=";

    public string steamID = "76561198021788589"; // Replace with the actual SteamID
    public string apiKey = "098672FD0D7DED5443663F21AA28E9C6"; // Replace with your Steam API key

    void Start()
    {
        GetRecommendedGames(steamID, apiKey);
    }

    public async void GetRecommendedGames(string steamID, string apiKey)
    {
        try
        {
            using (HttpClient client = new HttpClient())
            {
                // Step 1: Get game recommendations for the player
                string requestUrl = string.Format(steamRecommenderUrl, steamID, apiKey);
                HttpResponseMessage response = await client.GetAsync(requestUrl);
                response.EnsureSuccessStatusCode();

                string responseBody = await response.Content.ReadAsStringAsync();
                JObject jsonResponse = JObject.Parse(responseBody);

                List<int> recommendedAppIds = new List<int>();

                // Step 2: Parse the recommended games and get the first 10 games
                JArray recommendations = (JArray)jsonResponse["items"];

                for (int i = 0; i < Mathf.Min(10, recommendations.Count); i++)
                {
                    int appId = (int)recommendations[i]["id"];
                    recommendedAppIds.Add(appId);
                }

                // Step 3: Fetch and print game details for each App ID
                foreach (var appId in recommendedAppIds)
                {
                    await GetGameDetails(appId);
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

                    // Print the game details
                    Debug.Log($"Game: {name}");
                    Debug.Log($"Description: {description}");
                    Debug.Log($"Image URL: {imageUrl}");

                    // Optionally, you can load the image and display it in Unity
                    StartCoroutine(LoadImage(imageUrl));
                }
            }
        }
        catch (HttpRequestException e)
        {
            Debug.LogError($"Request error for App ID {appId}: {e.Message}");
        }
    }

    private IEnumerator LoadImage(string imageUrl)
    {
        using (WWW www = new WWW(imageUrl))
        {
            yield return www;
            if (www.texture != null)
            {
                // Create a new GameObject to display the image
                GameObject imageObject = new GameObject("GameImage");
                SpriteRenderer renderer = imageObject.AddComponent<SpriteRenderer>();
                renderer.sprite = Sprite.Create(www.texture, new Rect(0, 0, www.texture.width, www.texture.height), new Vector2(0.5f, 0.5f));

                // Optionally, position the image in the scene
                imageObject.transform.position = new Vector3(0, 0, 0); // Adjust as needed
            }
            else
            {
                Debug.LogError("Failed to load image.");
            }
        }
    }
}
