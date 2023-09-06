import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.locations){ location in
                Button{
                    viewModel.showNextLocation(location: location)
                }label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationListView {
    private func listRowView(location: Location) -> some View {
        HStack{
            if let imageName = location.imagesNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70,height: 70)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.custom("Sunnyspells-Regular", size: 22))
                Text(location.cityName)
                    .foregroundColor(.gray)
                    .font(.custom("MarckScript-Regular", size: 16))
                Text(location.address)
                    .fontWeight(.bold)
                    .font(.custom("MarckScript-Regular", size: 18))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationsViewModel())
    }
}
