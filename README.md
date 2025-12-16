# CustomTextfield

`CustomTextfield` is a **Swift Package** that provides a reusable, highly customizable **SwiftUI TextField component**.  
It is designed to be imported into any iOS project using **Swift Package Manager (SPM)**.

---

## 📱 Platform Support

iOS 13+

SwiftUI

Swift 5.7+

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
```
### Usage

Basic TextField
```
@State private var name = ""

CustomTextfieldPackage(
    "Name",
    text: $name
)
```
Border / Underline Style
```
CustomTextfieldPackage(
    "Email",
    text: $email,
    style: .underline
)
```
Prefix & Suffix Icons
```
CustomTextfieldPackage(
    "Username",
    text: $username,
    prefixIcon: "person",
    suffixIcon: "checkmark.circle"
)
```

Password Field with Visibility Toggle
```
CustomTextfieldPackage(
    "Password",
    text: $password,
    isSecure: true,
    prefixIcon: "lock"
)
```

Floating Label with Custom Placeholder
```
CustomTextfieldPackage(
    "Enter Name",
    text: $name,
    placeholderColor: .red,
    placeholderFont: .headline
)
```

Character Limit & Keyboard Type
```
CustomTextfieldPackage(
    "Phone Number",
    text: $phone,
    characterLimit: 10,
    keyboard: .numberPad
)
```

Dropdown Mode (Optional)
```
CustomTextfieldPackage(
    "Select Country",
    text: $country,
    isDropdownEnabled: true,
    dropdownOptions: ["India", "USA", "UK"],
    onOptionSelected: { value in
        print("Selected:", value)
    }
)
```

## 👩‍💻 Author

Keerthana
iOS Developer – SwiftUI




