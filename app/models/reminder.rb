class Reminder < ActiveRecord::Base
  attr_accessible :category, :item, :name, :user_id

  belongs_to :user

  after_validation do 
    self.user_id = 1
    temp_name = self.name.clone
    if temp_name.downcase.strip.start_with?('buy')
      self.item = temp_name.downcase.tap{|s| s.slice! 'buy'}.strip.downcase
      self.category = Item.where(:name => self.item).first[:category]
    end
  end

  def as_json(options={})
    options[:except] ||= [:item, :category, :created_at, :updated_at, :user_id]
    super(options)
  end
end
