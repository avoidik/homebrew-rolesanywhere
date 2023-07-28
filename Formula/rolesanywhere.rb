class Rolesanywhere < Formula
  desc "AWS Roles Anywhere credentials helper"
  homepage "https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html"
  url "https://github.com/aws/rolesanywhere-credential-helper.git", tag: "v1.0.5", revision: "a9442b3ab0c36897b5a8eac4074e1fd4926efd64"
  sha256 "7c3dab87e9299d1a7811f756bf7708bfbef5e5a558eee8ef536d6183d682b0ac"
  license "Apache-2.0"
  head "https://github.com/aws/rolesanywhere-credential-helper.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -w -s
      -X github.com/aws/rolesanywhere-credential-helper/cmd.Version=#{version}
      -linkmode=external
    ]
    system "go", "build", "-buildmode=pie", *std_go_args(ldflags: ldflags), "main.go"
    mv bin/"rolesanywhere", bin/"aws_signing_helper"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aws_signing_helper version")
  end
end