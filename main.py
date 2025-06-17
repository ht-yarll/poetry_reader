from google.cloud import vision
import csv

def test_read_text_from_image(image_path):
    reader = vision.ImageAnnotatorClient()

    with open(image_path, "rb") as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    response = reader.document_text_detection(image=image)

    verses = []
    text = response.full_text_annotation.text
    final_text = text.replace('&', '')
    for page in response.full_text_annotation.pages:
        for block in page.blocks:
            for paragraph in block.paragraphs:
                for word in paragraph.words:
                    word_text = "".join([symbol.text for symbol in word.symbols])
                    print(
                        f"Word text: {word_text} "
                        )
                    verses.append(word_text)
    print(verses)
    

    print(f"Detected text:\n")
    print(final_text)


    with open(f'data/csvs/{verses[0]}_{verses[1]}.csv', 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        for line in text.split('\n'):
            writer.writerow([line])


if __name__ == "__main__":
    test_read_text_from_image("data/20250617_105514.jpg")
