module Slug

  def slug
    name = self.name.to_s
    name = name.split(" ")
    name = name.map {|x| x.downcase}
    name.join("-")
  end


end
