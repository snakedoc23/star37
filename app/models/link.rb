class Link < ActiveRecord::Base
  require 'nokogiri'
  require 'open-uri'

	validates :content, :presence => true
	
	before_save :add_title
	
	default_scope :order => 'created_at DESC'

	def self.search(search)
		if search
			where('content LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	
	def add_title
	  url = self.content
	  doc = Nokogiri::HTML(open(url))
	  title = doc.at_css('title').text
	  self.title = title
	end
end
