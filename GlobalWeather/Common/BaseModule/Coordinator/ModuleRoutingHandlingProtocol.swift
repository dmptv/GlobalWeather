//
//  ModuleRoutingHandlingProtocol.swift
//  Pods
//
//  Created by Artem Belenkov on 18/03/2020.
//

import UIKit

protocol ModuleRoutingHandlingProtocol: AnyObject {
    func performRouteForBackRouting()
    func performRouteForCloseRouting()
    func performModuleRemovedRouting()
    func performRouteForBackOrCloseRouting()
}
