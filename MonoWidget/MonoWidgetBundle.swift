//
//  MonoWidgetBundle.swift
//  MonoWidget
//
//  Created by Alexander The Great on 2026-01-26.
//

import WidgetKit
import SwiftUI

@main
struct MonoWidgetBundle: WidgetBundle {
    var body: some Widget {
        MonoWidget()
        MonoWidgetControl()
        MonoWidgetLiveActivity()
    }
}
