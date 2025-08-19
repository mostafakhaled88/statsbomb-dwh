/*
===============================================================================
Script: Create ETL Logging Tables
Schema: logs
===============================================================================
Purpose:
    - Track ETL job execution (start/end, status, rows processed, duration)
    - Store detailed error logs (failures during ETL)
    - Provide audit trail for debugging and monitoring
===============================================================================
*/

USE StatsbombDW;
GO

------------------------------------------------------------------------------
-- 1. ETL Run History (high-level logging per ETL execution)
------------------------------------------------------------------------------
CREATE TABLE logs.ETL_RunHistory (
    RunID           INT IDENTITY(1,1) PRIMARY KEY,
    JobName         NVARCHAR(100) NOT NULL,
    StartTime       DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    EndTime         DATETIME2 NULL,
    Status          NVARCHAR(20) CHECK (Status IN ('Started','Success','Failed')),
    RowsProcessed   INT DEFAULT 0,
    DurationSeconds AS DATEDIFF(SECOND, StartTime, EndTime) PERSISTED
);
GO

------------------------------------------------------------------------------
-- 2. ETL Error Log (detailed error messages for failed runs)
------------------------------------------------------------------------------
CREATE TABLE logs.ETL_ErrorLog (
    ErrorID         INT IDENTITY(1,1) PRIMARY KEY,
    RunID           INT NOT NULL FOREIGN KEY REFERENCES logs.ETL_RunHistory(RunID),
    ErrorTime       DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ProcedureName   NVARCHAR(128) NULL,
    ErrorMessage    NVARCHAR(MAX) NOT NULL,
    ErrorSeverity   NVARCHAR(50) NULL,
    StackTrace      NVARCHAR(MAX) NULL
);
GO

------------------------------------------------------------------------------
-- 3. Data Quality Checks (optional, for completeness)
------------------------------------------------------------------------------
CREATE TABLE logs.DataQualityChecks (
    CheckID         INT IDENTITY(1,1) PRIMARY KEY,
    RunID           INT NOT NULL FOREIGN KEY REFERENCES logs.ETL_RunHistory(RunID),
    CheckName       NVARCHAR(100) NOT NULL,
    Status          NVARCHAR(20) CHECK (Status IN ('Pass','Fail')),
    CheckTime       DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    Notes           NVARCHAR(500) NULL
);
GO
