extends Object
class_name Utils

const FULL_CIRCLE = 360

static func movement_positive_angle(movement):
	var angle = int(rad_to_deg(movement.angle()))
	return abs(angle) if angle <= 0 else FULL_CIRCLE - angle
