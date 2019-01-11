require 'spec_helper'

describe 'threatstack::apt' do
  GPG_KEY_ID = 'ACCC2B02EA3A2409557B0AB991BB3B3C6EE04BD4'.freeze
  REPO_URL = 'https://pkg.threatstack.com/v2/Ubuntu'
  REPO_TYPE = 'main'

  context 'on Debian 8' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '8.11', 'major' => '8', 'minor' => '11'}, 'distro' => {'codename' => 'jessie'}, 'family' => 'Debian'} } }

    let(:params) { { 'location' => REPO_URL, 'release' => 'jessie', 'repos' => REPO_TYPE, 'key' => GPG_KEY_ID} }
    it {
        is_expected.to contain_apt__setting('list-threatstack').with(ensure: 'present').with_content(%r{# threatstack\ndeb  https://pkg.threatstack.com/v2/Ubuntu jessie main\n})
                                                             .without_content(%r{deb-src})
      }

    it {
        is_expected.to contain_apt__key("Add key: #{GPG_KEY_ID} from Apt::Source threatstack").that_comes_before('Apt::Setting[list-threatstack]').with(ensure: 'present',
        id: GPG_KEY_ID)
      }
  end

  context 'on Debian 9' do
    let(:facts) { {'operatingsystem' => 'Debian', 'osfamily' => 'Debian', 'os' => { 'name' => 'Debian', 'release' => {'full' => '9.1', 'major' => '9', 'minor' => '1'}, 'distro' => {'codename' => 'stretch'}, 'family' => 'Debian'} } }
    let(:params) { { 'location' => REPO_URL, 'release' => 'jessie', 'repos' => REPO_TYPE, 'key' => GPG_KEY_ID} }
    it {
        is_expected.to contain_apt__setting('list-threatstack').with(ensure: 'present').with_content(%r{# threatstack\ndeb https://pkg.threatstack.com/v2/Ubuntu stretch main\n})
                                                             .without_content(%r{deb-src})
      }

    it {
        is_expected.to contain_apt__key("Add key: #{GPG_KEY_ID} from Apt::Source threatstack").that_comes_before('Apt::Setting[list-threatstack]').with(ensure: 'present',
        id: GPG_KEY_ID)
      }
  end

  context 'on Ubuntu 18.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '18.04', 'major' => '18.04'}, 'distro' => {'codename' => 'bionic'}, 'family' => 'Debian'} }}
    let(:params) { { 'location' => REPO_URL, 'release' => 'bionic', 'repos' => REPO_TYPE, 'key' => GPG_KEY_ID} }
    it {
        is_expected.to contain_apt__setting('list-threatstack').with(ensure: 'present').with_content(%r{# threatstack\ndeb https://pkg.threatstack.com/v2/Ubuntu bionic main\n})
                                                             .without_content(%r{deb-src})
      }

    it {
        is_expected.to contain_apt__key("Add key: #{GPG_KEY_ID} from Apt::Source threatstack").that_comes_before('Apt::Setting[list-threatstack]').with(ensure: 'present',
        id: GPG_KEY_ID)
      }
  end

  context 'on Ubuntu 16.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '16.04', 'major' => '16.04'}, 'distro' => {'codename' => 'xenial'}, 'family' => 'Debian'} }}
    let(:params) { { 'location' => REPO_URL, 'release' => 'xenial', 'repos' => REPO_TYPE, 'key' => GPG_KEY_ID} }
    it {
        is_expected.to contain_apt__setting('list-threatstack').with(ensure: 'present').with_content(%r{# threatstack\ndeb https://pkg.threatstack.com/v2/Ubuntu xenial main\n})
                                                             .without_content(%r{deb-src})
      }

    it {
        is_expected.to contain_apt__key("Add key: #{GPG_KEY_ID} from Apt::Source threatstack").that_comes_before('Apt::Setting[list-threatstack]').with(ensure: 'present',
        id: GPG_KEY_ID)
      }
  end

  context 'on Ubuntu 14.04' do
    let(:facts) { {'osfamily' => 'Debian', 'os' => { 'name' => 'Ubuntu', 'release' => {'full' => '14.04', 'major' => '14.04'}, 'distro' => {'codename' => 'trusty'}, 'family' => 'Debian'} }}
    let(:params) { { 'location' => REPO_URL, 'release' => 'trust', 'repos' => REPO_TYPE, 'key' => GPG_KEY_ID} }
    it {
        is_expected.to contain_apt__setting('list-threatstack').with(ensure: 'present').with_content(%r{# threatstack\ndeb https://pkg.threatstack.com/v2/Ubuntu trusty main\n})
                                                             .without_content(%r{deb-src})
      }

    it {
        is_expected.to contain_apt__key("Add key: #{GPG_KEY_ID} from Apt::Source threatstack").that_comes_before('Apt::Setting[list-threatstack]').with(ensure: 'present',
        id: GPG_KEY_ID)
      }
  end

end
