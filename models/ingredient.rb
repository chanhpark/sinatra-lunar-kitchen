class Ingredient
  attr_reader :ingredients, :name

  def initialize(name)

    @name = name

  end

  def self.ingredients(id)
    sql = "SELECT name FROM ingredients
    WHERE recipe_id = ($1)"

      ingredient = Database.db_connection do |db|
        db.exec_params(sql, [id])
      end
    ingredients_array = []
    ingredient.each do |ing|
      ingredients_array << Ingredient.new(ing["name"])
    end
    ingredients_array
  end

end
