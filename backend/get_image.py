from serpapi import GoogleSearch
userQuery = input("What would you like to see? : ")
params = {
  "q": f"{userQuery}",
  "engine": "google_images",
  "ijn": "0",
  "api_key": "14544e1008a7bdd70d92ff8dd6e89e1dc1f7ce90ad0b30c78775d363e6be7351"
}

search = GoogleSearch(params)
results = search.get_dict()
images_results = results["images_results"]

x = images_results[0]["thumbnail"]
print(x)
