import Foundation

struct Country: Codable {
    let capital: String?
    let code: String
    let currency: Currency
    let flag: String
    let language: Language
    let name: String
    let region: String
    let demonym: String?

    struct Currency: Codable {
        let code: String
        let name: String
        let symbol: String?
    }

    struct Language: Codable {
        let code: String?
        let name: String
        let iso6392: String?
        let nativeName: String?

        enum CodingKeys: String, CodingKey {
            case code
            case name
            case iso6392 = "iso639_2"
            case nativeName
        }
    }
}
