require 'rubygems'
require 'test/unit'
require 'context'
require 'stump'
require 'redgreen' rescue nil
require File.join(File.dirname(__FILE__), '..', 'lib', 'wufoo')

def successful_response_data
  {"wufoo_submit" => [{
      "confirmation_message" => "Success! Thanks for filling out my form!",
      "entry_id"             => "1025",
      "success"              => "true"
    }]}
end

def successful_query_response_data
  {"success" => "true",
    "query_records" => [{
      "title"              => "data"
   }],
   "total_records" => "1"
  }
end

def error_response_data
  {"wufoo_submit" => [{
      "error"        => "The supplied form URL was not found.",
      "field_errors" => [],
      "success"      => "false"
    }]}
end

def error_query_response_data
  {"success" => "false",
    "error" => "Invalid API key."
  }
end

def field_error_response_data
  {"wufoo_submit" => [{
      "error" => "",
      "field_errors" => [
        {"field_id" => "field0", "error_message" => "Invalid email address.", "error_code" => "2"},
        {"field_id" => "field1", "error_message" => "Field is required.", "error_code" => "0"},
      ],
      "success" => "false"
    }]}
end