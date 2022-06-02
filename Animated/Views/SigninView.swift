//
//  SigninView.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 28/05/22.
//

import SwiftUI
import RiveRuntime

struct SigninView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @Binding var showModal: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
        
    var body: some View {
        VStack(spacing: 24) {
            title
            description
            
            emailTextField
            passwordTextField
            
            singInButton
            
            customDivider
            signUpText
            signUpLogos
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(roundedRectangle)
        .padding()
        .overlay(
            ZStack {
                if isLoading {
                    check.view().frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view().scaleEffect(3).allowsHitTesting(false)
            }
        )
    }
    
    //log in func used in signInButton
    func logIn() {
        HapticManager.instance.notification(type: .success)
        HapticManager.instance.impact(style: .medium)
        isLoading = true
        
        if email != "" {
            print(isLoading)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                try? check.triggerInput("Check")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
                try? confetti.triggerInput("Trigger explosion")
                HapticManager.instance.notification(type: .success)
                HapticManager.instance.impact(style: .soft)
            }
        } else {
            print(isLoading)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                try? check.triggerInput("Error")
                HapticManager.instance.notification(type: .error)
                HapticManager.instance.impact(style: .heavy)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation { showModal = false }
        }
    }
    
    func emailCheck(_ string: String) -> Bool {
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView(showModal: .constant(true))
            .preferredColorScheme(.dark)
    }
}

extension SigninView {
    private var title: some View {
        Text("Sign In")
            .customFont(.largeTitle)
    }
    private var description: some View {
        Text("Access to 240+ hours of content. Learn design and code, by building real apps with React and Swift")
            .customFont(.headline)
    }
    private var emailTextField: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            TextField("", text: $email)
                .customTextField().foregroundColor(.black)
        }
    }
    private var passwordTextField: some View {
        VStack(alignment: .leading) {
            Text("Passowrd")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            SecureField("", text: $password)
                .customTextField(Image("Icon Lock")).foregroundColor(.black)
        }
    }
    private var singInButton: some View {
        Button {logIn()} label: {
            Label("Sign In", systemImage: "arrow.right")
                .customFont(.headline)
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FF7D8E"))
                .foregroundColor(.white)
                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: "FF7D8E").opacity(0.5), radius: 20, x: 0, y: 10)
        }
        //.disabled(email.isEmpty)
    }
    private var customDivider: some View {
        HStack {
            Rectangle().frame(height: 1).opacity(0.1)
            Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
            Rectangle().frame(height: 1).opacity(0.1)
        }
    }
    private var signUpText: some View {
        Text("Sign up with Email, Apple or Google")
            .customFont(.subheadline)
            .foregroundColor(.secondary)
    }
    private var signUpLogos: some View {
        HStack {
            Image("Logo Email")
            Spacer()
            Image("Logo Apple")
            Spacer()
            Image("Logo Google")
        }
    }
    private var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(.linearGradient(
                colors: [.white.opacity(0.8), .white.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
    }
}
