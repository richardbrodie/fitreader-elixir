defmodule TestMethods do
  @map %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:position_lat, :coordinates, 0, 0},
    1 => {:position_long, :coordinates, 0, 0},
    2 => {:altitude, :uint16, 5, 500},
    3 => {:heart_rate, :uint8, 0, 0},
    4 => {:cadence, :uint8, 0, 0},
    5 => {:distance, :uint32, 100, 0},
    6 => {:speed, :uint16, 1000, 0},
    7 => {:power, :uint16, 0, 0},
    8 => {:compressed_speed_distance, :byte, 100, 0},
    9 => {:grade, :sint16, 100, 0},
    10 => {:resistance, :uint8, 0, 0},
    11 => {:time_from_course, :sint32, 1000, 0},
    12 => {:cycle_length, :uint8, 100, 0},
    13 => {:temperature, :sint8, 0, 0},
    17 => {:speed_1s, :uint8, 16, 0},
    18 => {:cycles, :uint8, 0, 0},
    19 => {:total_cycles, :uint32, 0, 0},
    28 => {:compressed_accumulated_power, :uint16, 0, 0},
    29 => {:accumulated_power, :uint32, 0, 0},
    30 => {:left_right_balance, :left_right_balance, 0, 0},
    31 => {:gps_accuracy, :uint8, 0, 0},
    32 => {:vertical_speed, :sint16, 1000, 0},
    33 => {:calories, :uint16, 0, 0},
    39 => {:vertical_oscillation, :uint16, 10, 0},
    40 => {:stance_time_percent, :uint16, 100, 0},
    41 => {:stance_time, :uint16, 10, 0},
    42 => {:activity_type, :activity_type, 0, 0},
    43 => {:left_torque_effectiveness, :uint8, 2, 0},
    44 => {:right_torque_effectiveness, :uint8, 2, 0},
    45 => {:left_pedal_smoothness, :uint8, 2, 0},
    46 => {:right_pedal_smoothness, :uint8, 2, 0},
    47 => {:combined_pedal_smoothness, :uint8, 2, 0},
    48 => {:time128, :uint8, 128, 0},
    49 => {:stroke_type, :stroke_type, 0, 0},
    50 => {:zone, :uint8, 0, 0},
    51 => {:ball_speed, :uint16, 100, 0},
    52 => {:cadence256, :uint16, 256, 0},
    53 => {:fractional_cadence, :uint8, 128, 0},
    54 => {:total_hemoglobin_conc, :uint16, 100, 0},
    55 => {:total_hemoglobin_conc_min, :uint16, 100, 0},
    56 => {:total_hemoglobin_conc_max, :uint16, 100, 0},
    57 => {:saturated_hemoglobin_percent, :uint16, 10, 0},
    58 => {:saturated_hemoglobin_percent_min, :uint16, 10, 0},
    59 => {:saturated_hemoglobin_percent_max, :uint16, 10, 0},
    62 => {:device_index, :device_index, 0, 0},
    67 => {:left_pco, :sint8, 0, 0},
    68 => {:right_pco, :sint8, 0, 0},
    69 => {:left_power_phase, :uint8, 0.7111111, 0},
    70 => {:left_power_phase_peak, :uint8, 0.7111111, 0},
    71 => {:right_power_phase, :uint8, 0.7111111, 0},
    72 => {:right_power_phase_peak, :uint8, 0.7111111, 0},
    73 => {:enhanced_speed, :uint32, 1000, 0},
    78 => {:enhanced_altitude, :uint32, 5, 500},
    81 => {:battery_soc, :uint8, 2, 0},
    82 => {:motor_power, :uint16, 0, 0}
  }
  def validate_fields([], _invalid, valid_fields), do: valid_fields
  def validate_fields([head|tail], invalid, valid_fields) do
    case head do
      ^invalid -> validate_fields(tail, invalid, valid_fields)
      _ -> validate_fields(tail, invalid, [head|valid_fields])
    end
  end

  def get_map, do: @map
  def get_map(i), do: @map[i]
end

