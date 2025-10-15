USE StatsbombDWH;
GO

/********************************************************************************************
  🧹 1. Drop Existing Tables (Nested & Core) — Order matters due to FK dependencies
********************************************************************************************/
IF OBJECT_ID('silver.fact_related_events', 'U') IS NOT NULL DROP TABLE silver.fact_related_events;
IF OBJECT_ID('silver.fact_shot_freeze_frame', 'U') IS NOT NULL DROP TABLE silver.fact_shot_freeze_frame;
IF OBJECT_ID('silver.fact_tactics_lineup', 'U') IS NOT NULL DROP TABLE silver.fact_tactics_lineup;
IF OBJECT_ID('silver.fact_event_locations', 'U') IS NOT NULL DROP TABLE silver.fact_event_locations;
IF OBJECT_ID('silver.fact_events', 'U') IS NOT NULL DROP TABLE silver.fact_events;
IF OBJECT_ID('silver.dim_matches', 'U') IS NOT NULL DROP TABLE silver.dim_matches;
IF OBJECT_ID('silver.dim_competitions', 'U') IS NOT NULL DROP TABLE silver.dim_competitions;
GO


/********************************************************************************************
  2️⃣ silver.dim_competitions
********************************************************************************************/
CREATE TABLE silver.dim_competitions (
    competition_id INT NOT NULL,
    season_id INT NOT NULL,
    country_name NVARCHAR(100) NULL,
    competition_name NVARCHAR(255) NULL,
    competition_gender NVARCHAR(50) NULL,
    competition_youth BIT NULL,
    competition_international BIT NULL,
    season_name NVARCHAR(50) NULL,
    match_updated NVARCHAR(50) NULL,
    match_updated_360 NVARCHAR(50) NULL,
    match_available_360 NVARCHAR(50) NULL,
    match_available NVARCHAR(50) NULL,
    CONSTRAINT PK_dim_competitions PRIMARY KEY (competition_id, season_id)
);
GO


/********************************************************************************************
  3️⃣ silver.dim_matches
********************************************************************************************/
CREATE TABLE silver.dim_matches (
    match_id INT NOT NULL PRIMARY KEY,
    match_date NVARCHAR(50) NULL,
    kick_off NVARCHAR(50) NULL,
    competition_competition_id INT NULL,
    competition_competition_name NVARCHAR(255) NULL,
    competition_country_name NVARCHAR(100) NULL,
    season_season_id INT NULL,
    season_season_name NVARCHAR(50) NULL,
    competition_stage_id INT NULL,
    competition_stage_name NVARCHAR(100) NULL,
    stadium_id INT NULL,
    stadium_name NVARCHAR(255) NULL,
    stadium_country_id INT NULL,
    stadium_country_name NVARCHAR(100) NULL,
    referee_id INT NULL,
    referee_name NVARCHAR(255) NULL,
    referee_country_id INT NULL,
    referee_country_name NVARCHAR(100) NULL,
    home_team_home_team_id INT NULL,
    home_team_home_team_name NVARCHAR(255) NULL,
    home_team_home_team_gender NVARCHAR(50) NULL,
    home_team_home_team_group FLOAT NULL,
    away_team_away_team_id INT NULL,
    away_team_away_team_name NVARCHAR(255) NULL,
    away_team_away_team_gender NVARCHAR(50) NULL,
    away_team_away_team_group FLOAT NULL,
    home_team_country_id INT NULL,
    home_team_country_name NVARCHAR(100) NULL,
    away_team_country_id INT NULL,
    away_team_country_name NVARCHAR(100) NULL,
    home_team_managers NVARCHAR(255) NULL,
    away_team_managers NVARCHAR(255) NULL,
    match_week INT NULL,
    last_updated NVARCHAR(50) NULL,
    last_updated_360 NVARCHAR(50) NULL,
    metadata_data_version NVARCHAR(50) NULL,
    metadata_shot_fidelity_version FLOAT NULL,
    metadata_xy_fidelity_version FLOAT NULL,
    match_status NVARCHAR(50) NULL,
    match_status_360 NVARCHAR(50) NULL,
    home_score INT NULL,
    away_score INT NULL,
    season_id INT NULL,
    CONSTRAINT FK_dim_matches_competition FOREIGN KEY (competition_competition_id, season_season_id)
        REFERENCES silver.dim_competitions (competition_id, season_id)
);
GO


