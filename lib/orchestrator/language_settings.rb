module Orchestrator
  class LanguageSettings
    def initialize(hash)
      @timeout_ms_atom = Concurrent::Atom.new(nil)
      @container_slug_atom = Concurrent::Atom.new(nil)

      update(hash)
    end

    def update(hash)
      timeout_ms_atom.reset(hash['timeout_ms'].to_i)
      container_slug_atom.reset(hash['container_slug'])
    end

    def timeout_ms
      timeout_ms_atom.value
    end

    def container_slug
      container_slug_atom.value
    end

    private
    attr_reader :timeout_ms_atom, :container_slug_atom
  end
end
