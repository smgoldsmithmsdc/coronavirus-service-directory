class Service < ApplicationRecord
  geocoded_by :postcode
  after_validation :geocode

  def rough_distance
         
      if distance < 1
        "Less than a mile away"
      elsif (1 < distance) && (distance < 2)
        "About a mile away"
      else
        "About #{distance.round} miles away"
      end
  end

  def self.categories
    [
      ["Shopping and groceries", "food"],
      ["Medicine and prescriptions", "meds"],
      ["Loneliness and isolation", "social"],
      ["Household maintenance", "house"],
      ["Petcare and dog walking", "pets"],
      ["Personal care", "care"],
    ]
  end

end
