//
//  ItemCategory.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/17/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import Foundation

protocol ItemCategoryConformable {
    var rawValue: Int { get }
    var description: String { get }
}

enum Equipment: Int, CaseIterable, ItemCategoryConformable {
    case weapon = 1
    case offhand
    case armor
    case garment
    case footgear
    case accessory
    
    var description: String {
        switch self  {
        case .weapon: return "Weapons"
        case .offhand: return "Off-hand"
        case .armor: return "Armors"
        case .garment: return "Garments"
        case .footgear: return "Footgears"
        case .accessory: return "Accessory"
        }
    }
}


enum UsableItem: Int, CaseIterable, ItemCategoryConformable {
    case potion = 8
    case refine
    case scroll
    case material
    case holiday
    case pet
    case premium
    
    var description: String {
        switch self {
        case .potion:
            return "Potion / Effect"
        case .refine:
            return "Refine"
        case .scroll:
            return "Scroll / Album"
        case .material:
            return "Material"
        case .holiday:
            return "Holiday material"
        case .pet:
            return "Pet material"
        case .premium:
            return "Premium"
        }
    }
}


enum Headgear: Int, CaseIterable, ItemCategoryConformable {
    case head = 16
    case face
    case mouth
    case back
    case tail
    
    var description: String {
        switch self {
        case .head:
            return "Headgear"
        case .face:
            return "Face"
        case .mouth:
            return "Mouth"
        case .back:
            return "Back"
        case .tail:
            return "Tail"
        }
    }
}

enum Card: Int, CaseIterable, ItemCategoryConformable {
    case weapon = 21
    case offhand
    case armor
    case garment
    case footgear
    case accessory
    
    var description: String {
        switch self  {
        case .weapon: return "Weapon cards"
        case .offhand: return "Off-hand cards"
        case .armor: return "Armor cards"
        case .garment: return "Garment cards"
        case .footgear: return "Footgear cards"
        case .accessory: return "Accessory cards"
        }
    }
}

enum Mount: Int, CaseIterable, ItemCategoryConformable {
    case mount = 28
    
    var description: String {
        switch self {
        case .mount: return "Mount"
        }
    }
}
