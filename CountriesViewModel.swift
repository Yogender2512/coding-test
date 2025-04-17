import Foundation

class CountriesViewModel {
    enum State: Equatable {
        case initial, loading, loaded, error(String)

        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial), (.loading, .loading), (.loaded, .loaded): return true
            case (.error(let lhsError), .error(let rhsError)): return lhsError == rhsError
            default: return false
            }
        }
    }

    struct CountryViewModel {
        let name: String
        let capital: String
        let region: String
        let population: String
        let flagURL: URL?
        let country: Country
    }

    private let service: CountriesServiceProtocol
    private var countries: [Country] = []
    private var filteredCountries: [Country] = []

    var state: State = .initial {
        didSet { stateChanged?(state) }
    }

    var stateChanged: ((State) -> Void)?

    init(service: CountriesServiceProtocol = CountriesService()) {
        self.service = service
    }

    var numberOfCountries: Int {
        filteredCountries.count
    }

    func countryViewModel(at indexPath: IndexPath) -> CountryViewModel? {
        guard indexPath.row < filteredCountries.count else { return nil }
        let country = filteredCountries[indexPath.row]
        return CountryViewModel(
            name: country.name,
            capital: "Capital: \(country.capital ?? "")",
            region: "Region: \(country.region)",
            population: "Population: \(formatPopulation(0))",
            flagURL: URL(string: country.flag),
            country: country
        )
    }

    func fetchCountries() {
        state = .loading
        service.fetchCountries { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countries):
                self.countries = countries
                self.filteredCountries = countries
                self.state = .loaded
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }

    func filterCountries(searchText: String) {
        filteredCountries = searchText.isEmpty ? countries :
            countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    private func formatPopulation(_ population: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: population)) ?? "\(population)"
    }
}
