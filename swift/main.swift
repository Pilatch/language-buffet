#!/usr/bin/swift

import Foundation

struct Player: Decodable {
    let name: String
    let winPercent: Double?
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(Player.self, from: data)
    }
}

func parseJson(player: String) throws -> Player? {
    do {
        guard let model = player.data(using:.utf8) else { return nil }
        return try Player(data: model)
    } catch {
        print("I can't parse this garbage.")
        return nil
    }
}

func introduce(player: Player) {
    if player.winPercent != nil {
        print("\(player.name) wins \(player.winPercent!)% of the time.")
    } else {
        print("\(player.name) is a new player.")
    }
}

let player = try parseJson(player: gladJson)
if let player = player {
    introduce(player: player)
}
