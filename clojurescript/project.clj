(defproject language-buffet "0.1.0"
  :description "example JSON decoding"
  :source-paths ["src"]
  :dependencies [[org.clojure/clojure "1.8.0"]
                  [org.clojure/clojurescript "1.9.521"
                    :exclusions [org.apache.ant/ant]]
                  [prismatic/schema "1.1.7"]]
  :plugins [[lein-cljsbuild "1.1.7"] [lein-cljfmt "0.5.7"]]
  :cljsbuild {
    :builds [{:source-paths ["src"]
              :compiler {:output-to "resources/public/js/main.js"
                         :optimizations :whitespace
                         :pretty-print false}}]})
