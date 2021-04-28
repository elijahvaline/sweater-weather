//
//  ActivityIndicatorView.swift
//  ActivityIndicatorView
//
//  Created by Alisa Mylnikova on 20/03/2020.
//  Copyright © 2020 Exyte. All rights reserved.
//

import SwiftUI

public struct ActivityIndicatorView: View {


    @Binding var isVisible: Bool

    public init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        
    }

    public var body: some View {
        guard isVisible else { return AnyView(EmptyView()) }

            return AnyView(ArcsIndicatorView())

    }
}
