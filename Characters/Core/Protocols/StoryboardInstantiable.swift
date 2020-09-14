//
//  StoryboardInstantiable.swift
//  Characters
//
//  Created by Coding. on 09/09/2020.
//  Copyright © 2020 Coding. All rights reserved.
//

import Foundation
import UIKit

public enum StoryboardInstantiateType {
    case initial
    case identifier(String)
}

public protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var instantiateType: StoryboardInstantiateType { get }
}

public extension StoryboardInstantiatable where Self: NSObject {
    static var storyboardName: String {
        return className
    }
    
    static var storyboardBundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }
    
    static var instantiateType: StoryboardInstantiateType {
        return .identifier(className)
    }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    static func instantiate() -> Self {
        switch instantiateType {
            case .initial:
                return storyboard.instantiateInitialViewController() as! Self
            case .identifier(let identifier):
                return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
    }
}
