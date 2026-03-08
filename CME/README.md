# CME - CDR Mediation Engine (Perl)

CME is a small telecom mediation pipeline that:

- Generates synthetic CDR CSV files (`bin/switch_simulator.pl`)
- Validates and rates records (`lib/CDR/*`)
- Stores valid/invalid outputs in MySQL (`bin/mediation_engine.pl`)
- Writes processing logs and archives processed files

## Project structure

- `bin/switch_simulator.pl`: Generates test CDR files in `input/`
- `bin/mediation_engine.pl`: Reads CSVs from `input/`, processes, inserts into DB, archives files
- `lib/CDR/Parser.pm`: Parses CSV rows into normalized hashes
- `lib/CDR/Validator.pm`: Validates mandatory fields, E.164 format, call type, duration rules
- `lib/CDR/Billing/Calculator.pm`: Computes charge (SMS flat; VOICE local/international by country code)
- `lib/CDR/Processor.pm`: End-to-end file processing and DB inserts
- `config/db.conf`: DB connection settings
- `input/`: Incoming CSV files
- `archived/`: Successfully processed CSV files
- `logs/`: Engine and processing logs

## Prerequisites

- Perl 5.x
- MySQL running locally (or reachable host)
- Perl modules:
  - `DBI`
  - `DBD::mysql`
  - `Text::CSV`
  - core modules used by scripts: `POSIX`, `FindBin`, `File::Copy`, `File::Basename`

## Database tables (required)

Create these tables before running the mediation engine.

```sql
CREATE TABLE processed_cdrs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  caller VARCHAR(20) NOT NULL,
  callee VARCHAR(20) NOT NULL,
  start_time DATETIME NOT NULL,
  duration INT NOT NULL,
  call_type VARCHAR(10) NOT NULL,
  charge DECIMAL(10,2) NOT NULL,
  source_file VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE invalid_cdrs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  raw_record TEXT NOT NULL,
  reason VARCHAR(255) NOT NULL,
  source_file VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mediation_summary (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  file_name VARCHAR(255) NOT NULL,
  total_records INT NOT NULL,
  total_revenue DECIMAL(10,2) NOT NULL,
  rejected_count INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Configuration

Edit `config/db.conf`.

Expected keys by current code:

```ini
dsn=DBI:mysql:database=CDR_CME2;host=localhost
db_user=root
password=
```

## Input CSV format

Header and order must be:

```csv
caller,callee,start_time,duration,call_type
```

Example row:

```csv
+919876543210,+14155552671,2026-03-08 23:30:00,125,VOICE
```

Validation/rating rules in current code:

- `caller` and `callee` must match E.164 (`+` followed by up to 15 digits)
- `call_type` must be `VOICE` or `SMS` (`DATA` is treated as invalid)
- `duration` must be numeric
- `VOICE` with `duration=0` is rejected
- `SMS` charge: `0.25`
- `VOICE` charge: billed per started minute (`ceil(duration/60)`)
  - Local (`caller` country code == `callee`): `0.75` per minute
  - International: `1.50` per minute

## Running

From repository root:

1. Generate sample CDR file:

```
perl bin/switch_simulator.pl
```

2. Process all CSV files currently in `input/`:

```
perl bin/mediation_engine.pl
```

## Outputs

- Valid records inserted into `processed_cdrs`
- Invalid records inserted into `invalid_cdrs`
- Per-file summary inserted into `mediation_summary`
- Processed file moved from `input/` to `archived/`
- Logs appended to:
  - `logs/mediation.log`
  - `logs/processed_sucessfully.log`


