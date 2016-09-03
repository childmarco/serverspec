module DirectoryHelper


def get_roles(node_file)
    roles = []
    JSON.parse(File.read(node_file))['localhost'].each do |role|
      p role
      roles << role.gsub(/role\[(.+)\]/, '\1')
    end
    roles
  end


  def get_recipes(role)
    recipes = []
    JSON.parse(File.read("role/#{role}.json"))["hogehoge"].each do |recipe|
      recipes << recipe.gsub(/recipe\[(.+)\]/, '\1')
    end
    recipes
  end


end





