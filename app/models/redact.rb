class Redact
  include Mongoid::Document

  field :code_name,     :type => String
  field :redact_array,  :type => Array
  field :sweary,        :type => Boolean, :default => false

  validates_presence_of :code_name
  
  ###
  # INSTANCE METHODS
  ###

  def redact_array
    self[:redact_array]
  end

  def redact_array=(redact_array_val)
    redact_array_temp   = redact_array_val.split("\r\n")
    self[:redact_array] = redact_array_temp.delete_if{|r| r == ''}
  end

end

