//
//  ItemSelectable.swift
//  Exchange
//
//  Created by Eduardo Salinas on 25/10/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

class ItemSelectable: ObservableObject {
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter
    }()
    
    let item: Item
    @Published var isSelected: Bool
    
    init(item: Item, isSelected: Bool = false) {
        self.item = item
        self.isSelected = isSelected
    }
    
    var showWeeklyGraph: Bool {
        item.hasWeekData && isSelected
    }
    
    var itemDetailsView: some View {
        HStack {
            Text(item.itemType.description)
                .foregroundColor(.secondary)
            if item.isOnSnapPeriod {
                Text("Open bet")
                    .padding(EdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 4))
                    .foregroundColor(.red)
                    .background(Color.red
                        .opacity(0.3)
                )
                    .clipShape(Capsule())
            }
        }
        .font(.caption)
    }
    
    var priceView: some View {
        HStack {
            if item.price != 0 {
                Text("\(item.price, formatter: Self.currencyFormatter)")
                Image(systemName: "z.circle")
            } else {
                Text("N/A")
            }
        }.font(.body)
    }
    
    var priceChangeView: some View {
        HStack {
            if item.hasWeekData && item.change != 0 {
                Text("\(item.change, specifier: "%.2f")%")
                Image(systemName: item.isNegative ? "arrowtriangle.down.circle.fill" :  "arrowtriangle.up.circle.fill")
            } else {
                Text("-")
                    .foregroundColor(.gray)
            }
        }
        .font(.caption)
        .foregroundColor(item.isNegative ? .red : .green)
    }
    
    var weeklyPriceView: some View {
        BarGraphView(data: item.weeklyPrices)
            .frame(height: 100)
            .padding()
    }
}
