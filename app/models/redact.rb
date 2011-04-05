class Redact
  include Mongoid::Document

  field :code_name,     :type => String
  field :redact_array,  :type => Array

  validates_presence_of :code_name
  
  ###
  # INSTANCE METHODS
  ###

  def redact_array
    self[:redact_array]
  end

  def redact_array=(redact_array_val)
    self[:redact_array] = redact_array_val.delete_if{|r| r == ''}
  end

end

