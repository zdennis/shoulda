require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class AcceptNestedAttributesForMatcherTest < ActiveSupport::TestCase # :nodoc:

  context "accept_nested_attributes_for" do
    setup do
      @matcher = accept_nested_attributes_for(:users)
    end

    should "accept a model that accepts nested attributes for users" do
      define_model :user do
        belongs_to :account
      end
      define_model :account do
        has_many :users
        accepts_nested_attributes_for :users
      end
      assert_accepts @matcher, Account.new
    end

    should "reject a model that does not accept nested attributes for users" do
      define_model :account
      assert_rejects @matcher, Account.new
    end
  end

end
