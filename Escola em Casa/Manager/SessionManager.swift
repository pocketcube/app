//
//  SessionManager.swift
//  Escola em Casa
//
//  Created by Miguel Pimentel on 04/10/20.
//  Copyright © 2020 Laércio Silva de Sousa Júnior. All rights reserved.
//

import Foundation

struct SessionManager {

    var isOnboardingCompleted: Bool {
        get {
            let defaults = UserDefaults.standard
            return defaults.bool(forKey: AppDefaultsKeys.onboadingCompleted.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: AppDefaultsKeys.onboadingCompleted.rawValue)
            defaults.synchronize()
        }
    }
}
