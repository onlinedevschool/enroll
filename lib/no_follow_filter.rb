class NoFollowFilter < HTML::Pipeline::Filter
  def call
    doc.search("a").each do |link|
      link['rel'] = "nofollow"
    end
    doc[:output] = doc.to_s
    doc
  end
end
