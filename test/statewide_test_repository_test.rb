require 'minitest'
# require './test/test_helper'
require './lib/statewide_test_repository'
require 'pry'

class StatewideTestRepositoryTest < Minitest::Test
  def statewide_test_repository_is_initialized
    str = StatewideTestRepository.new
    assert str.instance_of?(StatewideTestRepository)
  end

  def test_statewide_test_repository_takes_input_of_one_category
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/subsets/third_grade_proficient.csv"}})
    t_object = str.find_by_name("BETHUNE R-5")
    assert_equal StatewideTest, t_object.class
    assert t_object.data.fetch(:third_grade)
  end

  def test_statewide_test_repository_takes_input_of_multiple_categories_and_does_stuff_with_it
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/subsets/third_grade_proficient.csv",
        :eighth_grade => "./data/subsets/eighth_grade_proficient.csv"}})
    t_object = str.find_by_name("Academy 20")
    binding.pry
    assert t_object.data.fetch(:third_grade)
    assert t_object.data.fetch(:eighth_grade)
  end

  def test_statewide_test_repository_loads_data_gives_test_information_for_multiple_categories_within_a_school
    skip
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })
  assert_equal "Test Profile", str.find_by_name("ACADEMY 20")
  end

  def test_data_will_return_value_even_if_value_not_a_floating_num
    skip
   # Edge cases:
   # LNE instead of Percent, percent out of order, #Value! as percent (Bethune)


  end

end
