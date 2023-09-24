//
//  ViewController.swift
//  SozlukUygulamasi
//
//  Created by Tülay MAYUNCUR on 24.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var kelimelerTableView: UITableView!
    
    var kelimeListesi = [Kelimeler]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        veritabaniKopyala()

        kelimelerTableView.delegate = self
        kelimelerTableView.dataSource = self
        
        kelimeListesi = KelimelerDao().tumKisilerAl()
        
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let gidilecekVC = segue.destination as! KelimeDetayViewController
        
        gidilecekVC.kelime = kelimeListesi[indeks!]
        
    }
}

func veritabaniKopyala(){
    let bundleYolu = Bundle.main.path(forResource: "sozluk", ofType: ".sqlite")
    
    let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    let fileManager = FileManager.default
    
    let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("sozluk.sqlite")
    
    if fileManager.fileExists(atPath: kopyalanacakYer.path) {
        print("Veritabanı zaten var. Kopyalamaya gerek yok.")
    }else{
        do {
            try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            
        }catch{
            print(error)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kelime = kelimeListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimelerHucre", for: indexPath) as! KelimelerHucreTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toKelimeDetay", sender: indexPath.row)
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu: \(searchText)")
        
        kelimeListesi = KelimelerDao().aramaYap(ingilizce: searchText)
        
        kelimelerTableView.reloadData()
        
    }
    
    
}

