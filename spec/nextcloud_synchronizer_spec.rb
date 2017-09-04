require 'rails_helper'

describe ::DiscourseBackupToNextcloud::NextcloudSynchronizer do

  let(:backup) { Backup.new('backup') }

  describe "#backup" do
    it "has a reader method for the backup" do
      ds = described_class.new(backup)
      expect(ds.backup).to eq(backup)
    end
  end

  describe "#can_sync?" do
    it "should return false when disabled via site setting" do
      SiteSetting.discourse_sync_to_nextcloud_enabled = false
      ds = described_class.new(backup)
      expect(ds.can_sync?).to eq(false)
    end

    it "should return true when everything is correct" do
      SiteSetting.discourse_sync_to_nextcloud_enabled = true
      ds = described_class.new(backup)
      expect(ds.can_sync?).to eq(true)
    end
  end

end
