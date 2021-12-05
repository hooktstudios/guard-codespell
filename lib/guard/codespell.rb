# frozen_string_literal: true

require "guard/compat/plugin"

module Guard
  # Service that runs the codespell tool inside guard.
  # Based on an example from the guard documentation https://github.com/guard/guard/wiki/Create-a-guard
  class Codespell < Plugin
    attr_reader :options, :codespell

    # Initializes a Guard plugin.
    # Don't do any work here, especially as Guard plugins get initialized even if they are not in an active group!
    #
    # @param [Hash] options the custom Guard plugin options
    # @option options [Array<Guard::Watcher>] watchers the Guard plugin file watchers
    # @option options [Symbol] group the group this Guard plugin belongs to
    # @option options [Boolean] any_return allow any object to be returned from a watcher
    def initialize(options = {})
      super
      @codespell = codespell_installed?
    end

    # Called once when Guard starts. Please override initialize method to init stuff.
    #
    # @raise [:task_has_failed] when start has failed
    # @return [Object] the task result
    def start
      run_all if options[:all_on_start]
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    #
    # @raise [:task_has_failed] when run_all has failed
    # @return [Object] the task result
    def run_all
      return warn_codespell_missing unless codespell

      run_codespell
    end

    # Called on file(s) additions that the Guard plugin watches.
    #
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_additions has failed
    # @return [Object] the task result
    def run_on_additions(paths)
      return warn_codespell_missing unless codespell

      run_codespell(paths)
    end

    # Called on file(s) modifications that the Guard plugin watches.
    #
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_modifications has failed
    # @return [Object] the task result
    def run_on_modifications(paths)
      return warn_codespell_missing unless codespell

      run_codespell(paths)
    end

    private

    def run_codespell(paths = [])
      Guard::Compat::UI.info "Looking for typos with codespell"
      cmd = build_command(paths)
      Guard::Compat::UI.info "... running #{cmd}"
      system(cmd)
    end

    def build_command(paths)
      cmd = []
      cmd << "codespell"
      cmd << "--config=#{options[:config]}" if options[:config]
      cmd << paths.join(" ") if paths.any?

      cmd.join(" ")
    end

    def codespell_installed?
      # Based on this script to check if an executable is present in PATH: https://stackoverflow.com/a/5471032
      exts = ENV["PATHEXT"] ? ENV["PATHEXT"].split(";") : [""]
      ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
        exts.each do |ext|
          exe = File.join(path, "codespell#{ext}")
          return true if File.executable?(exe) && !File.directory?(exe)
        end
      end
      false
    end

    def warn_codespell_missing
      Guard::Compat::UI.warning "Spellcheck failed - guard-codespell cannot find the codespell library."
      Guard::Compat::UI.warning "Please run `pip install codespell` to resolve this issue."
    end
  end
end
