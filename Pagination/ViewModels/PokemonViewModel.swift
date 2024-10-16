//
//  PokemonViewModel.swift
//  Pagination
//
//  Created by epismac on 16/10/24.
//

import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable> ()
    private var nextURL: String? = "https://pokeapi.co/api/v2/pokemon"
    
    func fetchPokemons(){
        guard let urlString = nextURL, let url = URL (string: urlString), !isLoading else {return}
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: PokemonResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let failure) = completion {
                    print("Error fetching pokemons... :\(failure)")
                }
            }, receiveValue:{[weak self] response in
                self?.pokemons.append(contentsOf: response.results)
                self?.nextURL = response.next
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
