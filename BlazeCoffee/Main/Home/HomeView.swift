import SwiftUI

struct HomeView: View {
    @StateObject var news = NewsViewModel()
    @State var selectedTab: String = "1"
    var body: some View {
        VStack(spacing: 25){
            Text(" - News & Promotion - ")
                .font(.custom("MarckScript-Regular", size: 35))
                .foregroundColor(.black)
                .background{
                    Color("moloko")
                }
                .cornerRadius(15)
                .shadow(color: Color("brown"), radius: 5)
            TabView(selection: $selectedTab){
                ForEach(news.services) { news in
                    VStack{
                        Image(news.imgName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                        Text(news.description)
                            .font(.custom("MarckScript-Regular", size: 25))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .tag(news.number)
                    .frame(width: 300, height: 300)
                    .padding()
                    .background{
                        Color("moloko")
                    }
                    .cornerRadius(45)
                    .shadow(color: Color("brown"), radius: 5)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 350)
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack(spacing: 15) {
                ForEach(news.services) {tab in
                    Capsule()
                        .fill(Color("brown"))
                        .frame(width: selectedTab == tab.number ? 15 : 7 ,height: 7)
                }
            .offset(y: 25)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background{
            Image("bg")
                .resizable()
                .scaledToFill()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
