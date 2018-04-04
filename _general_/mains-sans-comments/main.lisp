(ql:quickload "cl-json" :silent t)
(ql:quickload "assoc-utils" :silent t)
(use-package :json)
(use-package :assoc-utils)
(load "json-strings.lisp")

(defun verify-player (name win-percent)
  (and (typep name 'string) (or (typep win-percent 'single-float) (eq win-percent nil))))

(defun introduce (player)
  (let ((name (aget player :name)) (win-percent (aget player :win-percent)))
    (if (verify-player name win-percent)
      (if win-percent
        (format t "~s wins ~d% of the time." name win-percent)
        (format t "~s is a new player." name))
      (format t "~s is not a valid player" player))))

(handler-case
  (introduce (decode-json-from-string good-json))
  (json-syntax-error (ex) (print ex))
)
