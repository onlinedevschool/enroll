xml.instruct! :xml, :version => "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "https://onlinedevschool.com"
    xml.lastmod 2.days.ago.to_date
    xml.changefreq "weekly"
    xml.priority "0.5"
  end
end

