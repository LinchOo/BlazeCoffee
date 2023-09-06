import SwiftUI

struct TabItem: View{
    var tint: Color
    var inActiveTint: Color
    var tab: TabBarModel
    var animation: Namespace.ID
    @State var fontSize = 20
    @Binding var activeTab: TabBarModel
    @State private var tabPosition: CGPoint = .zero
    @Binding var position: CGPoint
    
    
    var body: some View {
        VStack(spacing: 0){
            Image(tab.Images)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(activeTab == tab ? .white : .black)
                .frame(width: activeTab == tab ? 30 : 20, height: activeTab == tab ? 30 : 20)
                .padding(10)
                .background{
                    if activeTab == tab {
                        Circle()
                            .foregroundColor(Color("brown"))
//                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.custom("MarckScript-Regular", size: activeTab == tab ? 23 : 15 ))
                .foregroundColor(activeTab ==  tab ? tint : .gray)
                .shadow(radius: 0.5)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                position.x = tabPosition.x
                
            }
            
        }
        
        
    }
    
}
