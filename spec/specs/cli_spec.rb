require 'spec_helper'
require 'procodile/cli'

describe Procodile::CLI do
  subject(:cli) { described_class.new }

  let(:worker_below) do
    {'type' => 'incorrect_quantity', 'process' => 'worker', 'current' => 23, 'desired' => 25}
  end

  let(:web_below) do
    {'type' => 'incorrect_quantity', 'process' => 'web', 'current' => 1, 'desired' => 2}
  end

  let(:not_running) do
    {'type' => 'not_running', 'instance' => 'worker.1', 'status' => 'Failed'}
  end

  describe "#processes_below_quantity" do
    it "returns every under-quantity process when nothing specific was requested" do
      result = cli.send(:processes_below_quantity, [worker_below, web_below], nil)
      expect(result).to eq(['worker', 'web'])
    end

    it "ignores messages that are not about quantity" do
      result = cli.send(:processes_below_quantity, [not_running], nil)
      expect(result).to be_empty
    end

    it "narrows to the processes the user asked to start" do
      result = cli.send(:processes_below_quantity, [worker_below, web_below], ['web'])
      expect(result).to eq(['web'])
    end

    it "matches a requested instance name against its process type" do
      result = cli.send(:processes_below_quantity, [worker_below], ['worker.1'])
      expect(result).to eq(['worker'])
    end

    it "returns nothing when the requested process is at its quantity" do
      result = cli.send(:processes_below_quantity, [worker_below], ['web'])
      expect(result).to be_empty
    end

    it "returns nothing when there are no messages" do
      expect(cli.send(:processes_below_quantity, [], nil)).to be_empty
    end
  end
end
