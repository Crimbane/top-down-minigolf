extends Area2D

func _ready() -> void:
	var curve = $Path2D.curve
	var polygon = curve.get_baked_points()
	
	$Polygon2D.polygon = polygon
	$Polygon2D/Outline.points = polygon
	$Polygon2D/Shadow.points = polygon
	
	$CollisionPolygon2D.polygon = polygon
