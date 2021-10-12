extends Node

export (NodePath) var pathfinding:NodePath

func _ready():
	var pathfinder:PathfindAstar = get_node(pathfinding)

	for child in get_children():
		if child != pathfinder:
			child.pathfinding = pathfinder
