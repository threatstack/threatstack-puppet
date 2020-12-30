Facter.add(:ts_config_args) do
  setcode do
    config_args = [{ 'log.maxSize' => '22' }]

    config_args
  end
end