//
//  SecondViewController.swift
//  piscineDay09
//
//  Created by Artem Potekhin on 23.08.2022.
//

import Foundation
import UIKit
import ArticleManager

class SecondViewController: UIViewController {
    
    var currentArticle: Article?
    
    func getCurrentArticle(article: Article?) {
        self.currentArticle = article
        if currentArticle == nil {
            currentArticle = ArticleManager.shared.newArticle()
            currentArticle?.creationDate = Date()
        }
    }
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20)
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.placeholder = "title...".localized()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.textAlignment = .left
        textField.textColor = .black
        return textField
    }()
    
    let contentTextView: UITextView = {
        let content = UITextView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.isScrollEnabled = true
        let point = CGPoint(x: 0.0, y: (content.contentSize.height - content.bounds.height))
        content.setContentOffset(point, animated: true)
        content.backgroundColor = .clear
        content.font = .systemFont(ofSize: 15)
        content.textColor = .black
        content.layer.borderWidth = 2
        content.layer.cornerRadius = 5
        return content
    }()
    
    let takePictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Take Picture".localized(), for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    let choosePictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose Picture".localized(), for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        takePictureButton.addTarget(self,
                                    action: #selector(takePicture),
                                    for: .touchUpInside)
        choosePictureButton.addTarget(self,
                                      action: #selector(choosePicture),
                                      for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [takePictureButton, choosePictureButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 100
        return stack
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var articleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleTextField,
                                                   contentTextView,
                                                   buttonStack,
                                                   imageView])
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = .orange
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing =  5
        return stack
    }()
    
    func setConstraints() {
        view.addSubview(articleStackView)
        
        NSLayoutConstraint.activate([
            
            titleTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                                  multiplier: 0.75),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            contentTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                                   multiplier: 0.75),
            contentTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                    multiplier: 0.35),
            
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                             multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                              multiplier: 0.35),
            
            articleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 5),
            articleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 5),
            articleStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -5),
            articleStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -5)
        ])
    }
    
    
    
    func configureSecondViewController() {
        view.backgroundColor = .systemGray5
        self.title = "Article".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel".localized(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonTap))
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Save".localized(),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(saveButtonTap))
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            .foregroundColor: UIColor.link,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ],for: .normal)
        
        self.titleTextField.delegate = self
        self.contentTextView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSecondViewController()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.refreshViewData()
        }
    }
    
    func refreshViewData() {
        titleTextField.text = currentArticle?.title
        contentTextView.text = currentArticle?.content
        imageView.image = UIImage(data: currentArticle?.image ?? Data())
    }
    
    @objc func saveButtonTap() {
        print("save button was tapped")
        if let savedArticle = currentArticle {
            savedArticle.language = Locale.current.languageCode
            savedArticle.title = titleTextField.text
            savedArticle.content = contentTextView.text
            savedArticle.modificationDate = Date()
            savedArticle.image = imageView.image?.pngData()
            ArticleManager.shared.save()
            print(ArticleManager.shared.getAllArticles().count)
        }
   

        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonTap() {
        print("cancel button was tapped")
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func takePicture() {
        print("take picture was tapped")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func choosePicture() {
        print("choose picture was tapped")
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SecondViewController: UITextViewDelegate, UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true,
                       completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,
                       completion: nil)
    }
    
}
