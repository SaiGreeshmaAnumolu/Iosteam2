//
//  HomeViewController.swift
//  PlanYourTripWithCheero
//
//  Created by Supriya Bodapati on 11/3/2023.
//

import UIKit
import FirebaseAuth

struct Option {
    
    var img: String
    var title: String
}

class HomeViewController: UIViewController {

    @IBOutlet weak var dataCV: UICollectionView!
    
    var allOptions: [Option] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Home"
        
        var op = Option(img: "Itineraries", title: "Itineraries")
        allOptions.append(op)
        
        op = Option(img: "Myitns", title: "My Itineraries")
        allOptions.append(op)
        
        op = Option(img: "Upcmg", title: "Upcoming")
        allOptions.append(op)
        
        op = Option(img: "History", title: "My History")
        allOptions.append(op)
        
        
        op = Option(img: "Profile", title: "My Profile")
        allOptions.append(op)
        
        
        op = Option(img: "Logout", title: "Logout")
        allOptions.append(op)
        
        dataCV.backgroundColor = .clear
        dataCV.delegate = self
        dataCV.dataSource = self
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    @objc func rotated() {
        self.dataCV.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.size.width / 2
        
        if width > 200 {
            
            return CGSize(width: 200, height: 200)
        }else {
            
            return CGSize(width: width - 18, height: width + 20)
        }
        
        
//        if UIDevice.current.orientation.isLandscape {
//            print("landscap")
//            return CGSize(width: 200, height: 200)
//        } else {
//            print("portrait")
//            return CGSize(width: width - 18, height: width + 20)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : HomeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "home", for: indexPath) as! HomeCVC
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        cell.contantView.layer.cornerRadius = 8
        cell.contantView.clipsToBounds = true
        
        let opt = allOptions[indexPath.item]
        cell.imgView.image = UIImage(named: opt.img)
        cell.titleLbl.text = opt.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ItinerariesViewController") as! ItinerariesViewController
            self.navigationController!.pushViewController(obj, animated: true)
            
        }else if indexPath.item == 1 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "MyItinerariesViewController") as! MyItinerariesViewController
            self.navigationController!.pushViewController(obj, animated: true)
            
        }else if indexPath.item == 2 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "MyUpcommingViewController") as! MyUpcommingViewController
            self.navigationController!.pushViewController(obj, animated: true)
            
        }else if indexPath.item == 3 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "MyHistoryViewController") as! MyHistoryViewController
            self.navigationController!.pushViewController(obj, animated: true)
            
        }else if indexPath.item == 4 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController!.pushViewController(obj, animated: true)
        }else {
            
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                
                do {
                    try Auth.auth().signOut()
                } catch {}
                 
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController!.pushViewController(obj, animated: true)
            })
            
            let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
            })
            alert.addAction(cancel)
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
            
        }
    }
}
