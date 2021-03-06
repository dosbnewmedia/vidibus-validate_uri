# encoding: utf-8
require 'spec_helper'

class Test
  include Vidibus::ValidateUri::Core
end

describe 'Vidibus::ValidateUri::Core' do
  let(:test) {Test.new}

  describe '#valid_uri?' do
    it 'should validate http://mydomain.local' do
      uri = 'http://mydomain.local'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/' do
      uri = 'http://mydomain.local/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.com' do
      uri = 'http://mydomain.com'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://www.mydomain.com' do
      uri = 'http://www.mydomain.com'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://www.mydomain.a-b.de' do
      uri = 'http://www.mydomain.a-b.de'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://www.my-do-main.a-b.de' do
      uri = 'http://www.my-do-main.a-b.de'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should fail for http://www.my-do-main.-ab.de' do
      uri = 'http://www.my-do-main.-ab.de'
      test.valid_uri?(uri).should eq(false)
    end

    it 'should validate http://mydomain.com:8080' do
      uri = 'http://mydomain.com:8080'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/' do
      uri = 'http://mydomain.local/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://localhost' do
      uri = 'http://localhost'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://localhost/' do
      uri = 'http://localhost/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should fail for http://localhosts' do
      uri = 'http://localhosts'
      test.valid_uri?(uri).should eq(false)
    end

    it 'should validate http://localhost:3000' do
      uri = 'http://localhost:3000'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://localhost:3000/' do
      uri = 'http://localhost:3000/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://84.191.143.127' do
      uri = 'http://84.191.199.127'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://84.191.143.127/' do
      uri = 'http://84.191.199.127/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://84.191.143.127:80' do
      uri = 'http://84.191.199.127:80'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should fail for http://84.2a.143.127' do
      uri = 'http://84.2a.143.127'
      test.valid_uri?(uri).should eq(false)
    end

    it 'should validate https://some.weird.sub.1.mydomain.com:10000' do
      uri = 'https://some.weird.sub.1.mydomain.com:10000'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local?some=params' do
      uri = 'http://mydomain.local?some=params'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/?some=params' do
      uri = 'http://mydomain.local/?some=params'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/hello/world' do
      uri = 'http://mydomain.local/hello/world'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should fail for http://mydomain.local/hel lo/world' do
      uri = 'http://mydomain.local/hel lo/world'
      test.valid_uri?(uri).should eq(false)
    end

    it 'should validate http://mydomain.local/hello/world/' do
      uri = 'http://mydomain.local/hello/world/'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/hello/world.html' do
      uri = 'http://mydomain.local/hello/world.html'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/hello/world.html#doit' do
      uri = 'http://mydomain.local/hello/world.html#doit'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/hello/world?some=params' do
      uri = 'http://mydomain.local/hello/world?some=params'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/hello/world/?some=params' do
      uri = 'http://mydomain.local/hello/world/?some=params'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local?some=params&another=one' do
      uri = 'http://mydomain.local?some=params&another=one'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local?some=params&another=one#withFragment' do
      uri = 'http://mydomain.local?some=params&another=one#withFragment'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate https://mydomain.local' do
      uri = 'https://mydomain.local'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate https://mydomain.local with protocol => :https' do
      uri = 'https://mydomain.local'
      test.valid_uri?(uri, :protocol => :https).should eq(true)
    end

    it 'should validate https://mydomain.local with protocol => [:http, :https]' do
      uri = 'https://mydomain.local'
      test.valid_uri?(uri, :protocol => [:http, :https]).should eq(true)
    end

    it 'should fail for https://mydomain.local with protocol => :http' do
      uri = 'https://mydomain.local'
      test.valid_uri?(uri, :protocol => :http).should eq(false)
    end

    it 'should fail for https://mydomain.local with protocol => [:http, :rtmp]' do
      uri = 'https://mydomain.local'
      test.valid_uri?(uri, :protocol => [:http, :rtmp]).should eq(false)
    end

    it 'should validate rtmp://mydomain.local/video/13os/pi1x/1391/sxj9/go.flv?10|12|33 with protocol => [:rtmp, :rtsp]' do
      uri = 'rtmp://mydomain.local/video/13os/pi1x/1391/sxj9/go.flv?10|12|33'
      test.valid_uri?(uri, :protocol => [:rtmp, :rtsp]).should eq(true)
    end

    it 'should validate http://www.ali.baba.döner.de' do
      uri = 'http://www.ali.baba.döner.de'
      test.valid_uri?(uri).should eq(true)
    end

    it 'should validate http://mydomain.local/WhatsUp' do
      uri = 'http://mydomain.local/WhatsUp'
      test.valid_uri?(uri).should eq(true)
    end
  end

  describe '#accessible_uri?' do
    it 'should validate http://www.vidibus.org which redirects permanently' do
      uri = 'http://www.vidibus.org'
      stub_request(:head, uri).to_return(:status => 301)
      test.accessible_uri?(uri).should eq(true)
    end

    it 'should validate https://encrypted.google.com' do
      uri = 'https://encrypted.google.com'
      stub_request(:head, uri).to_return(:status => 200)
      test.accessible_uri?(uri).should eq(true)
    end

    it 'should fail for http://www.vidibus.zzz which causes an SocketError' do
      mock(Rails).logger.any_number_of_times {true}
      mock(Rails.logger).error.with_any_args
      uri = 'http://www.vidibus.zzz'
      stub.any_instance_of(Net::HTTP).head {raise SocketError}
      test.accessible_uri?(uri).should eq(false)
    end

    it 'should fail for http://vidibus.org/invalid which does not exist' do
      uri = 'http://vidibus.org/invalid'
      stub_request(:head, uri).to_return(:status => 404)
      test.accessible_uri?(uri).should eq(false)
    end

    it 'should log HTTP errors with Rails.logger, if available' do
      uri = 'http://www.vidibus.zzz'
      stub.any_instance_of(Net::HTTP).head {raise SocketError}
      mock(Rails).logger.any_number_of_times {true}
      mock(Rails.logger).error.with_any_args
      test.accessible_uri?(uri)
    end

    it 'should not perform accessibility check of syntactically invalid URIs' do
      uri = 'http://invalid'
      dont_allow(URI).parse
      test.accessible_uri?(uri).should eq(false)
    end
  end
end
