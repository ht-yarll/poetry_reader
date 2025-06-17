from google.cloud import vision

def test_read_text_from_image(image_path):
    reader = vision.ImageAnnotatorClient()

    with open(image_path, "rb") as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    response = reader.document_text_detection(image=image)

    text = response.full_text_annotation.text

    print(f"Detected text:\n")
    print(text.replace('&', ''))

    # for page in response.full_text_annotation.pages:
    #     for block in page.blocks:
    #         for paragraph in block.paragraphs:
    #             for word in paragraph.words:
    #                 word_text = ''.join([
    #                     symbol.text for symbol in word.symbols
    #                 ])
    #                 print(f"Word text: {word_text}".format(word_text=word_text))

if __name__ == "__main__":
    test_read_text_from_image("data/20250617_105514.jpg")
