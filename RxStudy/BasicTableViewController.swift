//
//  BasicTableViewController.swift
//  RxStudy
//
//  Created by Madeline on 3/28/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class BasicTableViewController: UIViewController, UITableViewDelegate {
    
    let tableView = UITableView()
    let wireframe = DefaultWireframe()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureView()
        
        let items = Observable.just(["🍏", "🥑", "🫒", "🥗", "🧃", "🥬", "🥒", "🍋"])
        items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "\(row).\(element)"
            cell.textLabel?.textColor = .black
        }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                DefaultWireframe.presentAlert("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
