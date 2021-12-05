# frozen_string_literal: true

require "guard/compat/test/helper"
require "guard/codespell"

RSpec.describe Guard::Codespell do
  subject(:guard) { described_class.new({}) }

  let(:paths) { %w[path/to/foo.rb path/to/bar/baz.js] }

  before do
    allow(guard).to receive(:run_codespell)
    allow(Guard::Compat::UI).to receive(:info)
    allow(Guard::Compat::UI).to receive(:warning)
  end

  shared_examples "a method calling run_codespell with specific paths" do
    it "calls run_codespell with paths" do
      guard.public_send(method, paths)
      expect(guard).to have_received(:run_codespell).with(paths)
    end
  end

  shared_examples "a method call when codespell is not installed" do
    it "returns a warning" do
      guard.public_send(method, paths)
      expect(guard).not_to have_received(:run_codespell)
      expect(Guard::Compat::UI).to have_received(:warning).twice
    end
  end

  context "with codespell installed" do
    before do
      allow(guard).to receive(:codespell).and_return(true)
    end

    describe "#run_all" do
      it "calls run_codespell without any args" do
        guard.run_all
        expect(guard).to have_received(:run_codespell).with(no_args)
      end
    end

    describe "#run_on_additions" do
      let(:method) { :run_on_additions }

      it_behaves_like "a method calling run_codespell with specific paths"
    end

    describe "#run_on_modifications" do
      let(:method) { :run_on_modifications }

      it_behaves_like "a method calling run_codespell with specific paths"
    end
  end

  context "with codespell not installed" do
    before do
      allow(guard).to receive(:codespell).and_return(false)
    end

    describe "#run_all" do
      let(:method) { :run_all }

      it "returns a warning" do
        guard.run_all
        expect(guard).not_to have_received(:run_codespell)
        expect(Guard::Compat::UI).to have_received(:warning).twice
      end
    end

    describe "#run_on_additions" do
      let(:method) { :run_on_additions }

      it_behaves_like "a method call when codespell is not installed"
    end

    describe "#run_on_modifications" do
      let(:method) { :run_on_modifications }

      it_behaves_like "a method call when codespell is not installed"
    end
  end
end
