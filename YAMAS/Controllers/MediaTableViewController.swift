import UIKit
import AlamofireImage
import AVKit

class MediaTableViewController: UITableViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    var mediaItems = [MediaItem]()
    @IBOutlet weak var mediaTypePicker: UIPickerView!
    var pickerData = [String]()
    var mediaTypes = [String]()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text
        let callback: ([MediaItem]) -> Void = { items in
            self.mediaItems = items
            self.tableView.reloadData()
        }
        let selectedIndex = Int(mediaTypePicker.selectedRow(inComponent: 0).description)
        let selectedMedia = mediaTypes[selectedIndex!]
        MediaItemRepo.search(term: text!, mediaType: selectedMedia, completion: callback)
        return false
    }
    
    //Begin Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 12)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = pickerData[row]
        
        
        return pickerLabel!
    }
    
    //End Picker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Music", "TV Shows", "Movies"]
        mediaTypes = ["music", "tvShow", "movie"]
        searchTextField.delegate = self
        mediaTypePicker.delegate = self
        mediaTypePicker.dataSource = self
        
    }
    //Begin TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mediaItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableCell", for: indexPath) as! MediaTableViewCell
        let row = indexPath.row
        
        cell.artistLabel.text = mediaItems[row].artistName
        cell.titleLabel.text = mediaItems[row].trackName
        cell.descriptionLabel.text = mediaItems[row].longDescription
        cell.artworkImage.af_setImage(withURL: URL(string: mediaItems[row].artworkUrl)!)
        cell.data = mediaItems[row]
        return cell
    }
    //End TableView

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is AVPlayerViewController){
            let cell = sender as! MediaTableViewCell
            let player = AVPlayer(url: URL(string: (cell.data?.previewUrl)!)!)
            var controller = segue.destination as! AVPlayerViewController
            controller.player = player
            controller.player?.play()
        }
    }
    
    
}
