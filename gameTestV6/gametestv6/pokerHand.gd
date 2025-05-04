extends Node



func run_hand(hand):
	pass
	
func royal_flush(hand):
	isFlush(hand)

func isFlush(hand):
	#edge caase
	if hand.size() < 1:
		return false
	
	var temp_suit = hand[0].suit
	for i in hand:
		if i.suit != temp_suit:
			return false

func isStraight(hand):
	pass
