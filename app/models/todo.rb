class Todo
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :user, :inverse_of => :todos

  field :what_to_do,  :type => String
  field :anger_level, :type => Integer, :default => 1
  field :ordinal,     :type => Integer
  field :complete,    :type => Boolean, :default => false
  field :deleted,     :type => Boolean, :default => false

  attr_accessible :what_to_do, :anger_level, :ordinal

  validates_presence_of :what_to_do

  scope :alive, :where => { :complete => false, :deleted => false }
  scope :completed, :where => { :complete => true, :deleted => false }

  before_create :add_ordinal

  protected

  def add_ordinal
    user_todos  = user.todos
    if user.todos.alive.count == 0
      last_ordinal  = 0
    else
      last_ordinal  = user.todos.alive.order_by(:ordinal.desc).first.ordinal
    end
    self[:ordinal]  = last_ordinal + 1
  end

end
