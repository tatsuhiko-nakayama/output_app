module ItemsHelper
  def render_with_tags(tagbody)
    tagbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/items/hashtag/#{word.delete('#')}" }.html_safe
  end
end
