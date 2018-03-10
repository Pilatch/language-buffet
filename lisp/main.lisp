(ql:quickload "cl-json" :silent t)
(use-package :json)
(print(decode-json-from-string "{\"name\": \"Nooby McNooberson\", \"winPercent\": null}"))

; At this point I've given up on Lisp.
; It took too long to get a package manager up and running.
; What packages exist for json-schema in Lisp are not published to quicklisp.

; Here's what I learned.
; The JSON decoding package will throw an error if the JSON is invalid.
; It returns a hash table when decoding an object.
; Lisp syntax is as bad as the hype, based on my looking around at source code
; and configuration files, which are written in Lisp.
; Everything wants to write to the output by default. You have to hunt for a way to not
; make things talk to you.
; I have not gotten to the touted metaprogramming, and at this point I don't care to.

; Paraphrasing Ian Bicking
; http://www.ianbicking.org/the-challenge-of-metaprogramming.html

; Metaprogramming can save an experienced Lisp programmer from writing a significant fraction of
; his/her overall number of lines of code. However that metaprogrammed code is drastically harder
; to understand. "Lisp metaprogramming scales wrong." He goes on to compare Lisp to Python:

;   [Python] makes those most productive programmers more productive and more valuable.
;   That Python is easy to learn and maintain means that there's less risk in using a highly skilled,
;   highly productive programmer. In other languages you risk being left with a program
;   that only another highly skilled programmer can maintain, and that's less likely to occur with Python.

; If you're determined to use a Lisp variant, Clojure could be attractive because it compiles to JVM byte code,
; while ClojureScript compiles to JavaScript https://clojurescript.org/reference/dependencies
