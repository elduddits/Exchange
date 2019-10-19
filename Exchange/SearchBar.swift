//
//  SearchBar.swift
//  Exchange
//
//  Created by Eduardo Marquez on 10/18/19.
//  Copyright © 2019 Eduardo Marquez. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    var searchQuery: Binding<String>
    var action: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter item name", text: searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button(action: {
                self.action()
            }) {
                Image(systemName: "magnifyingglass.circle")
                    .font(.title)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchQuery = "Katana"
    
    static var previews: some View {
        SearchBar(searchQuery: $searchQuery, action: {
            
        })
    }
}
