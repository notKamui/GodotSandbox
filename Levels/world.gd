extends Node2D

func _ready():
	Foo.bar.connect(func (): print("something happened"))
