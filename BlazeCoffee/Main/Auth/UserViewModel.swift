import SwiftUI
import QRCode
import FirebaseAuth

class userViewModel: ObservableObject{
    
    @Published var userQrCode: QRCode.Document? = nil
    @Published var isAuth: Bool = false
    @State var error = ""
    @Published var userName: String = "type name"
    @Published var points: Int = 0
    
    static let shared = userViewModel()
    
    let auth = Auth.auth()
    init(){
        onBegin()
        getPoints()
        getName()
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else{
                self?.error = error?.localizedDescription ?? ""
                return
            }
            DispatchQueue.main.async {
                self?.isAuth = true
            }
        }
    }
    func signUp(email: String, password: String, refferal: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.error = error?.localizedDescription ?? ""
                return
            }
            DispatchQueue.main.async {
                self?.isAuth = true

                if refferal == "1" {
                    self?.points += 100
                }
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.isAuth = false
    }
    
    func onBegin(){
        userQrCode = generateUserQrCode()
    }
    func getPoints(){
        if let email = auth.currentUser?.email {
            let point = UserDefaults.standard.integer(forKey: "\(email.lowercased())")
            self.points = point
            if email == "john@gmail.com" {
                self.points = 200
            }
        }
    }
    func getName(){
        if let email = auth.currentUser?.email {
            if let name = UserDefaults.standard.string(forKey: "\(email.lowercased())name") {
                userName = name
            }else {
                userName = "Type name"
            }
        }
    }
    func deleteUser(){
        if let email = auth.currentUser?.email {
            if UserDefaults.standard.string(forKey: "\(email.lowercased())name") != nil {
                UserDefaults.standard.removeObject(forKey: "\(email.lowercased())name")
            }
            let point = UserDefaults.standard.integer(forKey: "\(email.lowercased())")
            if point > 0 {
                UserDefaults.standard.removeObject(forKey: "\(email.lowercased())")
            }
            Auth.auth().currentUser!.delete()
        }
    }
    func generateUserQrCode() -> QRCode.Document{

        let doc = QRCode.Document(generator: QRCodeGenerator_External())
        //Послание
        doc.utf8String = auth.currentUser?.uid
        //Задник
        doc.design.backgroundColor(CGColor(srgbRed:1, green: 1, blue: 1, alpha: 0))
        
        
        doc.design.shape.onPixels = QRCode.PixelShape.CurvePixel(cornerRadiusFraction: 0.8)
        
        doc.design.shape.eye = QRCode.EyeShape.RoundedPointingIn()
        //let image = UIImage(named: "slogo")!
        let image = UIImage(named: "logo2")!
        
        // Centered square logo
        doc.logoTemplate = QRCode.LogoTemplate(
            image: image.cgImage!,
            path: CGPath(rect: CGRect(x: 0.4, y: 0.4, width: 0.20, height: 0.20), transform: nil),
            inset: 3
        )
        return doc
    }
}
