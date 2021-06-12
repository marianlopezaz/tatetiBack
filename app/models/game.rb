class Game < ApplicationRecord
    validates :player_id1, :board, :moveNumber, presence: true

    def isValidMovement?(board, x,y, game, currentPlayer)
        return board[x][y] == "" && (game.result == nil || game.result == "") && currentPlayer == game.currentPlayer.to_i
    end

    def get_result(board, moveNumber)
      
      # Three horizontal
      board.each do |row|
        next if row[0] == ""
        if row.uniq.length == 1 then return row.uniq.first end
      end
  
      # Three vertical
      board.transpose.each do |col|
        next if col[0] == ""
        if col.uniq.length == 1 then return col.uniq.first end
      end
  
      # Three diagonal
      if board[0][0] != "" and 
          board[0][0] == board[1][1] and 
          board[1][1] == board[2][2] then
          return board[0][0]
      end
  
      if board[2][0] != "" and
          board[2][0] == board[1][1] and
          board[1][1] == board[0][2] then
          return board[2][0]
        end
    
      if moveNumber === 9 then return 9 end
      return nil
   
    end
end
