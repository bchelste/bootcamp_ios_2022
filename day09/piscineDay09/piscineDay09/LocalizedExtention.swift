//
//  LocalizedExtention.swift
//  piscineDay09
//
//  Created by Artem Potekhin on 23.08.2022.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "MyLocalizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
