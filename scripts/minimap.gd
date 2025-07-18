extends SubViewport

func _ready():
	world_2d = get_tree().root.world_2d

func _process(delta: float) -> void:
	$MinimapCamera.position = get_parent().get_parent().get_parent().position
	
