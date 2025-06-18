import os
import sys
import pathlib
from turtle import home

from google.cloud import vision

template = """---
tags: minhas_poesias
---

# **{title}**
{text}
_{sign}_

"""

def test_read_text_from_image(image_folder):
    reader = vision.ImageAnnotatorClient()

    for img in pathlib.Path(image_folder).glob('*.jpg'):
        with open(img, "rb") as image_file:
            content = image_file.read()

        image = vision.Image(content=content)
        image_context = vision.ImageContext(language_hints=["pt"])

        response = reader.document_text_detection(image=image, image_context=image_context)

        text = response.full_text_annotation.text

        file_name = img.name.split('.')[0]
        home = os.path.expanduser("~")
        file_path = os.path.join(home, f"Documents/cofre/Knoweldge/= Hub =/2 Areas/Poesia/{file_name}.md")

        print('title', text.split('\n')[0])
        print('verses', text.split('\n')[1:-1])
        print('sign', text.split('\n')[-1])
        poem = text.split('\n')
        content = template.format(
            title = poem[0],
            text = '\n'.join(poem[1:-1]),
            sign = poem[-1]
        )
        with open(file_path, 'w', encoding='utf-8') as mdfile:
            mdfile.write(content)

if __name__ == "__main__":
    test_read_text_from_image("data")
