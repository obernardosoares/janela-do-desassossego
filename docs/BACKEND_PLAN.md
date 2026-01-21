# Arquivo Central de Sensações - Backend Infrastructure

> *"Central Archive of Sensations"* — IaC project for cloud and self-hosted deployments

---

## Overview

The backend is an **Infrastructure as Code** project deployable on:

| Platform | Type | Examples |
|----------|------|----------|
| **Cloud** | Managed services | AWS, Azure, GCP, Nebius |
| **Self-Hosted** | Own infrastructure | OpenWRT, Raspberry Pi, home server |


---

## Project Structure

```
arquivo-central-de-sensacoes/          # IaC project
├── cloud/
│   ├── aws/                           # Current CloudFormation (→ Terraform)
│   ├── azure/
│   ├── gcp/
│   ├── terraform/                     # Future IaC
│   └── kubernetes/                    # K8s manifests
│
├── self-hosted/
│   ├── docker/                        # Docker Compose stack
│   ├── openwrt/                       # OpenWRT packages
│   └── ansible/                       # SBC provisioning
│
├── api/
│   ├── rest/                          # REST API (FastAPI/Go)
│   └── graphql/                       # GraphQL schema
│
├── services/
│   ├── mqtt-broker/                   # Mosquitto / EMQX
│   ├── timeseries-db/                 # InfluxDB / TimescaleDB
│   ├── config-db/                     # PostgreSQL / SQLite
│   └── ml-inference/                  # TFServing / Triton
│
└── docs/
```

---

## Cloud Architecture

### Current (AWS CloudFormation)

```
┌─────────────────────────────────────────────┐
│  AWS IoT Core  ──►  Lambda  ──►  InfluxDB   │
│       │                              │      │
│       ▼                              ▼      │
│  DynamoDB ◄──────────────────► API Gateway  │
└─────────────────────────────────────────────┘
```

### Future (Terraform + Kubernetes)

```
┌─────────────────────────────────────────────┐
│      Kubernetes Cluster                     │
│  ┌─────────┐  ┌─────────┐  ┌─────────────┐  │
│  │ MQTT Pod│  │ API Pod │  │ InfluxDB Pod│  │
│  └─────────┘  └─────────┘  └─────────────┘  │
│                    │                        │
│              ┌─────▼─────┐                  │
│              │ Ingress   │                  │
│              └───────────┘                  │
└─────────────────────────────────────────────┘
```

---

## Self-Hosted Architecture

### Supported Platforms

| Platform | Specs | Connectivity |
|----------|-------|--------------|
| OpenWRT Router | 128MB RAM | WiFi, Ethernet |
| Raspberry Pi 4 | 4GB RAM | WiFi, BT, Thread* |
| x86 Mini PC | 8GB+ RAM | Full stack |
| Home NAS | Varies | Docker support |

*Thread requires additional radio module

### Connectivity Options

| Protocol | Range | Power | Use Case |
|----------|-------|-------|----------|
| **WiFi** | 50m | High | Primary, all devices |
| **Bluetooth LE** | 10m | Low | Proximity sensors |
| **Thread/Zigbee** | 30m mesh | Low | Battery sensors |
| **LoRa** | 10km | Very Low | Rural, outdoor |
| **5G/LTE** | Cellular | Medium | Mobile, no WiFi |

### Docker Compose Stack

```yaml
# self-hosted/docker/docker-compose.yml
services:
  mqtt:
    image: eclipse-mosquitto:2
    ports: ["1883:1883", "8883:8883"]
    
  influxdb:
    image: influxdb:2.7
    ports: ["8086:8086"]
    
  api:
    build: ../api
    ports: ["8080:8080"]
    
  grafana:
    image: grafana/grafana:latest
    ports: ["3000:3000"]
```

---

## API Contract

Both cloud and self-hosted implement identical REST API:

### Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/auth/login` | POST | User authentication |
| `/api/v1/devices` | GET | List devices |
| `/api/v1/devices/{id}` | GET/PATCH | Device CRUD |
| `/api/v1/telemetry` | GET | Query telemetry |
| `/api/v1/automation/rules` | GET/POST | Manage rules |

### WebSocket

| Event | Direction | Description |
|-------|-----------|-------------|
| `telemetry.live` | S→C | Real-time data |
| `device.status` | S→C | Online/offline |
| `automation.trigger` | S→C | Rule executed |

---

## Migration Path

```
Phase 1: CloudFormation (Current)
    │
    ▼
Phase 2: Terraform (Multi-cloud)
    │
    ▼
Phase 3: Kubernetes (Self-hosted + Cloud)
    │
    ▼
Phase 4: Edge Computing (OpenWRT packages)
```

---

## Implementation Phases

### Phase 1: API Specification (Weeks 1-2)
- OpenAPI spec for REST API
- GraphQL schema
- WebSocket protocol docs

### Phase 2: Cloud Terraform (Weeks 3-6)
- Migrate CloudFormation → Terraform
- Multi-cloud modules (AWS, Azure, GCP)
- CI/CD for infrastructure

### Phase 3: Self-Hosted Docker (Weeks 7-10)
- Docker Compose stack
- Ansible playbooks for SBC
- Documentation

### Phase 4: Edge/OpenWRT (Weeks 11-14)
- OpenWRT package development
- Minimal footprint services
- Local mesh networking

---

## Technology Choices

| Component | Cloud | Self-Hosted |
|-----------|-------|-------------|
| MQTT Broker | AWS IoT Core | Mosquitto / EMQX |
| Time-Series DB | InfluxDB Cloud / Timestream | InfluxDB OSS |
| Config DB | DynamoDB | PostgreSQL / SQLite |
| API | Lambda / API Gateway | FastAPI / Go |
| Auth | Cognito | Keycloak / Local |
| ML Inference | SageMaker | TFServing / Local |
