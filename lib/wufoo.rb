$:.unshift File.dirname(__FILE__)

require 'rubygems'
gem 'httparty', '0.2.2'
require 'httparty'

require 'wufoo/client'
require 'wufoo/query'
require 'wufoo/submission'
require 'wufoo/version'