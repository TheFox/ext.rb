#!/usr/bin/env ruby

require 'minitest/autorun'
require 'thefox-ext'


class TestDate < MiniTest::Test
	def test_today
		assert_equal(true, Date.today.today?)
		
		assert_equal(false, Date.new(2001, 2, 3).today?)
		assert_equal(false, Date.new(2001, 2, 4).today?)
		
		# This test may fail on 01.01.2018 ;)
		assert_equal(false, Date.new(2018, 1, 1).today?)
		
		assert_equal(true, Time.now.to_date.today?)
	end
	
	def test_week_mid
		e = ['2014-02-17', '2014-02-18', '2014-02-19', '2014-02-20', '2014-02-21', '2014-02-22', '2014-02-23']
		assert_equal(e, Date.new(2014, 2, 21).week.map{ |d| "#{d}" })
		
		e = ['2014-03-31', '2014-04-01', '2014-04-02', '2014-04-03', '2014-04-04', '2014-04-05', '2014-04-06']
		assert_equal(e, Date.new(2014, 4, 1).week.map{ |d| "#{d}" })
		
		e = ['2015-02-16', '2015-02-17', '2015-02-18', '2015-02-19', '2015-02-20', '2015-02-21', '2015-02-22']
		assert_equal(e, Date.new(2015, 2, 21).week.map{ |d| "#{d}" })
		
		e = ['2016-02-15', '2016-02-16', '2016-02-17', '2016-02-18', '2016-02-19', '2016-02-20', '2016-02-21']
		assert_equal(e, Date.new(2016, 2, 21).week.map{ |d| "#{d}" })
	end
	
	def test_week_jan
		e = ['2013-12-30', '2013-12-31', '2014-01-01', '2014-01-02', '2014-01-03', '2014-01-04', '2014-01-05']
		assert_equal(e, Date.new(2014, 1, 1).week.map{ |d| "#{d}" })
		
		e = ['2014-12-29', '2014-12-30', '2014-12-31',
			'2015-01-01', '2015-01-02', '2015-01-03', '2015-01-04']
		assert_equal(e, Date.new(2015, 1, 1).week.map{ |d| "#{d}" })
		
		e = ['2015-12-28', '2015-12-29', '2015-12-30', '2015-12-31',
			'2016-01-01', '2016-01-02', '2016-01-03']
		assert_equal(e, Date.new(2016, 1, 1).week.map{ |d| "#{d}" })
		
		e = ['2016-12-26', '2016-12-27', '2016-12-28', '2016-12-29', '2016-12-30', '2016-12-31',
			'2017-01-01']
		assert_equal(e, Date.new(2017, 1, 1).week.map{ |d| "#{d}" })
		
		e = ['2018-01-01', '2018-01-02', '2018-01-03', '2018-01-04', '2018-01-05', '2018-01-06', '2018-01-07']
		assert_equal(e, Date.new(2018, 1, 1).week.map{ |d| "#{d}" })
	end
	
	def test_week_dec
		e = ['2014-12-29', '2014-12-30', '2014-12-31',
			'2015-01-01', '2015-01-02', '2015-01-03', '2015-01-04']
		assert_equal(e, Date.new(2014, 12, 31).week.map{ |d| "#{d}" })
		
		e = ['2015-12-28', '2015-12-29', '2015-12-30', '2015-12-31',
			'2016-01-01', '2016-01-02', '2016-01-03']
		assert_equal(e, Date.new(2015, 12, 31).week.map{ |d| "#{d}" })
		
		e = ['2016-12-26', '2016-12-27', '2016-12-28', '2016-12-29', '2016-12-30', '2016-12-31',
			'2017-01-01']
		assert_equal(e, Date.new(2016, 12, 31).week.map{ |d| "#{d}" })
		
		e = ['2017-12-25', '2017-12-26', '2017-12-27', '2017-12-28', '2017-12-29', '2017-12-30', '2017-12-31']
		assert_equal(e, Date.new(2017, 12, 31).week.map{ |d| "#{d}" })
	end
end
