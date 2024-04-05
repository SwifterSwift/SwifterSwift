//
//  ViewExtensions.swift
//  SwifterSwift
//
//  Created by SwifterSwift on 06/04/2024.
//  Copyright © 2024 SwifterSwift
//

import SwiftUI

struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

private struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }

    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
    
    func fullFill() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    func fullWidth(alignment: Alignment = .center) -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
    }
    
    func fullHeight(alignment: Alignment = .center) -> some View {
        return self.frame(minHeight: 0, maxHeight: .infinity, alignment: alignment)
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
        if enabled {
            self
        } else {
            simultaneousGesture(DragGesture(minimumDistance: 0), including: .all)
        }
    }
    
    func roundedRectangleButtonStyle() -> some View {
        #if os(iOS)
        return self.padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.secondary))
        #else
        return self
        #endif
    }
    
    func stackNavigationViewStyle() -> some View {
        #if os(iOS)
        return self.navigationViewStyle(StackNavigationViewStyle())
        #else
        return self
        #endif
    }
    
    func groupedListStyle() -> some View {
        #if os(iOS)
        return self.listStyle(GroupedListStyle())
        #else
        return self
        #endif
    }
    
    func inlineNavigationBarTitle<T>(_ title: T) -> some View where T: StringProtocol {
        #if os(iOS)
        return self.navigationBarTitle(title, displayMode: .inline)
        #else
        return self.navigationTitle(title)
        #endif
    }

    func largeControlSize() -> some View {
        #if os(macOS)
        return self.controlSize(.large)
        #else
        return self
        #endif
    }
    
    func smallControlSize() -> some View {
        #if os(macOS)
        return self.controlSize(.small)
        #else
        return self
        #endif
    }
    
    func toolbarMenu<T>(_ menu: T) -> some View where T: View {
        #if os(iOS)
        return self.navigationBarItems(trailing: menu)
        #else
        return self.toolbar(content: {
            menu
        })
        #endif
    }
    
    func pickerWidthLimit(_ width: CGFloat) -> some View {
        #if os(macOS)
        return self.frame(maxWidth: width)
        #else
        return self
        #endif
    }
    
    func blurBackgroundEffect(cornerRadius: CGFloat) -> some View {
        #if os(macOS)
        return self.background(VisualEffectBlur(material: .hudWindow, blendingMode: .withinWindow, state: .followsWindowActiveState).clipShape(RoundedRectangle(cornerRadius: cornerRadius)))
        #elseif os(iOS)
        return self.background(VisualEffectBlur(blurStyle: .systemThinMaterialDark)
                                .clipShape(RoundedRectangle(cornerRadius: cornerRadius)))
        #endif
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
#endif

//View Rotation
// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    
    ///Example
    // An example view to demonstrate the solution
    //    struct ContentView: View {
    //        @State private var orientation = UIDeviceOrientation.unknown
    //
    //        var body: some View {
    //            Group {
    //                if orientation.isPortrait {
    //                    Text("Portrait")
    //                } else if orientation.isLandscape {
    //                    Text("Landscape")
    //                } else if orientation.isFlat {
    //                    Text("Flat")
    //                } else {
    //                    Text("Unknown")
    //                }
    //            }
    //            .onRotate { newOrientation in
    //                orientation = newOrientation
    //            }
    //        }
    //    }

    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
    

}

extension View {
    func isRunInPreview() -> Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}



struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

struct TabBarHeighOffsetViewModifier: ViewModifier {
    let action: (CGFloat) -> Void
//MARK: this screenSafeArea helps determine the correct tab bar height depending on device version
    private let screenSafeArea = (UIApplication.shared.windows.first { $0.isKeyWindow }?.safeAreaInsets.bottom ?? 34)
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .onAppear {
                        let offset = proxy.safeAreaInsets.bottom - screenSafeArea
                        action(offset)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        let offset = proxy.safeAreaInsets.bottom - screenSafeArea
                        action(offset)
                }
            }
        }
}
extension View {
    func tabBarHeightOffset(perform action: @escaping (CGFloat) -> Void) -> some View {
        modifier(TabBarHeighOffsetViewModifier(action: action))
    }
}


/*
 Copyright © 2020 Apple Inc.

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#if os(iOS)
public struct VisualEffectBlur<Content: View>: View {
    /// Defaults to .systemMaterial
    var blurStyle: UIBlurEffect.Style

    /// Defaults to nil
    var vibrancyStyle: UIVibrancyEffectStyle?

    var content: Content

    public init(blurStyle: UIBlurEffect.Style = .systemMaterial, vibrancyStyle: UIVibrancyEffectStyle? = nil, @ViewBuilder content: () -> Content) {
        self.blurStyle = blurStyle
        self.vibrancyStyle = vibrancyStyle
        self.content = content()
    }

    public var body: some View {
        Representable(blurStyle: blurStyle, vibrancyStyle: vibrancyStyle, content: ZStack { content })
            .accessibility(hidden: Content.self == EmptyView.self)
    }
}

// MARK: - Representable

extension VisualEffectBlur {
    struct Representable<Content: View>: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        var vibrancyStyle: UIVibrancyEffectStyle?
        var content: Content

        func makeUIView(context: Context) -> UIVisualEffectView {
            context.coordinator.blurView
        }

        func updateUIView(_ view: UIVisualEffectView, context: Context) {
            context.coordinator.update(content: content, blurStyle: blurStyle, vibrancyStyle: vibrancyStyle)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(content: content)
        }
    }
}

// MARK: - Coordinator

extension VisualEffectBlur.Representable {
    class Coordinator {
        let blurView = UIVisualEffectView()
        let vibrancyView = UIVisualEffectView()
        let hostingController: UIHostingController<Content>

        init(content: Content) {
            hostingController = UIHostingController(rootView: content)
            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            hostingController.view.backgroundColor = nil
            blurView.contentView.addSubview(vibrancyView)
            
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vibrancyView.contentView.addSubview(hostingController.view)
            vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }

        func update(content: Content, blurStyle: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle?) {
            hostingController.rootView = content

            let blurEffect = UIBlurEffect(style: blurStyle)
            blurView.effect = blurEffect

            if let vibrancyStyle = vibrancyStyle {
                vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
            } else {
                vibrancyView.effect = nil
            }

            hostingController.view.setNeedsDisplay()
        }
    }
}

// MARK: - Content-less Initializer

public extension VisualEffectBlur where Content == EmptyView {
    init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.init(blurStyle: blurStyle, vibrancyStyle: nil) {
            EmptyView()
        }
    }
}
#endif
