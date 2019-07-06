class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # return all catamaran captains by finding boats that include a
    # classification where the classification is catamaran
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    # return all unique sailboat captains (sailors) by finding boats that
    # include a classification where the classification is sailboat
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    #
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    #
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    #
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
