class Recipe
  attr_reader :id, :name, :description, :instructions, :ingredients

  def initialize(id, name, description, instructions, ingredients = nil)
    @id = id
    @name = name
    @description = description
    @instructions = instructions
    @ingredients = ingredients
  end

  def self.all
    attribute = []
    sql = "SELECT id, name FROM recipes
    ORDER BY name"

    recipes = Database.db_connection do |db|
      db.exec(sql)
    end
    recipes.each do |recipe|
      addition = Recipe.new(recipe["id"],recipe["name"], nil, nil, nil)
      attribute << addition
    end
    attribute
  end

  def self.find(id)
    sql = "SELECT id, name, description, instructions
    FROM recipes
    WHERE recipes.id = ($1)"

    recipe_info = Database.db_connection do |db|
      db.exec_params(sql, [id])
    end
      Recipe.new(recipe_info.to_a[0]["id"], recipe_info.to_a[0]["name"],
      recipe_info.to_a[0]["description"], recipe_info.to_a[0]["instructions"], Ingredient.ingredients(id))
  end
end
