//
//  ViewController.swift
//  OpenLibraryApp
//
//  Created by Ever on 02/10/16.
//  Copyright © 2016 Ever. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtISBN: UITextField!
    
    @IBOutlet weak var lblDatosLibro: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func doBuscarLibroAct(_ sender: AnyObject) {
        
        var isbn : String
        
        isbn = txtISBN.text!
        
        if (isbn.characters.count>=0){
            buscaLibro(isbn: txtISBN.text!)
            let resp = sender.resignFirstResponder()
            print (resp)
            
        } else{
            lblDatosLibro.text = "favor de escribir un isbn"
        }
        
    }
    
    
    func buscaLibro(isbn: String) {
        
        var cadenaURL : String!
        
        cadenaURL = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn
        
        let urls = cadenaURL
        //let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7"
        let url = NSURL(string : urls!)
        let datos : NSData? = NSData (contentsOf : url! as URL)
        
        
        
        
        
        if (datos==nil){
            lblDatosLibro.text = "No existe esta conectado a internet, \n la busqueda no puede ser realizada"
            
        } else {
            
            do {
                let json = try? JSONSerialization.jsonObject(with: datos! as Data, options: .mutableLeaves)
                //let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.)
                let tmpISBN = "ISBN:"+isbn
                let dico1 = json as! NSDictionary
                let objISBN = dico1[tmpISBN] as! NSDictionary
                let title = objISBN["title"] as! String
               
                let parsedData = try? JSONSerialization.jsonObject(with: datos as! Data) as! [String:Any]
                    let language = parsedData?[tmpISBN] as! [String:Any]
                    let field = language["authors"] as! [[String:Any]]
                
                
                    let name = field[0]["name"]!

                
                
                var msg = "Titulo: \(title) \n"
                
               msg += "Autor: \(name)"
                
                lblDatosLibro.text = msg
                
                
                
                
            
            } catch _ {
                
            }
            
            
            
            
            
            
            //let texto = NSString(data : datos! as Data, encoding: String.Encoding.utf8.rawValue)
            //print(texto)
            //lblDatosLibro.text = texto as String?
        }
        
        
        
    }


}

