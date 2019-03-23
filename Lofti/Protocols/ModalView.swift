//
//  ModalView.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

protocol ModalView {
    
    var backgroundView: UIView { get set }
    var dialogView: UIView { get set }
    
    func present(animated: Bool)
    func dismiss(animated: Bool)
}
