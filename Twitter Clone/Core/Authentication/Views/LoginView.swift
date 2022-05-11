//
//  LoginView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct LoginView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	@EnvironmentObject var viewModel: AuthViewModel
	
	@State private var showSignup: Bool = false
	
    var body: some View {
		VStack(alignment: .leading) {
			
			// header view
			AuthenticationHeaderView(title: "Hello.", subtitle: "Welcome Back", leadingPadding: 30)
				.ignoresSafeArea()
			
			Spacer()
				.frame(maxHeight: 50)
			
			// body and footer view
			VStack(spacing: 30) {
				CustomTextField(image: "envelope", placeholder: "Email", text: $email, isSecureInput: false)
				CustomTextField(image: "lock", placeholder: "Password", text: $password, isSecureInput: true)
				
				HStack {
					Spacer()
					NavigationLink {
						Text("Forgot password")
					} label: {
						Text("Forgot Password?")
							.fontWeight(.semibold)
							.font(.caption)
					}
				}
				
				AuthButton(with: "Sign in") {
					viewModel.login(withEmail: email, password: password)
				}
				
				Spacer()
				
				NavigationButton(showNextView: $showSignup) {
					HStack {
						Text("Don't have an account?")
						Text("Sign Up")
							.fontWeight(.semibold)
					}
					.font(.callout)
					.padding(.bottom, 30)
				} destination: {
					SignupView()
				}
			}
			.padding(.horizontal, 30)
			
			
			
			
		}
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
