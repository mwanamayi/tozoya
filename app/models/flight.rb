class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight
  attr_accessible :content, :date, :departure, :destination, :picture, :public
end
