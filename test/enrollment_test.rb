require 'minitest'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def test_instantiates_an_enrollment_class
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert e.instance_of?(Enrollment)
  end

  def test_enrollment_has_a_method_that_returns_district_name
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal "ACADEMY 20", e.name
  end

  def test_enrollment_data_is_truncated_at_3_decimals
      e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal 0.267, e.truncate_float(0.2677)
    assert_equal 0.0, e.truncate_float(0.0000)
    assert_equal 1.0, e.truncate_float(1)
  end

  def test_kindergarten_participation_by_year_returns_single_hash_with_data
    data = {
      2010=>0.3915,
      2011=>0.35356,
      2012=>0.2677,
      2006=>0.523,
      1800=>0.325}
    e = Enrollment.new({
        :name => "Academy for Nerds",
        :kindergarten_participation => data})
    assert_equal data, e.kindergarten_participation
  end

  def test_kindergarten_participation_in_year_returns_single_value_for_year_and_nil_for_failed_searches
    e = Enrollment.new({
        :name => "Hogwarts",
        :kindergarten_participation => {
            2010 => 0.3915,
            2011 => 0.35356,
            2012 => 0.2677,
            2006 => 0.523,
            1800 => 0.3252}})

    participation = e.kindergarten_participation_in_year(1800)
    participation2 = e.kindergarten_participation_in_year(1825)

    assert_equal 0.325, participation
    assert_nil participation2
  end

  def test_graduation_date_by_year_returns_single_hash_with_annual_data_of_grad_percent
    enrollment = Enrollment.new({:name => "ACADEMY 20", :high_school_graduation => { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}})

    grad_hash = { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
    assert_equal grad_hash, enrollment.graduation_rate_by_year
  end

  def test_graduation_date_in_year_returns_percent
    enrollment = Enrollment.new({:name => "ACADEMY 20", :high_school_graduation => { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}})
    assert_equal 0.895, enrollment.graduation_rate_in_year(2010)
  end

  def test_graduation_date_in_year_when_passed_in_an_unknown_year_returns_nil
    enrollment = Enrollment.new({:name => "ACADEMY 20", :high_school_graduation => { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}})

    assert_equal nil, enrollment.graduation_rate_in_year(1010)
  end

  def test_graduation_date_in_year_when_passed_in_an_abonormal_year_returns_nil
    enrollment = Enrollment.new({:name => "ACADEMY 20", :high_school_graduation => { 2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}})

    assert_equal nil, enrollment.graduation_rate_in_year(80038382)
  end
end
