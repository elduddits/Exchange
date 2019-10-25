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
                .font(.headline)
            }
            
            Section {
                ForEach(itemData.items) { item in
                    ItemView(model: ItemSelectable(item: item))
                    .onAppear(perform: {
                        if self.itemData.items.count >= 20 && item.id == self.itemData.items.last?.id {
                            // Make API call to next page
                            print("calling next page")
                            self.itemData.getItems()
                        }
                    })
                }
            }
            
            Section {
                if itemData.error != nil {
                    Text(itemData.error!.localizedDescription)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationBarTitle(itemData.description)
        .onAppear(perform: {
            if self.option != .search && self.itemData.page <= 1 {
                self.itemData.getItems()
            }
        })
        .onDisappear(perform: {
            self.itemData.cancelRequest()
        })
    }
}

struct ItemListView_Previews: PreviewProvider {
    
    static var itemData: ItemListData = {
        let data = ItemListData(query: "Shield")
        
        let weekPrice = WeekPrice(data: [], change: 5.6)
        let historical = HistoricalPrice(week: weekPrice,
                                         currentPrice: 125_750,
                                         timestamp: "")
        data.items = [Item(name: "Shield shard", type: 1, priceDiff: -3.8, global: historical)]
        return data
    }()
    
    static var previews: some View {
        ItemListView(option: .search, itemData: itemData)
    }
}
