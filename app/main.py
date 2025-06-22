import os

import pathlib

from utils.load_config import load_config

from google.cloud import vision

config = load_config()

template = config["template"]
target = config["md_target"]


def ocr_to_obsidian(image_folder):
    reader = vision.ImageAnnotatorClient()
    path = sorted(pathlib.Path(image_folder).glob("*.jpg"))
    files_scanned = []

    for img in path:
        with open(img, "rb") as image_file:
            print("🔍 Scanning Image:", img.name)
            content = image_file.read()

        image = vision.Image(content=content)
        image_context = vision.ImageContext(language_hints=["pt"])
        response = reader.document_text_detection(
            image=image, image_context=image_context
        )
        text = response.full_text_annotation.text

        if img.name.lower().startswith("sem-titulo"):
            file_name = img.name.split(".")[0]
        else:
            file_name = img.name.split("-")[0]

        home = os.path.expanduser("~")
        file_path = os.path.join(home, target.format(file_name=f"{file_name}"))
        poem_lines = text.split("\n")

        files_scanned.append(file_name)

        if not os.path.exists(file_path):
            with open(file_path, "w", encoding="utf-8") as mdfile:
                mdfile.write(
                    template.format(title=file_name, verses="\n".join(poem_lines))
                )
                (
                    mdfile.write("_Eu_")
                    if file_name not in files_scanned
                    else mdfile.write("\n")
                )
                print(f"🔷 Arquivo {file_path} criado com sucesso.")

        else:
            print(f"🔹 Arquivo {file_path} já existe, appending conteúdo.")
            with open(file_path, "a", encoding="utf-8") as mdfile:
                mdfile.write("\n".join(poem_lines))
                (
                    mdfile.write("\n\n_Eu_")
                    if file_name in files_scanned
                    else mdfile.write("\n")
                )


if __name__ == "__main__":
    ocr_to_obsidian("data")
