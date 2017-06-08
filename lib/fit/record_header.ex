defmodule Fit.RecordHeader do
  def parse(<< byte::8, rest::binary >>) do
    case <<byte>> do
      << 0                      ::1,
         message_type           ::1,
         message_type_specific  ::1,
         _reserved              ::1,
         local_message_type     ::4 >> ->
           {%{header_type: (if message_type == 1, do: :definition, else: :data),
             message_type_specific: message_type_specific,
             local_message_type: local_message_type},rest}
       << 1                      ::1,
          local_message_type     ::2,
          time_offset            ::5 >> ->
            {%{header_type: :timestamp,
              local_message_type: local_message_type,
              time_offset: time_offset},rest}
    end
  end
end
