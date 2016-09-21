class SampleProduct
  def initialize(*args)
    args.extract_options!.each do |key, val|
      define_attr(key, val)
    end if args.present?
  end

  def [](name)
    self.instance_variable_get("@#{name}") if self.respond_to? name
  end

  private
  def define_attr(attribute, val)
    self.class.__send__(:attr_accessor, attribute)
    self.__send__("#{attribute}=", val)
  end
end