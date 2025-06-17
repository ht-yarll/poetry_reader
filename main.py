import easyocr
import csv

def main(image):
    reader = easyocr.Reader(['pt'])
    result = reader.readtext(image,decoder='wordbeamsearch', detail=0)
    print(result)
    with open(f'data/csvs/{result[0]}.csv', mode='w') as csvfile:

        for item in result:
            writer = csv.writer(csvfile)
            writer.writerow([item])


if __name__ == "__main__":
    main("data/test.png")
