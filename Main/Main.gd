extends Node
class_name Main_Scene

# This is the captian of the ship
# Main will not do any "game logic work"
# Main will delegate game tasks to nodes/scenes you create
# Each node/scene should only concern its own feature. indepedent of all other elements
# node/scene should be built in a captain to ensign sort of command sturcture.
# main is captain, main will receive signals from the nodes under it and then give them commands
# This pattern of control ought to be copied down top level down

# call this function here if you want to exit
# change the code if you require some special process to exit safely
func close_game():
	get_tree().quit()
