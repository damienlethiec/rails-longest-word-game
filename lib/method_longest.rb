require 'open-uri'
require 'json'

def grid
  charset = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  @grid = (0...9).map { charset.to_a[rand(charset.size)] }
end

def results(grid, answer)
  clone_grid = grid.clone
  test_repeat_letter(answer, clone_grid)
  main_result(grid, answer, clone_grid)
end

def test_repeat_letter(answer, clone_grid)
  answer.upcase.split(//).each do |letter|
    if clone_grid.include?(letter)
      clone_grid.delete_at(clone_grid.index(letter))
    end
  end
end

def main_result(grid, answer, clone_grid)
  @score = 0
  @translation = nil
  if grid.size == (clone_grid.size + answer.size)
    test_api
  else
    @message = "not in the grid"
  end
end

def test_api
  api_url = "http://api.wordreference.com/0.8/80143/json/enfr/#{@answer.downcase}"
  quote_serialized = open(api_url).read
  quote = JSON.parse(quote_serialized)
  if quote["Error"]
    @message = "not an english word"
  else
    @message = "well done"
    @translation = quote["term0"]["PrincipalTranslations"]["0"]["FirstTranslation"]["term"]
    @score = (30 - @time) * answer.length
    if @score < 0
      @score = 0
    end
  end
end

