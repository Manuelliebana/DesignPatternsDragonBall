import UIKit

class HeroDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var transformationsButton: UIButton!
    
    // MARK: - Properties
    private let viewModel: HeroDetailViewModel
    private let networkModel = NetworkModel(client: APIClient())
    
    // MARK: - Init
    init(hero: Hero, token: String) {
        self.viewModel = HeroDetailViewModel(hero: hero, token: token)
        super.init(nibName: "HeroDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkTransformations()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = viewModel.name
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        favoriteLabel.text = viewModel.isFavorite ? "⭐ Favorito" : ""
        
        // Cargar imagen
        if let url = URL(string: viewModel.photo) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.heroImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    // Mostrar u ocultar el botón según si hay transformaciones
    private func checkTransformations() {
        transformationsButton.isHidden = true
        networkModel.fetchTransformations(heroId: viewModel.hero.id, token: viewModel.token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transformations):
                    self?.transformationsButton.isHidden = transformations.isEmpty
                case .failure:
                    self?.transformationsButton.isHidden = true
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction private func transformationsButtonTapped(_ sender: UIButton) {
        let transformationsVC = TransformationListTableViewController(hero: viewModel.hero, token: viewModel.token)
        navigationController?.pushViewController(transformationsVC, animated: true)
    }
}
