require 'json'

class V1::GameController < ApplicationController

  def index
    render(json: Game.all, status: 200)
  end

  def create
    if checkStartedGame()
      game = checkStartedGame()
      game.player_id2 = "1"
      playerID = 1
    else
      game = Game.new({player_id1:"0",player_id2:nil,board:[["","",""],["","",""],["","",""]],  moveNumber: 0})
      playerID = 0
    end
    if game.save
      render(json: { game: game, playerID:playerID }, status: 200)
    else
        render(json: format_error(request.path, game.errors.full_messages), status: 401)
    end
  end

  def destroy
    game = Game.find_by(id: params[:id])
    if game.delete
        render(json: { game: game }, status: 200)
      else
          render(json: format_error(request.path, game.errors.full_messages), status: 401)
      end
    end


    def newmovement
        game =  Game.find_by(id: params[:gameId])
        currentPlayer = game.currentPlayer
        x = params[:movement][0]
        y = params[:movement][1]
        board = JSON[game.board]
        isValidMovement = game.isValidMovement?(board, x,y, game, params[:playerId])
        if(isValidMovement)
            board[x][y] = currentPlayer
            game.board = board
            game.moveNumber += 1
            game.result = game.get_result(board, game.moveNumber)
            game.currentPlayer = currentPlayer == "1" ? "0" : "1"
            if game.save
                return render(json: {board: board, winner: game.result }, status: 200)
            end
            
        end
        render(json: {message: "Movimiento inválido" }, status: 200)
    end
    
    def checkStartedGame
      return  Game.find_by(player_id2: nil)
    end

    def getGameState
      game = Game.find_by(id: params[:gameId])
      if game
        return render(json: {game: game, winner: game.result}, status: 200)
      end
      return nil
    end
end
