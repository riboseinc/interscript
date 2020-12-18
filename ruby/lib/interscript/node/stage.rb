class Interscript::Node::Stage < Interscript::Node::Group::Sequential
  attr_accessor :children
  def initialize *args, **kargs, &block
    puts "Interscript::Node::Stage.new (args = #{
      args.inspect})" if $DEBUG

    self.children = []


    %i{boundary not_word line_start line_end none space}.each do |sym|
      self.class.send(:define_method,sym) {
         Interscript::Node::Item.new(sym)}
    end

    if block_given?
      instance_eval(&block)
    end

    #self
  end


  #doesn't do anything yet
  def map(*args)
    {}
  end
  def run(*args)
    nil
  end

  def sub(from, to, **kargs, &block)
    puts "sub(#{from.inspect},#{to}, kargs = #{
      kargs.inspect
    }) from #{self.inspect}" if $DEBUG

    self.children << Interscript::Node::Rule::Sub.new(from,to,**kargs)
  end

  def any(chars)
    puts "any(#{chars.inspect}) from #{self.inspect}" if $DEBUG
    Interscript::Node::Item::Any.new(chars)
  end



  def parallel(&block)
    puts "parallel(#{chars.inspect}) from #{self.inspect}" if $DEBUG
    self.children << Interscript::Node::Group::Parallel.new(&block)
  end

  def any(chars)
    puts "any(#{chars.inspect}) from #{self.inspect}" if $DEBUG
    Interscript::Node::Item::Any.new(chars)
  end



  def to_hash
    {:class => self.class.to_s,
      :children => @children.map{|x| x.to_hash}}
  end


end
