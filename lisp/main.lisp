(ql:quickload "cl-json" :silent t) ; t is shorthand for standard out
(ql:quickload "assoc-utils" :silent t)
(use-package :json)
(use-package :assoc-utils)
(load "json-strings.lisp") ; OK, loading a local file was really easy.

(defun verify-player (name win-percent)
  (and (typep name 'string) (or (typep win-percent 'single-float) (eq win-percent nil))))

(defun introduce (player)
  (let ((name (aget player :name)) (win-percent (aget player :win-percent)))
    (if (verify-player name win-percent)
      (if win-percent
        ; Finally got format to work. http://www.gigamonkeys.com/book/a-few-format-recipes.html
        ; There is other documentation out there that sayso you should use % signs, but that straight-up doesn't work.
        ; You need to use ~d to avoid the interpolated things coming out with quotes around them.
        ; It's not related to decimals as you might expect from other languages.
        (format t "~d wins ~d% of the time." name win-percent)
        (format t "~d is a new player." name))
      (format t "~s is not a valid player" player))))

(handler-case
  (introduce (decode-json-from-string rad-json))
  ; Decoding the json creates a list of pairs, or an association list.
  ; These are also called "dotted pairs."
  ; When you print it out, it looks like ((:NAME . "Nooby McNooberson") (:WIN-PERCENT . 88))
  ; in JS-land that would look like [['name', 'Nooby'], ['winPercent', 85.2]]
  (json-syntax-error (ex) (print ex))
)

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

; Paraphrasing Ian Bicking (a programmer for Mozilla)
; http://www.ianbicking.org/the-challenge-of-metaprogramming.html

; Metaprogramming can save an experienced Lisp programmer from writing a significant fraction of
; his/her overall number of lines of code. However that metaprogrammed code is drastically harder
; to understand.
; "Lisp metaprogramming scales wrong." He goes on to compare Lisp to Python:

;   [Python] makes those most productive programmers more productive and more valuable.
;   That Python is easy to learn and maintain means that there's less risk in using a highly skilled,
;   highly productive programmer. In other languages you risk being left with a program
;   that only another highly skilled programmer can maintain, and that's less likely to occur with Python.

; If you're determined to use a Lisp variant, Clojure could be attractive because it compiles to JVM byte code,
; while ClojureScript compiles to JavaScript https://clojurescript.org/reference/dependencies

; However smelly this code may be, there are complex production systems that use Lisp,
; and developers who endorse it. https://softwareengineering.stackexchange.com/questions/51082/would-you-use-a-dialect-of-lisp-for-a-real-world-application-where-and-why
;   "Macro metaprogramming - the Lisp "code is data" philosophy is hard to understand unless you've actually experienced it,
;    but it's one of the reasons Lisps are so expressive and productive.
;    You basically have the power to extend the language to match your problem domain."

; Reddit was originally written in common lisp, but then ported to Python in 2005.