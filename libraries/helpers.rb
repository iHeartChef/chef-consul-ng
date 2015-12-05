def package_arch
  node['kernel']['machine'] == 'x86_64' ? 'amd64' : '386'
end

def notify_service_restart?
  if node['consul']['notify_restart'] && !node['consul']['disable_service']
    true
  else
    false
  end
end

def consul_sha256sum(version)
  sha256sums = {
    '386' => {
      '0.5.2' => '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60'
    },
    'amd64' => {
      '0.5.2' => '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445'
    }
  }
  sha256sum = sha256sums[package_arch][version]
  fail "sha256sum is missing for consul package version #{version}" unless sha256sum
  sha256sum
end

def webui_sha256sum(version)
  sha256sums = {
    '0.5.2' => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1'
  }
  sha256sum = sha256sums[version]
  fail "sha256sum is missing for consul web ui package version #{version}" unless sha256sum
  sha256sum
end
