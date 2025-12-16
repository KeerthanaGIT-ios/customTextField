// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum CustomTextFieldStyle {
    case border
    case underline
}


public struct CustomTextfieldPackage: View {
    @Binding var text: String
    
    private var placeholder: String
    private var isSecure: Bool
    private var fieldStyle: CustomTextFieldStyle
    private var prefixIcon: String?
    private var suffixIcon: String?
    private var onSuffixTap: (() -> Void)?
    private var characterLimit: Int?
    private var keyboard: UIKeyboardType
    private var placeholderColor: Color
    private var placeholderFont: Font
    
    // NEW: Dropdown support
    private var isDropdownEnabled: Bool
    private var dropdownOptions: [String]
    private var onOptionSelected: ((String) -> Void)?

    @State private var showDropdown: Bool = false
    @State private var secureVisible: Bool = false
    @FocusState private var isFocused: Bool

    
    public init(
        _ placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        style: CustomTextFieldStyle = .border,
        prefixIcon: String? = nil,
        suffixIcon: String? = nil,
        onSuffixTap: (() -> Void)? = nil,
        characterLimit: Int? = nil,
        keyboard: UIKeyboardType = .default,
        placeholderColor: Color = .gray.opacity(0.6),
        placeholderFont: Font = .body,
        isDropdownEnabled: Bool = false,
        dropdownOptions: [String] = [],
        onOptionSelected: ((String) -> Void)? = nil,
        //New
        isRequired: Bool = false,
        requiredMessage: String = "This field is required"


    ) {
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.fieldStyle = style
        self.prefixIcon = prefixIcon
        self.suffixIcon = suffixIcon
        self.onSuffixTap = onSuffixTap
        self.characterLimit = characterLimit
        self.keyboard = keyboard
        self.placeholderColor = placeholderColor
        self.placeholderFont = placeholderFont
        self._secureVisible = State(initialValue: !isSecure)
        self.isDropdownEnabled = isDropdownEnabled
        self.dropdownOptions = dropdownOptions
        self.onOptionSelected = onOptionSelected
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            
            ZStack(alignment: .leading) {
                
          
                // NEW: FLOATING LABEL
    
                Text(placeholder)
                    .foregroundColor(isFocused ? .blue : placeholderColor)
                    .font(placeholderFont)
                    .offset(y: (isFocused || !text.isEmpty) ? -20 : 0)
                    .scaleEffect((isFocused || !text.isEmpty) ? 0.75 : 1.0, anchor: .leading)
                    .animation(.easeInOut(duration: 0.20), value: isFocused)
                    .animation(.easeInOut(duration: 0.20), value: text)
                    .padding(.leading, prefixIcon == nil ? 0 : 24)
                
                // FIELD + ICONS
                HStack(spacing: 10) {
                    
                    if let prefixIcon = prefixIcon {
                        Image(systemName: prefixIcon)
                            .foregroundColor(isFocused ? .blue : .gray)
                    }
                    
   
                    // FIELD: supports secure toggle

                    Group {
                        if isSecure && !secureVisible {
                            SecureField("", text: $text)
                                .disabled(isDropdownEnabled)
                                .focused($isFocused)
                                .keyboardType(keyboard)
                                .onChange(of: text) { applyCharacterLimit($0) }
                        } else {
                            TextField("", text: $text)
                                .disabled(isDropdownEnabled)
                                .focused($isFocused)
                                .keyboardType(keyboard)
                                .onChange(of: text) { applyCharacterLimit($0) }
                        }
                    }
                    
             
                    // NEW: PASSWORD VISIBILITY TOGGLE
                
                    if isSecure {
                        Button {
                            secureVisible.toggle()
                        } label: {
                            Image(systemName: secureVisible ? "eye" : "eye.slash")
                                .foregroundColor(isFocused ? .blue : .gray)
                        }
                    }
                    // Custom suffix icon
                    else if let suffixIcon = suffixIcon {
                        if let onSuffixTap = onSuffixTap {
                            Button(action: onSuffixTap) {
                                Image(systemName: suffixIcon)
                                    .foregroundColor(isFocused ? .blue : .gray)
                            }
                        } else {
                            Image(systemName: suffixIcon)
                                .foregroundColor(isFocused ? .blue : .gray)
                        }
                    }
                    
                    // NEW: DROPDOWN BUTTON
                    if isDropdownEnabled {
                        Button {
                            showDropdown.toggle()
                            isFocused = false
                        } label: {
                            Image(systemName: showDropdown ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }

                }
                .padding(.top, (isFocused || !text.isEmpty) ? 12 : 0) // NEW (push field down)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .background(backgroundView)
            
            
            if isDropdownEnabled && showDropdown {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(dropdownOptions, id: \.self) { option in
                            Button {
                                text = option
                                showDropdown = false
                                onOptionSelected?(option)
                            } label: {
                                Text(option)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }

                            Divider()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3))
                    )
                    .padding(.top, 4)
                }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
    
    private func applyCharacterLimit(_ value: String) {
        if let limit = characterLimit, value.count > limit {
            text = String(value.prefix(limit))
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch fieldStyle {
        case .border:
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color.blue : Color.gray.opacity(0.4), lineWidth: 1.5)
            
        case .underline:
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: isFocused ? 2 : 1)
                    .foregroundColor(.gray.opacity(0.4))
            }
        }
    }
}


#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var country = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // bordered
            CustomTextfieldPackage("Name", text: $name, style: .border, prefixIcon: "person")
            
            // underlined
            CustomTextfieldPackage("Email", text: $email, style: .underline)
            
            CustomTextfieldPackage(
                "Password",
                text: $password,
                isSecure: true,
                prefixIcon: "lock",
                suffixIcon: "eye",
                onSuffixTap: { print("Toggle visibility") }
            )
            
            CustomTextfieldPackage(
                "Enter name",
                text: $name,
                placeholderColor: .red,
                placeholderFont: .headline
            )
            CustomTextfieldPackage(
                "Select Country",
                text: $country,
                isDropdownEnabled: true,
                dropdownOptions: ["India", "USA", "UK", "Germany"],
            )

            
            
        }
        .padding()
    }
}
