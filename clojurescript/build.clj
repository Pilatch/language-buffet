(require 'cljs.build.api) ; Don't accidentally make a matching single quote!

(cljs.build.api/build "src"
  {:main 'main.core
   :output-to "out/main.js"})