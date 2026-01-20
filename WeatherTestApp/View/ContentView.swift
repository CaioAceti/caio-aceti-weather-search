//
//  ContentView.swift
//  WeatherTestApp
//
//  Created by Caio Aceti on 20/01/26.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = WeatherSearchViewModel()

    var body: some View {
        VStack {
            TextField("Search City...", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding()
            Spacer()

            switch viewModel.state {
            case .idle:
                Text("Type a city to start")
            case .loading:
                ProgressView("Loading...")
            case .success(let location):
                VStack(spacing: 8) {
                    Text(location.city)
                    Text("\(location.temperature)")
                }
            case .empty:
                Text("No results found")
                    .foregroundColor(.orange)
            case .failure(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
