import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    // MARK: - Properties
    private let viewModel = LoginViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
        // 1. Validar que los campos no están vacíos
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController(
                title: "Campos vacíos",
                message: "Email o contraseña no pueden estar vacíos",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        // Validar formato de email
        if !email.contains("@") || !email.contains(".") {
            let alert = UIAlertController(
                title: "Email inválido",
                message: "Introduce un email válido.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        // Validar longitud de contraseña
        if password.count < 4 {
            let alert = UIAlertController(
                title: "Contraseña inválida",
                message: "La contraseña debe tener al menos 4 caracteres.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // 2. Desactivar el botón para evitar múltiples toques
        loginButton.isEnabled = false

        // 3. Realizar la llamada de login
        viewModel.login(username: email, password: password) { [weak self] success, token in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                if success, let token = token {
                    // Login exitoso
                    let heroListVC = HeroListTableViewController(token: token)
                    self?.navigationController?.pushViewController(heroListVC, animated: true)
                } else {
                    // Error en el login
                    let alert = UIAlertController(
                        title: "Error de Login",
                        message: "Usuario o contraseña incorrectos",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
