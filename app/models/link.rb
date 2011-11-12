class Link < ActiveRecord::Base

	validates :content, :presence => true
end
