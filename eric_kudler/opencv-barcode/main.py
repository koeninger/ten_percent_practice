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
args = vars(ap.parse_args())
for filename in os.listdir(args["input"]):
    if not filename.endswith('.png') and not filename.endswith('.jpeg') and not filename.endswith('.jpg'):
        continue

    # load the input image
    image = cv2.imread(args["input"] + filename)

    # find the barcodes in the image and decode each of the barcodes
    barcodes = pyzbar.decode(image)

# loop over the detected barcodes
for barcode in barcodes:
    # extract the bounding box location of the barcode and draw the
    # bounding box surrounding the barcode on the image
    (x, y, w, h) = barcode.rect
    cv2.rectangle(image, (x, y), (x + w, y + h), (0, 0, 255), 2)

    # the barcode data is a bytes object so if we want to draw it on
    # our output image we need to convert it to a string first
    barcodeData = barcode.data.decode("utf-8")
    barcodeType = barcode.type

    # draw the barcode data and barcode type on the image
    text = "{} ({})".format(barcodeData, barcodeType)
    cv2.putText(image, text, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)

    # print the barcode type and data to the terminal
    print("[INFO] Found {} barcode: {}".format(barcodeType, barcodeData))

# show the output image
cv2.imshow("Image", image)
cv2.waitKey(0)
