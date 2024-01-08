//
//  LifeFormTableViewController.swift
//  Life-Form-Search
//
//  Created by Dax Gerber on 1/8/24.
//

import UIKit

class LifeFormTableViewController: UITableViewController {
    
    var lifeForms = [LifeForm]()

    @IBOutlet weak var searchBarText: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   
    @IBSegueAction func seguey(_ coder: NSCoder, sender: Any?) -> DetailsViewController? {
        let cell = (sender as? UITableViewCell)!
        let indexPath = tableView.indexPath(for: cell)
        return DetailsViewController(coder: coder, id: lifeForms[indexPath!.row].id)
    }
    
    func getLifeForms() {
        Task {
            do {
                let retrieveLifeForms = try await sendRequest(LifeFormAPIRequest(searchTerm: searchBarText.text ?? ""))
                lifeForms = retrieveLifeForms.results
                tableView.reloadData()
            }
            catch {
                
            }
        }
    }
    
    func sendRequest<Request: APIRequest>(_ request: Request) async throws -> Request.Response {
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request.urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw APIError.youSuck
        }
        return try request.decodeData(data)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lifeForms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bob", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let lifeForm = lifeForms[indexPath.row]
        content.text = lifeForm.content
        content.secondaryText = lifeForm.title
        cell.contentConfiguration = content
    
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LifeFormTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getLifeForms()
    }
    
}
