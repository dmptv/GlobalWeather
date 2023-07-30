//
//  ViewOutputProtocol.swift
//  Pods
//
//  Created by Artem Belenkov on 17/03/2020.
//

import UIKit

protocol ViewOutputProtocol: AnyObject {
    func viewDidLoad()
    
    func didGoBack()
    func didClose()
    func didGoBackOrClose()
    func didRemove()
}
