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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = NSLocalizedString("home:title", comment: "Home View: The title of the view")
        textField.placeholder = NSLocalizedString("home:input:placeholder", comment: "Home View: The placeholder text for the username input text field")
        button.setTitle(NSLocalizedString("home:button:title", comment: "Home View: The title of the button"), for: .normal)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension HomeViewController: StoryboardView {

    func bind(reactor: HomeReactor) {
        button.rx.tap
            .map { [unowned self] in HomeReactor.Action.requestTracks(user: self.textField.text ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        reactor.state.map { $0.tracks }
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, track, cell in
                cell.textLabel?.text = track.debugDescription
            }
            .disposed(by: disposeBag)
    }
    
}
