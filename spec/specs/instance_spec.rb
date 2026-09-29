require 'spec_helper'
require 'procodile/instance'

describe Procodile::Instance do
  let(:config) { double("config", :root => '/apps/example', :pid_root => '/apps/example/pids') }

  let(:process) do
    double("process",
           :name => 'worker',
           :log_color => 32,
           :command => 'bundle exec worker',
           :restart_mode => 'usr1',
           :environment_variables => {'RAILS_ENV' => 'production'},
           :config => config)
  end

  subject(:instance) { described_class.new(double("supervisor"), process, 1) }

  describe "#unapplied_changes" do
    it "reports nothing when the instance was never spawned by this supervisor" do
      expect(instance.unapplied_changes).to be_empty
    end

    it "reports nothing when neither the environment nor the command has changed" do
      instance.instance_variable_set(:@spawned_environment_variables, instance.environment_variables)
      instance.instance_variable_set(:@spawned_command, process.command)

      expect(instance.unapplied_changes).to be_empty
    end

    it "reports the environment when an environment variable has changed" do
      instance.instance_variable_set(:@spawned_environment_variables,
                                     instance.environment_variables.merge('RAILS_ENV' => 'staging'))
      instance.instance_variable_set(:@spawned_command, process.command)

      expect(instance.unapplied_changes).to eq(['environment'])
    end

    it "reports the environment when a variable has been added since spawn" do
      spawned = instance.environment_variables.dup
      spawned.delete('RAILS_ENV')
      instance.instance_variable_set(:@spawned_environment_variables, spawned)
      instance.instance_variable_set(:@spawned_command, process.command)

      expect(instance.unapplied_changes).to eq(['environment'])
    end

    it "reports the command when the command has changed" do
      instance.instance_variable_set(:@spawned_environment_variables, instance.environment_variables)
      instance.instance_variable_set(:@spawned_command, 'bundle exec old-worker')

      expect(instance.unapplied_changes).to eq(['command'])
    end

    it "reports both when both have changed" do
      instance.instance_variable_set(:@spawned_environment_variables,
                                     instance.environment_variables.merge('RAILS_ENV' => 'staging'))
      instance.instance_variable_set(:@spawned_command, 'bundle exec old-worker')

      expect(instance.unapplied_changes).to eq(['environment', 'command'])
    end
  end
end
