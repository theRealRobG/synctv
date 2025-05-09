/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 ViewController for the Bonjour browser view
 */

import UIKit
import AVFoundation

/// This is a viewController for a generic Bonjour service browser that browses for HTTP service advertisements
class BrowseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public var sourceButtonSide: ViewController.ButtonSide?
    public var selectedURL: URL?

    @IBOutlet weak var serviceTable: UITableView?

    let urls = [
        URL(string: "https://demo.unified-streaming.com/k8s/live/stable/scte35.isml/master.m3u8?hls_fmp4")!
    ]
    
    deinit {
        if let serviceTable = serviceTable {
            serviceTable.delegate = nil
            serviceTable.dataSource = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let serviceTable = serviceTable {
            serviceTable.delegate = self
            serviceTable.dataSource = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedURL = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urlIndex = indexPath[1]
        let url = urls[urlIndex]
        let identifier = "\(url.absoluteString) \(urlIndex)"

        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = url.absoluteString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedURL = urls[indexPath.row]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}

