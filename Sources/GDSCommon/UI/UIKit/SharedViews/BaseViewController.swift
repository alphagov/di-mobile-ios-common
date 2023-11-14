import UIKit

public class BaseViewController: UIViewController {
    private let viewModel: BaseViewModel?
    init(viewModel: BaseViewModel?, nibName: String, bundle: Bundle) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        setBackButtonTitle(isHidden: viewModel?.backButtonIsHidden ?? false)
        
        if viewModel?.rightBarButtonTitle != nil {
            self.navigationItem.rightBarButtonItem = .init(title: viewModel?.rightBarButtonTitle?.value,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissScreen))
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.didAppear()
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true)
        
        viewModel?.didDismiss()
    }
}
