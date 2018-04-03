(ns main.core
  (:require [main.jsonstrings :as jsonstrings]
    [schema.core :as s :include-macros true]))

(enable-console-print!)

(def PlayerSchema
  "A chess player schema"
  {(s/required-key :name) s/Str
   (s/required-key :winPercent) [s/Num]})

(try
  (def player (js->clj (.parse js/JSON jsonstrings/rad) :keywordize-keys true))
  (try
    (s/validate PlayerSchema player)
    (if (player :winPercent)
      (println (str (player :name) " wins " (player :winPercent) "% of the time."))
      (println (str (player :name) " is a new player.")))
    (catch js/Error e
      (println (str "validation error" e))))
(catch js/Error e
  (println (str "parse error" e))))