import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(50.44850, 30.52432), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding()
                Spacer()
              locationsPriviewStack
            }
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

extension LocationsView {
    private var header: some View {
        VStack{
            Button{
                viewModel.showLocationList.toggle()
            } label: {
                HStack{
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.05))
                        }
                    VStack{
                        Text("Blaze Caffee" + ",  " + viewModel.mapLocation.cityName)
                            .font(.custom("MarckScript-Regular", size: 20))
                            //.font(.title3)
                            .foregroundColor(.primary)
                        
                        Text(viewModel.mapLocation.address)
                            .font(.custom("MarckScript-Regular", size: 25))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(.primary)
                    }
                    .animation(.none, value: viewModel.mapLocation)
                    .frame(maxWidth: .infinity)
                }
            }
            if viewModel.showLocationList {
                LocationListView()
            }
            
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20)
    }
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coodinates) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
        })
    }
    private var locationsPriviewStack: some View {
        ZStack{
            ForEach(viewModel.locations){ location in
                if viewModel.mapLocation == location {
                    LocationPriviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
                
            }
        }
    }
}
struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
