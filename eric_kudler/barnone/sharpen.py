import cv2
import numpy as np
# Reading our image and displaying it
image = cv2.imread('bottle2.jpg')
cv2.imshow('Original Image', image)
cv2.waitKey(0)
# Creating our 3 x 3 kernel that would look like this:
# [[ 0.11111111  0.11111111  0.11111111]
#  [ 0.11111111  0.11111111  0.11111111]
#  [ 0.11111111  0.11111111  0.11111111]]

kernel_3x3 = np.ones((3, 3), np.float32) * -1
kernel_3x3[1][1] = 9

# We apply the filter and display the image
sharpen = cv2.filter2D(image, -1, kernel_3x3)
cv2.imshow('3x3 Kernel Blurring', sharpen)
cv2.waitKey(0)