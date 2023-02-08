import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var isLoading: Bool = false
    @State private var isLoggedIn = false
    var body: some View {
        VStack {
            if !isLoggedIn {
                TextField("Email", text: $email)
                    .padding()
                    .background()
                    .cornerRadius(5.0)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.lightGray))
                    .cornerRadius(5.0)
                
                HStack {
                    Button(action: signUp) {
                        Text("Sign UP")
                    }
                    Button(action: login) {
                        Text("Login")
                    }
                }
                
                if isLoading {
                    ActivityIndicator(style: .large)
                }
                
                Text(error)
                    .foregroundColor(.red)
            } else {
                ContentView()
            }
        }
    }
    
    func signUp() {
        isLoading = true
        error = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false

            if let error = error {
                self.error = error.localizedDescription
            } else {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            }
        }
        
    }
    
    func login() {
        isLoading = true
        error = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.isLoggedIn = true
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    var style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}


