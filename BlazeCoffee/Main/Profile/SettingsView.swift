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
                                .font(.custom("MarckScript-Regular", size: 20))
                                .accentColor(.white.opacity(0.5))
                                .minimumScaleFactor(0.8)
                                .lineLimit(1)
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
            .frame(width: 250,height: 350)
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
            .environmentObject(userViewModel())
    }
}
/*
 Ice
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>ITSAppUsesNonExemptEncryption</key>
     <false/>
     <key>CFBundleDevelopmentRegion</key>
     <string>$(DEVELOPMENT_LANGUAGE)</string>
     <key>CFBundleDisplayName</key>
     <string>Ice Queen Tale</string>
     <key>CFBundleExecutable</key>
     <string>$(EXECUTABLE_NAME)</string>
     <key>CFBundleIdentifier</key>
     <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
     <key>CFBundleInfoDictionaryVersion</key>
     <string>6.0</string>
     <key>CFBundleName</key>
     <string>$(PRODUCT_NAME)</string>
     <key>CFBundlePackageType</key>
     <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
     <key>CFBundleShortVersionString</key>
     <string>$(MARKETING_VERSION)</string>
     <key>CFBundleVersion</key>
     <string>$(CURRENT_PROJECT_VERSION)</string>
     <key>LSRequiresIPhoneOS</key>
     <true/>
     <key>UILaunchStoryboardName</key>
     <string>Main.storyboard</string>
     <key>UIMainStoryboardFile</key>
     <string>Main</string>
     <key>UIRequiredDeviceCapabilities</key>
     <array>
         <string>armv7</string>
     </array>
     <key>UIStatusBarHidden</key>
     <true/>
     <key>CFBundleURLTypes</key>
     <array>
         <dict>
             <key>CFBundleURLSchemes</key>
             <array>
                 <string>fb986422045929934</string>
             </array>
         </dict>
     </array>
     <key>FacebookAdvertiserIDCollectionEnabled</key>
     <string>TRUE</string>
     <key>FacebookAppID</key>
     <string>986422045929934</string>
     <key>FacebookClientToken</key>
     <string>d82fbcd0ebbf1f30e52e624dace3ec07</string>
     <key>FacebookDisplayName</key>
     <string>IceQueenTale</string>
     <key>NSAdvertisingAttributionReportEndpoint</key>
     <string>https://appsflyer-skadnetwork.com/</string>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>We collect this data for analytics and special offers in the menu for visitors</string>
     <key>NSUserTrackingUsageDescription</key>
     <string>This identifier will be used to show you personalized ads on the marketplaces.</string>
     <key>UIApplicationSupportsIndirectInputEvents</key>
     <true/>
     <key>UIBackgroundModes</key>
     <array>
         <string>remote-notification</string>
     </array>
 </dict>
 </plist>

 
 */
/*
 Old
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>UIAppFonts</key>
     <array>
         <string>MarckScript-Regular.ttf</string>
         <string>Sunnyspells-Regular.otf</string>
     </array>
     <key>ITSAppUsesNonExemptEncryption</key>
     <false/>
     <key>UIBackgroundModes</key>
     <array>
         <string>remote-notification</string>
     </array>
     <key>CFBundleDevelopmentRegion</key>
     <string>$(DEVELOPMENT_LANGUAGE)</string>
     <key>CFBundleDisplayName</key>
     <string>Blaze Coffee</string>
     <key>CFBundleExecutable</key>
     <string>$(EXECUTABLE_NAME)</string>
     <key>CFBundleIdentifier</key>
     <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
     <key>CFBundleInfoDictionaryVersion</key>
     <string>6.0</string>
     <key>CFBundleName</key>
     <string>$(PRODUCT_NAME)</string>
     <key>CFBundlePackageType</key>
     <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
     <key>CFBundleShortVersionString</key>
     <string>$(MARKETING_VERSION)</string>
     <key>CFBundleVersion</key>
     <string>$(CURRENT_PROJECT_VERSION)</string>
     <key>LSRequiresIPhoneOS</key>
     <true/>
     <key>UILaunchStoryboardName</key>
     <string>Main.storyboard</string>
     <key>UIMainStoryboardFile</key>
     <string>Main</string>
     <key>UIRequiredDeviceCapabilities</key>
     <array>
         <string>armv7</string>
     </array>
     <key>UIStatusBarHidden</key>
     <true/>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
 </dict>
 </plist>

 */
