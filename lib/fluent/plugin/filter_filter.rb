module Fluent
class FilterFilter < Filter
  require 'fluent/plugin/filter_util'
  include FilterUtil

  Plugin.register_filter('filter', self)

  config_param :all, :string, :default => 'allow'
  config_param :allow, :string, :default => ''
  config_param :deny, :string, :default => ''
  config_param :delim, :string, :default => ','

  attr_accessor :allows
  attr_accessor :denies

  def configure(conf)
    super
    @allows = toMap(@allow, @delim)
    @denies = toMap(@deny, @delim)
  end

  def filter(tag, time, record)
    record if passRules(record)
  end
end

end
