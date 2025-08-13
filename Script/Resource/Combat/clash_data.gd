class_name ClashData
extends Resource

enum ClashResult { WIN, LOSE, DRAW }

var clash_result: ClashResult

var owner_name: String
var owner: CharacterBase
var owner_token: DiceData
var owner_token_value: int

var opponent: CharacterBase
var opponent_token: DiceData
var opponent_token_value: int
