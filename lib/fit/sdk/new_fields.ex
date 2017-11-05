defmodule Fit.Sdk.NewFields do
  @_msg_0 %{
    0 => {:filetype, {:enum, :enum_file}, 0, 0},
    1 => {:manufacturer, {:enum, :enum_manufacturer}, 0, 0},
    2 => {:garmin_product, :raw, 0, 0},
    3 => {:serial_number, :raw, 0, 0},
    4 => {:time_created, :date_time, 0, 0},
    5 => {:number, :raw, 0, 0},
    8 => {:product_name, :raw, 0, 0}
  }
  def get(0, key), do: get_0(key)
  def get_0(0), do: {:filetype, {:enum, :enum_file}, 0, 0}

  @_msg_3 %{
    254 => {:message_index, :message_index, 0, 0},
    0 => {:friendly_name, :string, 0, 0},
    1 => {:gender, {:enum, :enum_gender}, 0, 0},
    2 => {:age, :raw, 0, 0},
    3 => {:height, :uint8, 100, 0},
    4 => {:weight, :uint16, 10, 0},
    5 => {:language, {:enum, :enum_language}, 0, 0},
    6 => {:elev_setting, {:enum, :enum_display_measure}, 0, 0},
    7 => {:weight_setting, {:enum, :enum_display_measure}, 0, 0},
    8 => {:resting_heart_rate, :uint8, 0, 0},
    9 => {:default_max_running_heart_rate, :uint8, 0, 0},
    10 => {:default_max_biking_heart_rate, :uint8, 0, 0},
    11 => {:default_max_heart_rate, :uint8, 0, 0},
    12 => {:hr_setting, {:enum, :enum_display_heart}, 0, 0},
    13 => {:speed_setting, {:enum, :enum_display_measure}, 0, 0},
    14 => {:dist_setting, {:enum, :enum_display_measure}, 0, 0},
    16 => {:power_setting, {:enum, :enum_display_power}, 0, 0},
    17 => {:activity_class, {:enum, :enum_activity_class}, 0, 0},
    18 => {:position_setting, {:enum, :enum_display_position}, 0, 0},
    21 => {:temperature_setting, {:enum, :enum_display_measure}, 0, 0},
    22 => {:local_id, :user_local_id, 0, 0},
    23 => {:global_id, :byte, 0, 0},
    30 => {:height_setting, {:enum, :enum_display_measure}, 0, 0}
  }
  def get(3), do: @_msg_3
  def get(3, key) do
    @_msg_3[key]
  end

  @_msg_6 %{
    254 => {:message_index, :message_index, 0, 0},
    0 => {:name, :string, 0, 0},
    1 => {:sport, {:enum, :enum_sport}, 0, 0},
    2 => {:sub_sport, {:enum, :enum_sub_sport}, 0, 0},
    3 => {:odometer, :uint32, 100, 0},
    4 => {:bike_spd_ant_id, :uint16z, 0, 0},
    5 => {:bike_cad_ant_id, :uint16z, 0, 0},
    6 => {:bike_spdcad_ant_id, :uint16z, 0, 0},
    7 => {:bike_power_ant_id, :uint16z, 0, 0},
    8 => {:custom_wheelsize, :uint16, 1000, 0},
    9 => {:auto_wheelsize, :uint16, 1000, 0},
    10 => {:bike_weight, :uint16, 10, 0},
    11 => {:power_cal_factor, :uint16, 10, 0},
    12 => {:auto_wheel_cal, :bool, 0, 0},
    13 => {:auto_power_zero, :bool, 0, 0},
    14 => {:id, :uint8, 0, 0},
    15 => {:spd_enabled, :bool, 0, 0},
    16 => {:cad_enabled, :bool, 0, 0},
    17 => {:spdcad_enabled, :bool, 0, 0},
    18 => {:power_enabled, :bool, 0, 0},
    19 => {:crank_length, :uint8, 2, 0},
    20 => {:enabled, :bool, 0, 0},
    21 => {:bike_spd_ant_id_trans_type, :uint8z, 0, 0},
    22 => {:bike_cad_ant_id_trans_type, :uint8z, 0, 0},
    23 => {:bike_spdcad_ant_id_trans_type, :uint8z, 0, 0},
    24 => {:bike_power_ant_id_trans_type, :uint8z, 0, 0}
  }
  def get(6), do: @_msg_6
  def get(6, key) do
    @_msg_6[key]
  end

  @_msg_7 %{
    1 => {:max_heart_rate, :uint8, 0, 0},
    2 => {:threshold_heart_rate, :uint8, 0, 0},
    3 => {:functional_threshold_power, :uint16, 0, 0},
    5 => {:hr_calc_type, :hr_zone_calc, 0, 0},
    7 => {:pwr_calc_type, :pwr_zone_calc, 0, 0}
  }
  def get(7), do: @_msg_7
  def get(7, key) do
    @_msg_7[key]
  end

  @_msg_18 %{
    254 => {:message_index, :message_index, 0, 0},
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:event, {:enum, :enum_event}, 0, 0},
    1 => {:event_type, {:enum, :enum_event_type}, 0, 0},
    2 => {:start_time, :date_time, 0, 0},
    3 => {:start_position_lat, :coordinates, 0, 0},
    4 => {:start_position_long, :coordinates, 0, 0},
    5 => {:sport, {:enum, :enum_sport}, 0, 0},
    6 => {:sub_sport, {:enum, :enum_sub_sport}, 0, 0},
    7 => {:total_elapsed_time, :uint32, 1000, 0},
    8 => {:total_timer_time, :uint32, 1000, 0},
    9 => {:total_distance, :uint32, 100, 0},
    10 => {:total_cycles, :uint32, 0, 0},
    11 => {:total_calories, :uint16, 0, 0},
    13 => {:total_fat_calories, :uint16, 0, 0},
    14 => {:avg_speed, :uint16, 1000, 0},
    15 => {:max_speed, :uint16, 1000, 0},
    16 => {:avg_heart_rate, :uint8, 0, 0},
    17 => {:max_heart_rate, :uint8, 0, 0},
    18 => {:avg_cadence, :uint8, 0, 0},
    19 => {:max_cadence, :uint8, 0, 0},
    20 => {:avg_power, :uint16, 0, 0},
    21 => {:max_power, :uint16, 0, 0},
    22 => {:total_ascent, :uint16, 0, 0},
    23 => {:total_descent, :uint16, 0, 0},
    24 => {:total_training_effect, :uint8, 10, 0},
    25 => {:first_lap_index, :uint16, 0, 0},
    26 => {:num_laps, :uint16, 0, 0},
    27 => {:event_group, :uint8, 0, 0},
    28 => {:trigger, {:enum, :enum_session_trigger}, 0, 0},
    29 => {:nec_lat, :coordinates, 0, 0},
    30 => {:nec_long, :coordinates, 0, 0},
    31 => {:swc_lat, :coordinates, 0, 0},
    32 => {:swc_long, :coordinates, 0, 0},
    34 => {:normalized_power, :uint16, 0, 0},
    35 => {:training_stress_score, :uint16, 10, 0},
    36 => {:intensity_factor, :uint16, 1000, 0},
    37 => {:left_right_balance, :left_right_balance_100, 0, 0},
    41 => {:avg_stroke_count, :uint32, 10, 0},
    42 => {:avg_stroke_distance, :uint16, 100, 0},
    44 => {:pool_length, :uint16, 100, 0},
    45 => {:threshold_power, :uint16, 0, 0},
    46 => {:pool_length_unit, {:enum, :enum_display_measure}, 0, 0},
    47 => {:num_active_lengths, :uint16, 0, 0},
    48 => {:total_work, :uint32, 0, 0},
    49 => {:avg_altitude, :uint16, 5, 0},
    50 => {:max_altitude, :uint16, 5, 0},
    51 => {:gps_accuracy, :uint8, 0, 0},
    52 => {:avg_grade, :sint16, 100, 0},
    53 => {:avg_pos_grade, :sint16, 100, 0},
    54 => {:avg_neg_grade, :sint16, 100, 0},
    55 => {:max_pos_grade, :sint16, 100, 0},
    56 => {:max_neg_grade, :sint16, 100, 0},
    57 => {:avg_temperature, :sint8, 0, 0},
    58 => {:max_temperature, :sint8, 0, 0},
    59 => {:total_moving_time, :uint32, 1000, 0},
    60 => {:avg_pos_vertical_speed, :sint16, 1000, 0},
    61 => {:avg_neg_vertical_speed, :sint16, 1000, 0},
    62 => {:max_pos_vertical_speed, :sint16, 1000, 0},
    63 => {:max_neg_vertical_speed, :sint16, 1000, 0},
    64 => {:min_heart_rate, :uint8, 0, 0},
    65 => {:time_in_hr_zone, :uint32, 1000, 0},
    66 => {:time_in_speed_zone, :uint32, 1000, 0},
    67 => {:time_in_cadence_zone, :uint32, 1000, 0},
    68 => {:time_in_power_zone, :uint32, 1000, 0},
    69 => {:avg_lap_time, :uint32, 1000, 0},
    70 => {:best_lap_index, :uint16, 0, 0},
    71 => {:min_altitude, :uint16, 5, 500},
    82 => {:player_score, :uint16, 0, 0},
    83 => {:opponent_score, :uint16, 0, 0},
    84 => {:opponent_name, :string, 0, 0},
    85 => {:stroke_count, :uint16, 0, 0},
    86 => {:zone_count, :uint16, 0, 0},
    87 => {:max_ball_speed, :uint16, 100, 0},
    88 => {:avg_ball_speed, :uint16, 100, 0},
    89 => {:avg_vertical_oscillation, :uint16, 10, 0},
    90 => {:avg_stance_time_percent, :uint16, 100, 0},
    91 => {:avg_stance_time, :uint16, 10, 0},
    92 => {:avg_fractional_cadence, :uint8, 128, 0},
    93 => {:max_fractional_cadence, :uint8, 128, 0},
    94 => {:total_fractional_cycles, :uint8, 128, 0},
    95 => {:avg_total_hemoglobin_conc, :uint16, 100, 0},
    96 => {:min_total_hemoglobin_conc, :uint16, 100, 0},
    97 => {:max_total_hemoglobin_conc, :uint16, 100, 0},
    98 => {:avg_saturated_hemoglobin_percent, :uint16, 10, 0},
    99 => {:min_saturated_hemoglobin_percent, :uint16, 10, 0},
    100 => {:max_saturated_hemoglobin_percent, :uint16, 10, 0},
    101 => {:avg_left_torque_effectiveness, :uint8, 2, 0},
    102 => {:avg_right_torque_effectiveness, :uint8, 2, 0},
    103 => {:avg_left_pedal_smoothness, :uint8, 2, 0},
    104 => {:avg_right_pedal_smoothness, :uint8, 2, 0},
    105 => {:avg_combined_pedal_smoothness, :uint8, 2, 0},
    107 => {:num_front_gear_changes, :uint16, 0, 0},
    108 => {:num_rear_gear_changes, :uint16, 0, 0},
    111 => {:sport_index, :uint8, 0, 0},
    112 => {:time_standing, :uint32, 1000, 0},
    113 => {:stand_count, :uint16, 0, 0},
    114 => {:avg_left_pco, :sint8, 0, 0},
    115 => {:avg_right_pco, :sint8, 0, 0},
    116 => {:avg_left_power_phase, :uint8, 0.7111111, 0},
    117 => {:avg_left_power_phase_peak, :uint8, 0.7111111, 0},
    118 => {:avg_right_power_phase, :uint8, 0.7111111, 0},
    119 => {:avg_right_power_phase_peak, :uint8, 0.7111111, 0},
    120 => {:avg_power_position, :uint16, 0, 0},
    121 => {:max_power_position, :uint16, 0, 0},
    122 => {:avg_cadence_position, :uint8, 0, 0},
    123 => {:max_cadence_position, :uint8, 0, 0},
    124 => {:enhanced_avg_speed, :uint32, 1000, 0},
    125 => {:enhanced_max_speed, :uint32, 1000, 0},
    126 => {:enhanced_avg_altitude, :uint32, 5, 500},
    127 => {:enhanced_min_altitude, :uint32, 5, 500},
    128 => {:enhanced_max_altitude, :uint32, 5, 500},
    129 => {:avg_lev_motor_power, :uint16, 0, 0},
    130 => {:max_lev_motor_power, :uint16, 0, 0},
    131 => {:lev_battery_consumption, :uint8, 2, 0}
  }
  def get(18), do: @_msg_18
  def get(18, key) do
    @_msg_18[key]
  end

  @_msg_19 %{
    254 => {:message_index, :message_index, 0, 0},
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:event, {:enum, :enum_event}, 0, 0},
    1 => {:event_type, {:enum, :enum_event_type}, 0, 0},
    2 => {:start_time, :date_time, 0, 0},
    3 => {:start_position_lat, :coordinates, 0, 0},
    4 => {:start_position_long, :coordinates, 0, 0},
    5 => {:end_position_lat, :coordinates, 0, 0},
    6 => {:end_position_long, :coordinates, 0, 0},
    7 => {:total_elapsed_time, :uint32, 1000, 0},
    8 => {:total_timer_time, :uint32, 1000, 0},
    9 => {:total_distance, :uint32, 100, 0},
    10 => {:total_cycles, :uint32, 0, 0},
    11 => {:total_calories, :uint16, 0, 0},
    12 => {:total_fat_calories, :uint16, 0, 0},
    13 => {:avg_speed, :uint16, 1000, 0},
    14 => {:max_speed, :uint16, 1000, 0},
    15 => {:avg_heart_rate, :uint8, 0, 0},
    16 => {:max_heart_rate, :uint8, 0, 0},
    17 => {:avg_cadence, :uint8, 0, 0},
    18 => {:max_cadence, :uint8, 0, 0},
    19 => {:avg_power, :uint16, 0, 0},
    20 => {:max_power, :uint16, 0, 0},
    21 => {:total_ascent, :uint16, 0, 0},
    22 => {:total_descent, :uint16, 0, 0},
    23 => {:intensity, {:enum, :enum_intensity}, 0, 0},
    24 => {:lap_trigger, {:enum, :enum_lap_trigger}, 0, 0},
    25 => {:sport, {:enum, :enum_sport}, 0, 0},
    26 => {:event_group, :uint8, 0, 0},
    27 => {:nec_lat, :coordinates, 0, 0},
    28 => {:nec_long, :coordinates, 0, 0},
    29 => {:swc_lat, :coordinates, 0, 0},
    30 => {:swc_long, :coordinates, 0, 0},
    32 => {:num_lengths, :uint16, 0, 0},
    33 => {:normalized_power, :uint16, 0, 0},
    34 => {:left_right_balance, :left_right_balance_100, 0, 0},
    35 => {:first_length_index, :uint16, 0, 0},
    37 => {:avg_stroke_distance, :uint16, 100, 0},
    38 => {:swim_stroke, {:enum, :enum_swim_stroke}, 0, 0},
    39 => {:sub_sport, {:enum, :enum_sub_sport}, 0, 0},
    40 => {:num_active_lengths, :uint16, 0, 0},
    41 => {:total_work, :uint32, 0, 0},
    42 => {:avg_altitude, :uint16, 5, 500},
    43 => {:max_altitude, :uint16, 5, 500},
    44 => {:gps_accuracy, :uint8, 0, 0},
    45 => {:avg_grade, :sint16, 100, 0},
    46 => {:avg_pos_grade, :sint16, 100, 0},
    47 => {:avg_neg_grade, :sint16, 100, 0},
    48 => {:max_pos_grade, :sint16, 100, 0},
    49 => {:max_neg_grade, :sint16, 100, 0},
    50 => {:avg_temperature, :sint8, 0, 0},
    51 => {:max_temperature, :sint8, 0, 0},
    52 => {:total_moving_time, :uint32, 1000, 0},
    53 => {:avg_pos_vertical_speed, :sint16, 1000, 0},
    54 => {:avg_neg_vertical_speed, :sint16, 1000, 0},
    55 => {:max_pos_vertical_speed, :sint16, 1000, 0},
    56 => {:max_neg_vertical_speed, :sint16, 1000, 0},
    57 => {:time_in_hr_zone, :uint32, 1000, 0},
    58 => {:time_in_speed_zone, :uint32, 1000, 0},
    59 => {:time_in_cadence_zone, :uint32, 1000, 0},
    60 => {:time_in_power_zone, :uint32, 1000, 0},
    61 => {:repetition_num, :uint16, 0, 0},
    62 => {:min_altitude, :uint16, 5, 500},
    63 => {:min_heart_rate, :uint8, 0, 0},
    71 => {:wkt_step_index, :message_index, 0, 0},
    74 => {:opponent_score, :uint16, 0, 0},
    75 => {:stroke_count, :uint16, 0, 0},
    76 => {:zone_count, :uint16, 0, 0},
    77 => {:avg_vertical_oscillation, :uint16, 10, 0},
    78 => {:avg_stance_time_percent, :uint16, 100, 0},
    79 => {:avg_stance_time, :uint16, 10, 0},
    80 => {:avg_fractional_cadence, :uint8, 128, 0},
    81 => {:max_fractional_cadence, :uint8, 128, 0},
    82 => {:total_fractional_cycles, :uint8, 128, 0},
    83 => {:player_score, :uint16, 0, 0},
    84 => {:avg_total_hemoglobin_conc, :uint16, 100, 0},
    85 => {:min_total_hemoglobin_conc, :uint16, 100, 0},
    86 => {:max_total_hemoglobin_conc, :uint16, 100, 0},
    87 => {:avg_saturated_hemoglobin_percent, :uint16, 10, 0},
    88 => {:min_saturated_hemoglobin_percent, :uint16, 10, 0},
    89 => {:max_saturated_hemoglobin_percent, :uint16, 10, 0},
    91 => {:avg_left_torque_effectiveness, :uint8, 2, 0},
    92 => {:avg_right_torque_effectiveness, :uint8, 2, 0},
    93 => {:avg_left_pedal_smoothness, :uint8, 2, 0},
    94 => {:avg_right_pedal_smoothness, :uint8, 2, 0},
    95 => {:avg_combined_pedal_smoothness, :uint8, 2, 0},
    96 => {:num_front_gear_changes, :uint16, 0, 0},
    97 => {:num_rear_gear_changes, :uint16, 0, 0},
    98 => {:time_standing, :uint32, 1000, 0},
    99 => {:stand_count, :uint16, 0, 0},
    100 => {:avg_left_pco, :sint8, 0, 0},
    101 => {:avg_right_pco, :sint8, 0, 0},
    102 => {:avg_left_power_phase, :uint8, 0.7111111, 0},
    103 => {:avg_left_power_phase_peak, :uint8, 0.7111111, 0},
    104 => {:avg_right_power_phase, :uint8, 0.7111111, 0},
    105 => {:avg_right_power_phase_peak, :uint8, 0.7111111, 0},
    106 => {:avg_power_position, :uint16, 0, 0},
    107 => {:max_power_position, :uint16, 0, 0},
    108 => {:avg_cadence_position, :uint8, 0, 0},
    109 => {:max_cadence_position, :uint8, 0, 0},
    110 => {:enhanced_avg_speed, :uint32, 1000, 0},
    111 => {:enhanced_max_speed, :uint32, 1000, 0},
    112 => {:enhanced_avg_altitude, :uint32, 5, 500},
    113 => {:enhanced_min_altitude, :uint32, 5, 500},
    114 => {:enhanced_max_altitude, :uint32, 5, 500},
    115 => {:avg_lev_motor_power, :uint16, 0, 0},
    116 => {:max_lev_motor_power, :uint16, 0, 0},
    117 => {:lev_battery_consumption, :uint8, 2, 0}
  }
  def get(19), do: @_msg_19
  def get(19, key) do
    @_msg_19[key]
  end

  @_msg_20 %{
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
  def get(20), do: @_msg_20
  def get(20, key) do
    @_msg_20[key]
  end

  @_msg_21 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:event, {:enum, :enum_event}, 0, 0},
    1 => {:event_type, {:enum, :enum_event_type}, 0, 0},
    2 => {:data16, :uint16, 0, 0},
    3 => {:data, :uint32, 0, 0},
    4 => {:event_group, :uint8, 0, 0},
    7 => {:score, :uint16, 0, 0},
    8 => {:opponent_score, :uint16, 0, 0},
    9 => {:front_gear_num, :uint8z, 0, 0},
    10 => {:front_gear, :uint8z, 0, 0},
    11 => {:rear_gear_num, :uint8z, 0, 0},
    12 => {:rear_gear, :uint8z, 0, 0},
    13 => {:device_index, :raw, 0, 0}
  }
  def get(21), do: @_msg_21
  def get(21, key) do
    @_msg_21[key]
  end

  @_msg_22 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:speed, :device_index, 0, 0},
    1 => {:distance, :device_index, 0, 0},
    2 => {:cadence, :device_index, 0, 0},
    3 => {:altitude, :device_index, 0, 0},
    4 => {:heart, :device_index, 0, 0}
  }
  def get(22), do: @_msg_22
  def get(22, key) do
    @_msg_22[key]
  end

  @_msg_23 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:device_index, :device_index, 0, 0},
    1 => {:device_type, :uint8, 0, 0},
    2 => {:manufacturer, {:enum, :enum_manufacturer}, 0, 0},
    3 => {:serial_number, :uint32z, 0, 0},
    4 => {:product, :uint16, 0, 0},
    5 => {:software_version, :uint16, 100, 0},
    6 => {:hardware_version, :uint8, 0, 0},
    7 => {:cum_operating_time, :uint32, 0, 0},
    10 => {:battery_voltage, :uint16, 256, 0},
    11 => {:battery_status, {:enum, :enum_battery_status}, 0, 0},
    18 => {:sensor_position, {:enum, :enum_body_location}, 0, 0},
    19 => {:descriptor, :string, 0, 0},
    20 => {:ant_transmission_type, :uint8z, 0, 0},
    21 => {:ant_device_number, :uint16z, 0, 0},
    22 => {:ant_network, {:enum, :enum_ant_network}, 0, 0},
    23 => {:serial_number, :raw, 0, 0},
    24 => {:sensor_serial_number, :raw, 0, 0},
    25 => {:source_type, {:enum, :enum_source_type}, 0, 0},
    27 => {:product_name, :string, 0, 0}
  }
  def get(23), do: @_msg_23
  def get(23, key) do
    @_msg_23[key]
  end

  @_msg_34 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:total_timer_time, :uint32, 0, 0},
    1 => {:num_sessions, :uint16, 0, 0},
    2 => {:type, {:enum, :enum_activity}, 0, 0},
    3 => {:event, {:enum, :enum_event}, 0, 0},
    4 => {:event_type, {:enum, :enum_event_type}, 0, 0},
    5 => {:local_timestamp, :local_date_time, 0, 0},
    6 => {:event_group, :uint8, 0, 0}
  }
  def get(34), do: @_msg_34
  def get(34, key) do
    @_msg_34[key]
  end

  @_msg_49 %{
    0 => {:software_version, :uint16, 0, 0},
    1 => {:hardware_version, :uint8, 0, 0}
  }
  def get(49), do: @_msg_49
  def get(49, key) do
    @_msg_49[key]
  end

  @_msg_72 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:type, {:enum, :enum_file}, 0, 0},
    1 => {:manufacturer, {:enum, :enum_manufacturer}, 0, 0},
    2 => {:product, :uint16, 0, 0},
    3 => {:serial_number, :uint32z, 0, 0},
    4 => {:time_created, :date_time, 0, 0}
  }
  def get(72), do: @_msg_72
  def get(72, key) do
    @_msg_72[key]
  end

  @_msg_104 %{
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:charge, :raw, 0, 0},
    2 => {:percent, :raw, 0, 0}
  }
  def get(104), do: @_msg_104
  def get(104, key) do
    @_msg_104[key]
  end

  @_msg_142 %{
    254 => {:message_index, :message_index, 0, 0},
    253 => {:timestamp, :date_time, 0, 0},
    0 => {:event, :event, 0, 0},
    1 => {:event_type, :event_type, 0, 0},
    2 => {:start_time, :date_time, 0, 0},
    3 => {:start_position_lat, :coordinates, 0, 0},
    4 => {:start_position_long, :coordinates, 0, 0},
    5 => {:end_position_lat, :coordinates, 0, 0},
    6 => {:end_position_long, :coordinates, 0, 0},
    7 => {:total_elapsed_time, :uint32, 1000, 0},
    8 => {:total_timer_time, :uint32, 1000, 0},
    9 => {:total_distance, :uint32, 100, 0},
    10 => {:total_cycles, :uint32, 0, 0},
    11 => {:total_calories, :uint16, 0, 0},
    12 => {:total_fat_calories, :uint16, 0, 0},
    13 => {:avg_speed, :uint16, 1000, 0},
    14 => {:max_speed, :uint16, 1000, 0},
    15 => {:avg_heart_rate, :uint8, 0, 0},
    16 => {:max_heart_rate, :uint8, 0, 0},
    17 => {:avg_cadence, :uint8, 0, 0},
    18 => {:max_cadence, :uint8, 0, 0},
    19 => {:avg_power, :uint16, 0, 0},
    20 => {:max_power, :uint16, 0, 0},
    21 => {:total_ascent, :uint16, 0, 0},
    22 => {:total_descent, :uint16, 0, 0},
    23 => {:sport, :sport, 0, 0},
    24 => {:event_group, :uint8, 0, 0},
    25 => {:nec_lat, :coordinates, 0, 0},
    26 => {:nec_long, :coordinates, 0, 0},
    27 => {:swc_lat, :coordinates, 0, 0},
    28 => {:swc_long, :coordinates, 0, 0},
    29 => {:name, :string, 0, 0},
    30 => {:normalized_power, :uint16, 0, 0},
    31 => {:left_right_balance, :left_right_balance_100, 0, 0},
    32 => {:sub_sport, :sub_sport, 0, 0},
    33 => {:total_work, :uint32, 0, 0},
    34 => {:avg_altitude, :uint16, 5, 500},
    35 => {:max_altitude, :uint16, 5, 500},
    36 => {:gps_accuracy, :uint8, 0, 0},
    37 => {:avg_grade, :sint16, 100, 0},
    38 => {:avg_pos_grade, :sint16, 100, 0},
    39 => {:avg_neg_grade, :sint16, 100, 0},
    40 => {:max_pos_grade, :sint16, 100, 0},
    41 => {:max_neg_grade, :sint16, 100, 0},
    42 => {:avg_temperature, :sint8, 0, 0},
    43 => {:max_temperature, :sint8, 0, 0},
    44 => {:total_moving_time, :uint32, 1000, 0},
    45 => {:avg_pos_vertical_speed, :sint16, 1000, 0},
    46 => {:avg_neg_vertical_speed, :sint16, 1000, 0},
    47 => {:max_pos_vertical_speed, :sint16, 1000, 0},
    48 => {:max_neg_vertical_speed, :sint16, 1000, 0},
    49 => {:time_in_hr_zone, :uint32, 1000, 0},
    50 => {:time_in_speed_zone, :uint32, 1000, 0},
    51 => {:time_in_cadence_zone, :uint32, 1000, 0},
    52 => {:time_in_power_zone, :uint32, 1000, 0},
    53 => {:repetition_num, :uint16, 0, 0},
    54 => {:min_altitude, :uint16, 5, 500},
    55 => {:min_heart_rate, :uint8, 0, 0},
    56 => {:active_time, :uint32, 1000, 0},
    57 => {:wkt_step_index, :message_index, 0, 0},
    58 => {:sport_event, :sport_event, 0, 0},
    59 => {:avg_left_torque_effectiveness, :uint8, 2, 0},
    60 => {:avg_right_torque_effectiveness, :uint8, 2, 0},
    61 => {:avg_left_pedal_smoothness, :uint8, 2, 0},
    62 => {:avg_right_pedal_smoothness, :uint8, 2, 0},
    63 => {:avg_combined_pedal_smoothness, :uint8, 2, 0},
    64 => {:status, :segment_lap_status, 0, 0},
    65 => {:uuid, :string, 0, 0},
    66 => {:avg_fractional_cadence, :uint8, 128, 0},
    67 => {:max_fractional_cadence, :uint8, 128, 0},
    68 => {:total_fractional_cycles, :uint8, 128, 0},
    69 => {:front_gear_shift_count, :uint16, 0, 0},
    70 => {:rear_gear_shift_count, :uint16, 0, 0},
    71 => {:time_standing, :uint32, 1000, 0},
    72 => {:stand_count, :uint16, 0, 0},
    73 => {:avg_left_pco, :sint8, 0, 0},
    74 => {:avg_right_pco, :sint8, 0, 0},
    75 => {:avg_left_power_phase, :uint8, 0.7111111, 0},
    76 => {:avg_left_power_phase_peak, :uint8, 0.7111111, 0},
    77 => {:avg_right_power_phase, :uint8, 0.7111111, 0},
    78 => {:avg_right_power_phase_peak, :uint8, 0.7111111, 0},
    79 => {:avg_power_position, :uint16, 0, 0},
    80 => {:max_power_position, :uint16, 0, 0},
    81 => {:avg_cadence_position, :uint8, 0, 0},
    82 => {:max_cadence_position, :uint8, 0, 0}
  }
  def get(142), do: @_msg_142
  def get(142, key) do
    @_msg_142[key]
  end

  @_msg_147 %{
    0 => {:serial_number, :raw, 0, 0},
    2 => {:name, :raw, 0, 0},
    17 => {:num_front_gears, :raw, 0, 0},
    18 => {:front_gears, :raw, 0, 0},
    19 => {:num_back_gears, :raw, 0, 0},
    20 => {:back_gears, :raw, 0, 0},
    32 => {:product, :raw, 0, 0},
    34 => {:software_version, :raw, 0, 0},
    254 => {:message_index, :message_index, 0, 0}
  }
  def get(147), do: @_msg_147
  def get(147, key) do
    @_msg_147[key]
  end

  def get(other), do: nil
  def get(_field, _key), do: nil
end
