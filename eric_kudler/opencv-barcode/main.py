# import the necessary packages
from pyzbar import pyzbar
import argparse
import cv2
from fpdf import FPDF
import barcode as barcode_builder
import os
import time

BARCODE_IMAGE_WIDTH = 45

# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=False,
                help="path to input image")
ap.add_argument("-x", "--input", required=False,
                help="path to collection of barcodes to be analyzed in bulk")

total_barcodes = []
args = vars(ap.parse_args())
pdf = FPDF()
pdf.add_page()

image_x = pdf.w / 4
image_y = 20

for filename in os.listdir(args["input"]):
    if not filename.endswith('.png') and not filename.endswith('.jpeg') and not filename.endswith('.jpg'):
        continue

    # load the input image
    image = cv2.imread(args["input"] + filename)

    # find the barcodes in the image and decode each of the barcodes
    barcodes = pyzbar.decode(image)

    total_barcodes += barcodes

    # loop over the detected barcodes
    for barcode in barcodes:
        # the barcode data is a bytes object so if we want to draw it on
        # our output image we need to convert it to a string first
        barcodeData = barcode.data.decode("utf-8")
        barcodeType = barcode.type

        # print the barcode type and data to the terminal
        print("[INFO] Found {} barcode: {}".format(barcodeType, barcodeData))

for barcode in total_barcodes:
    # the barcode data is a bytes object so if we want to draw it on
    # our output image we need to convert it to a string first
    barcodeData = barcode.data.decode("utf-8")
    barcodeType = barcode.type

    timestamp = int(round(time.time() * 1000))
    image_name = barcode_builder.generate(barcodeType, barcodeData, output=str(timestamp), writer=barcode_builder.writer.ImageWriter())
    pdf.image(image_name, x=image_x - (BARCODE_IMAGE_WIDTH / 2), y=image_y, w=BARCODE_IMAGE_WIDTH)
    os.remove(image_name)

    image_x += pdf.w / 4
    if image_x >= pdf.w:
        image_x = pdf.w / 4
        image_y += 100
        if image_y >= pdf.h:
            pdf.add_page()
            image_y = 20


pdf.output("test.pdf")

# show the output image
# cv2.imshow("Image", image)
# cv2.waitKey(0)
