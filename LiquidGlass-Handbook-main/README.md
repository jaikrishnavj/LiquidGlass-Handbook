# iOS 26 Liquid Glass Showcase

A comprehensive SwiftUI showcase app exploring Liquid Glass - Apple's new dynamic material that combines optical properties of glass with fluid interactions.

## ✨ Features

- 🎨 **12+ Interactive Chapters** - Each demonstrating different Liquid Glass techniques
- 🔄 **Morphing Transitions** - Smooth animations between glass shapes
- 🎯 **GlassEffectContainer** - Examples of unified and blended effects
- 💫 **Interactive Touch/Pointer** - Real-time reactions to user interactions
- 📝 **Complete Code Samples** - Every demo includes full source code
- ⚡ **Performance Optimized** - Built following SwiftUI best practices with Equatable views

## 🌟 What is Liquid Glass?

Liquid Glass is iOS 26's revolutionary material system that:
- Blurs content behind it with dynamic translucency
- Reflects colors and light from surrounding content
- Reacts to touch and pointer interactions in real time
- Morphs seamlessly between different shapes during transitions

## 📱 Chapters Overview

### 1. Toolbar with Liquid Glass
Demonstrates toolbar buttons with `.glass` style

### 2. Glass Button Styles
Showcases `.glass` and `.glassProminent` button styles

### 3. Sheet Presentations
Sheets with material backgrounds and glass effects

### 4. Scroll Edge Effects
Content blur under glass layers during scrolling

### 5. Tab Bar Glass
Tab bars with translucent glass backgrounds

### 6. Glass Effect Modifier
Using `.glassEffect()` on custom views with shapes and tints

### 7. Liquid Glass Effects
Dynamic translucent glass effects with interactivity

### 8. Search with Materials
Searchable modifier combined with glass materials

### 9. Glass Effect Container
Grouping elements with unified glass using `GlassEffectContainer`

### 10. Pickers with Glass
Selection controls styled with glass effects

### 11. System Glass Components
Alert, Menu, and ConfirmationDialog with glass styling

### 12. Fluid Morphing Animation
Advanced morphing transitions with `glassEffectID` and `glassEffectUnion`

## 🚀 Key APIs Demonstrated

### Basic Glass Effect
```swift
Text("Hello, World!")
    .font(.title)
    .padding()
    .glassEffect()
```

### Interactive Glass with Custom Shape
```swift
Text("Hello, World!")
    .font(.title)
    .padding()
    .glassEffect(.regular.tint(.orange).interactive())
    .glassEffect(in: .rect(cornerRadius: 16.0))
```

### Morphing Transitions
```swift
@State private var isExpanded = false
@Namespace private var namespace

GlassEffectContainer(spacing: 40.0) {
    HStack(spacing: 40.0) {
        Image(systemName: "scribble.variable")
            .frame(width: 80, height: 80)
            .font(.system(size: 36))
            .glassEffect()
            .glassEffectID("pencil", in: namespace)

        if isExpanded {
            Image(systemName: "eraser.fill")
                .frame(width: 80, height: 80)
                .font(.system(size: 36))
                .glassEffect()
                .glassEffectID("eraser", in: namespace)
                .transition(.glassEffectTransition(.matchedGeometry))
        }
    }
}

Button("Toggle") {
    withAnimation {
        isExpanded.toggle()
    }
}
.buttonStyle(.glass)
```

### Unified Glass Effects
```swift
let symbols = ["cloud.bolt.rain.fill", "sun.rain.fill"]

GlassEffectContainer(spacing: 20.0) {
    HStack(spacing: 20.0) {
        ForEach(symbols.indices, id: \.self) { index in
            Image(systemName: symbols[index])
                .frame(width: 80, height: 80)
                .font(.system(size: 36))
                .glassEffect()
                .glassEffectUnion(id: "weather", namespace: namespace)
        }
    }
}
```

## 📋 Requirements

- iOS 26.0+
- Xcode 16.0+
- Swift 6.0+

## 🛠 Installation

1. Clone this repository
```bash
git clone https://github.com/yourusername/iOS26-LiquidGlass-Showcase.git
```

2. Open the project in Xcode
```bash
cd iOS26-LiquidGlass-Showcase
open GlassEffectSample.xcodeproj
```

3. Build and run on iOS 26 device or simulator

## 🎯 Project Structure

```
GlassEffectSample/
├── Views/
│   ├── TableOfContentsView.swift
│   ├── ChapterDetailView.swift
│   ├── CodeDetailView.swift
│   └── ExplanationDetailView.swift
├── Chapters/
│   ├── ToolbarGlassDemo.swift
│   ├── GlassButtonStylesDemo.swift
│   ├── SheetGlassDemo.swift
│   ├── ScrollEdgeEffectDemo.swift
│   ├── TabBarGlassDemo.swift
│   ├── GlassEffectModifierDemo.swift
│   ├── VibrancyEffectsDemo.swift
│   ├── SearchGlassDemo.swift
│   ├── GlassEffectContainerDemo.swift
│   ├── PickerGlassDemo.swift
│   ├── SystemGlassComponentsDemo.swift
│   └── FluidMorphingAnimationDemo.swift
├── Components/
│   ├── ChapterCard.swift
│   ├── ModernChapterCard.swift
│   ├── InfoCard.swift
│   ├── ActionButtonsCard.swift
│   ├── CodeSection.swift
│   └── DemoSection.swift
└── Models/
    └── Chapter.swift
```

## 🎨 Design Principles

- **Performance First** - All views implement `Equatable` for optimal SwiftUI diffing
- **Component Splitting** - Views are broken down following SwiftUI recommendations
- **No Force Unwrapping** - Safe optional handling throughout
- **Optimized Code** - No redundant code, clean implementations
- **Best Practices** - Follows Apple's SwiftUI guidelines

## 💡 Learning Resources

This app demonstrates concepts from:
- [Apple's Liquid Glass Documentation](https://developer.apple.com/documentation/swiftui/styling-views-with-liquid-glass)
- Landmarks: Building an app with Liquid Glass sample
- WWDC 2026 sessions on Liquid Glass

## 📄 License

This project is available under the MIT License.

## 👤 Author

Created as a comprehensive learning resource for iOS 26's Liquid Glass API.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

## ⭐ Show Your Support

If this project helped you learn Liquid Glass, give it a star!

---

**Note:** This is a showcase/learning project. iOS 26 is required to run the app as it uses platform-specific APIs.
