
import Alamofire

class MediaItemRepo {
    static let BASE_URL = "https://itunes.apple.com/search?"
    static func search(term: String, mediaType: String, completion: @escaping ([MediaItem]) -> (Void)){
        var mediaItems = [MediaItem]()
        let url = BASE_URL
            + "term=" + term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            + "&media=" + mediaType
        Alamofire.request(url).responseJSON { result in
            //Check if status is OK
            if (result.response?.statusCode == 200){
                let json = result.value as! NSDictionary
                let foundMedia = json.mutableArrayValue(forKey: "results")
                for media in foundMedia{
                    let item = media as! NSDictionary
                    switch mediaType{
                    case "movie":
                        mediaItems.append(MediaItem(artistName: "", trackName: item.value(forKey: "trackName") as! String, artworkUrl: item.value(forKey: "artworkUrl100") as! String, longDescription: item.value(forKey: "longDescription") as? String, previewUrl: item.value(forKey: "previewUrl") as! String))
                    case "tvShow":
                        mediaItems.append(MediaItem(artistName: item.value(forKey: "artistName") as! String, trackName: item.value(forKey: "trackName") as! String, artworkUrl: item.value(forKey: "artworkUrl100") as! String, longDescription: item.value(forKey: "longDescription") as? String, previewUrl: item.value(forKey: "previewUrl") as! String))
                    case "music":
                        mediaItems.append(MediaItem(artistName: item.value(forKey: "artistName") as! String, trackName: item.value(forKey: "trackName") as! String, artworkUrl: item.value(forKey: "artworkUrl100") as! String, previewUrl: item.value(forKey: "previewUrl") as! String))
                    default:
                        print("No selection made")
                    }
                }
            }
            completion(mediaItems)
        }
    }
}
