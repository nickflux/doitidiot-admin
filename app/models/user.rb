class User
  include Mongoid::Document

  references_many :todos, :dependent => :destroy

end
