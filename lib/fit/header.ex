defmodule Fit.Header do
  def parse(<<
              filesize,
              protocol,
              profile_version   ::little-16,
              num_record_bytes  ::little-32,
              ".FIT",
              crc               ::little-16,
              rest             ::binary >>) do
    {%{
      filesize: filesize,
      protocol: protocol,
      profile_version: profile_version,
      num_record_bytes: num_record_bytes,
      crc: crc}, rest}
  end
end
