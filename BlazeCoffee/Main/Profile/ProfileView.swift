import SwiftUI
import QRCode

struct ProfileView: View {
    @EnvironmentObject var viewModel: userViewModel
    @State var isSettings: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Image("code")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .zIndex(0)
                    .shadow(color: Color("brown"), radius: 5)
                VStack{
                    HStack{
                        Text("Earned:")
                            .font(.custom("MarckScript-Regular", size: 18))
                            .foregroundColor(.gray)
                        
                        Text("\(viewModel.points)" )
                            .font(.custom("MarckScript-Regular", size: 25))
                            .foregroundColor(.black)
                    }
                    .padding(15)
                    .background{
                        Color("moloko")
                            .cornerRadius(15)
                            .shadow(color: Color("brown"), radius: 2)
                    }
                    QRCodeDocumentUIView(document: viewModel.userQrCode!)
                        .frame(width: 245, height: 245)
                        .cornerRadius(15)
//                        .background(.ultraThinMaterial.opacity(1))
                        .cornerRadius(15)
                    Spacer()
                }
                .frame(height: 500)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background{
            Image("bg")
                .resizable()
                .scaledToFill()
        }
        .overlay{
            VStack{
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            isSettings.toggle()
                        }
                        
                    }label: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(maxWidth: 35,maxHeight: 35)
                            .foregroundColor(Color("brown"))
                    }
                }
                .padding(.trailing, 15)
//                .padding(.top, 60)
                Spacer()
            }
            .zIndex(0)
            if isSettings {
                SettingsView(isSettings: $isSettings)
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(userViewModel())
    }
}
//struct MainTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBarView()
//    }
//}
