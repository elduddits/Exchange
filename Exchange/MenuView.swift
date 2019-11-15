//
//  ContentView.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/16/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

enum Options: CaseIterable, ItemCategoryConformable {
    var rawValue: Int {
        switch self {
        case .blueprint: return 7
        case .costume: return 15
        default: return -1
        }
    }
    
    var description: String {
        switch self {
        case .search: return "Search"
        case .equip: return "Equipment"
        case .blueprint: return "Blueprint"
        case .item: return "Item"
        case .costume: return "Costume"
        case .headgear: return "Headgear"
        case .cards: return "Cards"
        case .mount: return "Mounts"
        }
    }
    
    case search
    case equip
    case blueprint
    case item
    case costume
    case headgear
    case cards
    case mount
}


struct PoweredByFooterModifier: ViewModifier {
    let title: String
    let url: URL?
    
    func body(content: Content) -> some View {
        Section(footer:
            HStack(spacing: 3) {
                Text("Powered by")
                Button(action: {
                    // take me there
                    if let url = self.url {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text(title)
                })
            }
        ) {
            content
        }
    }
}

extension View {
    func poweredByFooter(title: String, url: URL?) -> some View {
        self.modifier(PoweredByFooterModifier(title: title, url: url))
    }
}

struct MenuView: View {
    
    var body: some View {
        NavigationView {
            List {
                Text("Use this app to search for items for Ragnarok Online Mobile. Currently, all prices are for Global server.")
                .poweredByFooter(title: "ROM Exchange",
                                 url: URL(string: "https://www.romexchange.com"))
                ForEach(Options.allCases, id: \.self) { option in
                    NavigationLink(destination: ListView(option: option)) {
                        Text(option.description)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Exchange RO:M")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
