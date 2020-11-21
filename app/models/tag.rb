class Tag < ApplicationRecord
  has_many :item_tags
  has_many :items, through: :item_tags

  paginates_per 23

  def self.search(search)
    if search != ''
      Tag.where('name LIKE(?)', "%#{search.tr('＃', '#').tr('/０-９/', '/0-9/').delete('#')}%")
    else
      Tag.all
    end
  end
end
