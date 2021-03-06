class Interscript::Node::Stage < Interscript::Node::Group::Sequential
  attr_accessor :name, :doc_name

  def initialize name = :main
    @name = name
    super()
  end

  def to_hash
    { :class => self.class.to_s,
      :name => name,
      :children => @children.map{|x| x.to_hash} }
  end

  def inspect
    name = "(#{@name})" if @name != :main
    "stage#{name} {\n#{super}\n}"
  end
end
