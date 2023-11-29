import GDSCommon
import UIKit

class MockInstructionsWithImageViewModel: InstructionsWithImageViewModel, BaseViewModel {
    var title: GDSLocalisedString
    var body: NSAttributedString
    var image: UIImage
    var warningButtonViewModel: ButtonViewModel?
    var primaryButtonViewModel: ButtonViewModel
    var secondaryButtonViewModel: ButtonViewModel?
    var rightBarButtonTitle: GDSLocalisedString?
    var backButtonIsHidden: Bool = false

    let screenView: () -> Void
    let dismissAction: () -> Void

    func didAppear() {
        screenView()
    }
    
    func didDismiss() {
        dismissAction()
    }
    
    
    init(title: GDSLocalisedString = "This is the Instructions with image view",
         body: NSAttributedString = NSAttributedString("We can use this body to provide details or context as to what we want the users to do"),
         image: UIImage = UIImage(named: "licence")!,
         warningButtonViewModel: ButtonViewModel? = nil,
         primaryButtonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel? = nil,
         rightBarButtonTitle: GDSLocalisedString? = nil,
         screenView: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        self.title = title
        self.body = body
        self.image = image
        self.warningButtonViewModel = warningButtonViewModel
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.rightBarButtonTitle = rightBarButtonTitle
        self.screenView = screenView
        self.dismissAction = dismissAction
    }
}
