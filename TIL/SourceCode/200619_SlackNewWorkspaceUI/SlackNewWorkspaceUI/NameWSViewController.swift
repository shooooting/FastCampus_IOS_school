//
//  NameWSViewController.swift
//  SlackNewWorkspaceUI
//
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class NameWSViewController: UIViewController {
  
  let nameTextLabel: UILabel = {
    var label = UILabel()
    label.text = "Name your Workspace"
    label.font = .boldSystemFont(ofSize: 20)
    label.alpha = 0
    return label
  }()
  
  let nameTextFields: UITextField = {
    let tf = UITextField()
    tf.font = .systemFont(ofSize: 30)
    tf.autocorrectionType = .no
    tf.placeholder = "Name your Workspace"
    return tf
  }()
  
  let activityIndicator = UIActivityIndicatorView()
  
  
  fileprivate func configureNavigationBar() {
    // 왼쪽
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(tabXmarkItem))
    
    
    // 오른쪽
    navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(tabNextItem))
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  fileprivate func configureAutoLayout() {
    view.addSubview(nameTextLabel)
    view.addSubview(nameTextFields)
    view.addSubview(activityIndicator)
    
    nameTextFields.translatesAutoresizingMaskIntoConstraints = false
    nameTextLabel.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      nameTextFields.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
      nameTextFields.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -50),
      
      nameTextLabel.leadingAnchor.constraint(equalTo: nameTextFields.leadingAnchor),
      nameTextLabel.widthAnchor.constraint(equalTo: nameTextFields.widthAnchor, multiplier: 1),
      nameTextLabel.bottomAnchor.constraint(equalTo: nameTextFields.topAnchor, constant: -5),
      
      activityIndicator.leadingAnchor.constraint(equalTo: nameTextFields.leadingAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: nameTextFields.centerYAnchor)
    ])
  }
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    nameTextFields.delegate = self
    
    configureNavigationBar()
    
    configureAutoLayout()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.nameTextFields.becomeFirstResponder()
  }
  
  @objc func tabXmarkItem() {
    // 뒤로가기 버튼
    navigationController?.popViewController(animated: true)
  }
  
  @objc func tabNextItem() {
    //Next 버튼 엑션
    guard let string = nameTextFields.text else { return }
    let stringSize = (string as NSString).size()
    print(stringSize.width)
    
    self.activityIndicator.center.x += self.activityIndicator.center.x + stringSize.width*2 + 10
    self.activityIndicator.startAnimating()
    
    // 1초 뒤 activityIndicator 종료 후 다음 화면으로 이동
    let time = DispatchTime.now() + .seconds(1)
    DispatchQueue.main.asyncAfter(deadline: time) {
      self.activityIndicator.stopAnimating()
      let urlWSVC = UrlWSViewController()
      urlWSVC.userName = self.nameTextFields.text
      self.navigationController?.pushViewController(urlWSVC, animated: true)
    }
  }
}

extension NameWSViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    // 글자의 길이 구하기
    let newLength = (textField.text?.count)! + string.count - range.length
    
    if newLength > 0 && nameTextLabel.alpha != 1 {
      // nameTextLabel 나타내주는
      UIView.animate(withDuration: 0.5, animations: {
        self.nameTextLabel.center.y -= 10
        self.nameTextLabel.alpha = 1
      })
      self.navigationItem.rightBarButtonItem?.isEnabled = true
    } else if newLength == 0 {
      // nameTextLabel 사라짐
      
      UIView.animate(withDuration: 0.5, animations: {
        self.nameTextLabel.alpha = 0
        self.nameTextLabel.center.y += 10
      })
      navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    // 글자수 제한
    if newLength > 16 {
      textField.text?.removeLast()
    }
    return !(newLength > 16)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    tabNextItem()
    return true
  }
  
}
