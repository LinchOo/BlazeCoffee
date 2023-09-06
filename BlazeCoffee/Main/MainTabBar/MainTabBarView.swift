import SwiftUI

struct MainTabBarView: View {
    @State var isAuth: Bool = true
    // @State var authUser = AuthManager.shared.currentUser
    @StateObject private var locationViewModel = LocationsViewModel()
    @StateObject var viewModelUser = userViewModel()
    // Custom TabBar
    @State private var activeTab: TabBarModel = .cafe
    @State private var tabShapePosition: CGPoint = .zero
    @Namespace private var animation
    init(){
        UITabBar.appearance().isHidden  = true
    }
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $activeTab) {
                HomeView()
                    .tag(TabBarModel.home)
                    .padding(.top, 90)
                ProfileView()
                    .tag(TabBarModel.profile)
                    .environmentObject(viewModelUser)
                    .padding(.top, 30)
                LocationsView()
                    .tag(TabBarModel.cafe)
                    .environmentObject(locationViewModel)
            }
            CustomTabBar()
        }
        .background{
            Image("bg")
                .resizable()
                .scaledToFill()
        }
        .overlay {
            if viewModelUser.auth.currentUser == nil {
                AuthView()
                    .environmentObject(viewModelUser)
            }
        }
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("brown"), _ inActiveTint: Color = .red) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(TabBarModel.allCases, id: \.rawValue) {
                TabItem(tint: tint,
                        inActiveTint: inActiveTint,
                        tab: $0,
                        animation: animation,
                        activeTab: $activeTab,
                        position: $tabShapePosition)
            }
        }
        .padding(.horizontal, 15)
        .background{
            TabShape(midPoint: tabShapePosition.x)
                .fill(Color("moloko").opacity(1))
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.4), radius: 2, x: 0, y: -7)
            
        }
        .ignoresSafeArea()
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
