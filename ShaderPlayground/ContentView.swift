//
//  ContentView.swift
//  ShaderPlayground
//
//  Created by Ricardo Gonzalez on 2024-01-21.
//

import SwiftUI

struct ContentView: View {
    let start = Date()
    @State private var playheadPosition: CGFloat = 0
    var body: some View {
        TimelineView(.animation) { _ in
            VStack {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.blue)
                        .colorEffect(
                            ShaderLibrary
                                .wip(
                                    .float(Date().timeIntervalSince(start)),
                                    .float2(geometry.size)
                                )
                        )
                }
            }

        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
