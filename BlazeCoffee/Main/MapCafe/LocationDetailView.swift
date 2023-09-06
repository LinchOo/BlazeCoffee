import SwiftUI

struct LocationDetailView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let location: Location
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}
extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imagesNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(location.name)
                .font(.custom("MarckScript-Regular", size: 35))
                //.font(.largeTitle)
                //.fontWeight(.semibold)
            Text(location.cityName)
                .font(.custom("MarckScript-Regular", size: 18))
                //.font(.title3)
                .foregroundColor(.secondary)
            Text(location.address)
                .font(.custom("MarckScript-Regular", size: 20))
                //.font(.title3)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
        }
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(location.description, id: \.self){ description in
                VStack{
                    HStack{
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35,height: 35)
                        VStack(alignment: .leading){
                            Text("Olga")
                                .font(.custom("MarckScript-Regular", size: 20))
                            HStack(spacing: 5){
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Image(systemName: "star.fill")
                            }
                        }
                    }
                }
                Text(description)
                    //.font(.subheadline)
                    .font(.custom("MarckScript-Regular", size: 20))
                    .foregroundColor(.secondary)
            }
        }
    }
    private var backButton: some View{
        Button{
            viewModel.sheetLocation = nil
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(4)
                .shadow(radius: 4)
                .padding()
        }
    }
}
struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
