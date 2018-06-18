require 'spec_helper'

describe 'pptp' do
  on_supported_os.sort.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('pptp') }
    end
  end
end
