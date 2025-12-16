# CustomTextfield

`CustomTextfield` is a **Swift Package** that provides a reusable, highly customizable **SwiftUI TextField component**.  
It is designed to be imported into any iOS project using **Swift Package Manager (SPM)**.

---

## ✨ Features

- Floating label (Material-style)
- Border & underline textfield styles
- Prefix & suffix SF Symbols
- Password visibility toggle (eye / eye.slash)
- Character limit support
- Keyboard type configuration
- Custom placeholder color & font
- Focus highlight
- Optional dropdown mode
- SwiftUI Preview support
- Lightweight & dependency-free

---

## 📦 Installation (Swift Package Manager)

### Using Xcode

1. Open your project in **Xcode**
2. Go to **File → Add Packages**
3. Enter the repository URL: https://github.com/KeerthanaGIT-ios/customTextField
4. Add the package to your app target

---

### Using `Package.swift`

```swift
dependencies: [
 .package(
     url: "https://github.com/your-username/CustomTextfield",
     from: "1.0.0"
 )
]
Then add it to your target:
.target(
    name: "YourAppTarget",
    dependencies: ["CustomTextfield"]
)




