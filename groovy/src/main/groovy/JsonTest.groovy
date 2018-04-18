import groovy.json.JsonSlurper

class Player {
    String name
    Float winPercent

    void setName(String name) {
        if(!name) throw new Exception("'name' value missing.")
        this.name = name
    }
}

class JsonTest {
    static void main(String[] args) {
        try {
            Player player = new JsonSlurper().parseText(JsonStrings.radJson)

            if (player.winPercent != null)
                println "$player.name wins $player.winPercent% of the time"
            else
                println "$player.name is a new player!"
        } catch (Exception e) {
            println "Here's what went wrong. \n\n ${e.message}" 
        }
    }
}