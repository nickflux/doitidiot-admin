class Faq
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question,  :type => String
  field :answer,    :type => String
  field :faq_group, :type => String
  field :ordinal,   :type => Integer, :default => 1
  field :published, :type => Boolean, :default => false
  
  validates_presence_of :question, :answer, :faq_group

  scope :alive, :where => { :published => true }

  before_create :add_ordinal

  protected

    def add_ordinal
      group_faqs  = Todo.where(:faq_group => faq_group).alive
      if group_faqs.count == 0
        last_ordinal  = 0
      else
        last_ordinal  = group_faqs.order_by(:ordinal.desc).first.ordinal
      end
      self[:ordinal]  = last_ordinal + 1
    end

end
