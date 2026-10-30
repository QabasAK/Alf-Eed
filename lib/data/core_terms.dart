// ─────────────────────────────────────────────────────────────────────────────
// The 42 core terms the lexicon shows.
//
// Why 42? In Douglas Adams' "The Hitchhiker's Guide to the Galaxy", 42 is the
// Answer to the Ultimate Question of Life, the Universe, and Everything. It
// also splits evenly: 14 terms in each of the 3 categories.
//
// Selection rule: the 10 terms that already have animations / sign videos are
// always kept; the rest are the concepts a student meets first and most often
// in an engineering degree. All 100 definitions stay in sample_terms.dart —
// swap an id here to change which ones are shown.
// ─────────────────────────────────────────────────────────────────────────────

const Set<String> coreTermIds = {
  // ── Engineering Basics (14) ───────────────────────────────────────────────
  'circuit', 'frequency', 'signal', 'voltage', // have media
  'current', 'resistance', 'energy', 'power', 'force',
  'system', 'sensor', 'feedback', 'conductor', 'insulator',

  // ── Computer Engineering (14) ─────────────────────────────────────────────
  'algorithm', 'binary', 'loop', 'data_structure', // have media
  'variable', 'function', 'array', 'memory', 'processor',
  'operating_system', 'compiler', 'logic_gate', 'database', 'debugging',

  // ── Electrical Engineering (14) ───────────────────────────────────────────
  'resistor', 'transistor', // have media
  'capacitor', 'inductor', 'diode', 'transformer', 'amplifier', 'ground',
  'short_circuit', 'ac_dc', 'battery', 'power_supply', 'microcontroller', 'pcb',
};
