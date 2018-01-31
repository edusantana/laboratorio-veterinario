class Organizacao < ApplicationRecord
  resourcify
  belongs_to :dono, class_name: "User"
  has_one :laboratorio

  
end
