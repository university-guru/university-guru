# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Metrics/ClassLength
class UniversityTest < ActiveSupport::TestCase
  test 'search' do
    University.create(name: 'Miami University')
    University.create(name: 'Test University')

    search_str = 'miami'
    results = University.search(search_str)
    results.each do |university|
      assert_not((university.name =~ /#{search_str}/i).nil?)
    end
  end

  test 'adv_search name' do
    University.create(name: 'Miami University')
    University.create(name: 'Test University')

    search_str = 'miami'
    results = University.adv_search(search_str, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.name =~ /#{search_str}/i).nil?)
    end
  end

  test 'adv_search city' do
    University.create(city: 'Oxford')
    University.create(name: 'Cincinnati')

    search_str = 'oxford'
    results = University.adv_search('', search_str, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.city =~ /#{search_str}/i).nil?)
    end
  end

  test 'adv_search state' do
    University.create(state: 'Ohio')
    University.create(state: 'Indiana')

    search_str = 'ohio'
    results = University.adv_search('', '', search_str, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.state =~ /#{search_str}/i).nil?)
    end
  end

  test 'adv_search zip' do
    University.create(zip_code: '45056')
    University.create(zip_code: '12345')

    search_str = '45056'
    results = University.adv_search('', '', '', search_str, '', '', '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.zip_code =~ /#{search_str}/i).nil?)
    end
  end

  test 'adv_search size_min' do
    University.create(student_count: 10_000)
    University.create(student_count: 15_000)

    search = 12_500
    results = University.adv_search('', '', '', '', search, '', '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.student_count > search).nil?)
    end
  end

  test 'adv_search size_max' do
    University.create(student_count: 10_000)
    University.create(student_count: 15_000)

    search = 12_500
    results = University.adv_search('', '', '', '', '', search, '', '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.student_count < search).nil?)
    end
  end

  test 'adv_search acceptance_rate_min' do
    University.create(acceptance_rate: 80)
    University.create(acceptance_rate: 40)

    search = 60
    results = University.adv_search('', '', '', '', '', '', search, '', '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.acceptance_rate > search).nil?)
    end
  end

  test 'adv_search acceptance_rate_max' do
    University.create(acceptance_rate: 80)
    University.create(acceptance_rate: 40)

    search = 60
    results = University.adv_search('', '', '', '', '', '', '', search, '', '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.acceptance_rate < search).nil?)
    end
  end

  test 'adv_search sat_reading_min' do
    University.create(q3_sat_reading: 400)
    University.create(q3_sat_reading: 800)

    search = 600
    results = University.adv_search('', '', '', '', '', '', '', '', search, '', '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.q3_sat_reading > search).nil?)
    end
  end

  test 'adv_search sat_reading_max' do
    University.create(q1_sat_reading: 400)
    University.create(q1_sat_reading: 800)

    search = 600
    results = University.adv_search('', '', '', '', '', '', '', '', '', search, '', '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.q1_sat_reading < search).nil?)
    end
  end

  test 'adv_search sat_math_min' do
    University.create(q3_sat_math: 400)
    University.create(q3_sat_math: 800)

    search = 600
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', search, '', '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.q3_sat_math > search).nil?)
    end
  end

  test 'adv_search sat_math_max' do
    University.create(q1_sat_math: 400)
    University.create(q1_sat_math: 800)

    search = 600
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', search, '', '', '', '', '', '')
    results.each do |university|
      assert_not((university.q1_sat_math < search).nil?)
    end
  end

  test 'adv_search act_min' do
    University.create(q3_act: 20)
    University.create(q3_act: 30)

    search = 25
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', search, '', '', '', '', '')
    results.each do |university|
      assert_not((university.q3_act > search).nil?)
    end
  end

  test 'adv_search act_max' do
    University.create(q1_act: 20)
    University.create(q1_act: 30)

    search = 25
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', '', search, '', '', '', '')
    results.each do |university|
      assert_not((university.q1_act < search).nil?)
    end
  end

  test 'adv_search cost_in_min' do
    University.create(cost_in: 1000)
    University.create(cost_in: 10_000)

    search = 5500
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', '', '', search, '', '', '')
    results.each do |university|
      assert_not((university.cost_in > search).nil?)
    end
  end

  test 'adv_search cost_in_max' do
    University.create(cost_in: 1000)
    University.create(cost_in: 10_000)

    search = 5500
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', search, '', '')
    results.each do |university|
      assert_not((university.cost_in < search).nil?)
    end
  end

  test 'adv_search cost_out_min' do
    University.create(cost_out: 1000)
    University.create(cost_out: 10_000)

    search = 5500
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', search, '')
    results.each do |university|
      assert_not((university.cost_out > search).nil?)
    end
  end

  test 'adv_search cost_out_max' do
    University.create(cost_out: 1000)
    University.create(cost_out: 10_000)

    search = 5500
    results = University.adv_search('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', search)
    results.each do |university|
      assert_not((university.cost_out < search).nil?)
    end
  end

  test 'sat_reading' do
    u1 = University.create(q1_sat_reading: 400, q3_sat_reading: 800)
    u2 = University.create(q1_sat_reading: 400)
    u3 = University.create(q3_sat_reading: 400)
    u4 = University.create

    assert u1.sat_reading?
    assert_not u2.sat_reading?
    assert_not u3.sat_reading?
    assert_not u4.sat_reading?
  end

  test 'sat_math' do
    u1 = University.create(q1_sat_math: 400, q3_sat_math: 800)
    u2 = University.create(q1_sat_math: 400)
    u3 = University.create(q3_sat_math: 400)
    u4 = University.create

    assert u1.sat_math?
    assert_not u2.sat_math?
    assert_not u3.sat_math?
    assert_not u4.sat_math?
  end

  test 'act' do
    u1 = University.create(q1_act: 20, q3_act: 30)
    u2 = University.create(q1_act: 20)
    u3 = University.create(q3_act: 20)
    u4 = University.create

    assert u1.act?
    assert_not u2.act?
    assert_not u3.act?
    assert_not u4.act?
  end

  test 'full_url' do
    u1 = University.create(school_site: 'example.com')
    u2 = University.create(school_site: 'http://example.com')

    assert u1.full_url == 'http://example.com'
    assert u2.full_url == 'http://example.com'
  end
end
# rubocop:enable Metrics/ClassLength
