# Domotics & Smart Home Integration

> Complete home automation: from smart bulbs to precision agriculture

---

## Supported Device Categories

### Indoor

| Category | Devices | Protocols |
|----------|---------|-----------|
| **Lighting** | Smart bulbs, strips, switches | Zigbee, WiFi, Thread |
| **Power** | Smart plugs, energy monitors | WiFi, Zigbee |
| **Climate** | Thermostats, AC, fans | WiFi, IR bridges |
| **Security** | Cameras, locks, sensors | WiFi, Zigbee, BLE |
| **Media** | TVs, speakers | WiFi, IR |
| **Appliances** | Fridges, washers (monitoring) | WiFi |

### Outdoor

| Category | Devices | Protocols |
|----------|---------|-----------|
| **Garden** | Irrigation valves, soil sensors | WiFi, LoRa, Zigbee |
| **Orchard** | Weather stations, frost alerts | WiFi, LoRa |
| **Livestock** | GPS trackers, feeders | LoRa, BLE |
| **Security** | Outdoor cameras, doorbells | WiFi |

---

## Protocol Support

| Protocol | Range | Power | Best For |
|----------|-------|-------|----------|
| **WiFi** | 50m | High | Always-on devices |
| **Zigbee/Thread** | 30m mesh | Low | Sensors, switches |
| **Bluetooth LE** | 10m | Very Low | Proximity, wearables |
| **LoRa** | 10km | Very Low | Rural, agriculture |
| **Z-Wave** | 30m mesh | Low | Legacy integration |
| **IR** | Line of sight | — | Legacy TVs, AC |

---

## Automation Capabilities

### Triggers

| Type | Examples |
|------|----------|
| **Sensor** | Motion, door open, temperature threshold |
| **Time** | Sunrise, schedule, recurring |
| **Location** | Arrive home, leave home |
| **Device** | Another device state changes |
| **Weather** | Rain forecast, frost warning |
| **ML** | Anomaly detection, pattern recognition |

### Actions

| Type | Examples |
|------|----------|
| **Control** | Turn on/off, set brightness, temperature |
| **Notify** | Push notification, SMS, email |
| **Scene** | Activate multiple devices together |
| **Data** | Log to database, trigger ML training |

---

## Example Automations

```yaml
# Morning routine
- trigger: time == sunrise
  conditions:
    - weekday in [Mon, Tue, Wed, Thu, Fri]
  actions:
    - lights.bedroom: brightness=30%
    - thermostat: heat to 21°C
    - coffee_maker: on

# Water conservation
- trigger: shower.running > 10 minutes
  actions:
    - notify: "Shower running long - save water!"

# Frost protection
- trigger: weather.forecast.min_temp < 0°C
  conditions:
    - time > sunset
  actions:
    - greenhouse.heater: on
    - notify: "Frost protection activated"

# Pet feeding
- trigger: time == 08:00
  actions:
    - pet_feeder: dispense(amount=50g)
    - camera.kitchen: snapshot → upload
```

---

## Precision Agriculture Features

### Monitoring

| Metric | Sensors | Insight |
|--------|---------|---------|
| Soil moisture | Capacitive probes | Irrigation timing |
| Soil pH | Electrochemical | Nutrient availability |
| Light | PAR sensors | Shade management |
| Temperature | Thermocouples | Frost/heat stress |
| Humidity | DHT22, BME280 | Disease risk |

### Camera + ML

| Use Case | Model Type | Output |
|----------|------------|--------|
| Plant identification | Image classification | Species, variety |
| Disease detection | Object detection | Affected areas |
| Pest identification | Image classification | Pest type, severity |
| Growth tracking | Measurement | Height, leaf count |
| Harvest readiness | Classification | Ready/not ready |

---

## Integration Architecture

```
┌─────────────────────────────────────────────────────┐
│                     MOBILE APP                       │
│              (Janela do Desassossego)               │
└───────────────────────┬─────────────────────────────┘
                        │
           ┌────────────┴────────────┐
           ▼                         ▼
┌──────────────────┐      ┌──────────────────────────┐
│   CLOUD BACKEND  │      │   LOCAL BACKEND          │
│   (Optional)     │      │   (arquivo-central)      │
└──────────────────┘      └────────────┬─────────────┘
                                       │
           ┌───────────────────────────┼───────────────────────────┐
           ▼                           ▼                           ▼
┌──────────────────┐      ┌──────────────────┐      ┌──────────────────┐
│   MQTT BROKER    │      │   ZIGBEE HUB     │      │   MATTER/THREAD  │
│   (Mosquitto)    │      │   (Zigbee2MQTT)  │      │   CONTROLLER     │
└────────┬─────────┘      └────────┬─────────┘      └────────┬─────────┘
         │                         │                         │
    ┌────┴────┐               ┌────┴────┐               ┌────┴────┐
    ▼         ▼               ▼         ▼               ▼         ▼
 [ESP32]  [LoRa GW]       [Bulbs]  [Sensors]       [Plugs]  [Locks]
```

---

## Self-Hosted Requirements

### Minimum (OpenWRT Router)

- Mosquitto (MQTT)
- Basic automation engine
- SQLite storage

### Recommended (Raspberry Pi / Mini PC)

- Full MQTT + Zigbee2MQTT
- InfluxDB time-series
- Grafana dashboards
- ML inference server
