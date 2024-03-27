//
//  NumberViewController.swift
//  RxStudy
//
//  Created by Madeline on 3/28/24.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class NumberViewController: UIViewController {
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    
    let result = UILabel()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        Observable.combineLatest( // 이게 뭔가?
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty
        ) {
            textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        
        number1.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(44)
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(16)
            make.width.equalTo(300)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        result.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        number1.backgroundColor = .red
        number2.backgroundColor = .orange
        number3.backgroundColor = .green
    }
}
