//
//  ModalView.swift
//  Lofti
//
//  Created by Medi Assumani on 3/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

/**
    Defines a view that can be presented modally.
 
 - Variables:
    - backgroundview: A view that can be displayed on the background of the main view
    - dialogView: An view that can be used to interact with the user.
 
 - Methods:
    - present(animated:) - presentes the view with animation or not
    - dismiss(animated:) - dismisses the view with animation or not
 
 **/
protocol ModalViewable {
    
    var backgroundView: UIView { get set }
    var dialogView: UIView { get set }
    
    func present(animated: Bool)
    func dismiss(animated: Bool)
}
