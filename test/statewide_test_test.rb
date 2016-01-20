require 'minitest'
# require './test/test_helper'
require './lib/statewide_test'
require 'pry'

class StatewideTestTest < Minitest::Test

  def test_statewide_test_instantiates
    str = StatewideTest.new
    str.instance_of?(StatewideTest)
  end

  def test_instance_of_statewide_test_contains_all_data_from_single_method
    skip

  end

  def test_proficient_by_grade_returns_data_from_grade
    skip
    statewide_test = StatewideTest.new
    actual = statewide_test.proficient_by_grade(3)

    expected = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
             2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
             2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
             2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
             2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
             2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
             2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
           }
    actual.values.zip(expected.values).each do |pair|
    assert_in_delta pair.last, pair.first, 0.005
    end
    end

  def test_proficient_by_grade_returns_error_if_wrong_year
    skip
    statewide_test = StatewideTest.new
    actual = statewide_test.proficient_by_grade(4)

    assert_equal UnknownDataError, actual
  end

  def test_proficient_by_race_or_ethnicity_gives_percent_proficiency_for_given_race
    skip
    actual = statewide_test = StatewideTest.new

     expected =  { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
       2012 => {math: 0.818, reading: 0.893, writing: 0.808},
       2013 => {math: 0.805, reading: 0.901, writing: 0.810},
       2014 => {math: 0.800, reading: 0.855, writing: 0.789},
       }
     actual.values.zip(expected.values).each do |pair|
     assert_in_delta pair.last, pair.first, 0.005
     end
  end

  def test_proficient_by_race_returns_error_if_unknown_race
    skip
    statewide_test = StatewideTest.new
    actual = statewide_test.proficient_by_race_or_ethnicity(:skaterboys)

    assert_equal UnknownDataError, actual
  end

  def test_proficient_for_subject_by_grade_in_year_gives_correct_percent
     skip
     statewide_test = StatewideTest.new
     assert_equal 0.857, statewide_test.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_proficient_for_subject_by_grade_in_year_gives_correct_percent
    skip
    statewide_test = StatewideTest.new
    assert_equal UnknownDataError, statewide_test.proficient_for_subject_by_grade_in_year(:science, 3, 2008)
  end

  def test_proficient_for_subject_by_race_returns_correct_percent
    skip
    statewide_test = StatewideTest.new

    assert_equal 0.818, statewide_test.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
  end

  def test_proficient_for_subject_by_race_returns_error_if_wrong_paramter
    skip
    statewide_test = StatewideTest.new

    assert_equal UnknownDataError, statewide_test.proficient_for_subject_by_race_in_year(:history, :asian, 2012)
  end

  def test_proficient_for_subject_by_race_returns_error_if_multiple_wrong_parameters
    skip
    statewide_test = StatewideTest.new

    assert_equal UnknownDataError, statewide_test.proficient_for_subject_by_race_in_year(:history, :cyborg, 2012)
  end

    def test_proficient_for_subject_by_race_returns_error_if_all_wrong_parameters
      skip
      statewide_test = StatewideTest.new

      assert_equal UnknownDataError, statewide_test.proficient_for_subject_by_race_in_year(:history, :cyborg, 200)
    end

end
