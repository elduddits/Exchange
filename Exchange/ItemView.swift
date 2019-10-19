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
    let item: Item
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
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
                
                HStack {
                    if item.price != 0 {
                        Text("\(item.price, formatter: Self.currencyFormatter)")
                        Image(systemName: "z.circle")
                    } else {
                        Text("N/A")
                    }
                }
                .font(.body)
            }
            
            Spacer()
            
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
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item())
    }
}
