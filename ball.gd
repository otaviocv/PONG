
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var vx = 350
var vy = 200
var velocity
var posx = 512
var posy = 300
var radius = 10
var velocities = Array()
var positions = Array()
var color = Color(255,255,255)
var N = 2000

func increase_velocity_x(k):
	var vx = self.get_linear_velocity().x
	if vx > 0:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	else:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	# print("1:"+ str(self.get_linear_velocity().x))


func reset():
	self.set_pos(Vector2(512, 300))
	self.set_linear_velocity(Vector2(0, 0))

func reset_velocity(dir):
	var k = 0.28727
	vx = 350
	vy = rand_range(-k*vx,k*vx)
	self.set_linear_velocity(Vector2(dir*vx, vy))

	

func increase_velocity_y(k):
	var vy = self.get_linear_velocity().y
	self.set_linear_velocity(Vector2(get_linear_velocity().x, vy+k))

func _fixed_process(delta):
	increase_velocity_x(1.0035)
	vy = self.get_linear_velocity().y
	if vy > 1000:
		self.set_linear_velocity(Vector2(self.get_linear_velocity().x, 1000))
	elif vy < -1000:
		self.set_linear_velocity(Vector2(self.get_linear_velocity().x, -1000))
	update()
	
	
func _draw():
	positions.push_front(get_pos())
	positions.pop_back()
	#print(positions)
	velocities.push_front(get_linear_velocity())
	velocities.pop_back()
	var h = 1.0

	for i in positions:
		var polig = Array() 
		var v1 = Vector2(i.x + h*radius, i.y + h*radius) - get_pos()
		var v2 = Vector2(i.x + h*radius, i.y - h*radius) - get_pos()
		var v3 = Vector2(i.x - h*radius, i.y - h*radius) - get_pos()
		var v4 = Vector2(i.x -h*radius, i.y + h*radius) - get_pos()
		polig.append(v1)
		polig.append(v2)
		polig.append(v3)
		polig.append(v4)
		h -= 71.0/N
		if h < 0:
			break
		draw_colored_polygon(Vector2Array(polig), Color(h,h,h))
	
	

func _ready():
	set_fixed_process(true)
	reset()
	reset_velocity(1)
	velocities.resize(N)
	positions.resize(N)
	for i in range(0, N):
		velocities[i] = Vector2(0,0)
		positions[i] = Vector2(0,0)


func _on_ball_body_enter( body ):
	pass
	#get_node("sounds").play("hit")
	# get_node("Particles2D").set_emitting(true)
	
func get_stored_velocity():
	return velocity

func set__pause(state):
	if state:
		velocity = get_linear_velocity()
		set_linear_velocity(Vector2(0,0))
	else:
		set_linear_velocity(velocity)
	