/********************************************************************************************
  4️⃣ silver.fact_events
********************************************************************************************/
CREATE TABLE silver.fact_events (
    id NVARCHAR(100) NOT NULL PRIMARY KEY,
    match_id INT NULL,
    season_id INT NULL,
    [index] INT NULL,
    period INT NULL,
    [timestamp] NVARCHAR(50) NULL,
    minute INT NULL,
    second INT NULL,
    type_id INT NULL,
    type_name NVARCHAR(100) NULL,
    possession INT NULL,
    possession_team_id INT NULL,
    possession_team_name NVARCHAR(255) NULL,
    play_pattern_id INT NULL,
    play_pattern_name NVARCHAR(255) NULL,
    team_id INT NULL,
    team_name NVARCHAR(255) NULL,
    player_id FLOAT NULL,
    player_name NVARCHAR(255) NULL,
    position_id FLOAT NULL,
    position_name NVARCHAR(100) NULL,
    [location] NVARCHAR(100) NULL,
    duration FLOAT NULL,
    related_events NVARCHAR(MAX) NULL,
    under_pressure NVARCHAR(MAX) NULL,
    off_camera NVARCHAR(MAX) NULL,
    [out] FLOAT NULL,
    tactics_formation FLOAT NULL,
    tactics_lineup NVARCHAR(MAX) NULL,
    counterpress NVARCHAR(MAX) NULL,
    injury_stoppage_in_chain FLOAT NULL,
    pass_recipient_id FLOAT NULL,
    pass_recipient_name NVARCHAR(255) NULL,
    pass_length FLOAT NULL,
    pass_angle FLOAT NULL,
    pass_height_id FLOAT NULL,
    pass_height_name NVARCHAR(100) NULL,
    pass_outcome_id FLOAT NULL,
    pass_outcome_name NVARCHAR(100) NULL,
    pass_body_part_id FLOAT NULL,
    pass_body_part_name NVARCHAR(100) NULL,
    pass_technique_id FLOAT NULL,
    pass_technique_name NVARCHAR(100) NULL,
    pass_type_id FLOAT NULL,
    pass_type_name NVARCHAR(100) NULL,
    pass_cross FLOAT NULL,
    pass_cut_back FLOAT NULL,
    pass_switch NVARCHAR(100) NULL,
    pass_straight FLOAT NULL,
    pass_backheel FLOAT NULL,
    pass_miscommunication FLOAT NULL,
    pass_through_ball FLOAT NULL,
    pass_inswinging FLOAT NULL,
    pass_outswinging FLOAT NULL,
    pass_aerial_won FLOAT NULL,
    pass_end_location NVARCHAR(100) NULL,
    pass_assisted_shot_id NVARCHAR(100) NULL,
    pass_shot_assist FLOAT NULL,
    pass_goal_assist FLOAT NULL,
    shot_key_pass_id NVARCHAR(100) NULL,
    shot_statsbomb_xg FLOAT NULL,
    shot_end_location NVARCHAR(100) NULL,
    shot_freeze_frame NVARCHAR(MAX) NULL,
    shot_aerial_won FLOAT NULL,
    shot_outcome_id FLOAT NULL,
    shot_outcome_name NVARCHAR(100) NULL,
    shot_body_part_id FLOAT NULL,
    shot_body_part_name NVARCHAR(100) NULL,
    shot_technique_id FLOAT NULL,
    shot_technique_name NVARCHAR(100) NULL,
    shot_type_id FLOAT NULL,
    shot_type_name NVARCHAR(100) NULL,
    foul_committed_type_id FLOAT NULL,
    foul_committed_type_name NVARCHAR(100) NULL,
    foul_committed_card_id FLOAT NULL,
    foul_committed_card_name NVARCHAR(100) NULL,
    foul_committed_penalty FLOAT NULL,
    duel_type_id FLOAT NULL,
    duel_type_name NVARCHAR(100) NULL,
    duel_outcome_id FLOAT NULL,
    duel_outcome_name NVARCHAR(100) NULL,
    [50_50_outcome_id] FLOAT NULL,
    [50_50_outcome_name] NVARCHAR(100) NULL,
    goalkeeper_type_id FLOAT NULL,
    goalkeeper_type_name NVARCHAR(100) NULL,
    goalkeeper_technique_id FLOAT NULL,
    goalkeeper_technique_name NVARCHAR(100) NULL,
    goalkeeper_outcome_id FLOAT NULL,
    goalkeeper_outcome_name NVARCHAR(100) NULL,
    goalkeeper_body_part_id FLOAT NULL,
    goalkeeper_body_part_name NVARCHAR(100) NULL,
    goalkeeper_position_id FLOAT NULL,
    goalkeeper_position_name NVARCHAR(100) NULL,
    goalkeeper_end_location NVARCHAR(100) NULL,
    goalkeeper_punched_out FLOAT NULL,
    block_deflection FLOAT NULL,
    block_offensive FLOAT NULL,
    dribble_outcome_id FLOAT NULL,
    dribble_outcome_name NVARCHAR(100) NULL,
    dribble_nutmeg FLOAT NULL,
    dribble_overrun FLOAT NULL,
    clearance_aerial_won FLOAT NULL,
    clearance_body_part_id FLOAT NULL,
    clearance_body_part_name NVARCHAR(100) NULL,
    clearance_head NVARCHAR(100) NULL,
    clearance_left_foot NVARCHAR(100) NULL,
    clearance_right_foot NVARCHAR(100) NULL,
    clearance_other FLOAT NULL,
    interception_outcome_id FLOAT NULL,
    interception_outcome_name NVARCHAR(100) NULL,
    ball_receipt_outcome_id FLOAT NULL,
    ball_receipt_outcome_name NVARCHAR(100) NULL,
    ball_recovery_recovery_failure FLOAT NULL,
    substitution_outcome_id FLOAT NULL,
    substitution_outcome_name NVARCHAR(100) NULL,
    substitution_replacement_id FLOAT NULL,
    substitution_replacement_name NVARCHAR(255) NULL,
    bad_behaviour_card_id FLOAT NULL,
    bad_behaviour_card_name NVARCHAR(100) NULL,
    foul_won_advantage FLOAT NULL,
    foul_won_defensive NVARCHAR(100) NULL,
    foul_committed_offensive FLOAT NULL,
    foul_committed_advantage FLOAT NULL,
    pass_deflected FLOAT NULL,
    shot_deflected FLOAT NULL,
    shot_redirect FLOAT NULL,
    shot_first_time FLOAT NULL,
    shot_one_on_one FLOAT NULL,
    carry_end_location NVARCHAR(100) NULL,
	foul_won_penalty FLOAT NULL
      ,ball_recovery_offensive FLOAT NULL
      ,block_save_block FLOAT NULL
    CONSTRAINT FK_fact_events_matches FOREIGN KEY (match_id)
        REFERENCES silver.dim_matches (match_id)
);
GO


