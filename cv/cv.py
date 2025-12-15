import json
from datetime import date

inspect = json.loads(open("./.quarto/cv/inspect.json").read())


publications = [
    val["metadata"]["reference"]
    for key, val in inspect["fileInformation"].items()
    if "/publications/" in key and not key.endswith("index.qmd")
]


def extract_conference(val):
    dt = date.fromisoformat(val["date"])
    return {
        "year": dt.year,
        "conference": val.get("conference", ""),
        "place": val.get("place", ""),
        "date": dt.strftime("%m-%d"),
    }


conferences = [
    {
        "date": val["metadata"]["date"],
        "conference": val["metadata"]["conference"],
        "place": val["metadata"]["place"],
    }
    for key, val in inspect["fileInformation"].items()
    if "/talks/" in key
    and not key.endswith("index.qmd")
    and val["metadata"].get("include-in-cv", True)
]

conferences = sorted(conferences, key=lambda x: x["date"], reverse=True)

for idx, item in enumerate(conferences):
    year = str(date.fromisoformat(item["date"]).year)
    dt = date.fromisoformat(item["date"]).strftime("%m-%d")
    if idx > 0:
        if year == conferences[idx - 1]["year"]:
            year = ""
    conferences[idx] = {
        "year": year,
        "date": dt,
        "conference": item["conference"],
        "place": item["place"],
    }


output = {"publications": publications, "conferences": conferences}
with open("./.quarto/cv/data.json", "w") as f:
    f.write(json.dumps(output, indent=2))
