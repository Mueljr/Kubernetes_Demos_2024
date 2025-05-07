import requests
import sys
import os

api_key = os.getenv("NASA_API_KEY")
url = f"https://api.nasa.gov/DONKI/FLR?startDate=2024-01-01&api_key={api_key}"

res = requests.get(url)
data = res.json()

# Check for strong flares
active = any(flare.get("classType", "") in ["X", "M"] for flare in data)

if active:
    print("⚠️  Solar flare detected. Skipping deployment.")
    sys.exit(1)
else:
    print("✅ No dangerous flares. Proceeding.")
    sys.exit(0)
