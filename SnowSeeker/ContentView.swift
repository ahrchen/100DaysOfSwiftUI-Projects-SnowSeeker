//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Raymond Chen on 4/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink {
                    Text(resort.name)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Resorts")
        }
        
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
