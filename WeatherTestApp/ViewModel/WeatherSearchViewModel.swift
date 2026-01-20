//
//  WeatherSearchViewModel.swift
//  WeatherTestApp
//
//  Created by Caio Aceti on 20/01/26.
//

import Foundation

import Combine

final class WeatherSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var state: ViewState = .idle

    private let service: WeatherService
    private var cancellables = Set<AnyCancellable>()

    init(service: WeatherService = WeatherService()) {
        self.service = service
        setupBindings()
    }

    private func setupBindings() {
        $query.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
            guard let self, !text.isEmpty else {
                 return
            }
            Task { await self.search(for: text)}

        }
        .store(in: &cancellables)
    }

    private func search(for city: String) async {
        await MainActor.run { state = .loading }
        do {
            if let location = try await service.fetchCoordinates(for: city) {
                let weather = try await service.fetchWeather(for: location)
                await MainActor
                    .run {
                        state =
                            .success(
                                city: location.name,
                                temperature: weather.temperature
                            )
                    }
            } else {
                await MainActor.run { state = .empty }
            }

        } catch {
            await MainActor.run { state = .failure(error) }
        }
    }
}

enum ViewState {
    case idle
    case loading
    case success(city: String, temperature: Double)
    case empty
    case failure(Error)
}
