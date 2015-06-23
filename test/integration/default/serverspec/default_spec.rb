require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "Pypiserver Daemon" do

  it "is listening on port 8080" do
    expect(port(8080)).to be_listening
  end

  it "has a running service of pypiserver" do
    expect(service("pypiserver")).to be_running
  end

end

describe "Nginx Daemon" do

  it "is listening on port 80" do
    expect(port(80)).to be_listening
  end

  it "is listening on port 443" do
    expect(port(443)).to be_listening
  end

  it "has a running service of Nginx" do
    expect(service("nginx")).to be_running
  end

end

describe file('/opt/pypi-server/packages') do
  it { should be_directory }
end

describe command('pip list | grep -i django') do
  its(:stdout) { should match /Django/ }
end
