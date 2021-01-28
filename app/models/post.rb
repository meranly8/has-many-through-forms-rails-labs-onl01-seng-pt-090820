class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  
  accepts_nested_attributes_for :comments

  def categories_attributes=(categories)
    categories.each do |i, attrs|
      if attrs[:name].present?
        category = Category.find_or_create_by(name: attrs[:name])
          if !self.categories.include?(category)
            self.post_categories.build(category: category)
          end
      end
    end
  end
end
