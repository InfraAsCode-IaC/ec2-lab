# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-07

### Added
- Initial stable release of Terraform EC2 AWS module
- Modular architecture with networking, security, and compute modules
- S3 backend with DynamoDB state locking for dev environment
- Security hardening with IMDSv2 enforcement
- Encrypted EBS volumes with proper lifecycle management

### Changed
- **BREAKING CHANGE:** Migrated from development version 0.0.1 to stable 1.0.0
- Updated AWS provider to ~> 5.0
- Enforced Terraform >= 1.7.0 requirement

### Security
- Restricted SSH access to authorized IPs only
- Enabled AES-256 encryption for S3 state bucket
- Implemented proper security group rules for web traffic

## [0.0.1] - 2026-05-01

### Added
- Initial development setup
- Basic EC2 deployment with networking and security modules
- Development environment configuration