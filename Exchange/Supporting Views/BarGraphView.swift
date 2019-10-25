//
//  BarGraphView.swift
//  Exchange
//
//  Created by Eduardo Salinas on 25/10/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

struct BarGraphView: View {
    let max: CGFloat
    
    static let isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter
    }()
    
    init(data: [Price]) {
        let values = data.map { CGFloat($0.price) }
        let max = values.max() ?? 0.0
        self.graphData = data.map {
            BarGraphData(amount: CGFloat($0.price),
                         maxAmount: max,
                         date: Self.isoDateFormatter.date(from: $0.timestamp) ?? Date())
        }
        self.max = max
    }
    
    @State var selectedData: BarGraphData?
    
    var graphData: [BarGraphData]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { geometry in
                HStack(alignment: .bottom) {
                    ForEach(self.graphData) { point in
                        Button(action: {
                            self.graphData.forEach {
                                if $0 == point {
                                    $0.isSelected.toggle()
                                    if $0.isSelected {
                                        self.selectedData = $0
                                    } else {
                                        self.selectedData = nil
                                    }
                                } else {
                                    $0.isSelected = false
                                }
                            }
                        }) {
                            BarGraphComponent(data: point, height: geometry.size.height)
                        }
                    }
                }
                Spacer()
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.blue)
            
            if selectedData != nil {
                HStack {
                    Text("\(Self.dateFormatter.string(from: selectedData!.date)) -  \(Int(selectedData!.amount))")
                    Image(systemName: "z.circle")
                }
                .foregroundColor(Color(UIColor.systemGray6))
                .padding(1)
                .background(Color(UIColor.secondaryLabel))
            }
        }
    }
}

struct BarGraphView_Previews: PreviewProvider {
    static let someData: [Price] = [
        Price(snap: false, price: 1000, timestamp: ""),
        Price(snap: false, price: 850, timestamp: ""),
        Price(snap: false, price: 330, timestamp: ""),
        Price(snap: false, price: 200, timestamp: ""),
        Price(snap: false, price: 1000, timestamp: "")
    ]
    static var previews: some View {
        BarGraphView(data: someData)
            .frame(width: 300, height: 200)
    }
}
