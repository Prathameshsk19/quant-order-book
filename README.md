# FPGA Low-Latency Order Book

A hardware implementation of a financial market order book using **Verilog**, developed with a focus on **FPGA-based low-latency trading systems**.

The project is being developed incrementally, starting from basic order handling and progressing toward a complete FPGA order-book and matching-engine architecture.

---

## 🚀 Project Goals

The main goal of this project is to understand and implement the hardware architecture behind low-latency electronic trading systems.

The project focuses on:

- RTL design
- FPGA architecture
- Low-latency data processing
- Order book management
- Market order processing
- Order matching
- Hardware pipelining
- Timing optimization
- Resource utilization
- Latency measurement
- Verification and testbench development

The long-term objective is to build an FPGA-based order processing pipeline capable of processing market data and orders with deterministic, cycle-level latency.

---

## 🏗️ Development Roadmap

### V1 — Basic Order Book

- [x] Project structure
- [x] Verilog RTL module
- [x] Clock and reset
- [x] Valid order input
- [x] BUY order detection
- [x] Best bid register
- [x] Basic testbench
- [x] Icarus Verilog simulation
- [x] GTKWave waveform verification

### V2 — Bid/Ask Handling

- [x] SELL order detection
- [x] Best ask tracking
- [x] Spread calculation
- [x] Multiple orders
- [x] Price comparison

### V3 — Quantity Handling

- [x] Order quantities
- [x] Quantity aggregation at the same price
- [x] Best bid quantity
- [x] Best ask quantity
- [x] Testbench verification

### V4 — Multi-Level Order Book

- [x] Multiple bid price levels
- [x] Multiple ask price levels
- [x] Price-level aggregation
- [x] Best bid search
- [x] Best ask search
- [x] Spread calculation across multiple levels

### V5 — Order Book Verification

- [x] Directed test cases
- [x] Multiple price levels
- [x] Quantity aggregation tests
- [x] GTKWave waveform verification

### V6 — Order Matching Engine

- [ ] BUY/SELL matching
- [ ] Trade generation
- [ ] Partial fills
- [ ] Remaining quantity tracking
- [ ] Best-price matching
- [ ] Trade output signals

### V7 — Verification & Robustness

- [ ] Self-checking testbench
- [ ] Directed edge-case tests
- [ ] Randomized tests
- [ ] Assertions
- [ ] Functional coverage

### V8 — FPGA Implementation & Optimization

- [ ] Synthesis
- [ ] Timing analysis
- [ ] Critical-path analysis
- [ ] Pipeline optimization
- [ ] Parallel processing
- [ ] Resource utilization analysis
- [ ] Fmax measurement
- [ ] Cycle-level latency measurement

### V9 — Market Data Pipeline

- [ ] Market-data message parser
- [ ] Feed handler
- [ ] Order-book update pipeline
- [ ] Binary protocol processing
- [ ] UDP interface

### V10 — Low-Latency Trading Architecture

- [ ] FPGA network interface
- [ ] Packet parsing
- [ ] Market-data processing
- [ ] Strategy logic
- [ ] Order generation
- [ ] Hardware timestamping
- [ ] End-to-end latency measurement

---
---

## 📈 Current Development Status

The project currently contains a functional multi-level order book supporting:

- BUY and SELL orders
- Four price levels per side
- Price-level quantity aggregation
- Best bid / best ask detection
- Spread calculation
- Verilog RTL implementation
- Icarus Verilog simulation
- GTKWave waveform verification

The next development stage is the implementation of the **order matching engine**, including trade generation and partial fills.

The architecture will initially prioritize correctness and deterministic behavior before moving toward FPGA synthesis, timing optimization, pipelining, and low-latency optimization.

---

## 📂 Repository Structure

```text
quant-order-book/
│
├── rtl/
│   └── order_book.v
│
├── tb/
│   └── order_book_tb.v
│
├── sim/
│   └── simulation files
│
├── docs/
│   └── project documentation
│
├── README.md
└── .gitignore
