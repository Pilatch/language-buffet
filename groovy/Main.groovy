import groovy.json.JsonSlurper

class Main {
    class Player {
        String name
        Float winPercent

        void setName(String name) {
            if (!name)
                throw new Exception("'name' value missing.")
            this.name = name
        }
    }

    static void introduce(Player player) {
        if (player.winPercent != null)
            println "$player.name wins $player.winPercent% of the time."
        else
            println "$player.name is a new player!"
    }

    static void main(String[] args) {
        try {
            Player player = new JsonSlurper().parseText(JsonStrings.deadJson)
            introduce(player)
        } catch (Exception e) {
            println "Here's what went wrong. \n\n ${e.message}"
        }
    }
}
