extends Control

var player_words = []
var last_input = ""
			

		
var current_story = {}

func pick_story():
	
	var stories = get_from_json("resources/StoryBook.json")
	current_story = stories[randi()%len(stories)]
	
#	var stories = $StoryBook.get_child_count()
#	var selected_story = randi()%stories
#	current_story.prompts = $StoryBook.get_child(selected_story).prompts
#	current_story.story = $StoryBook.get_child(selected_story).story
	# 
	
func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _ready():
	
	pick_story()
	$DisplayText.text = "Welcome to Loony Lips"
	$PlayerText.grab_focus()
#
#	var prompts = ["Long time ago", 
#					"Jann", 
#					"Conan", 
#					"greatest", 
#					"the decade"]
#
#	var story = "%s %s watched %s"+\
#		" and thought it was the %s movie of %s"
#
#	$DisplayText.text = story % prompts


func _on_PlayerText_text_entered(new_text):
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		get_input($PlayerText.text)
	
func _on_SubmitText_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		get_input($PlayerText.text)
	
func get_input(input):
	last_input = input
	$PlayerText.clear()
	append_player_words(input)
	if is_story_done():
		tell_story()
	else:
		prompt_player()
	
func append_player_words(word):
	player_words.append(word)
	
func is_story_done():
	return player_words.size() == current_story["prompts"].size()
	
func tell_story():
	$DisplayText.text = current_story["story"] % player_words
	endgame()
	
func prompt_player():
	var prompt = "Please give me: "+current_story["prompts"][player_words.size()]
	$DisplayText.text = prompt


func _on_PlayerText_text_changed(new_text):
	if not is_story_done():
		prompt_player()
	
func endgame():
	$PlayerText.text = "Again?"
