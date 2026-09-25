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

- [ ] SELL order detection
- [ ] Best ask tracking
- [ ] Spread calculation
- [ ] Multiple orders
- [ ] Price comparison

### V3 — Multi-Level Order Book

- [ ] Multiple bid price levels
- [ ] Multiple ask price levels
- [ ] Order quantities
- [ ] Price-level aggregation
- [ ] Order cancellation

### V4 — Matching Engine

- [ ] BUY/SELL matching
- [ ] Price-time priority
- [ ] Partial fills
- [ ] Remaining quantity tracking
- [ ] Trade generation

### V5 — Verification

- [ ] Self-checking testbench
- [ ] Directed tests
- [ ] Randomized tests
- [ ] Assertions
- [ ] Functional coverage

### V6 — FPGA Optimization

- [ ] Synthesis
- [ ] Timing analysis
- [ ] Critical-path analysis
- [ ] Pipeline optimization
- [ ] Parallel processing
- [ ] Resource optimization
- [ ] Fmax measurement
- [ ] Cycle-level latency measurement

### V7 — Market Data Pipeline

- [ ] Market-data message parser
- [ ] Feed handler
- [ ] Order-book update pipeline
- [ ] Binary protocol processing
- [ ] UDP interface

### V8 — Low-Latency Trading Architecture

- [ ] FPGA network interface
- [ ] Packet parsing
- [ ] Market-data processing
- [ ] Strategy logic
- [ ] Order generation
- [ ] Hardware timestamping
- [ ] End-to-end latency measurement

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
