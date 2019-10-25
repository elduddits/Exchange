//
//  BarGraphComponent.swift
//  Exchange
//
//  Created by Eduardo Salinas on 25/10/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

class BarGraphData: ObservableObject, Identifiable, Equatable {
    static func == (lhs: BarGraphData, rhs: BarGraphData) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let amount: CGFloat
    let maxAmount: CGFloat
    let date: Date
    
    @Published var isSelected: Bool = false
    
    var barHeight: CGFloat {
        amount / maxAmount
    }
    
    init(amount: CGFloat, maxAmount: CGFloat, date: Date) {
        self.amount = amount
        self.maxAmount = maxAmount
        self.date = date
    }
}

struct BarGraphComponent: View {
    
    @ObservedObject var data: BarGraphData
    
    let height: CGFloat
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 5)
            .speed(2)
            .delay(0.03)
    }
    
    var body: some View {
        Rectangle()
            .fill(data.isSelected ? Color.green : Color.blue)
            .frame(maxWidth: 20,
                   maxHeight: height * data.barHeight,
                   alignment: .bottom)
        
        
    }
}

struct BarGraphComponent_Previews: PreviewProvider {
    static var previews: some View {
        let data = BarGraphData(amount: 40, maxAmount: 50, date: Date())
        return BarGraphComponent(data: data, height: 100)
                .frame(width: 20, height: 150)
    }
}
