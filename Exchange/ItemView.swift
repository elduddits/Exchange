//
//  ItemView.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/16/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

extension Int: ReferenceConvertible {
    public var debugDescription: String {
        return "\(self)"
    }
    
    public typealias ReferenceType = NSNumber
}

struct ItemView: View {
    @ObservedObject var model: ItemSelectable
   
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(model.item.name)
                    
                    model.itemDetailsView
                    
                    model.priceView
                }
                
                Spacer()
                
                model.priceChangeView
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.model.isSelected.toggle()
            }
            
            if model.showWeeklyGraph {
                model.weeklyPriceView
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var item: Item = {
        let prices: [Price] = [
            Price(snap: false, price: 10000, timestamp: ""),
            Price(snap: false, price: 12500, timestamp: ""),
            Price(snap: false, price: 13000, timestamp: ""),
            Price(snap: false, price: 9000, timestamp: ""),
            Price(snap: false, price: 6000, timestamp: ""),
            Price(snap: false, price: 3000, timestamp: ""),
            Price(snap: false, price: 4444, timestamp: "")
        ]
        let weekPrice = WeekPrice(data: prices, change: 5.6)
        let historical = HistoricalPrice(week: weekPrice,
                                         currentPrice: 125_750,
                                         timestamp: "")
        return Item(name: "Shield shard", type: 1, priceDiff: -3.8, global: historical)
    }()
    
    static var previews: some View {
        Group {
            ItemView(model: ItemSelectable(item: item))
            
            ItemView(model: ItemSelectable(item: item, isSelected: true))
                
        }
    }
}
