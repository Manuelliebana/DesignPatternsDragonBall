import UIKit

class TransformationListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private let viewModel: TransformationListViewModel
    
    // MARK: - Init
    init(hero: Hero, token: String) {
        self.viewModel = TransformationListViewModel(hero: hero, token: token)
        super.init(nibName: "TransformationListTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.onTransformationsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] message in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
        viewModel.loadTransformations()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "TransformationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TransformationCell")
        tableView.rowHeight = 80
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTransformations()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransformationCell", for: indexPath) as? TransformationTableViewCell else {
            return UITableViewCell()
        }
        let transformation = viewModel.transformation(at: indexPath.row)
        cell.configure(with: transformation)
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let transformation = viewModel.transformation(at: indexPath.row)
        let detailVC = TransformationDetailViewController(transformation: transformation)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
