//
//  SecondViewController.swift
//  piscineDay02
//
//  Created by Artem Potekhin on 11.08.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var victimInfo = PersonData(name: String(), date: Date(), comment: String())

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .systemMint
//        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 0, height: 1200)
        return scrollView
    }()
    
    let background: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sheet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .purple
        textField.font = .boldSystemFont(ofSize: 25)
        textField.textAlignment = .center
        let placeholderColor = UIColor(named: "placeholder") ?? UIColor.gray
        textField.attributedPlaceholder = NSAttributedString(string: "VICTIM NAME",
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        textField.textColor = .black
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .date
        date.locale = Locale(identifier: "en_US")
        date.preferredDatePickerStyle = .wheels
        date.minimumDate = Date()
        date.setValue(UIColor.black, forKeyPath: "textColor")
        date.setValue(false, forKey: "highlightsToday")
        return date
    }()
    
    lazy var commentTextView: UITextView = {
//        let comment = UITextView(frame: CGRect(origin: CGPoint(), size: CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 150)))
        let comment = UITextView()
        comment.translatesAutoresizingMaskIntoConstraints = false
        comment.isScrollEnabled = true
        let point = CGPoint(x: 0.0, y: (comment.contentSize.height - comment.bounds.height))
        comment.setContentOffset(point, animated: true)
        comment.backgroundColor = .clear
        comment.layer.borderWidth = 2
        comment.font = .systemFont(ofSize: 20)
        comment.textColor = .black
        return comment
    }()
    
    func configureSecondVievController() {
        view.addSubview(background)
        view.addSubview(scrollView)
        
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(datePicker)
        scrollView.addSubview(commentTextView)
        
        NSLayoutConstraint.activate([
        
            background.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            nameTextField.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 150),
            
            commentTextView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            commentTextView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            commentTextView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            commentTextView.heightAnchor.constraint(equalToConstant: 300)
//            commentTextView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -25)

        ])
    }
    
    func configureUI() {
        navigationItem.title = "Add a Person"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Done",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(doneButtonTap))
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ],for: .normal)
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.backgroundColor = .black
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        registerForKeyboardNotifications()
        tapScreen()
        configureUI()
        configureSecondVievController()
        

    }
    
    @objc func doneButtonTap() {
        print("DONE button was tapped")
        grabInfo()
        if victimInfo.name != "" {
            infoDelegate?.sendPersonInfo(info: victimInfo)
            navigationController?.popViewController(animated: true)
        } else {
            showAlertController()
        }
    }
    
    private func grabInfo(){
        victimInfo.name = nameTextField.text ?? ""
        victimInfo.date = datePicker.date
        victimInfo.comment = commentTextView.text ?? ""
    }
    
    func showAlertController() {
        let alert = UIAlertController(title: "!Error!",
                                      message: "You have to put person NAME",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    deinit {
        removeForKeyboardNotifications()
    }
    
    weak var infoDelegate: InfoDelegate?

}

extension SecondViewController {
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func removeForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func kbWillShow(notification: Notification) {

//        if let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if commentTextView.text != "" {
//                scrollView.contentOffset = CGPoint.zero
//            } else if nameTextField.text != "" {
//                scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
//                scrollView.contentOffset = CGPoint(x: 0, y: 250)
//            }
//        }
    }
    
    @objc func kbWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero


        
    }
    
    func tapScreen() {
        let tapScreen = UITapGestureRecognizer(target: self,
                                               action: #selector(dismissKeyboard(sender:)))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

protocol InfoDelegate: AnyObject {
    func sendPersonInfo(info: PersonData)
}
