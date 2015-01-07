describe 'box' do
  describe 'windows box' do
    it 'should have a vagrant user' do
      expect(user 'vagrant').to exist
    end
  end

  # this tests if rsync (or at least the shared folder) works from bin/test-box-vcloud.bat
  describe file('c:/vagrant/testdir/testfile.txt') do
    its(:content) { should match /Works/ }
  end

  # check SSH
  describe service('OpenSSH Server') do
    it { should be_installed  }
    it { should be_enabled  }
    it { should be_running  }
    it { should have_start_mode("Automatic")  }
  end
  describe port(22) do
    it { should be_listening  }
  end

  describe service('VMware Tools') do
    it { should be_installed  }
    it { should be_enabled  }
    it { should be_running  }
    it { should have_start_mode("Automatic")  }
  end

  # check WinRM
  describe port(5985) do
    it { should be_listening  }
  end

  # check RDP
  describe port(3389) do
    it { should be_listening  }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server') do
    it { should have_property_value('fDenyTSConnections', :type_dword, '0') }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp') do
    it { should have_property_value('UserAuthentication', :type_dword, '0') }
  end

  # no Windows Updates, just manual updates, but Windows updates service is running
  describe service('Windows Update') do
    it { should be_installed  }
    it { should be_running  }
  end
  describe windows_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update') do
    it { should have_property_value('AUOptions', :type_dword, '1') }
  end

  # check time zone
  describe command('& tzutil /g') do
      its(:stdout) { should match /W. Europe Standard Time/ }
  end

end
