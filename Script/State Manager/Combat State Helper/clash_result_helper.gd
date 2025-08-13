class_name ClashResultHelper
extends Node


#region Process Clash Response : Process Owner Token Type
func process_clash_response(clash_data: ClashData):
	var owner_token_type: DiceData.DiceType = clash_data.owner_token.token_type
	match owner_token_type:
		clash_data.owner_token.DiceType.ATTACK:
			await process_attack_token_clash_response(clash_data)
		clash_data.owner_token.DiceType.GUARD:
			await process_guard_token_clash_response(clash_data)
		clash_data.owner_token.DiceType.EVADE:
			await process_evade_token_clash_response(clash_data)
#endregion


#region Process Clash Response : Process Combat Result
func process_attack_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			print(clash_data.owner.char_name, " is WIN")
			await perform_attack_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			print(clash_data.owner.char_name, " is LOSE")
			await perform_attack_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			print(clash_data.owner.char_name, " is DRAW")
			await perform_attack_token_response_on_draw(clash_data)


func process_guard_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			print(clash_data.owner.char_name, " is WIN")
			await perform_guard_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			print(clash_data.owner.char_name, " is LOSE")
			await perform_guard_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			print(clash_data.owner.char_name, " is DRAW")
			await perform_guard_token_response_on_draw(clash_data)


func process_evade_token_clash_response(clash_data: ClashData):
	var clash_result: ClashData.ClashResult = clash_data.clash_result
	match clash_result:
		clash_data.ClashResult.WIN:
			await perform_evade_token_response_on_win(clash_data)
		clash_data.ClashResult.LOSE:
			await perform_evade_token_response_on_lose(clash_data)
		clash_data.ClashResult.DRAW:
			await perform_evade_token_response_on_draw(clash_data)
#endregion


#region Play Token Response : Attack Token 
func perform_attack_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_attack_on_win_response()
		clash_data.opponent_token.DiceType.GUARD:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_guard_on_win_response()
		clash_data.opponent_token.DiceType.EVADE:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_evade_on_win_response()


func perform_attack_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_attack_on_lose_response()
		clash_data.opponent_token.DiceType.GUARD:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_guard_on_lose_response()
		clash_data.opponent_token.DiceType.EVADE:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_evade_on_lose_response()


func perform_attack_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_attack_on_draw_response()
		clash_data.opponent_token.DiceType.GUARD:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_guard_on_draw_response()
		clash_data.opponent_token.DiceType.EVADE:
			var attack_token_response = clash_data.owner.attack_token_response
			await attack_token_response.perform_attack_vs_evade_on_draw_response()
#endregion


#region Play Token Response : Guard Token 
func perform_guard_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_attack_on_win_response()
		clash_data.opponent_token.DiceType.GUARD:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_guard_on_win_response()
		clash_data.opponent_token.DiceType.EVADE:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_evade_on_win_response()


func perform_guard_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_attack_on_lose_response()
		clash_data.opponent_token.DiceType.GUARD:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_guard_on_lose_response()
		clash_data.opponent_token.DiceType.EVADE:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_evade_on_lose_response()


func perform_guard_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_attack_on_draw_response()
		clash_data.opponent_token.DiceType.GUARD:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_guard_on_draw_response()
		clash_data.opponent_token.DiceType.EVADE:
			var guard_token_response = clash_data.owner.guard_token_response
			await guard_token_response.perform_guard_vs_evade_on_draw_response()
#endregion


#region Perform Token Response : Evade Token 
func perform_evade_token_response_on_win(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_attack_on_win_response()
		clash_data.opponent_token.DiceType.GUARD:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_guard_on_win_response()
		clash_data.opponent_token.DiceType.EVADE:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_evade_on_win_response()


func perform_evade_token_response_on_lose(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_attack_on_lose_response()
		clash_data.opponent_token.DiceType.GUARD:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_guard_on_lose_response()
		clash_data.opponent_token.DiceType.EVADE:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_evade_on_lose_response()


func perform_evade_token_response_on_draw(clash_data: ClashData):
	match clash_data.opponent_token.token_type:
		clash_data.opponent_token.DiceType.ATTACK:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_attack_on_draw_response()
		clash_data.opponent_token.DiceType.GUARD:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_guard_on_draw_response()
		clash_data.opponent_token.DiceType.EVADE:
			var evade_token_response = clash_data.owner.evade_token_response
			await evade_token_response.perform_evade_vs_evade_on_draw_response()
#endregion
