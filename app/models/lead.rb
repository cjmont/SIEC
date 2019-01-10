class Lead < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :sondeo
end
