//
//  ViewController.swift
//  piscineDay07V3
//
//  Created by Artem Potekhin on 19.08.2022.
//

import UIKit
import RecastAI
import CoreLocation
import ForecastIO

class ViewController: UIViewController {
    
    let locationController = RecastAIController()
    let forecastController = ForecastIOController()
 
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 10
        button.tintColor = .white
        button.setTitle("Search ", for: .normal)
        let buttonImage = UIImage(systemName: "magnifyingglass.circle.fill")
        button.setImage(buttonImage, for: .normal)
        button.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        label.text = "search Result"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 25)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    func configureViewController() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        view.addSubview(label)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        label.textColor = .clear
        self.textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 250),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20),
            label.widthAnchor.constraint(equalTo: textField.widthAnchor),
            label.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewController()
        
    }
    
//    @objc func buttonTap() {
//        print("button was tapped")
//        let request = textField.text ?? ""
//        locationController.makeTextRequest(text: request) { result in
//            do {
//                let currentLongitude = try result.get().longitude
//                let currentLatitude = try result.get().latitude
//                let currentLocation = CLLocationCoordinate2D(latitude: currentLatitude,
//                                                             longitude: currentLongitude)
//                print(currentLocation)
//                self.forecastController.getForecast(location: currentLocation) { forecast in
//                    print(forecast)
//                    do {
//                        let textForecast = try forecast.get().currently
//                        if let forOutput = textForecast {
//                            self.output.initWeatherData(reply: forOutput)
//
//                        }
//
//
//                    } catch {
//
//                    }
//                }
//            } catch {
//                print(result)
//            }
//        }
//
//
//    }
    
    @objc func buttonTap() {
        textField.resignFirstResponder()
        self.button.isEnabled = false
            print("button was tapped")
            self.label.textColor = .clear
            let request = self.textField.text ?? ""
            self.textField.text = ""
            self.locationController.makeTextRequest(text: request) { result in
                switch result {
                case .success(let currentLocation):
//                    print(currentLocation)
                    self.forecastController.getForecast(location: currentLocation) { forecast in
                        switch forecast {
                        case .success(let replyForecast):
//                            print(replyForecast)
                            DispatchQueue.main.async {
                                self.updateWeatherData(forecast: replyForecast)
                            }
                           
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.wrongLocation()
                    }
                }
                
                    
            }
        self.button.isEnabled = true
        
        
       
    }
    
    func updateWeatherData(forecast: Forecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let tmpDate = forecast.currently?.time ?? Date()
        let time = dateFormatter.string(from: tmpDate)
        let windSpeed = forecast.currently?.windSpeed ?? 0.0
        var temperature = forecast.currently?.temperature ?? 0.0
        temperature = (temperature - 32) * 5 / 9
        let stringTemperature = String(format: "%.2f", temperature)
        var pressure = forecast.currently?.pressure ?? 0.0
        pressure *= 0.7268
        let stringPressure = String(format: "%.2f", pressure)
        let tmpString =  "TZ: \(forecast.timezone)\n" +
                        "\(time)\n" +
                        "wind speed: \(windSpeed) mps\n" +
                        "temp: \(stringTemperature) C\n" +
                        "pres: \(stringPressure) mmHg"
        label.text = tmpString
        label.textColor = .link
    }
    
    func wrongLocation() {
        label.text = "Wrong location!"
        label.textColor = .red
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

}


