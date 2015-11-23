xml.instruct! :xml, :version => "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "https://devschool.rocks"
    xml.lastmod 2.days.ago.to_date
    xml.changefreq "weekly"
    xml.priority "0.8"
  end

  Post.homepage.no_internals.
                published.
                ordered.each do |p|
    xml.url do
      xml.loc post_url(p.permalink)
      xml.lastmod p.updated_at.to_date
      xml.priority "0.9"
    end
  end
end

