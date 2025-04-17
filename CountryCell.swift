import UIKit

class CountryCell: UITableViewCell {
    static let identifier = "CountryCell"

    private lazy var mainStackView = UIStackView()
    private lazy var nameAndRegionLabel = UILabel()
    private lazy var codeLabel = UILabel()
    private lazy var capitalLabel = UILabel()

    func configure(country: Country) {
        nameAndRegionLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}
