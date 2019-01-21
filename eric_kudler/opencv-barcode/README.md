# BarNone
### Introduction
Since it's creation, New York's "Bottle Bill" has caused the number of recycled bottles to jump 30 million each year.  At the same time, it has been a great method for the state's underprivileged or undeserved to make a steady income without a full time job, some making up [to $40,000 anually](http://gothamist.com/2018/08/08/nyc_canning_recyclables.php).  However, sometimes someone wants to recycle a bottle but can't.  This is even though the bottle is intact, the bar code has been damaged or destroyed, and our antiquated recycling machines can't identify it's maker.  Thanks to BarNone, this won't be a problem anymore!

### How it works
The goal of was to build a better barcode scanner.  Just take pictures of your broken barcodes and save them into a directory on your computer.  Then run:

```
python main.py --input /your/image/directory/here --ouput /your/output/director/here
```
and BarNone will determine what the damaged barcode should be, genenrate a fixed version, and then export it into a pdf.  Once you have all your barcodes generated, print the pdf and tape or sticker the new barcodes onto your bottles, and they'll be reedemable wherever you go!

### Setup
BarNone uses [OpenCV](https://opencv.org/) and [Pyzbar](https://pypi.org/project/pyzbar/) to determine the location of a barcode and then convert it into a integer.  You'll need these packages and a couple more on your desktop before it can run.
1.  Install OpenCV for Python 3 (if you're on Mac, I reccomend [this](https://www.learnopencv.com/install-opencv3-on-macos/) tutorial).
2.  Install virtualenv onto your computer using `pip`.
3.  Create a `virtualenv` using
    ```
    mkvirtualenv barnone -p python3
    ```
4.  Enter your virtualenv and install your packages with
    ```
    pip install -r requirements.txt
    ```
5.  Run the command with the directory containing photos with barcodes in them.
    ```
    python main.py --input /your/image/directory/here --ouput /your/output/director/here
    ```
6.  Open the output pdf, print your new barcodes, attach them to your bottles, and redeem them wherever you want!