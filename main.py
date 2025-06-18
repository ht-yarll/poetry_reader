import os
import sys
import pathlib

from google.cloud import vision
import spacy
import contextualSpellCheck


def test_read_text_from_image(image_folder):
    reader = vision.ImageAnnotatorClient()
    nlp = spacy.load('pt_core_news_lg')
    contextualSpellCheck.add_to_pipe(nlp)

    for img in pathlib.Path(image_folder).glob('*.jpg'):
        with open(img, "rb") as image_file:
            content = image_file.read()

        image = vision.Image(content=content)
        image_context = vision.ImageContext(language_hints=["pt"])

        response = reader.document_text_detection(image=image, image_context=image_context)

        text = response.full_text_annotation.text

        file_name = img.name.split('.')[0]
                    
        with open(f'data/txt/{file_name}.txt', 'w', encoding='utf-8') as txtfile:
                for line in text.split('\n'):
                    # text = nlp(line)
                    txtfile.write(f'{line} \n')

if __name__ == "__main__":
    test_read_text_from_image("data")
