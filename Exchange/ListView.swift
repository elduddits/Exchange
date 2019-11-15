//
//  ListView.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/17/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    let option: Options
    
    var subitems: [ItemCategoryConformable] {
        switch option {
        case .equip:
            return Equipment.allCases
        case .headgear:
            return Headgear.allCases
        case .cards:
            return Card.allCases
        case .item:
            return UsableItem.allCases
        case .mount:
            return Mount.allCases
        case .blueprint:
            return [Options.blueprint]
        case .costume:
            return [Options.costume]
        case .search:
            return []
        }
    }
    
    var body: some View {
        Form {
            if option == .search {
                ItemListView(option: .search,
                             itemData: ItemListData(query: ""))
            } else if option == .blueprint {
                ItemListView(option: .blueprint,
                             itemData: ItemListData(itemType: option))
            } else if option == .costume {
                ItemListView(option: .costume,
                             itemData: ItemListData(itemType: option))
            } else {
                List {
                    EmptyView()
                        .poweredByFooter(title: "ROM Exchange",
                                         url: URL(string: "https://www.romexchange.com"))
                    ForEach(subitems, id: \.rawValue) { subitem in
                        NavigationLink(destination: ItemListView(option: self.option, itemData: ItemListData(itemType: subitem))) {
                            Text(subitem.description)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(self.option.description)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(option: .search)
    }
}
