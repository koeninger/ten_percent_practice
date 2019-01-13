import barcode
from fpdf import FPDF

name = barcode.generate('EAN13', u'0688267022760', output='barcode', writer=barcode.writer.ImageWriter())

pdf = FPDF()
pdf.add_page()
pdf.image('barcode.png', x=10, y=8, w=50)
pdf.output("add_image.pdf")

print(name)
