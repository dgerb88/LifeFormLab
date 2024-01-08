//
//  DetailsViewController.swift
//  Life-Form-Search
//
//  Created by Dax Gerber on 1/8/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var id: Int?
    
    init?(coder: NSCoder, id: Int?) {
        self.id = id
        super.init(coder: coder)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
