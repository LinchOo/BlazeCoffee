import FirebaseAuth
import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel : userViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var repass: String = ""
    @State var isPassVisible: Bool = false
    @State var error = ""
    @State var isLogin = true
    @State var refferal: String = ""
    @State var isAlert: Bool = false
    @State var errorText: String = ""

    var body: some View {
        VStack(spacing: 65){
            VStack{
//                Text("Blaze Coffee")
//                    .font(.system(size: 40, weight: .bold, design: .serif))
//                    .foregroundColor(.brown)
//                    .shadow(color: .white.opacity(0.7), radius: 0.3, x: 1, y: 1)
//                    .shadow(color: .white.opacity(0.7), radius: 0.3, x: -1, y: -1)
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
            }
            VStack{
                VStack(spacing: 5){
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .background(Rectangle().fill(.brown))
                        TextField("Email",text: $email)
                    }
                    .background(Rectangle().stroke(lineWidth: 0.3))
                    HStack{
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .background(Rectangle().fill(.brown))
                        if isPassVisible {
                            TextField("Password", text: $password)
                        }else {
                            SecureField("Password", text: $password)
                        }
                        Button{
                            isPassVisible.toggle()
                        }label: {
                            Image(systemName: isPassVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.trailing, 5)
                    }
                    .background(Rectangle().stroke(lineWidth: 0.3))
                    if !isLogin {
                        HStack{
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .background(Rectangle().fill(.brown))
                            if isPassVisible {
                                TextField("Confirm Password", text: $repass)
                            }else {
                                SecureField("Confirm Password", text: $repass)
                            }
                        }
                        .background(Rectangle().stroke(lineWidth: 0.3))
                        HStack{
                            Image("promo-code")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .background(Rectangle().fill(.brown))
                            TextField("Referral Code", text: $refferal)
                        }
                        .background(Rectangle().stroke(lineWidth: 0.3))
                    }
                }
                .frame(width: 200)
                .padding()
                if !isLogin{
                    Spacer()
                }
                HStack{
                    Button{
                        if isLogin{
                            signIn()
                        }else {
                            signUp()
                        }
                    }label: {
                        Text(isLogin ? "LOGIN" : "Register")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .frame(width: 200, height: 35)
                .background(Color.brown)
                Button{
                    withAnimation {
                        isLogin.toggle()
                    }
                }label: {
                    Text(isLogin ? "new member?" : "Login")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .frame(width: 200, height: 25)
                .background(Color.white.opacity(0.1))

                .cornerRadius(15, corners: .bottomLeft)
                .cornerRadius(15, corners: .bottomRight)
            }
            .padding()
            .frame(width: 250, height: 250)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .overlay(alignment: .top, content: {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Circle().fill(.brown))
                    .offset(y:-50)
            })
            .shadow(color: .white, radius: 1, x: 1, y: 1)
            .shadow(color: .white, radius: 1, x: -1, y: -1)
            Spacer()
        }
        .overlay(alignment: .center, content: {
            if isAlert{
                AlertView
            }
        })
        .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
    private var AlertView: some View {
        VStack{
            VStack{
                Text("Error!")
                    .frame(width: 500, height: 35)
                    .background{
                        Rectangle().fill(Color.brown)
                    }
                Text(errorText)
                    .minimumScaleFactor(0.7)
                    .lineLimit(5)
                Spacer()
                Button{
                    isAlert.toggle()
                }label: {
                    Text("ok")
                        .foregroundColor(.white)
                }
                .frame(width: 500, height: 35)
                .background{
                    Rectangle().fill(Color.brown)
                }
            }
            .background{
                Color.brown.opacity(0.3)
                    .shadow(color: .white, radius: 1, x: 1, y: 1)
                    .shadow(color: .white, radius: 1, x: -1, y: -1)
            }
            .frame(width: 200, height: 200)
            .cornerRadius(15)
            .clipped()

        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial.opacity(0.6))
    }
    func signIn(){
        if email != "" && password != "" {
            Auth.auth().signIn(withEmail: email, password: password){
                res, error in
                if error != nil {
                    errorText = error!.localizedDescription
                    isAlert.toggle()
                }
                viewModel.isAuth = true
                if email.lowercased() == "john@gmail.com" {
                    viewModel.points = 200
                    viewModel.getName()
                } else {
                    let points = UserDefaults.standard.integer(forKey: "\(email.lowercased())")
                    viewModel.points = points
                    viewModel.getName()
                }
            }
        } else {
            errorText = "Fill all contents properly"
            isAlert.toggle()
        }
    }
    func signUp() {
        if email != "" && password != "" {
            if password == repass {
                Auth.auth().createUser(withEmail: email, password: password){ res, error in
                    if error != nil {
                        errorText = error!.localizedDescription
                        isAlert.toggle()
                    }
                    viewModel.isAuth = true
                    if refferal == "M9zOhFplQya9UneEKTkFbAOxy8t1"{
                        UserDefaults.standard.set(100, forKey: "\(email.lowercased())")
                        viewModel.points = 100
                        refferal = ""
                    }
                }
            } else {
                errorText = "Password mismatch"
                isAlert.toggle()
            }
        } else {
            errorText = "Fill all contents properly"
            isAlert.toggle()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(userViewModel())
    }
}
