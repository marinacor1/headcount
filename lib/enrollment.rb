class Enrollment
  attr_reader :enrollment, :name
  attr_accessor  :kindergarten_participation, :high_school_graduation

  def initialize(enrollment = {}, kindergarten_participation = enrollment[:kindergarten_participation])
    @name = (enrollment[:name]).upcase
    @kindergarten_participation = enrollment[:kindergarten_participation]
    @high_school_graduation = enrollment[:high_school_graduation]
  end

  def kindergarten_participation_by_year
    kindergarten_participation.map do |year, data|
      binding.pry
      [year, truncate_float(data)]
    end.to_h
  end

  def kindergarten_participation_in_year(year)
    search = nil
    kindergarten_participation.each do |key, value|
      if key == year
        search = value
      end
    end
    truncate_float(search) if !search.nil?
  end

  def graduation_rate_by_year
    high_school_graduation.map do |year, data|

      {year => truncate_float(data)}
    #grad_hash = { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
  end
end

  def truncate_float(number)
    (number * 1000).truncate/1000.to_f
  end
#   Enrollment: Gives access to enrollment data within that district, including:
# |  | -- Dropout rate information
# |  | -- Kindergarten enrollment rates
# |  | -- Online enrollment rates
# |  | -- Overall enrollment rates
# |  | -- Enrollment rates by race and ethnicity
# |  | -- High school graduation rates by race and ethnicity
# |  | -- Special education enrollment rates

# ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
#dividing first by colorado number
# end
end
