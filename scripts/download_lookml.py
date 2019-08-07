import os
import re
from base64 import b64decode
from pathlib import Path

import requests

username = os.environ["GITHUB_USERNAME"]
password = os.environ["GITHUB_PERSONAL_ACCESS_TOKEN"]
auth = requests.auth.HTTPBasicAuth(username, password)

directory = Path("github")
directory.mkdir(exist_ok=True)

start_url = "https://api.github.com/search/code?q=view+language:lookml"
next_url = None
page = 1

with requests.Session() as session:
    session.auth = auth

    while True:
        response = session.get(next_url or start_url)
        response.raise_for_status()

        links = response.headers["Link"]

        finds = re.findall(
            r"<(https://api.github.com/search/code\?"
            r'q=view\+language%3Alookml&page=\d+)>; rel="next"',
            links,
        )
        if finds:
            next_url = finds[0]
        else:
            next_url = None

        print(next_url)

        urls = [item["url"] for item in response.json()["items"]]

        print(f"Downloading all content from page {page}")
        for url in urls:
            response = session.get(url)
            response.raise_for_status()
            response_json = response.json()
            name = response_json["name"]
            encoded = response_json["content"]
            content = b64decode(encoded).decode("utf-8")

            if (
                name.endswith(".lookml")
                or content.startswith("-")
                or "- view" in content
            ):
                continue

            file_path = directory / name
            with file_path.open("w+") as file:
                file.write(content)

        if next_url is None:
            break
        else:
            page += 1
