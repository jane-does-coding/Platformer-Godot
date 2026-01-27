extends Area2D

# Assign in Inspector
@export var win_scene: PackedScene
@export var message_label: Label  # optional UI label for messages

func _ready() -> void:
	print("GoalBlock READY")

func _on_body_entered(body: Node2D) -> void:
	# Only react if the body is the player
	if not body.is_in_group("player"):
		return

	print("ENTERED:", body.name)  # debug print

	# Access GameManager singleton safely
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		if gm.has_all_coins():
			# Player won
			if win_scene:
				get_tree().change_scene_to_packed(win_scene)
			else:
				print("You won! (No win_scene assigned)")
		else:
			# Not all coins collected
			var remaining = gm.total_coins - gm.collected_coins
			if message_label:
				message_label.text = "Collect all coins! (%d left)" % remaining
				message_label.visible = true
				# Wait 2 seconds, then hide
				await get_tree().create_timer(2.0).timeout
				message_label.visible = false
			else:
				print("Collect all coins! (%d left)" % remaining)
	else:
		print("GameManager singleton not found!")
