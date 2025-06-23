import os

import pathlib
from concurrent.futures import ThreadPoolExecutor
from collections import defaultdict
from utils.load_config import load_config

from google.cloud import vision

config = load_config()
template = config["template"]
target = config["md_target"]


def process_group(name_base, imgs):
    reader = vision.ImageAnnotatorClient()

    images = sorted(imgs, key=lambda img: img.name)
    file_name = name_base
    home = os.path.expanduser("~")
    file_path = os.path.join(home, target.format(file_name=file_name))

    for idx, img in enumerate(images):
        with open(img, "rb") as image_file:
            print("🔍 Scanning Image:", img.name)
            content = image_file.read()

        image = vision.Image(content=content)
        image_context = vision.ImageContext(language_hints=["pt"])
        response = reader.document_text_detection(image=image, image_context=image_context)
        text = response.full_text_annotation.text
        poem_lines = text.split("\n")

        if idx == 0:
            with open(file_path, "w", encoding="utf-8") as mdfile:
                mdfile.write(template.format(title=file_name, verses="\n".join(poem_lines)))
                mdfile.write("\n_Eu_")
                print(f"🔷 Arquivo {file_path} criado com sucesso.")
        else:
            with open(file_path, "a", encoding="utf-8") as mdfile:
                mdfile.write("\n" + "\n".join(poem_lines))
                print(f"🔹 Conteúdo adicionado em {file_path}.")


def ocr_to_obsidian(image_folder):
    path = sorted(pathlib.Path(image_folder).glob("*.jpg"))
    poems = defaultdict(list)
    for img in path:
        if not img.name.startswith("sem-titulo"):
            name_base = img.name.split("-")[0].strip()

        else:
            name_base = img.name.split(".")[0].strip()
            
        poems[name_base].append(img)

    with ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(lambda item: process_group(*item), poems.items())


if __name__ == "__main__":
    ocr_to_obsidian("data")
