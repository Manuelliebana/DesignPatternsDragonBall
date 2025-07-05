import UIKit

class HeroListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let viewModel: HeroListViewModel
    
    // MARK: - Init
    init(token: String) {
        self.viewModel = HeroListViewModel(token: token)
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.onHeroesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
        viewModel.loadHeroes()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "HeroTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HeroCell")
        tableView.rowHeight = 80
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHeroes()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroTableViewCell else {
            return UITableViewCell()
        }
        let hero = viewModel.hero(at: indexPath.row)
        cell.configure(with: hero)
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let hero = viewModel.hero(at: indexPath.row)
        let detailVC = HeroDetailViewController(hero: hero, token: viewModel.token)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

