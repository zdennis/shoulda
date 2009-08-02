module Shoulda # :nodoc:
  module ActiveRecord # :nodoc:
    module Matchers

      # Ensures that the attribute can be set on mass update.
      #
      #   it { should accept_nested_attributes_for(:tasks) }
      #
      def accept_nested_attributes_for(association)
        AcceptNestedAttributesForMatcher.new(association)
      end

      class AcceptNestedAttributesForMatcher # :nodoc:

        def initialize(association)
          @association = association.to_s
        end

        def matches?(subject)
          @subject = subject
          association_attributes_setter?
        end

        def failure_message
          "#{model_class} does not accept nested attributes for #{@association}"
        end

        def negative_failure_message
          "#{model_class} accepts nested attributes for #{@association}"
        end

        def description
          "accept nested attributes for #{@association}"
        end

        protected

        def association_attributes_setter?
          @subject.respond_to?(:"#{@association}_attributes=")
        end

        def model_class
          @subject.class
        end

      end

    end
  end
end

