extends Resource
class_name VNVideo

var data : Dictionary = {
    "name": "",
    "loop": true,
    "video": null,
    "type": ""
}

func _init(file: String, folder_path: String):
    data.name = file.get_basename()
    data.type = file.get_extension().to_lower()
    data.video = import_video(get_video_path(file, folder_path))

# Creates the appropriate video stream resource and sets it to data.video
func import_video(path: String):
    var video_res = null
    if data.type == "webm":
        video_res = VideoStreamWebm.new()
    elif data.type == "o":
        video_res = VideoStreamTheora.new()
    
    video_res.set_file(path)
    return video_res

# Returns the full path with file
func get_video_path(file: String, folder_path: String):
    return folder_path + file

# Returns the loaded video resource, ready for streaming
func get_video():
    return data.video