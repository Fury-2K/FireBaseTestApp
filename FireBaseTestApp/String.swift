//
//  String.swift
//  FireBaseTestApp
//
//  Created by Manas Aggarwal on 30/05/19.
//  Copyright © 2019 zopsmart. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension String {
    
    func forceLocalize() -> String {
        return RemoteConfig.remoteConfig().configValue(forKey: self).stringValue ?? self
    }
    
}
