;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |33|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
#|
So I am to research the year 2000 problem but unfortunately I was old enough to live through it.
Basically programs written early on only used the last 2 digits for year dates to save on resources,
which was pretty expensive way back then.  Because of this, the '19' for the year was hard coded
for dates.  So when the clock struck 2000, most systems would roll over to 1900 instead of the
expected 2000.  Like a butterfly flapping its wings in the forest, this shortcut created the craze
that saw everyone freaking out as well as enjoying a command center live on tv hosted by Leonard
Nimoy.  The outcome wasn't as bad historically but there was enourmous waste of resources refactoring
code across industries to account for the year change.
|#