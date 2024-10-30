extends CanvasLayer

@export var player : Player
@export var HP_bar : ProgressBar
@export var Patrons_label : Label

func _process(delta: float) -> void:
	HP_bar.max_value = player.max_health
	HP_bar.value = player.health
	
	Patrons_label.text = str(player.patrons) + "/" + str(player.max_patrons)
