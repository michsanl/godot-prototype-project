extends Node


#region Process Clash Response : Process Owner Token Type
func process_clash_response(clash_data: ClashData):
	var owner_token_type: AbilityToken.TokenType = clash_data.owner_token.token_type
	match owner_token_type:
		clash_data.owner_token.TokenType.ATTACK:
			process_attack_token_clash_response(clash_data)
		clash_data.owner_token.TokenType.GUARD:
			process_guard_token_clash_response(clash_data)
		clash_data.owner_token.TokenType.EVADE:
			process_evade_token_clash_response(clash_data)
#endregion


#region Process Clash Response : Process Combat Result
func process_attack_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			perform_attack_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			perform_attack_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			perform_attack_token_response_on_draw(clash_data)


func process_guard_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			perform_guard_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			perform_guard_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			perform_guard_token_response_on_draw(clash_data)


func process_evade_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			perform_evade_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			perform_evade_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			perform_evade_token_response_on_draw(clash_data)
#endregion


#region Play Token Response : Attack Token 
func perform_attack_token_response_on_win(clash_data: ClashData):
	match clash_data.clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_attack_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_attack_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass
#endregion


#region Play Token Response : Guard Token 
func perform_guard_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_guard_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_guard_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass
#endregion


#region Perform Token Response : Evade Token 
func perform_evade_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_evade_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass


func perform_evade_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.TokenType.ATTACK:
			pass
		clash_data.opponent_token.TokenType.GUARD:
			pass
		clash_data.opponent_token.TokenType.EVADE:
			pass
#endregion
