require 'spec_helper'
require 'procodile/status_cli_output'

describe Procodile::StatusCLIOutput do
  def status_with(messages)
    {
      'version' => '1.0.27',
      'root' => '/apps/example',
      'supervisor' => {'pid' => 100, 'started_at' => nil},
      'environment_variables' => {},
      'messages' => messages
    }
  end

  let(:incorrect_quantity) do
    {'type' => 'incorrect_quantity', 'process' => 'worker', 'current' => 23, 'desired' => 25}
  end

  let(:not_running) do
    {'type' => 'not_running', 'instance' => 'worker.1', 'status' => 'Failed'}
  end

  context "when a process is below its configured quantity" do
    subject(:cli) { described_class.new(status_with([incorrect_quantity])) }

    it "still prints the underlying message" do
      expect { cli.print_header }.to output(/worker only has 23 instances \(should have 25\)/).to_stdout
    end

    it "suggests check_concurrency as the remedy" do
      expect { cli.print_header }.to output(/procodile check_concurrency/).to_stdout
    end
  end

  context "when the only messages are unrelated to quantity" do
    subject(:cli) { described_class.new(status_with([not_running])) }

    it "does not suggest check_concurrency" do
      expect { cli.print_header }.to_not output(/check_concurrency/).to_stdout
    end
  end

  context "when there are no messages at all" do
    subject(:cli) { described_class.new(status_with([])) }

    it "does not suggest check_concurrency" do
      expect { cli.print_header }.to_not output(/check_concurrency/).to_stdout
    end
  end

  context "when quantity and other messages are both present" do
    subject(:cli) { described_class.new(status_with([not_running, incorrect_quantity])) }

    it "suggests check_concurrency only once" do
      expect { cli.print_header }.to output(/check_concurrency/).to_stdout
    end
  end
end
