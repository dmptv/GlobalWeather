//
//  ModuleRoutingHandlingProtocol.swift
//  Pods
//
//  Created by Artem Belenkov on 18/03/2020.
//

import UIKit

public protocol ModuleRoutingHandlingProtocol: class {
    func performRouteForBackRouting()
    func performRouteForCloseRouting()
    func performModuleRemovedRouting()
    func performRouteForBackOrCloseRouting()
}
