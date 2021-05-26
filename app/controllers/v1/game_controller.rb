require 'json'

class V1::GameController < ApplicationController

  def index
    render(json: Game.all, status: 200)
  end

  def create
    game = Game.new({player_id1:"0",player_id2:"1",board:[["","",""],["","",""],["","",""]],  moveNumber: 0})
    if game.save
      render(json: { game: game }, status: 200)
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
        currentPlayer = params[:playerId]
        x = params[:movement][0]
        y = params[:movement][1]
        board = JSON[game.board]
        isValidMovement = game.isValidMovement?(board, x,y, game.result)
        if(isValidMovement)
            board[x][y] = currentPlayer
            game.board = board
            game.moveNumber += 1
            game.result = game.get_result(board, game.moveNumber)
            if game.save
                return render(json: {board: board, winner: game.result }, status: 200)
            end
            
        end
        render(json: {message: "Movimiento inválido" }, status: 200)
    end

end
