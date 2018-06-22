//
//  ViewController.swift
//  WebViewInTableView
//
//  Created by Echo Innovate IT on 19/06/18.
//  Copyright © 2018 Echo Innovate IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variable Declaration
    
    /* TableView */
    @IBOutlet weak var tblView: UITableView!
    
    /* Local Variable */
    var objList:[[String : String]]!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added Dummy Data
        objList = [[String:String]]()
        
        
        
        objList.append([
            "height":"0",
            "description":"With SmartChlor Technology <font color = 'blue'>the free chlorine maintains an equilibrium of</font> 0.5 to 1.0 when the water is balanced so over-chlorination is virtually impossible.\r\n"])
        
        
        objList.append([
            "height":"0",
            "description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard <b>dummy</b> text ever since the 1500s, when an unknown printer took a galley of type and scramble`d it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the <i>1960s with the release</i> of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."])
        
        objList.append([
            "height":"0",
            "description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's popularised in the 1960s <h3>with the release</h3> of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."])
        
        objList.append([
            "height":"0",
            "description":"Lorem Ipsum is simply and more <font color = 'red'>recently with desktop</font> publishing software like Aldus PageMaker including versions of Lorem Ipsum."])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - TableView Delegate

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WebViewCell = tableView.dequeueReusableCell(withIdentifier: "WebViewCell") as! WebViewCell
        
        let html = String(format: "<html><style>*{font-family:Arial;} body a{color:#0514FA !important;} </style><span>%@</span></body></html>", objList[indexPath.row]["description"]!)
        
        cell.viewWeb.loadHTMLString(html, baseURL: nil)
        cell.viewWeb.tag = indexPath.row
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(max(Float(objList[indexPath.row]["height"]!)!, 50.0))
    }
}


//MARK: - WebView Delegate

extension ViewController : UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if Float(objList[webView.tag]["height"]!) == 0.0 {
            
            let height = Double(webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")!)
            
            objList[webView.tag]["height"] = String(format: "%0.2lf", height!)
            
            tblView.reloadRows(at: [IndexPath(row: webView.tag, section: 0)], with: .automatic)
        }
    }
}