/********************************************************************************************
  5️⃣ silver.fact_related_events
********************************************************************************************/
CREATE TABLE silver.fact_related_events (
    event_id NVARCHAR(100) NOT NULL,
    related_event_id NVARCHAR(100) NOT NULL,
    match_id INT NULL,
    season_id INT NULL,
    CONSTRAINT FK_related_events_fact FOREIGN KEY (event_id)
        REFERENCES silver.fact_events (id)
);
GO


/********************************************************************************************
  6️⃣ silver.fact_shot_freeze_frame
********************************************************************************************/
CREATE TABLE silver.fact_shot_freeze_frame (
    event_id NVARCHAR(100) NOT NULL,
    match_id INT NULL,
    season_id INT NULL,
    player_id INT NULL,
    player_name NVARCHAR(255) NULL,
    position_name NVARCHAR(100) NULL,
    teammate BIT NULL,
    location_x FLOAT NULL,
    location_y FLOAT NULL,
    CONSTRAINT FK_freeze_frame_event FOREIGN KEY (event_id)
        REFERENCES silver.fact_events (id)
);
GO


/********************************************************************************************
  7️⃣ silver.fact_tactics_lineup
********************************************************************************************/
CREATE TABLE silver.fact_tactics_lineup (
    event_id NVARCHAR(100) NOT NULL,
    match_id INT NULL,
    season_id INT NULL,
    tactics_formation NVARCHAR(50) NULL,
    player_id INT NULL,
    player_name NVARCHAR(255) NULL,
    position_id INT NULL,
    position_name NVARCHAR(100) NULL,
    jersey_number INT NULL,
    CONSTRAINT FK_tactics_event FOREIGN KEY (event_id)
        REFERENCES silver.fact_events (id)
);
GO


/********************************************************************************************
  8️⃣ silver.fact_event_locations
********************************************************************************************/
CREATE TABLE silver.fact_event_locations (
    event_id NVARCHAR(100) NOT NULL,
    match_id INT NULL,
    season_id INT NULL,
    location_x FLOAT NULL,
    location_y FLOAT NULL,
    pass_end_x FLOAT NULL,
    pass_end_y FLOAT NULL,
    carry_end_x FLOAT NULL,
    carry_end_y FLOAT NULL,
    CONSTRAINT FK_event_locations FOREIGN KEY (event_id)
        REFERENCES silver.fact_events (id)
);
GO

