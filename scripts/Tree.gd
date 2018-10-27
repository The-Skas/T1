extends Tree

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
  var root = self.create_item()

  root.set_text(0, 'TIM3')

  var child1 = self.create_item(root)

  child1.set_text(0, '1')

  var child2 = self.create_item(root)

  child2.set_text(0, '2')

  var subchild1 = self.create_item(child1)
  subchild1.set_text(0, "1")
  var subchild2 = self.create_item(child1)
  subchild2.set_text(0, "2")


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
