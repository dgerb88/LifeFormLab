//
//  DetailsViewController.swift
//  Life-Form-Search
//
//  Created by Dax Gerber on 1/8/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    @IBOutlet weak var lifeFormImage: UIImageView!
    @IBOutlet weak var licenseHolder: UILabel!
    @IBOutlet weak var license: UILabel!
    
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
        Task {
            do {
                let lifeForm = try await sendRequest(TaxonPage(id: id!))
                scientificNameLabel.text = lifeForm.taxonConcept.taxonConcepts![0].scientificName
                if let rightsHolder = lifeForm.taxonConcept.dataObjects?[0].rightsHolder {
                    licenseHolder.text = rightsHolder
                } else {
                    licenseHolder.text = lifeForm.taxonConcept.dataObjects?[0].agents[0].full_name
                }
                license.text = lifeForm.taxonConcept.dataObjects?[0].license
                if let newImageString = lifeForm.taxonConcept.dataObjects?[0].eolMediaURL {
                    let newImage = try await sendRequest(ImageMaker(imageURLString: newImageString))
                    lifeFormImage.image = newImage
                    print(newImageString)
                } else {
                    lifeFormImage.image = UIImage(systemName: "photo.fill")
                }
 
            } catch {
                print(error.localizedDescription)
                lifeFormImage.image = UIImage(systemName: "photo.fill")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request.urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw APIError.youSuck
        }
        return try request.decodeData(data)
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
