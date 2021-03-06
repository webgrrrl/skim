require 'open-uri'
require 'nokogiri'

class WebArticle < Document

  field :url
  validates :url, presence: true, uniqueness: true

  def self.create_from_url(url)
    @web_article = self.find_or_create_by(url: url)
    doc = Nokogiri::HTML(open(url))
    page_content = ""
    doc.xpath('//p').each do |snippet|
      page_content += snippet 
      page_content += " " # Add a space after each snippet.
    end
    @web_article.text = page_content
    @web_article.save
    @web_article
  end

end
