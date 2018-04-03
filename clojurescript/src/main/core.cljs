(ns main.core
  (:require [main.jsonstrings :as jsonstrings] [schema.core :as s
             :include-macros true
             ]))
; The require call will silently fail if you have more than one of them,
; then only the last thingy you require will actually get loaded!
; This ate probably five hours of my life.

(enable-console-print!)

(def PlayerSchema
  "A chess player schema"
  {:name s/Str
   :winPercent [s/Num]}) ; I don't know how to handle a nullable number, and at this point I'm too afraid to ask.

(try
  (def player (.parse js/JSON jsonstrings/glad))
  (try
    (s/validate PlayerSchema player) ; This doesn't even work as expected. Something about
    (if (player :winPercent)
      (println (str (player :name) " wins " (player :winPercent) "% of the time."))
      (println (str (player :name) " is a new player.")))
    (catch js/Error e
      (println e)))
(catch js/Error e
  (println e)))

; This compiles to a JavaScript file that is 1.4Mb large, minified.

; Gotta recommend that you don't use the official quick start guide, https://clojurescript.org/guides/quick-start
; and instead go here - https://github.com/emezeske/lein-cljsbuild/tree/1.1.7/example-projects/simple

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

; The desire to have the compiler determine the types of things that
; clojurescript interoperates with is documented,
; but also that it's impossible to gain complete confidence.
; https://clojurescript.org/guides/externs

; It took me longer than it should have to find the package manager.
; https://leiningen.org/
; Look at it. Leiningen's tagline is, verbatim, "for automating Clojure projects without setting your hair on fire."
; But it refused to fetch stuff for me because, "This could be due to a typo in :dependencies, file system permissions, or network issues."
; Those are three vastly different causes.
; Turns out, you need to NOT listen to the recommendations on the installation page.
; I only got lein to install dependencies when I placed that shell script in the project's directory.
; Update on that last bit. It put the dependencies in my ~/.m2 directory.
; So you could have your build script use that.
; The documentation at clojurescript.org suggests you just download your dependency to the project directory.
; https://clojurescript.org/reference/dependencies#consuming-clojurescript-code

; There's a thing called Reagent which allows you to write your React app in Clojurescript.
; https://github.com/reagent-project/reagent
; By looking through its source code I was finally able to figure out how to require a local file!

; The compiler is solw and has crappy error messages that are just Java stack traces.
; Once you actually do get your application to compile, you may run it in a browser only to find that there's
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

; Clojure can run in a number of different virtual machines.
; https://m.oursky.com/why-i-chose-clojure-over-javascript-24f045daab7e

; Conclusion: If you want to write LISP, that's actually Java, and can compile to JavaScript,
; then totally go for Clojure.

