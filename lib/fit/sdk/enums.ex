defmodule Fit.Sdk.Enums do
  @_enum_file %{
    1 => :device,
    2 => :settings,
    3 => :sport,
    4 => :activity,
    5 => :workout,
    6 => :course,
    7 => :schedules,
    9 => :weight,
    10 => :totals,
    11 => :goals,
    14 => :blood_pressure,
    15 => :monitoring_a,
    20 => :activity_summary,
    28 => :monitoring_daily,
    32 => :monitoring_b,
    34 => :segment,
    35 => :segment_list,
    40 => :exd_configuration,
    0xF7 => :mfg_range_min,
    0xFE => :mfg_range_max
  }
  def get(:enum_file, key) do
    @_enum_file[key]
  end

  @_enum_manufacturer %{
    1 => :garmin,
    2 => :garmin_fr405_antfs,
    3 => :zephyr,
    4 => :dayton,
    5 => :idt,
    6 => :srm,
    7 => :quarq,
    8 => :ibike,
    9  => :saris,
    10 => :spark_hk,
    11 => :tanita,
    12 => :echowell,
    13 => :dynastream_oem,
    14 => :nautilus,
    15 => :dynastream,
    16 => :timex,
    17 => :metrigear,
    18 => :xelic,
    19 => :beurer,
    20 => :cardiosport,
    21 => :a_and_d,
    22 => :hmm,
    23 => :suunto,
    24 => :thita_elektronik,
    25 => :gpulse,
    26 => :clean_mobile,
    27 => :pedal_brain,
    28 => :peaksware,
    29 => :saxonar,
    30 => :lemond_fitness,
    31 => :dexcom,
    32 => :wahoo_fitness,
    33 => :octane_fitness,
    34 => :archinoetics,
    35 => :the_hurt_box,
    36 => :citizen_systems,
    37 => :magellan,
    38 => :osynce,
    39 => :holux,
    40 => :concept2,
    41 => :shimano,
    42 => :one_giant_leap,
    43 => :ace_sensor,
    44 => :brim_brothers,
    45 => :xplova,
    46 => :perception_digital,
    47 => :bf1systems,
    48 => :pioneer,
    49 => :spantec,
    50 => :metalogics,
    52 => :seiko_epson,
    53 => :seiko_epson_oem,
    54 => :ifor_powell,
    55 => :maxwell_guider,
    56 => :star_trac,
    57 => :breakaway,
    58 => :alatech_technology_ltd,
    59 => :mio_technology_europe,
    60 => :rotor,
    61 => :geonaute,
    62 => :id_bike,
    63 => :specialized,
    64 => :wtek,
    65 => :physical_enterprises,
    66 => :north_pole_engineering,
    67 => :bkool,
    68 => :cateye,
    69 => :stages_cycling,
    70 => :sigmasport,
    71 => :tomtom,
    72 => :peripedal,
    73 => :wattbike,
    76 => :moxy,
    77 => :ciclosport,
    78 => :powerbahn,
    79 => :acorn_projects_aps,
    80 => :lifebeam,
    81 => :bontrager,
    82 => :wellgo,
    83 => :scosche,
    84 => :magura,
    85 => :woodway,
    86 => :elite,
    87 => :nielsen_kellerman,
    88 => :dk_city,
    89 => :tacx,
    90 => :direction_technology,
    91 => :magtonic,
    93 => :inside_ride_technologies,
    94 => :sound_of_motion,
    95 => :stryd,
    96 => :icg,
    97 => :mi_pulse,
    98 => :bsx_athletics,
    99 => :look,
    100 => :campagnolo_srl,
    101 => :body_bike_smart,
    102 => :praxisworks,
    103 => :limits_technology,
    104 => :topaction_technology,
    105 => :cosinuss,
    255 => :development,
    257 => :healthandlife,
    258 => :lezyne,
    259 => :scribe_labs,
    260 => :zwift,
    261 => :watteam,
    262 => :recon,
    263 => :favero_electronics,
    264 => :dynovelo,
    265 => :strava,
    266 => :precor,
    267 => :bryton,
    268 => :sram,
    269 => :navman,
    270 => :cobi,
    271 => :spivi,
    272 => :mio_magellan,
    273 => :evesports,
    5759 => :actigraphcorp
  }
  def get(:enum_manufacturer, key) do
    @_enum_manufacturer[key]
  end

  @_enum_garmin_product %{
    1 => :hrm1,
    2 => :axh01,
    3 => :axb01,
    4 => :axb02,
    5 => :hrm2ss,
    6 => :dsi_alf02,
    7 => :hrm3ss,
    8 => :hrm_run_single_byte_product_id,
    9 => :bsm,
    10 => :bcm,
    11 => :axs01,
    12 => :hrm_tri_single_byte_product_id,
    14 => :fr225_single_byte_product_id,
    473 => :fr301_china,
    474 => :fr301_japan,
    475 => :fr301_korea,
    494 => :fr301_taiwan,
    717 => :fr405,
    782 => :fr50,
    987 => :fr405_japan,
    988 => :fr60,
    1011 => :dsi_alf01,
    1018 => :fr310xt,
    1036 => :edge500,
    1124 => :fr110,
    1169 => :edge800,
    1199 => :edge500_taiwan,
    1213 => :edge500_japan,
    1253 => :chirp,
    1274 => :fr110_japan,
    1325 => :edge200,
    1328 => :fr910xt,
    1333 => :edge800_taiwan,
    1334 => :edge800_japan,
    1341 => :alf04,
    1345 => :fr610,
    1360 => :fr210_japan,
    1380 => :vector_ss,
    1381 => :vector_cp,
    1386 => :edge800_china,
    1387 => :edge500_china,
    1410 => :fr610_japan,
    1422 => :edge500_korea,
    1436 => :fr70,
    1446 => :fr310xt_4t,
    1461 => :amx,
    1482 => :fr10,
    1497 => :edge800_korea,
    1499 => :swim,
    1537 => :fr910xt_china,
    1551 => :fenix,
    1555 => :edge200_taiwan,
    1561 => :edge510,
    1567 => :edge810,
    1570 => :tempe,
    1600 => :fr910xt_japan,
    1623 => :fr620,
    1632 => :fr220,
    1664 => :fr910xt_korea,
    1688 => :fr10_japan,
    1721 => :edge810_japan,
    1735 => :virb_elite,
    1736 => :edge_touring,
    1742 => :edge510_japan,
    1743 => :hrm_tri,
    1752 => :hrm_run,
    1765 => :fr920xt,
    1821 => :edge510_asia,
    1822 => :edge810_china,
    1823 => :edge810_taiwan,
    1836 => :edge1000,
    1837 => :vivo_fit,
    1853 => :virb_remote,
    1885 => :vivo_ki,
    1903 => :fr15,
    1907 => :vivo_active,
    1918 => :edge510_korea,
    1928 => :fr620_japan,
    1929 => :fr620_china,
    1930 => :fr220_japan,
    1931 => :fr220_china,
    1936 => :approach_s6,
    1956 => :vivo_smart,
    1967 => :fenix2,
    1988 => :epix,
    2050 => :fenix3,
    2052 => :edge1000_taiwan,
    2053 => :edge1000_japan,
    2061 => :fr15_japan,
    2067 => :edge520,
    2070 => :edge1000_china,
    2072 => :fr620_russia,
    2073 => :fr220_russia,
    2079 => :vector_s,
    2100 => :edge1000_korea,
    2130 => :fr920xt_taiwan,
    2131 => :fr920xt_china,
    2132 => :fr920xt_japan,
    2134 => :virbx,
    2135 => :vivo_smart_apac,
    2140 => :etrex_touch,
    2147 => :edge25,
    2148 => :fr25,
    2150 => :vivo_fit2,
    2153 => :fr225,
    2156 => :fr630,
    2157 => :fr230,
    2160 => :vivo_active_apac,
    2161 => :vector_2,
    2162 => :vector_2s,
    2172 => :virbxe,
    2173 => :fr620_taiwan,
    2174 => :fr220_taiwan,
    2175 => :truswing,
    2188 => :fenix3_china,
    2189 => :fenix3_twn,
    2192 => :varia_headlight,
    2193 => :varia_taillight_old,
    2204 => :edge_explore_1000,
    2219 => :fr225_asia,
    2225 => :varia_radar_taillight,
    2226 => :varia_radar_display,
    2238 => :edge20,
    2262 => :d2_bravo,
    2266 => :approach_s20,
    2276 => :varia_remote,
    2327 => :hrm4_run,
    2337 => :vivo_active_hr,
    2348 => :vivo_smart_hr,
    2398 => :varia_vision,
    2406 => :vivo_fit3,
    2413 => :fenix3_hr,
    2429 => :index_smart_scale,
    2431 => :fr235,
    2496 => :nautix,
    10007 => :sdm4,
    10014 => :edge_remote,
    20119 => :training_center,
    29241 => :di2_ant_connector,
    65531 => :connectiq_simulator,
    65532 => :android_antplus_plugin,
    65534 => :connect
  }
  def get(:enum_garmin_product, key) do
    @_enum_garmin_product[key]
  end

  @_enum_event %{
    0 => :timer,
    3 => :workout,
    4 => :workout_step,
    5 => :power_down,
    6 => :power_up,
    7 => :off_course,
    8 => :session,
    9 => :lap,
    10 => :course_point,
    11 => :battery,
    12 => :virtual_partner_pace,
    13 => :hr_high_alert,
    14 => :hr_low_alert,
    15 => :speed_high_alert,
    16 => :speed_low_alert,
    17 => :cad_high_alert,
    18 => :cad_low_alert,
    19 => :power_high_alert,
    20 => :power_low_alert,
    21 => :recovery_hr,
    22 => :battery_low,
    23 => :time_duration_alert,
    24 => :distance_duration_alert,
    25 => :calorie_duration_alert,
    26 => :activity,
    27 => :fitness_equipment,
    28 => :length,
    32 => :user_marker,
    33 => :sport_point,
    36 => :calibration,
    42 => :front_gear_change,
    43 => :rear_gear_change,
    44 => :rider_position_change,
    45 => :elev_high_alert,
    46 => :elev_low_alert,
    47 => :comm_timeout
  }
  def get(:enum_event, key) do
    @_enum_event[key]
  end

  @_enum_event_type %{
    0 => :start,
    1 => :stop,
    2 => :consecutive_depreciated,
    3 => :marker,
    4 => :stop_all,
    5 => :begin_depreciated,
    6 => :end_depreciated,
    7 => :end_all_depreciated,
    8 => :stop_disable,
    9 => :stop_disable_all
  }
  def get(:enum_event_type, key) do
    @_enum_event_type[key]
  end

  @_enum_battery_status %{
    1 => :new,
    2 => :good,
    3 => :ok,
    4 => :low,
    5 => :critical,
    6 => :charging,
    7 => :unknown
  }
  def get(:enum_battery_status, key) do
    @_enum_battery_status[key]
  end

  @_enum_body_location %{
    0 => :left_leg,
    1 => :left_calf,
    2 => :left_shin,
    3 => :left_hamstring,
    4 => :left_quad,
    5 => :left_glute,
    6 => :right_leg,
    7 => :right_calf,
    8 => :right_shin,
    9 => :right_hamstring,
    10 => :right_quad,
    11 => :right_glute,
    12 => :torso_back,
    13 => :left_lower_back,
    14 => :left_upper_back,
    15 => :right_lower_back,
    16 => :right_upper_back,
    17 => :torso_front,
    18 => :left_abdomen,
    19 => :left_chest,
    20 => :right_abdomen,
    21 => :right_chest,
    22 => :left_arm,
    23 => :left_shoulder,
    24 => :left_bicep,
    25 => :left_tricep,
    26 => :left_brachioradialis,
    27 => :left_forearm_extensors,
    28 => :right_arm,
    29 => :right_shoulder,
    30 => :right_bicep,
    31 => :right_tricep,
    32 => :right_brachioradialis,
    33 => :right_forearm_extensors,
    34 => :neck,
    35 => :throat
  }
  def get(:enum_body_location, key) do
    @_enum_body_location[key]
  end

  @_enum_ant_network %{
    0 => :public,
    1 => :antplus,
    2 => :antfs,
    3 => :private
  }
  def get(:enum_ant_network, key) do
    @_enum_ant_network[key]
  end

  @_enum_source_type %{
    0 => :ant,
    1 => :antplus,
    2 => :bluetooth,
    3 => :bluetooth_low_energy,
    4 => :wifi,
    5 => :local
  }
  def get(:enum_source_type, key) do
    @_enum_source_type[key]
  end

  @_enum_gender %{
    0 => :female,
    1 => :male
  }
  def get(:enum_gender, key) do
    @_enum_gender[key]
  end

  @_enum_language %{
    0 => :english,
    1 => :french,
    2 => :italian,
    3 => :german,
    4 => :spanish,
    5 => :croatian,
    6 => :czech,
    7 => :danish,
    8 => :dutch,
    9 => :finnish,
    10 => :greek,
    11 => :hungarian,
    12 => :norwegian,
    13 => :polish,
    14 => :portuguese,
    15 => :slovakian,
    16 => :slovenian,
    17 => :swedish,
    18 => :russian,
    19 => :turkish,
    20 => :latvian,
    21 => :ukrainian,
    22 => :arabic,
    23 => :farsi,
    24 => :bulgarian,
    25 => :romanian,
    26 => :chinese,
    27 => :japanese,
    28 => :korean,
    29 => :taiwanese,
    30 => :thai,
    31 => :hebrew,
    32 => :brazilian_portuguese,
    33 => :indonesian,
    254 => :custom
  }
  def get(:enum_language, key) do
    @_enum_language[key]
  end

  @_enum_display_measure %{
    0 => :metric,
    1 => :statute
  }
  def get(:enum_display_measure, key) do
    @_enum_display_measure[key]
  end

  @_enum_display_heart %{
    0 => :bpm,
    1 => :max,
    2 => :reserve
  }
  def get(:enum_display_heart, key) do
    @_enum_display_heart[key]
  end

  @_enum_display_power %{
    0 => :watts,
    1 => :percent_ftp
  }
  def get(:enum_display_power, key) do
    @_enum_display_power[key]
  end

  @_enum_display_position %{
    0 => :degree,
    1 => :degree_minute,
    2 => :degree_minute_second,
    3 => :austrian_grid,
    4 => :british_grid,
    5 => :dutch_grid,
    6 => :hungarian_grid,
    7 => :finnish_grid,
    8 => :german_grid,
    9 => :icelandic_grid,
    10 => :indonesian_equatorial,
    11 => :indonesian_irian,
    12 => :indonesian_southern,
    13 => :india_zone_0,
    14 => :india_zone_IA,
    15 => :india_zone_IB,
    16 => :india_zone_IIA,
    17 => :india_zone_IIB,
    18 => :india_zone_IIIA,
    19 => :india_zone_IIIB,
    20 => :india_zone_IVA,
    21 => :india_zone_IVB,
    22 => :irish_transverse,
    23 => :irish_grid,
    24 => :loran,
    25 => :maidenhead_grid,
    26 => :mgrs_grid,
    27 => :new_zealand_grid,
    28 => :new_zealand_transverse,
    29 => :qatar_grid,
    30 => :modified_swedish_grid,
    31 => :swedish_grid,
    32 => :south_african_grid,
    33 => :swiss_grid,
    34 => :taiwan_grid,
    35 => :united_states_grid,
    36 => :utm_ups_grid,
    37 => :west_malayan,
    38 => :borneo_rso,
    39 => :estonian_grid,
    40 => :latvian_grid,
    41 => :swedish_ref_99_grid
  }
  def get(:enum_display_position, key) do
    @_enum_display_position[key]
  end

  @_enum_activity_class %{
    0x7F => :level,
    100 => :level_max,
    0x80 => :athlete
  }
  def get(:enum_activity_class, key) do
    @_enum_activity_class[key]
  end

  @_enum_intensity %{
    0 => :active,
    1 => :rest,
    2 => :warmup,
    3 => :cooldown
  }
  def get(:enum_intensity, key) do
    @_enum_intensity[key]
  end

  @_enum_lap_trigger %{
    0 => :manual,
    1 => :time,
    2 => :distance,
    3 => :position_start,
    4 => :position_lap,
    5 => :position_waypoint,
    6 => :position_marked,
    7 => :session_end,
    8 => :fitness_equipment
  }
  def get(:enum_lap_trigger, key) do
    @_enum_lap_trigger[key]
  end

  @_enum_sport %{
    0 => :generic,
    1 => :running,
    2 => :cycling,
    3 => :transition,
    4 => :fitness_equipment,
    5 => :swimming,
    6 => :basketball,
    7 => :soccer,
    8 => :tennis,
    9 => :american_football,
    10 => :training,
    11 => :walking,
    12 => :cross_country_skiing,
    13 => :alpine_skiing,
    14 => :snowboarding,
    15 => :rowing,
    16 => :mountaineering,
    17 => :hiking,
    18 => :multisport,
    19 => :paddling,
    20 => :flying,
    21 => :e_biking,
    22 => :motorcycling,
    23 => :boating,
    24 => :driving,
    25 => :golf,
    26 => :hang_gliding,
    27 => :horseback_riding,
    28 => :hunting,
    29 => :fishing,
    30 => :inline_skating,
    31 => :rock_climbing,
    32 => :sailing,
    33 => :ice_skating,
    34 => :sky_diving,
    35 => :snowshoeing,
    36 => :snowmobiling,
    37 => :stand_up_paddleboarding,
    38 => :surfing,
    39 => :wakeboarding,
    40 => :water_skiing,
    41 => :kayaking,
    42 => :rafting,
    43 => :windsurfing,
    44 => :kitesurfing,
    254 => :all
  }
  def get(:enum_sport, key) do
    @_enum_sport[key]
  end

  @_enum_sub_sport %{
    0 => :generic,
    1 => :treadmill,
    2 => :street,
    3 => :trail,
    4 => :track,
    5 => :spin,
    6 => :indoor_cycling,
    7 => :road,
    8 => :mountain,
    9 => :downhill,
    10 => :recumbent,
    11 => :cyclocross,
    12 => :hand_cycling,
    13 => :track_cycling,
    14 => :indoor_rowing,
    15 => :elliptical,
    16 => :stair_climbing,
    17 => :lap_swimming,
    18 => :open_water,
    19 => :flexibility_training,
    20 => :strength_training,
    21 => :warm_up,
    22 => :match,
    23 => :exercise,
    24 => :challenge,
    25 => :indoor_skiing,
    26 => :cardio_training,
    27 => :indoor_walking,
    28 => :e_bike_fitness,
    29 => :bmx,
    30 => :casual_walking,
    31 => :speed_walking,
    32 => :bike_to_run_transition,
    33 => :run_to_bike_transition,
    34 => :swim_to_bike_transition,
    35 => :atv,
    36 => :motocross,
    37 => :backcountry,
    38 => :resort,
    39 => :rc_drone,
    40 => :wingsuit,
    41 => :whitewater,
    42 => :skate_skiing,
    43 => :yoga,
    44 => :pilates,
    45 => :indoor_running,
    46 => :gravel_cycling,
    47 => :e_bike_mountain,
    48 => :commuting,
    254 => :all
  }
  def get(:enum_sub_sport, key) do
    @_enum_sub_sport[key]
  end

  @_enum_session_trigger %{
    0 => :activity_end,
    1 => :manual,
    2 => :auto_multi_sport,
    3 => :fitness_equipment
  }
  def get(:enum_session_trigger, key) do
    @_enum_session_trigger[key]
  end

  @_enum_activity %{
    0 => :manual,
    1 => :auto_multi_sport
  }
  def get(:enum_activity, key) do
    @_enum_activity[key]
  end

  @_antplus_device_type %{
    1 => :antfs,
    11 => :bike_power,
    12 => :environment_sensor_legacy,
    15 => :multi_sport_speed_distance,
    16 => :control,
    17 => :fitness_equipment,
    18 => :blood_pressure,
    19 => :geocache_node,
    20 => :light_electric_vehicle,
    25 => :env_sensor,
    26 => :racquet,
    27 => :control_hub,
    31 => :muscle_oxygen,
    35 => :bike_light_main,
    36 => :bike_light_shared,
    38 => :exd,
    40 => :bike_radar,
    119 => :weight_scale,
    120 => :heart_rate,
    121 => :bike_speed_cadence,
    122 => :bike_cadence,
    123 => :bike_speed,
    124 => :stride_speed_distance
  }
  def get(:antplus_device_type, key) do
    @_antplus_device_type[key]
  end

  def get(_, key) do
    key
  end
end
