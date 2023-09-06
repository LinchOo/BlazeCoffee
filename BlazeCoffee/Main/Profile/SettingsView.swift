import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var viewModel: userViewModel
    @Binding var isSettings:Bool
    @State var isEditName: Bool = false
    @State var isFeedback: Bool = false
    @State var isConfirmDelete: Bool = false
    @State var feedbackText: String = ""
    @State var newName: String = ""
        
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    withAnimation {
                                isSettings.toggle()
                    }
                }label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.trailing,50)
            VStack{
                HStack{
                    Text("- Settings -")
                        .font(.custom("MarckScript-Regular", size: 30))
                        .foregroundColor(.black)
                }
                .overlay{
                    
                }
                .padding()
                Group {
                    HStack{
                        Text("Name:")
                            .font(.custom("MarckScript-Regular", size: 20))
                        Spacer()
                        Button{
                            isEditName.toggle()
                        }label: {
                            Image(systemName: "highlighter")
                                .imageScale(.small)
                        }
                        Text(viewModel.userName)
                            .font(.custom("MarckScript-Regular", size: 20))                
                    }
                    HStack{
                        Text("Email:")
                            .font(.custom("MarckScript-Regular", size: 20))
                        Spacer()
                        if viewModel.auth.currentUser != nil {
                            Text(viewModel.auth.currentUser!.email!)
                                .accentColor(.white.opacity(0.5))
                        } else {
                            Text("Empty")
                                .accentColor(.white.opacity(0.5))
                        }
                    }
                }
                Divider()
                Group {
                    Button{
                        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    }label: {
                        Text("Rate Application")
                            .font(.custom("MarckScript-Regular", size: 20))
                        Spacer()
                    }
                    Divider()
                    Button{
                        isFeedback.toggle()
                    }label: {
                        Text("Feedback")
                            .font(.custom("MarckScript-Regular", size: 20))
                        Spacer()
                    }
                    Divider()
                    Button{
                        viewModel.signOut()
                    }label: {
                        Text("Logout")
                            .font(.custom("MarckScript-Regular", size: 20))
                        Spacer()
                    }
                    Divider()
                    Button{
                        isConfirmDelete.toggle()
                    }label: {
                        Spacer()
                        Text("Delete account")
                            .font(.custom("MarckScript-Regular", size: 20))
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
            }
            .frame(width: 200,height: 350)
            .padding(.horizontal)
            .background(Color("moloko"))
            .cornerRadius(15)
        }
        .overlay(alignment: .center, content: {
            if isEditName {
                editNameSection
            }
            if isConfirmDelete{
                confirmDeleteSection
            }
            if isFeedback {
                feedbackSection
            }
        })
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
    private var feedbackSection: some View {
        VStack{
            VStack(spacing: 0){
                HStack{
                    Text("Write to us!")
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                }
                .frame(width: 250)
                .background(Color("moloko"))
                
                TextEditor(text: $feedbackText)
                    .frame(height: .infinity)
                HStack{
                    Spacer()
                    Button{
                        isFeedback.toggle()
                        feedbackText = ""
                    }label: {
                        Text("Send")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Divider()
                        .frame(height: 15)
                    Spacer()
                    Button{
                        isFeedback.toggle()
                        feedbackText = ""
                    }label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .frame(width: 250)
                .background(Color("moloko"))
            }
            .frame(width: 250, height: 220)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(color:  .white, radius: 1, x: 1, y: 1)
            .shadow(color:  .white, radius: 1, x: -1, y: -1)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)
    }
    private var confirmDeleteSection: some View {
        VStack{
            VStack{
                HStack{
                    Text("Warning!")
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                }
                .frame(width: 250)
                .background(Color("moloko"))
                VStack{
                    Text("Are you sure you want to delete your account?")
                }
                .frame(height: 100)
                HStack{
                    Spacer()
                    Button{
                        viewModel.deleteUser()
                        viewModel.signOut()
                        viewModel.userName = "Type name"
                        isConfirmDelete.toggle()
                    }label: {
                        Text("Yes")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Divider()
                        .frame(height: 15)
                    Spacer()
                    Button{
                        isConfirmDelete.toggle()
                    }label: {
                        Text("No, it's joke")
                            .foregroundColor(.green)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .frame(width: 250)
                .background(Color("Moloko"))
            }
            .frame(width: 250, height: 200)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(color:  .white, radius: 1, x: 1, y: 1)
            .shadow(color:  .white, radius: 1, x: -1, y: -1)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.ultraThinMaterial)

    }
    private var editNameSection: some View{
        VStack{
            VStack{
                HStack{
                    Text("Type New Name")
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                }
                .frame(width: 250)
                .background(Color("moloko"))
                TextField("\(viewModel.userName)", text: $newName)
                    .padding()
                HStack{
                    Spacer()
                    Button{
                        viewModel.userName = newName
                        if let email = viewModel.auth.currentUser?.email {
                            UserDefaults.standard.set(newName, forKey: "\(email.lowercased())name")

                        }
                        newName = ""
                        isEditName.toggle()
                    }label: {
                        Text("Confirm")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Divider()
                        .frame(height: 15)
                    Spacer()
                    Button{
                        isEditName.toggle()
                        newName = ""
                    }label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .frame(width: 250)
                .background(Color("moloko"))
            }
            .frame(width: 250, height: 150)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(color:  .white, radius: 1, x: 1, y: 1)
            .shadow(color:  .white, radius: 1, x: -1, y: -1)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .ignoresSafeArea()
        .background(.ultraThinMaterial)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isSettings: .constant(true))
    }
}
