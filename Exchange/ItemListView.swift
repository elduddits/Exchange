//
//  ItemListView.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/18/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI
import Combine

struct ItemListView: View {
    
    let option: Options

    @State private var searchQuery = ""
    @ObservedObject var itemData: ItemListData
    
    var body: some View {
        List {
            EmptyView()
            .poweredByFooter(title: "ROM Exchange",
                             url: URL(string: "https://www.romexchange.com"))
            
            if option == .search {
                SearchBar(searchQuery: $searchQuery) {
                    self.itemData.query = self.searchQuery
                    self.itemData.getItems()
                }
            }
            
            Section {
                ForEach(itemData.items) { item in
                    ItemView(item: item)
                    .onAppear(perform: {
                        if self.itemData.items.count >= 20 && item.id == self.itemData.items.last?.id {
                            // Make API call to next page
                            print("calling next page")
                            self.itemData.getItems()
                        }
                    })
                }
            }
        }
        .navigationBarTitle(itemData.description)
        .onAppear(perform: {
            if self.option != .search {
                self.itemData.getItems()
            }
        })
        .onDisappear(perform: {
            self.itemData.cancelRequest()
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(option: .search, itemData: ItemListData(query: ""))
    }
}
