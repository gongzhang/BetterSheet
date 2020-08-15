//
//  UIHostingController+BetterSheet.swift
//  BetterSheet
//
//  Created by Peter Verhage on 07/08/2019.
//  Copyright © 2019 Peter Verhage. All rights reserved.
//
#if os(iOS)
import SwiftUI

public extension UIHostingController {
    static func withBetterSheetSupport(rootView: Content) -> UIViewController {
        let coordinator = BetterSheetCoordinator()
        
        let betterSheetSupportingRootView =
            BetterSheetSupport(coordinator: coordinator) {
                rootView
            }

        let viewController = UIHostingController<BetterSheetSupport<Content>>(rootView: betterSheetSupportingRootView)
        coordinator.viewController = viewController
        
        return viewController
    }
    
    static func withBetterSheetSupport(rootView: Content, hostingController: (AnyView) -> UIViewController) -> UIViewController {
        let coordinator = BetterSheetCoordinator()
        
        let betterSheetSupportingRootView =
            BetterSheetSupport(coordinator: coordinator) {
                rootView
            }

        let viewController = hostingController(AnyView(betterSheetSupportingRootView))
        coordinator.viewController = viewController
        
        return viewController
    }
}

public extension UIHostingController where Content == AnyView {
    
    @discardableResult
    func withBetterSheetSupport() -> Self {
        let coordinator = BetterSheetCoordinator()
        let rootView = self.rootView
        
        let betterSheetSupportingRootView =
            BetterSheetSupport(coordinator: coordinator) {
                rootView
            }

        self.rootView = AnyView(betterSheetSupportingRootView)
        coordinator.viewController = self
        return self
    }
    
}
#endif
