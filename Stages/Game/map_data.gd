class_name MapData
extends Resource


var MapPath: String = ""
var HoleNumber: int = 0
var ParNumber: int = 0

func _init(data: Dictionary) -> void:
	for key in data:
		if key in self:
			self.set(key, data[key])
