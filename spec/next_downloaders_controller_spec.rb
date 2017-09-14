require 'rails_helper'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:propfind, "https://cloud.indie.host/remote.php/webdav/test.localhost").
      with(body: "<?xml version=\"1.0\" encoding=\"utf-8\"?><DAV:propfind xmlns:DAV=\"DAV:\"><DAV:allprop/></DAV:propfind>",
           headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'text/xml; charset="utf-8"', 'Depth'=>'1', 'User-Agent'=>'Ruby' }).
      to_return(status: 200, body: "", headers: {})
  end
end

describe Admin::AdminController::NextDownloadersController, type: :controller do

  context "while logged in as an admin" do

    # before { @admin = log_in(:admin) }
    before do
      @admin = log_in(:admin)
      SiteSetting.discourse_sync_to_nextcloud_enabled = true
    end

    it "is a subclass of Admin::AdminController" do
      expect(NextDownloadersController < Admin::AdminController).to eq(true)
    end

    describe "GET #index" do
      let(:sample_json) {
        "{\"files\":[
            {
            \"title\":\"discourse-2017-08-11-142637-v20170731030330.sql.gz\",
            \"file_path\":\"https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz\",
            \"size\":8009104,
            \"created_at\":[
              \"\",
              \"2017\",
              \"08\",
              \"11\"]
              }
            ]
        }"
      }

      before {
        next_instance = DiscourseDownloadFromNextcloud::NextDownloader
        next_instance.any_instance.stubs(:json_list).returns(sample_json)
      }

      it "returns a json list of all nextcloud files" do
        xhr :get, :index, format: :json
        expect(response.body).to eq(sample_json)
      end

      it "responds with 200 status" do
        xhr :get, :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

    end

    describe "POST #create" do
      let(:sample_file_path) {
        "https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz"
      }


      before {
        next_instance = DiscourseDownloadFromNextcloud::NextDownloader
        next_instance.any_instance.stubs(:file_path).returns(sample_file_path)
      }

      it "sends a google-file-path to the job" do
        xhr :post, :create
        @file_path = :sample_file_path
        expect(@file_path).to eq(:sample_file_path)
      end

      it "responds with 200 status" do
        xhr :post, :create
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      # it "raises an error when the post parameter is missing" do
      #   xhr :post, :create
      #   @file_path = nil
      #   puts response.body
      #   expect {
      #     xhr :post, :create
      #   }.to raise_error(ActionController::ParameterMissing)
      # end

      it "enqueues email job" do
        xhr :post, :create
        Jobs.expects(:enqueue).with(:send_download_next_link, has_entries(file_path: :sample_file_path))
        expect(response).to be_success
      end

      # it "returns 404 when the backup does not exist" do
      #   xhr :post, :sample_file_path
      #   expect(response).to be_not_found
      # end

    end


  end
end
