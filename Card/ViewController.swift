import UIKit

class ViewController: UIViewController {
    
    private var level:Level!
    
    init(level:Level){
        self.level = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

