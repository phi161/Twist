//
//  ViewController.swift
//  Twist
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var recommendationsInteractor: RecommendationsInteractor

    required init?(coder aDecoder: NSCoder) {
        let httpClient = HTTPClient()
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
