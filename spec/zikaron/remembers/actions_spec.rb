require 'spec_helper'

describe Zikaron::Remembers::Actions do

  class Request
    def url
      "test_key"
    end
  end

  class Response
    def body
      "test_value"
    end
  end

  class DummyClass
    include Zikaron::Remembers::Actions

    def request
      Request.new
    end

    def response
      Response.new
    end
  end

  before(:each) do
    @dummy = DummyClass.new
  end

  describe "class methods" do

    describe "write_to_cache" do
      it "should cache key and value in Redis" do
        @dummy.write_to_cache
        Zikaron.redis.get("zikaron_test_key").should == "test_value"
      end
    end

  end


end