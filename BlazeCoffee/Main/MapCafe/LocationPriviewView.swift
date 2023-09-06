import SwiftUI

struct LocationPriviewView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom,spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8){
                nextButton
                learnMoreButton
            }
        }
        .padding(10)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:75)
        }
        .cornerRadius(10
        )
        .padding(.bottom, 90)
    }
}

extension LocationPriviewView {
    private var imageSection: some View {
        ZStack{
            if let imageName = location.imagesNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110,height: 90)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0){
            Text(location.name)
                //.font(.title2)
                .font(.custom("MarckScript-Regular", size: 20))
                
            Text(location.cityName)
               // .font(.subheadline)
                .font(.custom("MarckScript-Regular", size: 14))
            
            //Text(location.address)
            Text(location.address)
                //.font(.subheadline)
                .font(.custom("MarckScript-Regular", size: 17))
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var nextButton: some View {
        Button{
            viewModel.nextButtonPressed()
        }label: {
            Text("Next cafe")
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(width: 125,height: 35)
                .font(.custom("MarckScript-Regular", size: 20))
                //.shadow(radius: 0.8)
                .foregroundColor(Color("brown"))
        }
        .buttonStyle(.bordered)
    }
    private var learnMoreButton: some View{
        Button{
            viewModel.sheetLocation = location
        }label: {
            Text("more info")
                .frame(width: 125,height: 35)
                .font(.custom("MarckScript-Regular", size: 17))
            
        }
        .buttonStyle(.borderedProminent)
    }
}

struct LocationPriviewView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
//        ZStack {
//           // Color.blue.ignoresSafeArea()
//            LocationPriviewView(location: LocationsDataService.locations.first!)
//                .padding()
//        }
//        .environmentObject(LocationsViewModel())
    }
}
