//
//  BasicPickerViewController.swift
//  RxStudy
//
//  Created by Madeline on 3/28/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BasicPickerViewController: UIViewController {
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureView()
        Observable.just([1,2,3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selcted 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([1,2,3])
            .bind(to: pickerView2.rx.itemAttributedTitles) {_, item in
                return NSAttributedString(string: "\(item)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue,
                                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
    }
    
    func configureView() {
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        
        pickerView1.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        pickerView2.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(pickerView1.snp.bottom).offset(24)
        }
        
        pickerView3.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(pickerView2.snp.bottom).offset(24)
        }
        
        pickerView1.backgroundColor = .systemGray4
        pickerView2.backgroundColor = .systemGray5
        pickerView3.backgroundColor = .systemGray3
    }
}
