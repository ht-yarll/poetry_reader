import os
import pathlib
from utils import load_config
from google.cloud import vision

config = load_config()

template = config["template"]
target = config["md_target"]

def ocr_to_obsidian(image_folder):
    reader = vision.ImageAnnotatorClient()

    for img in pathlib.Path(image_folder).glob("*.jpg"):
        with open(img, "rb") as image_file:
            content = image_file.read()

        image = vision.Image(content=content)
        image_context = vision.ImageContext(language_hints=["pt"])

        response = reader.document_text_detection(
            image=image, image_context=image_context
        )

        text = response.full_text_annotation.text

        file_name = img.name.split(".")[0]
        home = os.path.expanduser("~")
        file_path = os.path.join(home, target.format(file_name=file_name))

        poem = text.split("\n")
        content = template.format(
            title=poem[0], text="\n".join(poem[1:-1]), sign=poem[-1]
        )
        with open(file_path, "w", encoding="utf-8") as mdfile:
            mdfile.write(content)


if __name__ == "__main__":
    ocr_to_obsidian("data")
