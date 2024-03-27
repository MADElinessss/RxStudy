//
//  ValidationViewController.swift
//  RxStudy
//
//  Created by Madeline on 3/28/24.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class ValidationViewController: UIViewController {

    let usernameOutlet = UITextField()
    let usernameValidOutlet = UILabel()
    
    let passwordOutlet = UITextField()
    let passwordValidOutlet = UILabel()
    
    let doSomethingOutlet = UIButton()
    
    let minimalUsernameLength = 5
    let minimalPasswordLength = 5
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map {$0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map {$0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidOutlet)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidOutlet)
        view.addSubview(doSomethingOutlet)
        
        usernameValidOutlet.text = "이름은 최소한 \(minimalUsernameLength)글자 이상이어야 합니다."
        usernameValidOutlet.font = .systemFont(ofSize: 12, weight: .medium)
        passwordValidOutlet.text = "비밀번호는 최소한 \(minimalPasswordLength)글자 이상이어야 합니다."
        passwordValidOutlet.font = .systemFont(ofSize: 12, weight: .medium)
        
        usernameOutlet.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        usernameValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        passwordOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameValidOutlet.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        doSomethingOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordValidOutlet.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        usernameOutlet.backgroundColor = .systemGray6
        usernameOutlet.placeholder = "이름을 입력해주세요."
        usernameValidOutlet.textColor = .red
        passwordOutlet.backgroundColor = .systemGray6
        passwordOutlet.placeholder = "비밀번호를 입력해주세요."
        passwordValidOutlet.textColor = .red
        doSomethingOutlet.backgroundColor = .black
        
        doSomethingOutlet.setTitle("Do Something", for: .normal)
        doSomethingOutlet.titleLabel?.textColor = .white
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
