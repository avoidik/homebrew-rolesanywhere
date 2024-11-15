class Rolesanywhere < Formula
  desc "AWS Roles Anywhere credentials helper"
  homepage "https://docs.aws.amazon.com/rolesanywhere/latest/userguide/credential-helper.html"
  url "https://github.com/aws/rolesanywhere-credential-helper.git", tag: "v1.2.1", revision: "92d00d48aec4e08bc7002a1abeff67d66c2db293"
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
