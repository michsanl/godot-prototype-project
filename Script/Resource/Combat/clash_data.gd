class_name ClashData
extends Resource

enum ClashResult { WIN, LOSE, DRAW }

var clash_result: ClashResult

var owner: CharacterBase
var owner_token: AbilityToken
var owner_token_value: int

var opponent: CharacterBase
var opponent_token: AbilityToken
var opponent_token_value: int
