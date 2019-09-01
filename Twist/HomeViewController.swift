//
//  HomeViewController.swift
//  Twist
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var recommendationsInteractor: RecommendationsInteractorType

    required init?(coder aDecoder: NSCoder) {
        let httpClient = HTTPClient(isStubbed: true)
        let userRepository = UserRepository(client: httpClient)
        recommendationsInteractor = RecommendationsInteractor(userRepository: userRepository)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        recommendationsInteractor
            .tracks(user: "")
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, model, cell in
                cell.textLabel?.text = model.debugDescription
            }
            .disposed(by: disposeBag)
    }
}
