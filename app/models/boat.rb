class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # return 5 boats by limiting results to this number only
    all.limit(5)
  end

  def self.dinghy
    # find and return boats less than 20 ft
    where("length < 20")
  end

  def self.ship
    # find and return boats 20 ft or longer
    where("length >= 20")
  end

  def self.last_three_alphabetically
    # return last 3 boats alphabetically by organizing all boats
    # by name, in descending order, and limiting results to only 3
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    # find and return boats with no captain associated to them
    where(captain_id: nil)
  end

  def self.sailboats
    # includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    #
    # joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    # where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    # order('length DESC').first
  end
end
