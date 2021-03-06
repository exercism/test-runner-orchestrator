require_relative 'base'

module Orchestrator
  class AddLanguageTest < SystemBaseTestCase
    def test_adds_langauge_successfully
      stub_language_processor_run!(times: 2)
      application = Orchestrator.application

      timeout_ms = 1234
      version_slug = "git://some_slug"

      post '/languages/ruby', {
        settings: {
          timeout_ms: timeout_ms,
          version_slug: version_slug,
          num_processors: 2
        }
      }
      assert_equal 200, last_response.status

      application.send(:borrow_language, :ruby) do |lang|
        assert_equal timeout_ms, lang.settings.timeout_ms
        assert_equal version_slug, lang.settings.version_slug
      end
      assert_equal 2, application.num_processors(language: :ruby)
    end
  end
end

