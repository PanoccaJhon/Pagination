import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()  // Instancia del ViewModel
    
    var body: some View {
        NavigationView {
            List {
                // Recorremos la lista de Pokémon y los mostramos
                ForEach(viewModel.pokemons) { pokemon in
                    
                    Text(pokemon.name.capitalized)
                        .onAppear {
                            // Si este Pokémon es el último en la lista, cargamos más
                            if pokemon == viewModel.pokemons.last {
                                viewModel.fetchPokemons()
                            }
                        }
                }
                
                // Mostrar indicador de progreso mientras se cargan más datos
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("Pokémon List")
            .onAppear {
                viewModel.fetchPokemons()  // Llamar a la API la primera vez que se muestra la vista
            }
        }
    }
}

