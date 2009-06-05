require File.dirname(__FILE__) + '/test_helper'

class TestQuery < Test::Unit::TestCase
  before do
    @client = Wufoo::Client.new('http://foobar.wufoo.com', 'somecrazyapikey')
  end

  test 'initialize' do
    query = Wufoo::Query.new(@client, 'my-crazy-form')
    assert_equal(@client, query.client)
    assert_equal({}, query.params)
  end

  test 'initialize with params' do
    query = Wufoo::Query.new(@client, 'my-crazy-form', {'0' => 'Foo'})
    assert_equal({'0' => 'Foo'}, query.params)
  end

  test 'add_params' do
    query = Wufoo::Query.new(@client, 'my-crazy-form').add_params('0' => 'Foo')
    assert_equal({'0' => 'Foo'}, query.params)
  end

  test 'add_params returns self' do
    assert_kind_of(Wufoo::Query, Wufoo::Query.new(@client, 'my-crazy-form').add_params('0' => 'Foo'))
  end

  context 'processing response that was successful' do
    before do
      @client.stub!(:post, :return => successful_query_response_data)
      query = Wufoo::Query.new(@client, 'my-crazy-form').add_params({'0' => 'Foobar!'})
      @response = query.process
    end

    test 'should have data' do
      assert_equal(successful_query_response_data, @response.data)
    end

    test 'should be success?' do
      assert @response.success?
    end

    test 'should not be fail?' do
      assert ! @response.fail?
    end

    test 'should not have error' do
      assert_equal('', @response.error)
    end

  end

  context 'processing a response that failed' do
    before do
      @client.stub!(:post, :return => error_query_response_data)
      query = Wufoo::Query.new(@client, 'my-crazy-form').add_params({'0' => 'Foobar!'})
      @response = query.process
    end

    test 'should have data' do
      assert_equal(error_query_response_data, @response.data)
    end

    test 'should not be success?' do
      assert ! @response.success?
    end

    test 'should be a fail?' do
      assert @response.fail?
    end

    test 'should have error' do
      assert_equal('Invalid API key.', @response.error)
    end
  end

end