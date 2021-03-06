require File.dirname(__FILE__) + '/spec_helper'

begin
  require "moneta/adapters/lmc"
  require "fileutils"

  # Problem: If there are multiple caches around, they start
  # to block (with a system semaphore), which can be unpleasant
  # so just use one cache for the entire test run.
  $lmc_cache = Moneta::Builder.build do
    run Moneta::Adapters::LMC, :filename => "test"
  end

  describe "Moneta::LMC" do
    before(:all) do
      @cache = $lmc_cache
    end
    
    after(:each) do
      @cache.clear
    end
    
    it_should_behave_like "a read/write Moneta cache"
  end
rescue SystemExit
end