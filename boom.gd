extends Node2D

func _ready() -> void:
	$GPUParticles2D.emitting = false
	
func _physics_process(delta: float) -> void:
	if owner.explode == true:
		$GPUParticles2D.emitting = true
		owner.explode = false
