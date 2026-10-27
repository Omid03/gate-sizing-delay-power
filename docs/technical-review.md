# Technical review

| Finding | Consequence |
|---|---|
| NAND2/NAND3 series NMOS and NOR2 series PMOS use the same base widths as inverter devices | The resistance-normalized logical-effort model does not describe the implemented cells exactly. A mismatch between analytical and simulated optimum cannot be attributed only to approximation error. |
| Timing data have case labels but no preserved full sweep | Keep case labels as identifiers. Do not infer gate sizes or join the separate power sweep by case number. |
| 21 timing records, including case4.5 | Describe the actual record count, rather than the requested 20-point sweep. |
| Seven power runs: base y8 followed by y4,6,10,12,14,16 | Use listing order, not the order of the compact sorted export, to establish y-to-power mapping. |
| `.measure s_power rms power` | The metric is RMS, not average power or dynamic-only power. RMS times delay is not verified consumed energy. |
| Invalid power-print expression | The power listing warns that `@device.power` is unrecognized and ignored. Measurement values nevertheless exist for all seven runs. |
| ACDE model warning | The listings contain a BSIM4 parameter warning. Model suitability and the specified 1.8 V operating point were not independently qualified. |
| Incomplete nominal listing | The file ends mid-table around 380.573 ns, without a completion footer, despite a requested 800 ns run. Only one requested group of voltage columns survives. |
| Nonideal settled levels | At 150 ns, n is about 0.170 V and out about 1.687 V; do not claim exact rail-to-rail behavior. |
| Missing definitions | The final nominal deck has no timing measurements. `tp` records retain trigger/target times but not the full source expression. |
| Separate supplies inside each cell | Circuit power must not be reconstructed from the top-level Vs alone. Explicitly account for cell supplies and input sources when defining future energy measurements. |
| Legacy plotting helpers | Some assume specific listing block layouts, cannot parse signed values reliably, or reference absent data1/data2 files. The global text-replacement helper can corrupt arbitrary text. These helpers are not promoted as a reproducible analysis pipeline. |

Packaging changed only netlist titles and include paths. The large duplicate listing, unfinished helper experiments, and P.mat are not required by the provided compact result package. All numerical README claims are based on the supplied simulation records or explicitly identified analytical assumptions. Charts were regenerated from those records. No new HSPICE run was performed.
