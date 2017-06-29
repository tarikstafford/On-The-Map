//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/24/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

