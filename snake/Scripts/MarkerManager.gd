extends Area2D

var markerList = Array()

func _process(delta: float) -> void:
	var pos = self.transform
	var rot = self.rotation
	#UpdateMarkerList(pos,rot)
	print(self.rotation)
	ClearMarkerList()


func UpdateMarkerList(p,r):
	markerList.append([p,r])


func ClearMarkerList():
	markerList = Array()
