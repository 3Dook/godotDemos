extends Area2D


# mask will recvie
# layer will affect 

# use a signal to show that something is affecting

signal recieved_layer()

func _on_area_entered(area):
	print("hurt entered - ", area)
