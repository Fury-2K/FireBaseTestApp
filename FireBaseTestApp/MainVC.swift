//
//  MainVC.swift
//  FireBaseTestApp
//
//  Created by Manas Aggarwal on 29/05/19.
//  Copyright © 2019 zopsmart. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class MainVC: UIViewController {

    let fileURL = Bundle.main.path(forResource: "test", ofType: "txt")
    var newStore: [String] = []
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultValues()
        label1.text = "DEFAULT"
        label2.text = "DEFAULT"
        label3.text = "DEFAULT"
    }
    
    func setupDefaultValues() {
        let url = "http://www.mocky.io/v2/5cef7d4c3000008f363cd06c"
        self.fetchData(url: url, callback: { response in
            self.newStore = response
            var defaultValues: [String: Any] = [:]
            var i = 1
            for store in self.newStore {
                defaultValues["store\(i)"] = store
                i += 1
            }
            RemoteConfig.remoteConfig().setDefaults(defaultValues as? [String : NSObject])
            self.fetchRemoteConfig()
        })
    }
    
    func fetchRemoteConfig() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { [weak self] (status,error) in
            guard error == nil else {
                print("Failed to fetch")
                return
            }
            print("Fetch Successful")
            RemoteConfig.remoteConfig().activateFetched()
            self?.updateView()
        }
    }
    
    func updateView() {
        let labelArray: [UILabel] = [
        label1,
        label2,
        label3
        ]
        for i in 1...newStore.count {
            labelArray[i - 1].text = "store\(i)".forceLocalize()
        }
    }

}

extension MainVC {
    func fetchData(url: String, callback: @escaping ([String]) -> Void) {
        Alamofire.request(url)
            .responseJSON { response in
                if let data = response.result.value {
                    guard let dataField = data as? [String : Any],
                        let store1 = dataField["store1"] as? String,
                        let store2 = dataField["store2"] as? String,
                        let store3 = dataField["store3"] as? String
                        else {
                            print("Failed to read .JSON")
                            return
                    }
                    var result: [String] = []
                    let x1 = store1
                    let x2 = store2
                    let x3 = store3
                    result.append(x1)
                    result.append(x2)
                    result.append(x3)
                    callback(result)
                }
        }
    }

}
