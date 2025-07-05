import UIKit

class TransformationDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    private let viewModel: TransformationDetailViewModel
    
    // MARK: - Init
    init(transformation: Transformation) {
        self.viewModel = TransformationDetailViewModel(transformation: transformation)
        super.init(nibName: "TransformationDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateAppearance()
    }
    
    private func setupUI() {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        imageView.alpha = 0
        nameLabel.alpha = 0
        descriptionLabel.alpha = 0
        if let url = URL(string: viewModel.photo) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        UIView.animate(withDuration: 0.6) {
                            self.imageView.alpha = 1
                        }
                    }
                }
            }.resume()
        }
    }
    
    private func animateAppearance() {
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [], animations: {
            self.nameLabel.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [], animations: {
            self.descriptionLabel.alpha = 1
        }, completion: nil)
    }
} 
