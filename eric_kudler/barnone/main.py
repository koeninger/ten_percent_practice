# import the necessary packages
from pyzbar import pyzbar
import argparse
import cv2

import imutils
import numpy as np

from fpdf import FPDF
import barcode as barcode_builder
import os
import time

BARCODE_IMAGE_WIDTH = 45


def main():
    # construct the argument parser and parse the arguments
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--input", required=False,
                    help="path to collection of barcodes to be analyzed in bulk")
    ap.add_argument("-o", "--output", required=False, const='output/', nargs='?',
                    help="path to directory to keep pdfs in")

    total_barcodes = []
    args = vars(ap.parse_args())

    barcodes = get_barcodes(args["input"])
    pdf = write_barcodes_to_pdf(barcodes)
    save_pdf_to_file(pdf, args["output"])

def filter_barcode(original_image):
    image = original_image.copy()
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    kernel_3x3 = np.ones((7, 7), np.float32) * -1
    kernel_3x3[2][2] = 9
    grayZ = cv2.filter2D(gray, -1, kernel_3x3)

    # compute the Scharr gradient magnitude representation of the images
    # in both the x and y direction using OpenCV 2.4
    ddepth = cv2.cv.CV_32F if imutils.is_cv2() else cv2.CV_32F
    gradX = cv2.Sobel(gray, ddepth=ddepth, dx=1, dy=0, ksize=-1)
    gradY = cv2.Sobel(gray, ddepth=ddepth, dx=0, dy=1, ksize=-1)

    # subtract the y-gradient from the x-gradient
    gradient = cv2.subtract(gradX, gradY)
    gradient = cv2.convertScaleAbs(gradient)

    # blur and threshold the image
    b = int(7)
    blurred = cv2.blur(gradient, (b, b))
    (_, thresh) = cv2.threshold(blurred, 225, 255, cv2.THRESH_BINARY)

    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (21, 7))
    closed = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)

    # perform a series of erosions and dilations
    closed = cv2.erode(closed, None, iterations=4)
    closed = cv2.dilate(closed, None, iterations=4)

    # find the contours in the thresholded image, then sort the contours
    # by their area, keeping only the largest one
    cnts = cv2.findContours(closed.copy(), cv2.RETR_EXTERNAL,
                            cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    c = sorted(cnts, key=cv2.contourArea, reverse=True)[0]

    # compute the rotated bounding box of the largest contour
    rect = cv2.minAreaRect(c)
    box = cv2.cv.BoxPoints(rect) if imutils.is_cv2() else cv2.boxPoints(rect)
    box = np.int0(box)

    # draw a bounding box arounded the detected barcode and display the
    # image
    cv2.drawContours(image, [box], -1, (0, 255, 0), 3)

    #rotate the image so the barcode is horizontally aliged
    rows, cols, _ = image.shape
    M = cv2.getRotationMatrix2D((cols / 2, rows / 2), rect[2], 1)
    image = cv2.warpAffine(image, M, (cols, rows))

    #add a vertical directional blur
    kernel_size = 100
    kernel_motion_blur = np.zeros((kernel_size, kernel_size))
    kernel_motion_blur[:, int((kernel_size - 1) / 2)] = np.ones(kernel_size)
    kernel_motion_blur = kernel_motion_blur / kernel_size
    image = cv2.filter2D(image, -1, kernel_motion_blur)

    kernel_sharpening = np.ones((3, 3)) * -1
    kernel_sharpening[1][1] = 9
    image = cv2.filter2D(image, -1, kernel_sharpening)

    cv2.imshow("Image", image)
    cv2.waitKey(0)

    return image

def get_barcodes(input_directory):
    total_barcodes = []
    for filename in os.listdir(input_directory):
        if not filename.endswith('.png') and not filename.endswith('.jpeg') and not filename.endswith('.jpg'):
            continue

        # load the input image
        image = cv2.imread(input_directory + filename)

        filtered_image = filter_barcode(image)

        # find the barcodes in the image and decode each of the barcodes
        barcodes = pyzbar.decode(filtered_image)

        if not barcodes:
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

        # show the output image
        # cv2.imshow("Image", image)
        # cv2.waitKey(0)

    return total_barcodes

def write_barcodes_to_pdf(barcodes):
    pdf = FPDF()
    pdf.add_page()

    image_x = pdf.w / 4
    image_y = 20

    for barcode in barcodes:
        # the barcode data is a bytes object so if we want to draw it on
        # our output image we need to convert it to a string first
        barcodeData = barcode.data.decode("utf-8")
        barcodeType = barcode.type

        timestamp = int(round(time.time() * 1000))
        image_name = barcode_builder.generate(barcodeType, barcodeData, output=str(timestamp),
                                              writer=barcode_builder.writer.ImageWriter())
        pdf.image(image_name, x=image_x - (BARCODE_IMAGE_WIDTH / 2), y=image_y, w=BARCODE_IMAGE_WIDTH)
        os.remove(image_name)

        image_x += pdf.w / 4
        if image_x >= pdf.w:
            image_x = pdf.w / 4
            image_y += 100
            if image_y >= pdf.h:
                pdf.add_page()
                image_y = 20
    return pdf

def save_pdf_to_file(pdf, output_directory):
    timestamp = int(round(time.time() * 1000))
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)
    pdf.output(output_directory + "/" + str(timestamp) + ".pdf")


main()