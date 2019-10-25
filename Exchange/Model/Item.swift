//
//  Item.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/16/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import Foundation
import SwiftUI

enum ItemType: Int {
    case weapon = 1
    case offhand
    case armor
    case garment
    case footgear
    case accessory
    case blueprint
    case potion
    case refine
    case scroll
    case material
    case holiday
    case pet
    case premium
    case costume
    case head
    case face
    case back
    case mouth
    case tail
    case weaponCard
    case offhandCard
    case armorCard
    case garmentCard
    case shoeCard
    case accessoryCard
    case headwearCard
    case mount
    
    var description: String {
        switch self  {
        case .weapon: return "Weapon"
        case .offhand: return "Off-hand"
        case .armor: return "Armor"
        case .garment: return "Garment"
        case .footgear: return "Footgear"
        case .accessory: return "Accessory"
        case .blueprint: return "Blueprint"
        case .potion: return "Potion / Effect"
        case .refine: return "Refine"
        case .scroll: return "Scroll / Album"
        case .material: return "Material"
        case .holiday: return "Holiday material"
        case .pet: return "Pet material"
        case .premium: return "Premium"
        case .costume: return "Costume"
        case .head: return "Head"
        case .face: return "Face"
        case .back: return "Back"
        case .mouth: return "Mouth"
        case .tail: return "Tail"
        case .weaponCard: return "Weapon card"
        case .offhandCard: return "Off-hand card"
        case .armorCard: return "Armor card"
        case .garmentCard: return "Garments card"
        case .shoeCard: return "Shoe card"
        case .accessoryCard: return "Accessory card"
        case .headwearCard: return "Headwear card"
        case .mount: return "Mount"
        }
    }
    
    var color: Color {
        switch self  {
        case .weapon,
             .offhand,
             .armor,
             .garment,
             .footgear,
             .accessory: return .blue
        case .blueprint: return .yellow
        case .potion,
             .refine,
             .scroll,
             .material,
             .holiday,
             .pet,
             .premium: return .red
        case .costume: return .green
        case .head,
             .face,
             .back,
             .mouth,
             .tail: return .orange
        case .weaponCard,
             .offhandCard,
             .armorCard,
             .garmentCard,
             .shoeCard,
             .accessoryCard,
             .headwearCard: return .purple
        case .mount: return .gray
        }
    }
}

struct Item: Codable, Identifiable {
    
    let id = UUID()
    let name: String
    private let type: Int
    
    var itemType: ItemType {
        return ItemType(rawValue: type) ?? .material
    }
    
    let priceDiff: Double
    
    let global: HistoricalPrice
    let sea: HistoricalPrice
    
    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case priceDiff = "global_sea_diff"
        case global = "global"
        case sea = "sea"
    }
    
    init() {
        name = "Item"
        type = 1
        priceDiff = 0.0
        let weekPrice = WeekPrice(data: [], change: 0)
        global = HistoricalPrice(week: weekPrice,
                                 currentPrice: 0,
                                 timestamp: "")
        sea = HistoricalPrice(week: weekPrice,
                              currentPrice: 0,
                              timestamp: "")
    }
    
    init(name: String, type: Int, priceDiff: Double, global: HistoricalPrice) {
        self.name = name
        self.type = type
        self.priceDiff = priceDiff
        self.global = global
        let weekPrice = WeekPrice(data: [], change: 0)
        sea = HistoricalPrice(week: weekPrice,
                              currentPrice: 0,
                              timestamp: "")
    }
}

struct HistoricalPrice: Codable {
    let week: WeekPrice?
    let currentPrice: Int
    let timestamp: String?
    
    private enum CodingKeys: String, CodingKey {
        case week
        case currentPrice = "latest"
        case timestamp = "latest_time"
    }
}

struct WeekPrice: Codable {
    let data: [Price]
    let change: Double
}

struct Price: Codable {
    let snap: Bool
    let price: Int
    let timestamp: String
    
    private enum CodingKeys: String, CodingKey {
        case snap
        case price
        case timestamp = "time"
    }
}

extension Item {
    var hasWeekData: Bool {
        global.week != nil && !global.week!.data.isEmpty
    }
    
    var isNegative: Bool {
        global.week?.change.isLess(than: 0) ?? false
    }
    
    var initial: String {
        itemType.description.prefix(1).lowercased()
    }
    
    var isOnSnapPeriod: Bool {
        if let weekData = global.week, let lastData = weekData.data.last {
            return lastData.snap
        }
        return false
    }
    
    var change: Double {
        global.week?.change ?? 0.0
    }
    
    var price: Int {
        global.currentPrice
    }
    
    var weeklyPrices: [Price] {
        guard let weekData = global.week else { return [] }
        return weekData.data
    }
}
