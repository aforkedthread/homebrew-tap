cask "cloudbar" do
  version "2.0,7"
  sha256 "6bd54464686dc006ad14e9a52d20bf6df7caecf36303c7e8a9a3fa4f48e14397"

  url "https://downloads.getcloudbar.app/releases/CloudBar-#{version.csv.first}-#{version.csv.second}.zip"
  name "CloudBar"
  desc "Menu bar switcher for AWS IAM Identity Center accounts and roles"
  homepage "https://getcloudbar.app/"

  livecheck do
    url "https://downloads.getcloudbar.app/latest.txt"
    regex(/^(\d+(?:\.\d+)+,\d+)$/)
  end

  depends_on macos: :sequoia

  app "CloudBar.app"

  uninstall quit: "com.cloudbar.app"

  zap trash: [
    "~/Library/Application Scripts/com.cloudbar.app",
    "~/Library/Application Support/CloudBar",
    "~/Library/Containers/com.cloudbar.app",
  ]
end
