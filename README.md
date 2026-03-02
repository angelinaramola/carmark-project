# CarMark Customer Analytics Database

This project builds a relational Snowflake-style customer analytics database for CarMark, a local automotive dealership. The goal is to replace scattered spreadsheets with a centralized schema that supports customer tracking, segmentation, and financial analysis.

## What This Project Includes
- A single SQL file containing:
  - All table creation statements
  - Keys, constraints, and relationships
  - SCD2 effective‑dated history tables
  - MERGE logic for updates
  - Financial tier model fields
  - Bridge tables for many‑to‑many relationships

## What the Database Supports
- Customer demographics and contact info  
- Lifestyle traits, behaviors, and interests  
- Vehicle ownership and purchase history  
- Financial readiness and tier scoring  
- Customer segmentation with propensity scores  
- Full historical tracking using SCD2  

## Repo Structure
- `scripts/` — complete schema and logic
- `reports/` — project write‑up and presentation

## Notes
- All data is synthetic and created for academic use.
- The SQL file is designed for Snowflake but can be adapted to other warehouses.
