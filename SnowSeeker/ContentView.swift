//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Raymond Chen on 4/21/22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
struct ContentView: View {
    @State private var searchText = ""
    @State private var isShowingSort = false
    @State private var sortSelection: SortType = .none
    
    @StateObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    enum SortType {
        case none, alphabetical,country
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
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
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSort = true
                    } label : {
                        Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .confirmationDialog("Sort Resorts", isPresented: $isShowingSort) {
                Button("Default") {
                    sortSelection = .none
                }
                Button("Alphabetical") {
                    sortSelection = .alphabetical
                }
                Button("Country") {
                    sortSelection  = .country
                }
                Button("Cancel", role:.cancel) {}
            } message: {
                Text("Sort")
            }
            WelcomeView()
        }
        .phoneOnlyNavigationView()
        .environmentObject(favorites)
        
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortSelection {
        case .none:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted {
                $0.name < $1.name
            }
        case .country:
            return filteredResorts.sorted {
                $0.country < $1.country
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