m = %{
  253 => {:timestamp, :date_time, 0, 0},
  0 => {:position_lat, :coordinates, 0, 0},
  1 => {:position_long, :coordinates, 0, 0},
  2 => {:altitude, :uint16, 5, 500},
  3 => {:heart_rate, :uint8, 0, 0},
  4 => {:cadence, :uint8, 0, 0},
  5 => {:distance, :uint32, 100, 0},
  6 => {:speed, :uint16, 1000, 0},
  7 => {:power, :uint16, 0, 0},
  8 => {:compressed_speed_distance, :byte, 100, 0},
  9 => {:grade, :sint16, 100, 0},
  10 => {:resistance, :uint8, 0, 0},
  11 => {:time_from_course, :sint32, 1000, 0},
  12 => {:cycle_length, :uint8, 100, 0},
  13 => {:temperature, :sint8, 0, 0},
  17 => {:speed_1s, :uint8, 16, 0},
  18 => {:cycles, :uint8, 0, 0},
  19 => {:total_cycles, :uint32, 0, 0},
  28 => {:compressed_accumulated_power, :uint16, 0, 0},
  29 => {:accumulated_power, :uint32, 0, 0},
  30 => {:left_right_balance, :left_right_balance, 0, 0},
  31 => {:gps_accuracy, :uint8, 0, 0},
  32 => {:vertical_speed, :sint16, 1000, 0},
  33 => {:calories, :uint16, 0, 0},
  39 => {:vertical_oscillation, :uint16, 10, 0},
  40 => {:stance_time_percent, :uint16, 100, 0},
  41 => {:stance_time, :uint16, 10, 0},
  42 => {:activity_type, :activity_type, 0, 0},
  43 => {:left_torque_effectiveness, :uint8, 2, 0},
  44 => {:right_torque_effectiveness, :uint8, 2, 0},
  45 => {:left_pedal_smoothness, :uint8, 2, 0},
  46 => {:right_pedal_smoothness, :uint8, 2, 0},
  47 => {:combined_pedal_smoothness, :uint8, 2, 0},
  48 => {:time128, :uint8, 128, 0},
  49 => {:stroke_type, :stroke_type, 0, 0},
  50 => {:zone, :uint8, 0, 0},
  51 => {:ball_speed, :uint16, 100, 0},
  52 => {:cadence256, :uint16, 256, 0},
  53 => {:fractional_cadence, :uint8, 128, 0},
  54 => {:total_hemoglobin_conc, :uint16, 100, 0},
  55 => {:total_hemoglobin_conc_min, :uint16, 100, 0},
  56 => {:total_hemoglobin_conc_max, :uint16, 100, 0},
  57 => {:saturated_hemoglobin_percent, :uint16, 10, 0},
  58 => {:saturated_hemoglobin_percent_min, :uint16, 10, 0},
  59 => {:saturated_hemoglobin_percent_max, :uint16, 10, 0},
  62 => {:device_index, :device_index, 0, 0},
  67 => {:left_pco, :sint8, 0, 0},
  68 => {:right_pco, :sint8, 0, 0},
  69 => {:left_power_phase, :uint8, 0.7111111, 0},
  70 => {:left_power_phase_peak, :uint8, 0.7111111, 0},
  71 => {:right_power_phase, :uint8, 0.7111111, 0},
  72 => {:right_power_phase_peak, :uint8, 0.7111111, 0},
  73 => {:enhanced_speed, :uint32, 1000, 0},
  78 => {:enhanced_altitude, :uint32, 5, 500},
  81 => {:battery_soc, :uint8, 2, 0},
  82 => {:motor_power, :uint16, 0, 0}
}

l = [10,11,12,13,17,18,19,28,29,30,31,32,33,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57]
# path = "test/files/working_wahoo_dev_fields.fit"
path = "test/files/working/2017-04-29.fit"
# path = "test/files/not_working/2017-07-30-085002-ELEMNT BOLT FE0B-12-0.fit"
# path = "test/files/working/2016-08-27-12-24-19.fit"

Benchee.run(
  %{
    "single_run"    => fn -> Fit.read(path) end,
  }, time: 10
)

# Benchee.run(%{
#     "func call" => fn ->
#       for _ <- 0..1000 do
#         Enum.each(l, fn x -> TestMethods.get_map(x) end)
#       end
#     end,
#     "local call"  => fn ->
#       for _ <- 0..1000 do
#         m = TestMethods.get_map
#         Enum.each(l, fn x -> m[x] end)
#       end
#     end
# }, time: 20)
