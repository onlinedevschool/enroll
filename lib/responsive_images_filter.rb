class ResponsiveImagesFilter < HTML::Pipeline::Filter
  def call
    doc.search("img").each do |link|
      classes = link['class'].to_s.split(" ")
      classes << "img-responsive"
      link['class'] = classes.join(" ")
    end
    doc[:output] = doc.to_s
    doc
  end
end
