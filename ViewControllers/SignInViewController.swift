import UIKit
import Parse

class SignInViewController: UIViewController {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let titleLabel = UILabel()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let backgroundImageView = UIImageView()
    
    private let viewModel = SignVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotifications()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupNotifications() {
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(signUpCompleted), name: NSNotification.Name("kayit tamamlandi"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(signUpError), name: NSNotification.Name("kayit hatasi"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(signUpCompleted), name: NSNotification.Name("giriş yapıldı"), object: nil)
    }
    
    @objc private func signUpCompleted() {
        self.navigationController?.show(HomePage(), sender: nil)
    }
    
    @objc private func signUpError() {
        showAlert(title: "Error", message: "Error while signing up")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        // Background Image
        backgroundImageView.frame = view.bounds
        backgroundImageView.image = UIImage(named: "one")
        view.addSubview(backgroundImageView)
        
        // Title Label
        titleLabel.frame = CGRect(x: 10, y: 80, width: screenWidth - 20, height: 65)
        titleLabel.text = "FourSquare Clone (Parse)"
        titleLabel.font = UIFont(name: "Papyrus", size: 27)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 10
        titleLabel.layer.borderWidth = 0.6
        titleLabel.clipsToBounds = true
        titleLabel.backgroundColor = .systemPink
        view.addSubview(titleLabel)
        
        // Email TextField
        emailTextField.frame = CGRect(x: 25, y: 200, width: screenWidth - 50, height: 40)
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter your email"
        view.addSubview(emailTextField)
        
        // Password TextField
        passwordTextField.frame = CGRect(x: 25, y: 270, width: screenWidth - 50, height: 40)
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        // Sign In Button
        setupButton(signInButton, title: "Sign In", frame: CGRect(x: 30, y: 350, width: 80, height: 50), action: #selector(signIn))
        
        // Sign Up Button
        setupButton(signUpButton, title: "Sign Up", frame: CGRect(x: screenWidth - 110, y: 350, width: 80, height: 50), action: #selector(signUp))
    }
    
    private func setupButton(_ button: UIButton, title: String, frame: CGRect, action: Selector) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.6
        button.clipsToBounds = true
        button.frame = frame
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func signIn() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Username/password not entered")
            return
        }
        viewModel.signInFonk(email: email, password: password)
    }
    
    @objc private func signUp() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Username/password not entered")
            return
        }
        viewModel.signUpFonk(email: email, password: password)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

