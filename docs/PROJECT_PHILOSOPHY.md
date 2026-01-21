# Project Philosophy

> *"What gets measured gets managed"* — And what gets managed gets saved.

---

## The Three Projects

| Project | Name | Purpose |
|---------|------|---------|
| **Mobile App** | Janela do Desassossego | Window into your world's data |
| **Backend IaC** | Arquivo Central de Sensações | Central archive of all sensations |
| **Firmware** | Savearth IoT | The sensing layer |

---

## Core Principles

### 1. Measure Everything

We cannot save what we do not understand. Every resource flow deserves visibility:

| Domain | What We Measure |
|--------|----------------|
| **Water** | Shower duration, irrigation volume |
| **Energy** | Appliance consumption, solar production |
| **Living Things** | Plant health, animal welfare, growth patterns |
| **Environment** | Temperature, humidity, air quality |

### 2. Local First, Cloud Optional

Privacy and resilience come from local control:

```
Your Data → Your Home Server → Your Decision to Share
```

- **Self-hosted by default**: Run on OpenWRT, Raspberry Pi, or home NAS
- **Cloud as enhancement**: Optional sync for mobile access and ML training
- **No vendor lock-in**: Open protocols (MQTT, HTTP), portable data

### 3. Intelligence at Every Level

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│   Device    │   │    Edge     │   │    Cloud    │
│  (TFLite    │ → │  (Local     │ → │  (Training  │
│   Micro)    │   │   Server)   │   │   Center)   │
└─────────────┘   └─────────────┘   └─────────────┘
     ↑                  ↑                  ↑
  Inference         Aggregation         Learning
```

### 4. Family-Centric Design

This is not enterprise IoT. This is **home IoT**:

- Designed for families, not facilities
- Simple enough for anyone to use
- Powerful enough for the curious to explore

---

## What We Protect

### Inside the Home

| Category | Examples |
|----------|----------|
| **Utilities** | Water (showers, irrigation), electricity, gas |
| **Comfort** | Smart bulbs, plugs, thermostats, blinds |
| **Security** | Cameras, doorbells, motion sensors, locks |
| **Appliances** | Refrigerator, washer, HVAC monitoring |

### Outside the Home

| Category | Examples |
|----------|----------|
| **Garden** | Soil moisture, plant health, weather |
| **Orchard** | Fruit trees, irrigation automation |
| **Animals** | Livestock tracking, pet feeders, health alerts |
| **Agriculture** | Precision farming, drone data integration |

---

## The Names

### Janela do Desassossego
*"Window of Disquiet"*

Inspired by Fernando Pessoa's Book of Disquiet — a meditation on observing the world with restless curiosity. This app is your window into the data that surrounds you. It creates a productive disquiet: the awareness that drives action.

### Arquivo Central de Sensações
*"Central Archive of Sensations"*

Every sensor reading is a sensation — a moment of perception captured in data. The backend is the central nervous system, the archive of all these sensations, organized and ready for understanding.

---

## Our Commitment

1. **Open Standards**: MQTT, HTTP, SQLite — no proprietary protocols
2. **Privacy by Design**: Local processing, encrypted storage
3. **Sustainable Code**: Efficient algorithms, minimal footprint
4. **Accessible to All**: Affordable hardware, free software
