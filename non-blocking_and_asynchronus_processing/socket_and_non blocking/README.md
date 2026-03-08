# socket_and_non blocking

Perl examples for socket, non-blocking, async, file formats, APIs, and monitoring use cases.

## Files

- `01_non_blocking_async_processing.pl`
  - Non-blocking TCP server + clients with one async event loop (`IO::Select`).
- `02_optimize_io_file_network.pl`
  - Chunked file I/O and non-blocking network send/receive with throughput output.
- `03_consume_expose_rest_soap_apis.pl`
  - Exposes local REST/SOAP-like endpoints, then consumes them as a client.
- `04_handle_csv_json_xml_binary_logs.pl`
  - Reads/writes CSV, JSON, XML, and binary log records.
- `05_network_alarms_kpis_logs_event_correlation.pl`
  - Simulates telemetry, computes KPIs, generates alarms, and correlates incidents.
- `06_real_time_data_processing_aggregation.pl`
  - Simulated real-time event stream with rolling aggregate snapshots.

## Run

```bash
cd "socket_and_non blocking"
perl 01_non_blocking_async_processing.pl
perl 02_optimize_io_file_network.pl
perl 03_consume_expose_rest_soap_apis.pl
perl 04_handle_csv_json_xml_binary_logs.pl
perl 05_network_alarms_kpis_logs_event_correlation.pl
perl 06_real_time_data_processing_aggregation.pl
```
