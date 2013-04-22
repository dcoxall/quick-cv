# encoding: utf-8
require_relative "../../models/api_connection.rb"

describe APIConnection do
  let!(:options) do
    {
      state: nil,
      token: nil,
      cache_client: nil,
    }
  end
  let(:object) { APIConnection.new(options) }
  subject { object }

  describe "on initialization" do
    describe "sets api state" do
      context "pre set" do
        before { options[:state] = "1234ABC" }
        its(:api_state) { should eql("1234ABC") }
      end
      context "when nil" do
        before { SecureRandom.should_receive(:hex).and_return("secure value") }
        its(:api_state) { should eql("secure value") }
      end
    end

    describe "sets auth token" do
      context "pre set" do
        before { options[:token] = "1234ABC" }
        its(:auth_token) { should eql("1234ABC") }
      end
      context "when nil" do
        its(:auth_token) { should be_nil }
      end
    end

    describe "sets cache client" do
      context "pre set" do
        before { options[:cache_client] = double(:cache) }
        its(:cache_client) { should_not be_nil }
      end
      context "when nil" do
        its(:cache_client) { should be_nil }
      end
    end
  end

  describe ".authorize_url" do
    before { options[:state] = "1234ABC" }
    its(:authorize_url) { should start_with("https://www.linkedin.com") }
    its(:authorize_url) { should include("state=1234ABC", "scope=") }
  end

  describe ".authorized?" do
    context "pre authorized" do
      before { options[:token] = "1234ABC" }
      it { should be_authorized }
    end
    context "not authorized" do
      it { should_not be_authorized }
    end
  end

  describe ".validate" do
    it "sets the auth token"
  end
end
