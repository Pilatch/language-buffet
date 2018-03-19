; WARNING! I have no idea whether this code works, but I have run parts of it through a REPL.
(ns main.core
  (:require [main.json-strings :as json-strings])
  (:require [schema.core :as s
             :include-macros true
             ]))

(enable-console-print!)

(def PlayerSchema
  "A chess player schema"
  {:name s/Str
   :winPercent [s/Num s/Null]})

(try
  (def player (.parse js/JSON json-strings/good)
    (try
      (s/validate PlayerSchema player)
      (if (player :winPercent)
        (str (player :name) " wins " (player :winPercent) "% of the time.")
        (str (player :name) " is a new player.")))
    catch (js/Error e
      (println e)))
  (catch js/Error e
    (println e)))

; It would make sense to use Clojure because that can import Java stuff,
; and with (probably) minimal tweaking can compile to JS.
; https://learnxinyminutes.com/docs/clojure/

; There is an impressive list of companies who are using ClojureScript.
; https://github.com/clojure/clojurescript/wiki/Companies-Using-ClojureScript

; You can package your program as an executable file.
; It does so by packaging up the v8 engine with your JavaScript.
; https://clojurescript.org/guides/native-executables

; Apparently LISPs are really known for their REPLs
; https://clojurescript.org/guides/quick-start#browser-repl
; https://repl.it/repls/TatteredTechnoNature

; Though a bunch of functions in the API are REPL-only.
; Example - https://cljs.github.io/api/cljs.core/load-namespace

; The desire to have the compiler determine the types of things clojurescript interoperates
; with is documented, but also that it's impossible to gain complete confidence.
; https://clojurescript.org/guides/externs

; It took me longer than it should have to find the package manager.
; https://leiningen.org/
; Look at it. Leiningen's tagline is, verbatim, "for automating Clojure projects without setting your hair on fire."
; But it refused to fetch stuff for me because, "This could be due to a typo in :dependencies, file system permissions, or network issues."
; Those are three vastly different causes.
; Turns out, you need to NOT listen to the recommendations on the installation page.
; I only got lein to install dependencies when I placed that shell script in the project's directory.
; Update on that last bit. It put the dependencies in my ~/.m2 directory... I think.

; There's a thing called Reagent which allows you to write your React app in Clojurescript.
; https://github.com/reagent-project/reagent
; By looking through its source code I was finally able to figure out how to require a local file!

; The compiler has crappy error messages that are just Java stack traces.
; Once you actually do get your file to compile, you may run it only to find that there's
; an uninstantiated JavaScript var or something.

; Regarding if/else, there does not appear to be an else keyword that works in tandem with if.
; That means when you want if/else-if/else, it will look like this:
;  (if (player :winPercent)
;    (str (player :name) " wins " (player :winPercent) "% of the time.")
;    (if (= (player :name) "Mikhail Tal") "My favorite player."
;      (str (player :name) " is a new player."))))
;
; Note that for comparing strings you use a single equals sign, while for comparing numbers,
; two equals signs. This is because you're actually leveraging the Java Object.equals function,
; which is distinct from the == operator.
; Of course you're not allowed to use them as infix operators, oh no.
; You need to put them up front like any other function call and provide the arguments thereafter.
; https://clojure.org/reference/special_forms#if
; Maybe use a case statement instead.
; https://clojuredocs.org/clojure.core/case

; Conclusion: If you want to write LISP, that's actually Java, and can compile to JavaScript,
; then totally go for Clojure.

